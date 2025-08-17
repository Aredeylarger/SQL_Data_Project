SELECT job_posted_date

FROM job_postings_fact
LIMIT 20;

SELECT 
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Posted_Date

FROM 
    job_postings_fact

LIMIT 20;

SELECT 
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Posted_Date ,
    EXTRACT(YEAR FROM job_posted_date) AS Year_Posted,
    EXTRACT(MONTH FROM job_posted_date) AS Month_Posted

FROM
    job_postings_fact

LIMIT 20;

SELECT 
    COunt(job_id) AS total_jobs,
    EXTRACT(MONTH FROM job_posted_date) AS Month_Posted

FROM
    job_postings_fact

where 
    job_title_short = 'Data Analyst'

GROUP BY  
    Month_Posted

ORDER BY
    total_jobs DESC;