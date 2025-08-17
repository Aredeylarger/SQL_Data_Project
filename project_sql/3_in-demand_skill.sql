/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.
*/

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS sk
    INNER JOIN job_postings_fact AS jpf ON sk.job_id = jpf.job_id
    WHERE
        jpf.job_work_from_home = True
        AND jpf.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)
SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM
    remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;


-- alternative query to get the top 5 skills for Data Analyst jobs


SELECT 
    skills,
    count(sk.job_id) AS skill_count

FROM job_postings_fact AS jpf 

INNER JOIN skills_job_dim AS sk ON jpf.job_id =  sk.job_id
INNER JOIN skills_dim ON sk.skill_id = skills_dim.skill_id

WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.job_work_from_home = True

GROUP BY skills
ORDER BY skill_count DESC

LIMIT 5

