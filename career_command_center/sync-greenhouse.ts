// Supabase Edge Function: sync-greenhouse
// Deploy with: supabase functions deploy sync-greenhouse
// Required secrets: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY
// Optional secret: GREENHOUSE_BOARD_TOKENS_JSON
// Example: [{"company":"Example Co","token":"exampleco"}]

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") || Deno.env.get("SUPABASE_SECRET_KEY");
if (!supabaseUrl) throw new Error("Missing SUPABASE_URL secret.");
if (!serviceRoleKey) throw new Error("Missing SUPABASE_SERVICE_ROLE_KEY or SUPABASE_SECRET_KEY secret.");
const supabase = createClient(supabaseUrl, serviceRoleKey);

type Board = { company: string; token: string };
type GreenhouseJob = {
  id: number;
  title?: string;
  updated_at?: string;
  absolute_url?: string;
  content?: string;
  location?: { name?: string };
  departments?: { name?: string }[];
  offices?: { name?: string; location?: string }[];
};

function boards(): Board[] {
  const raw = Deno.env.get("GREENHOUSE_BOARD_TOKENS_JSON") || "[]";
  try {
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed.filter((x) => x?.company && x?.token) : [];
  } catch {
    throw new Error("GREENHOUSE_BOARD_TOKENS_JSON must be valid JSON.");
  }
}

function stripHtml(html = "") {
  return html.replace(/<[^>]*>/g, " ").replace(/&nbsp;/g, " ").replace(/\s+/g, " ").trim();
}

function arrangement(job: GreenhouseJob, description: string) {
  const text = `${job.title || ""} ${job.location?.name || ""} ${description}`.toLowerCase();
  if (text.includes("remote")) return "Fully remote";
  if (text.includes("hybrid")) return "Hybrid";
  return "On-site";
}

function score(profile: any, job: any) {
  const resume = [profile.headline, profile.professional_summary, profile.skills, profile.experience]
    .filter(Boolean).join(" ").toLowerCase();
  const text = [job.job_title, job.job_description, job.location, job.work_arrangement]
    .filter(Boolean).join(" ").toLowerCase();
  const terms = [
    "operations", "program", "project", "product", "process", "analytics", "strategy",
    "stakeholder", "healthcare", "leadership", "implementation", "data", "management",
    "improvement", "roadmap", "cross-functional", "vendor", "reporting", "optimization",
    "technology", "change", "planning", "continuous improvement"
  ];
  const hits = terms.filter((term) => resume.includes(term) && text.includes(term)).length;
  const titleWords = (job.job_title || "").toLowerCase().split(/[^a-z0-9]+/).filter((x: string) => x.length > 3);
  const titleHits = titleWords.filter((x: string) => resume.includes(x)).length;
  let location = 0;
  const preferred = (profile.preferred_locations || []).join(" ").toLowerCase();
  if (preferred && text.includes("baltimore")) location += 8;
  if (text.includes("remote") && (profile.preferred_work_arrangements || []).join(" ").toLowerCase().includes("remote")) location += 8;
  return Math.min(99, Math.max(50, Math.round(45 + hits * 2 + titleHits * 2 + location)));
}

async function fetchBoard(board: Board): Promise<GreenhouseJob[]> {
  const url = `https://boards-api.greenhouse.io/v1/boards/${encodeURIComponent(board.token)}/jobs?content=true`;
  const response = await fetch(url);
  if (!response.ok) throw new Error(`${board.company}: Greenhouse returned ${response.status}`);
  const body = await response.json();
  return Array.isArray(body.jobs) ? body.jobs : [];
}

Deno.serve(async (request) => {
  if (request.method !== "POST") return new Response("Use POST", { status: 405 });
  const started = new Date().toISOString();
  const syncResult = await supabase
    .from("source_syncs")
    .insert({ source: "greenhouse", started_at: started, status: "running" })
    .select("id")
    .single();

  if (!syncResult || syncResult.error || !syncResult.data?.id) {
    const message = syncResult?.error?.message || "Unable to create source_syncs record.";
    console.error("sync initialization failed", { message, data: syncResult?.data ?? null });
    return Response.json({ error: message }, { status: 500 });
  }

  const syncId = syncResult.data.id;

  let found = 0, added = 0, updated = 0, deactivated = 0;
  try {
    const configured = boards();
    if (!configured.length) throw new Error("No Greenhouse board tokens configured.");
    const profiles = await supabase.from("profiles").select("*");
    if (!profiles || profiles.error) throw new Error(profiles?.error?.message || "Unable to load profiles.");
    const seen = new Set<string>();

    for (const board of configured) {
      const jobs = await fetchBoard(board);
      found += jobs.length;
      for (const g of jobs) {
        const description = stripHtml(g.content || "");
        const sourceJobId = `${board.token}:${g.id}`;
        seen.add(sourceJobId);
        const record = {
          source: "greenhouse",
          source_job_id: sourceJobId,
          company_name: board.company,
          job_title: g.title || "Untitled role",
          job_description: description,
          location: g.location?.name || g.offices?.map((x) => x.location || x.name).filter(Boolean).join(", ") || "",
          work_arrangement: arrangement(g, description),
          posting_url: g.absolute_url || null,
          application_url: g.absolute_url || null,
          posted_at: g.updated_at || null,
          last_seen_at: new Date().toISOString(),
          is_active: true,
          updated_at: new Date().toISOString(),
        };
        const existing = await supabase.from("jobs").select("id").eq("source", "greenhouse").eq("source_job_id", sourceJobId).maybeSingle();
        if (!existing || existing.error) throw new Error(existing?.error?.message || `Unable to check existing job ${sourceJobId}.`);
        const saved = await supabase.from("jobs").upsert(record, { onConflict: "source,source_job_id" }).select().single();
        if (!saved || saved.error || !saved.data) throw new Error(saved?.error?.message || `Unable to save job ${sourceJobId}.`);
        if (existing.data) updated++; else added++;
        for (const profile of profiles.data || []) {
          const match = score(profile, record);
          const result = await supabase.from("job_matches").upsert({
            user_id: profile.id,
            job_id: saved.data.id,
            match_score: match,
            skills_score: match,
            experience_score: match,
            location_score: match,
            match_explanation: `Greenhouse posting matched against ${profile.full_name || "your"} saved profile.`,
            calculated_at: new Date().toISOString(),
          }, { onConflict: "user_id,job_id" });
          if (!result || result.error) throw new Error(result?.error?.message || `Unable to save match for ${sourceJobId}.`);
        }
      }
    }

    // Deactivate greenhouse jobs not seen in this sync.
    const active = await supabase.from("jobs").select("id,source_job_id").eq("source", "greenhouse").eq("is_active", true);
    if (!active || active.error) throw new Error(active?.error?.message || "Unable to load active Greenhouse jobs.");
    const stale = (active.data || []).filter((x) => !seen.has(x.source_job_id)).map((x) => x.id);
    if (stale.length) {
      const result = await supabase.from("jobs").update({ is_active: false, updated_at: new Date().toISOString() }).in("id", stale);
      if (!result || result.error) throw new Error(result?.error?.message || "Unable to deactivate stale jobs.");
      deactivated = stale.length;
    }

    await supabase.from("source_syncs").update({ completed_at: new Date().toISOString(), jobs_found: found, jobs_added: added, jobs_updated: updated, jobs_deactivated: deactivated, status: "completed" }).eq("id", syncId);
    return Response.json({ source: "greenhouse", found, added, updated, deactivated, completed_at: new Date().toISOString() });
  } catch (error) {
    await supabase.from("source_syncs").update({ completed_at: new Date().toISOString(), jobs_found: found, jobs_added: added, jobs_updated: updated, jobs_deactivated: deactivated, status: "failed", error_message: error instanceof Error ? error.message : String(error) }).eq("id", syncId);
    return Response.json({ error: message, found, added, updated, deactivated }, { status: 500 });
  }
});
