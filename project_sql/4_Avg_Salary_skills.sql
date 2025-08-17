/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
  helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg) ,2)  AS Average_Salary

FROM job_postings_fact AS jpf 

INNER JOIN skills_job_dim AS sk ON jpf.job_id =  sk.job_id
INNER JOIN skills_dim ON sk.skill_id = skills_dim.skill_id

WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND job_work_from_home = True
       

GROUP BY skills
ORDER BY  Average_Salary DESC

LIMIT 20

/*
finds from the query above
- **Core Skill Dominance**: SQL leads with 7,291 mentions,
 highlighting its essential role in driving high salaries for 
 data querying, while Python (4,330) outpaces Excel (4,611), 
 signaling a shift toward programming-based analysis over traditional tools.

- **Rising Demand for Visualization**: Tableau (3,745) and Power 
BI (2,609) show strong demand, indicating that expertise in data 
visualization is increasingly valued and likely contributes to 
top-paying roles requiring actionable insights.

- **Specialization for Higher Pay**: The high frequency of these
 skills (over 22,586 mentions across five) suggests that combining 
 SQL, Python, and visualization tools like Tableau or Power BI could 
 position Data Analysts for the highest earning potential as of August 2025.

*/