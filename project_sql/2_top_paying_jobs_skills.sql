/*
Question: What skills do top paying roles require?
- Look at the top 10 highest paying jobs from the previous query
- Determine what skills those roles look for
*/

WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title_short,
        name AS company_name,
        salary_year_avg
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    COUNT(top_paying_jobs.job_id) AS number_of_jobs,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills
ORDER BY number_of_jobs DESC;