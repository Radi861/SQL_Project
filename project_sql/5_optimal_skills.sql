/*
Question: What are the optimal skills to learn for Data Analysts?
- Identify skills in high demand with high average salaries
- Concentrate on remote positions with specified salaries
*/
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS number_of_jobs
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
), avg_salary AS(
    SELECT
    skills_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL 
    GROUP BY skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    number_of_jobs,
    average_salary
FROM
    skills_demand INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
ORDER BY average_salary DESC