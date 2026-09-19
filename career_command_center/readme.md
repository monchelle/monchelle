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
