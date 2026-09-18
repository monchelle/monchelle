-- Greenhouse sync setup checks and helpful indexes.
-- Run this in the Supabase SQL Editor.

create index if not exists jobs_greenhouse_active_idx
on public.jobs (
  source,
  is_active,
  last_seen_at desc
);

create index if not exists job_matches_user_score_idx
on public.job_matches (
  user_id,
  match_score desc,
  calculated_at desc
);

-- Optional: allow the dashboard to read
-- the latest sync summary.

alter table public.source_syncs
enable row level security;

drop policy if exists
  "Authenticated users can view greenhouse sync summaries"
on public.source_syncs;

create policy
  "Authenticated users can view greenhouse sync summaries"
on public.source_syncs
for select
to authenticated
using (
  source = 'greenhouse'
);