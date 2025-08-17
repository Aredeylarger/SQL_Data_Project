/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
  helping job seekers understand which skills to develop that align with top salaries
*/


WITH top_paying_jobs AS (

        SELECT 
            job_id AS Job_ID,
            job_title_short AS Title,
            salary_year_avg AS Average_Salary,
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

        LIMIT 10
)

SELECT 
    tpj.*,
    skills
FROM 
    top_paying_jobs AS tpj

INNER JOIN
    skills_job_dim ON tpj.job_id =  skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    tpj.Average_Salary DESC;


/*
Breakdown of Top 10 Skills

SQL

Frequency: 8
Percentage: 100.0%
Average Salary: $207,320
Context: SQL (Structured Query Language) is the cornerstone of data analysis, used for querying and manipulating databases. Its presence in every job posting underscores its universal importance for data retrieval and management in roles at companies like AT&T, Pinterest, and SmartAsset.


Python

Frequency: 7
Percentage: 87.5%
Average Salary: $205,937
Context: Python is a versatile programming language widely used for data manipulation, scripting, and automation. Its high frequency reflects its popularity for tasks like data cleaning and advanced analytics, appearing in jobs at AT&T, Pinterest, SmartAsset, and others.


Tableau

Frequency: 6
Percentage: 75.0%
Average Salary: $214,260
Context: Tableau is a leading data visualization tool, enabling analysts to create interactive dashboards. Its prevalence in 75% of roles (e.g., AT&T, Pinterest, Uclahealthcareers) highlights the demand for visual storytelling in data analysis.


R

Frequency: 4
Percentage: 50.0%
Average Salary: $215,313
Context: R is a statistical programming language favored for advanced analytics and data modeling. It appears in half the postings (e.g., AT&T, Pinterest, Motional), indicating its niche but significant role in data-heavy environments.


Excel

Frequency: 3
Percentage: 37.5%
Average Salary: $215,610
Context: Excel remains a staple for basic data analysis, reporting, and spreadsheet management. Its presence in jobs at SmartAsset and AT&T shows it’s still valued, though less universal than SQL or Python.


Pandas

Frequency: 3
Percentage: 37.5%
Average Salary: $215,610
Context: Pandas is a Python library for data manipulation and analysis. Its appearance in AT&T and SmartAsset roles aligns with Python’s dominance, as it’s a go-to tool for handling structured data programmatically.


Snowflake

Frequency: 3
Percentage: 37.5%
Average Salary: $193,436
Context: Snowflake is a cloud-based data platform for large-scale data storage and analytics. Its inclusion in SmartAsset and Inclusively postings reflects the growing adoption of cloud solutions in data analysis.


Azure

Frequency: 2
Percentage: 25.0%
Average Salary: $222,569
Context: Microsoft Azure is a cloud computing platform used for data storage and processing. Its presence in AT&T and Inclusively roles suggests a need for cloud infrastructure skills in higher-paying positions.


Power BI

Frequency: 2
Percentage: 25.0%
Average Salary: $222,569
Context: Power BI, another Microsoft tool, is used for data visualization and business intelligence. Its appearance in AT&T and Inclusively postings indicates a demand for Microsoft ecosystem expertise.


Go

Frequency: 2
Percentage: 25.0%
Average Salary: $195,500
Context: Go (Golang) is a programming language often used for backend development and data pipelines. Its inclusion in SmartAsset postings is less common for data analysts, suggesting specialized roles involving system integration or data engineering.



*/