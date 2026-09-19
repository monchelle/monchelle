# Monchelle's Career Command Center

An AI-optimized job-search dashboard designed to help manage applications, tailor resumes, discover job opportunities, and improve job-search decisions through personalized feedback.

## Project Overview

The Career Command Center combines job-search organization, resume management, application tracking, job matching, and document generation into one responsive web application.

The project was built to support a more intentional and data-driven job-search workflow, including:

- Tracking jobs I have applied for or want to apply for
- Managing job titles, companies, descriptions, statuses, links, and update dates
- Uploading and storing resumes securely
- Maintaining an editable master resume profile
- Generating tailored resumes and customized cover letters
- Calculating resume-to-job match scores
- Saving jobs to a Wishlist
- Removing jobs with persistent Not Interested feedback
- Connecting to external job sources
- Storing application and job-match data in a cloud database

## Key Features

### Application Tracker

- Add, edit, and delete applications
- Track application status:
  - Wishlist
  - Applied
  - Screening
  - Interview
  - Offer
  - Not selected
  - Rejected
- Store job descriptions, application URLs, locations, and match scores
- Automatically update last-status-change dates
- Persist application data in Supabase

### Resume & Cover Letter Tools

- Upload PDF, DOC, and DOCX resumes
- Store resume files in a private Supabase Storage bucket
- Maintain an editable master resume profile
- Save professional summary, skills, experience, headline, and contact information
- Generate targeted resumes for specific roles
- Generate customized cover letters
- Produce downloadable DOCX documents
- Apply ATS-conscious formatting and structured sections

### Job Matching

- Compare job descriptions with saved resume information
- Calculate skills, experience, location, and salary alignment
- Display match explanations and match percentages
- Show only active database-backed opportunities
- Filter out jobs marked Not interested
- Save Wishlist and Not Interested feedback
- Keep job-match counts synchronized with Supabase

### Dashboard Analytics

- Active application count
- Interview count
- Average match score
- Average applications per day
- Application momentum chart
- Pipeline health chart
- Wishlist reminders for aging opportunities
- Dynamic dashboard dates and tracker update timestamps

## Technology Stack

### Frontend

- HTML5
- CSS3
- JavaScript
- Tailwind CSS
- ECharts
- Responsive layout design
- Chrome-oriented browser compatibility improvements

### Backend and Cloud Services

- Supabase PostgreSQL
- Supabase Authentication
- Supabase Storage
- Supabase Edge Functions
- Supabase Row Level Security
- Supabase REST API
- GitHub for version control and project storage

### External Integrations

- Greenhouse Job Board API
- USAJOBS Search API
- Employer career pages and job-source links
- Future support planned for additional permitted job APIs and structured career feeds

## Database Architecture

The application uses a relational data model with tables for:

- `profiles`
- `resume_files`
- `jobs`
- `applications`
- `job_feedback`
- `job_matches`
- `source_syncs`

Row Level Security policies ensure user-owned records are isolated by authenticated user ID.

## Job-Source Synchronization

The project includes Supabase Edge Functions for importing and processing job postings.

### Greenhouse Synchronization

The Greenhouse integration:

- Reads configured employer board tokens
- Retrieves current job postings
- Normalizes job data
- Removes HTML from descriptions
- Prevents duplicate jobs
- Updates previously seen jobs
- Deactivates stale postings
- Calculates profile-based match scores
- Writes results to `jobs`, `job_matches`, and `source_syncs`

### USAJOBS Synchronization

The USAJOBS integration is designed to:

- Search Baltimore-area operations and program-management roles
- Search remote operations and strategy roles
- Apply a $70,000 minimum salary filter
- Normalize federal job announcements
- Store salary and location data
- Calculate personalized match scores
- Persist source-sync results

## Skills Demonstrated

This project showcases experience with:

- Full-stack application design
- Frontend interface development
- Responsive dashboard design
- JavaScript event handling
- Client-side state management
- Data persistence and synchronization
- Relational database design
- PostgreSQL schema development
- Row Level Security implementation
- Authentication workflows
- Private file storage
- REST API integration
- Third-party API consumption
- Serverless Edge Functions
- Scheduled data synchronization architecture
- Data normalization
- Job deduplication
- Record lifecycle management
- Match-scoring logic
- User-feedback modeling
- Resume and job-description analysis
- DOCX document generation
- Error handling and debugging
- Git and GitHub project management
- Browser compatibility troubleshooting
- Incremental feature development
- Staged integration testing

## Project Architecture

```text
Career Command Center
│
├── Responsive HTML dashboard
│   ├── Overview
│   ├── Application Tracker
│   ├── Job Matches
│   └── Resume & Letters
│
├── Supabase Authentication
│
├── Supabase PostgreSQL
│   ├── Profiles
│   ├── Applications
│   ├── Jobs
│   ├── Job Matches
│   ├── Feedback
│   └── Sync History
│
├── Supabase Storage
│   └── Private Resume Files
│
└── Supabase Edge Functions
    ├── Greenhouse Job Sync
    └── USAJOBS Job Sync

```
## Security Practices

- Browser-safe Supabase keys are used on the client.
- Service-role keys remain server-side in Supabase Edge Function secrets.
- Resume files are stored in a private Supabase Storage bucket.
- Row Level Security protects user-owned records.
- API credentials are stored as Supabase secrets.
- Sensitive credentials are excluded from GitHub source files.
- External links use `noopener` and `noreferrer` where appropriate.
- Database access is scoped to the authenticated user.
- Profile, application, resume, feedback, and match records are protected by user-specific policies.
- Server-side job synchronization functions do not expose private credentials to the browser.

## Development Approach

The project was developed incrementally through the following stages:

1. Built the initial responsive dashboard interface.
2. Added the application tracker.
3. Implemented job creation, editing, deletion, and status management.
4. Added resume upload functionality.
5. Added master-resume profile editing.
6. Added resume-to-job match scoring.
7. Added tailored resume and cover-letter generation.
8. Added downloadable DOCX document generation.
9. Added Supabase authentication.
10. Connected resume storage to Supabase Storage.
11. Connected master-resume data to the Supabase `profiles` table.
12. Connected the application tracker to the Supabase `applications` table.
13. Added persistent Wishlist and Not Interested feedback.
14. Connected the Job Matches page to `jobs`, `job_matches`, and `job_feedback`.
15. Created Greenhouse job-source synchronization functions.
16. Began USAJOBS API integration.
17. Used staged Edge Function testing to isolate:
    - Secret loading
    - Authentication
    - Database connectivity
    - Greenhouse API access
    - Job insertion
    - Match insertion
    - Full source synchronization

The project emphasized incremental testing, defensive error handling, persistent database state, and a gradual transition from local browser storage to cloud-backed application data.

## Future Improvements

- Schedule job synchronization once or twice daily.
- Add additional permitted job-source integrations.
- Improve semantic resume-to-job matching.
- Add feedback reasons for Not Interested selections.
- Personalize ranking based on Wishlist and rejection behavior.
- Add source-specific filtering and grouping.
- Add salary and work-arrangement filters.
- Add expired-posting detection and notifications.
- Add alerts for newly discovered high-match jobs.
- Add interview preparation tools.
- Add application conversion analytics.
- Add response-rate and pipeline analytics.
- Add production hosting with a custom domain.
- Add automated testing and regression coverage.
- Add backend monitoring and synchronization-health reporting.
- Add source-level retry and failure handling.
- Add pagination and batching for high-volume job boards.
- Add duplicate detection across multiple job sources.
- Add user preference controls for industries, titles, locations, and salary ranges.
- Add explanations showing why each job received its match score.

## Project Status

This project is an actively evolving personal career-technology application.

The following capabilities are implemented:

- Responsive career dashboard
- Application tracking
- Add, edit, and delete application functionality
- Application status management
- Dynamic tracker dates
- Overview statistics and charts
- Wishlist reminders
- Resume upload interface
- Private resume storage architecture
- Editable master resume profile
- Supabase authentication
- Supabase PostgreSQL integration
- Supabase Row Level Security
- Supabase Storage integration
- Database-backed applications
- Database-backed job matches
- Wishlist feedback persistence
- Not Interested feedback persistence
- Match-score persistence
- Tailored resume generation
- Customized cover-letter generation
- DOCX document generation
- Greenhouse job-source integration
- USAJOBS integration preparation

The job-source synchronization system is being developed incrementally. Greenhouse employer-board synchronization has been established as the first source, and USAJOBS integration is currently being added. Additional sources will be evaluated based on API availability, access permissions, reliability, and data quality.

## Author

Built by **Monchelle** as a practical application of:

- Frontend development
- Responsive dashboard design
- JavaScript application logic
- Backend integration
- PostgreSQL database design
- Supabase authentication
- Supabase Storage
- Row Level Security
- REST API integration
- Third-party job-source integration
- Serverless Edge Functions
- Data normalization
- Job deduplication
- Match-scoring logic
- Resume and job-description analysis
- DOCX document generation
- Git and GitHub project management
- Incremental debugging and integration testing
- Career-technology automation

This project demonstrates how a real-world personal productivity application can evolve from a front-end prototype into a cloud-connected, database-backed career platform.
