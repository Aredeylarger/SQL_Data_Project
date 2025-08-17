/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT 
        sk.skill_id,
        sd.skills,
        COUNT(sk.job_id) AS skill_count

    FROM job_postings_fact AS jpf 

    INNER JOIN skills_job_dim AS sk ON jpf.job_id = sk.job_id
    INNER JOIN skills_dim AS sd ON sk.skill_id = sd.skill_id

    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = True

    GROUP BY sk.skill_id,sd.skills
), 
Avg_salary AS (
    SELECT 
        sk.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 2) AS Average_Salary

    FROM job_postings_fact AS jpf 

    INNER JOIN skills_job_dim AS sk ON jpf.job_id = sk.job_id
    INNER JOIN skills_dim AS sd ON sk.skill_id = sd.skill_id

    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = True

    GROUP BY sk.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.skill_count,
    Avg_salary.Average_Salary
FROM
    skills_demand
INNER JOIN Avg_salary ON skills_demand.skill_id = Avg_salary.skill_id

WHERE skill_count > 10
    AND Average_Salary IS NOT NULL

ORDER BY 
        Average_Salary DESC,
        skill_count DESC

LIMIT 20;


/*

Insights and Trends for Optimal Skills to Become a Great Data Analyst

High Demand Meets Moderate Salaries: The most in-demand skills,
 Python (236 mentions) and Tableau (230 mentions), have lower average
salaries ($101,397.22 and $99,287.65, respectively) compared to less
common skills like Go ($115,319.89 for 27 mentions). This suggests 
that while Python and Tableau are foundational and widely sought after, 
their high demand may dilute average pay due to market saturation. 
Conversely, niche skills like Go, Confluence, and Hadoop (with fewer mentions 
but higher salaries, $113,192.57–$115,319.89) indicate premium pay for 
specialized expertise, pointing to a trend where mastering less common, 
high-value skills can significantly boost earnings.

Cloud and Big Data Dominance: Cloud platforms (Snowflake, Azure, AWS, 
BigQuery, Redshift) and big data tools (Hadoop, Spark) feature prominently, 
with Snowflake ($112,947.97 for 37 mentions) and Azure ($111,225.10 for 34 
mentions) leading in salary. This trend reflects the growing reliance on 
cloud-based data solutions and big data processing in remote Data Analyst roles, 
suggesting that proficiency in these technologies is increasingly critical 
for high-paying opportunities and future-proofing a career.
Visualization and Programming Balance: Traditional visualization tools 
(Tableau, Looker, Qlik) and programming languages (Python, R, Java) remain 
essential, with Looker ($103,795.30 for 49 mentions) and R ($100,498.77 
for 148 mentions) showing a balance of demand and decent pay. However, the 
presence of niche tools like SSIS ($106,683.33 for 12 mentions) and SSRS 
($99,171.43 for 14 mentions) alongside collaboration tools (Jira, Confluence) 
highlights a trend toward integrated skill sets—combining data processing, 
visualization, and project management—which employers value for remote, 
high-salary roles.
*/