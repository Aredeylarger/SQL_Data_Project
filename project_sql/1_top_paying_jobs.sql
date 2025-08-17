/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment.
*/

SELECT 
    job_id AS Job_ID,
    job_title,
    job_location AS Location,
    job_schedule_type AS Schedule,
    salary_year_avg AS Average_Salary,
    job_posted_date::DATE AS Posted_Date,
    name AS Company_Name

FROM 
    job_postings_fact AS jpf
LEFT JOIN
    company_dim ON jpf.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
  

ORDER BY
    salary_year_avg DESC

LIMIT 10;