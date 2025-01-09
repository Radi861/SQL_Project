/*
Question: What are the top paying data analyst job roles?
- Identify the top 10 highest paying Data Analyst roles that are available remotely
- Do not consider job postings with null va;ues for the salary
*/

SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    job_posted_date,
    salary_year_avg,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
ORDER BY salary_year_avg DESC
LIMIT 10;