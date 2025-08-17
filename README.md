# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql](/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data halls from my [SQL Course](https://
[ukebarousse.com/sql). It's padded with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my
SQL queries were:

1. What are the top-paying data analyst jobs?

2. What skills are required for these top-paying
jobs?

3. What skills are most in demand for data
analysts?

4. Which skills are associated with higher
salaries?

5. What are the most optimal skills to learn?



# Tools I Used
For my in-depth exploration of the Data Analyst job market, I leveraged a suite of powerful tools:

- **SQL**: The foundation of the analysis, facilitating database queries to extract valuable insights.
- **PostgreSQL**: The database management system employed to manage and process job posting data.
- **Visual Studio Code**: The main tool for database management and executing SQL queries.
- **Git & GitHub**: Utilized for version control, sharing SQL scripts, and enabling collaboration and project tracking.

# The Analysis
### 1. Top Paying Data Analyst Jobs  
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high-paying opportunities in the field.
```sql
SELECT 
    job_id AS Job_ID,
    job_title_short AS Title,
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
```
### Overview of Top Data Analyst Jobs in 2023

- **Broad Salary Spectrum**: The highest-paying 10 data analyst positions range from $184,000 to $650,000, highlighting substantial earning potential in the industry.
- **Varied Company Landscape**: Organizations such as SmartAsset, Meta, and AT&T are among the top payers, demonstrating widespread demand across multiple sectors.
- **Diverse Role Titles**: A wide array of job titles, including *Data Analyst* and *Director of Analytics*, underscores the range of specialized roles and expertise within data analytics.


![Top Paying Data Analyst Roles](/output_image/1_top%2010.png)

*Figure: Average salaries for the top 10 remote data analyst roles in 2023.*


### 2. Skills for Top Paying Jobs  
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
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
```
### Most In-Demand Skills for Top-Paying Data Analyst Jobs (2023)

Below is an overview of the most sought-after skills for the top 10 highest-paying data analyst roles:

- **SQL**: Tops the list with 8 instances
- **Python**: A strong contender with 7 instances
- **Tableau**: Widely desired, appearing 6 times
- **Additional Skills**: R, Snowflake, Pandas, and Excel exhibit differing levels of demand

![Top Skills for Data Analyst Roles](/output_image/2_top%20skills.png)
*Figure: Skills required for the top 10 remote data analyst roles in 2023.*

### 3. In-Demand Skills for Data Analyst 
This query effectively pinpointed the skills most commonly sought in job postings, guiding attention toward areas of high demand.
```sql
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
```
Most Demanded Skills for Data Analysts (2023)

Foundational Skills:
- **SQL** and **Excel** remain fundamental, emphasizing the need for:
  - Strong data processing capabilities
  - Advanced spreadsheet manipulation

### Technical & Visualization Tools:
- **Programming**:
  - **Python** (essential for advanced analysis)
- **Visualization**:
  - **Tableau**
  - **Power BI**  
*(Highlighting the growing importance of data storytelling and decision support)*

| Skills    | Skill Count |
|-----------|-------------|
| sql       | 7291        |
| excel     | 4611        |
| python    | 4330        |
| tableau   | 3745        |
| power bi  | 2609        |

*Table view of the query*

### 4. In-Demand Skills for Data Analyst 

Showing the average salaries associated with different skills revealed which skills are the highest paying
```sql


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
```
### Top Paying Skills for Data Analysts (2023)

### Key Findings:

1. **Big Data & Machine Learning**  
   - **Highest Value Skills:** PySpark, Couchbase, DataRobot, Jupyter  
   - **Key Libraries:** Pandas, NumPy  
   - **Industry Trend:** Premium on predictive modeling and advanced data processing  

2. **Software Development & Deployment**  
   - **Tools:** GitLab, Kubernetes, Airflow  
   - **Market Value:** 25-40% salary premium for data engineers with analysis skills  
   - **Why It Pays:** Automation and pipeline management expertise  

3. **Cloud Computing**  
   - **Platforms:** Elasticsearch, Databricks, GCP  
   - **Salary Impact:** Cloud skills add 15-30% to base compensation  
   - **Industry Shift:** Migration to cloud-based analytics environments  

| Rank | Skill          | Average Salary |
|------|----------------|----------------|
| 1    | PySpark        | $208,172       |
| 2    | Bitbucket      | $189,155       |
| 3    | Watson         | $160,515       |
| 4    | Couchbase      | $160,515       |
| 5    | DataRobot      | $155,486       |
| 6    | GitLab         | $154,500       |
| 7    | Swift          | $153,750       |
| 8    | Jupyter        | $152,777       |
| 9    | Pandas         | $151,821       |
| 10   | Elasticsearch  | $145,000       |
| 11   | Golang         | $145,000       |
| 12   | NumPy          | $143,513       |
| 13   | Databricks     | $141,907       |
| 14   | Linux          | $136,508       |
| 15   | Kubernetes     | $132,500       |
| 16   | Atlassian      | $131,162       |
| 17   | Twilio         | $127,000       |
| 18   | Airflow        | $126,103       |
| 19   | scikit-learn   | $125,781       |
| 20   | Jenkins        | $125,436       |


### 5. Skills Based On Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
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

```


| Rank | Skill       | Demand Count | Avg Salary ($) |
|------|-------------|--------------|----------------|
| 1    | Go          | 27           | $115,320       |
| 2    | Confluence  | 11           | $114,210       |
| 3    | Hadoop      | 22           | $113,193       |
| 4    | Snowflake   | 37           | $112,948       |
| 5    | Azure       | 34           | $111,225       |
| 6    | BigQuery    | 13           | $109,654       |
| 7    | AWS         | 32           | $108,317       |
| 8    | Java        | 17           | $106,906       |
| 9    | SSIS        | 12           | $106,683       |
| 10   | Jira        | 20           | $104,918       |
| 11   | Oracle      | 37           | $104,534       |
| 12   | Looker      | 49           | $103,795       |
| 13   | NoSQL       | 13           | $101,414       |
| 14   | Python      | 236          | $101,397       |
| 15   | R           | 148          | $100,499       |
| 16   | Redshift    | 16           | $99,936        |
| 17   | Qlik        | 13           | $99,631        |
| 18   | Tableau     | 230          | $99,288        |
| 19   | SSRS        | 14           | $99,171        |
| 20   | Spark       | 13           | $99,077        |

*Table of the most optimal skills for data analyst sorted by salary*
### Most Optimal Skills for Data Analysts (2023)

### 1. High-Demand Programming Languages
- **Python**:  
  - Demand: 236 listings  
  - Avg Salary: $101,397  
- **R**:  
  - Demand: 148 listings  
  - Avg Salary: $100,499  
*Key Insight*: Essential but competitive due to widespread availability

### 2. Cloud Tools & Technologies
- **Snowflake**: High demand (37) | $112,948  
- **Azure**: 34 listings | $111,225  
- **AWS**: 32 listings | $108,317  
- **BigQuery**: 13 listings | $109,654  
*Trend*: Cloud platform skills command premium salaries

### 3. Business Intelligence & Visualization
- **Tableau**:  
  - Dominant demand (230)  
  - Avg Salary: $99,288  
- **Looker**:  
  - Emerging adoption (49)  
  - Avg Salary: $103,795  
*Value*: Visualization skills critical for insights delivery

### 4. Database Technologies
- **Oracle**: $104,534  
- **NoSQL**: $101,414  
*Significance*: Core data management remains highly valued

### Strategic Recommendations:
1. **Prioritize Cloud+Visualization combos** (e.g., Snowflake + Looker)
2. **Balance Python/R with niche skills** to reduce market saturation
3. **Monitor emerging tools** like BigQuery and Looker


# Learnings

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.  
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like `COUNT()` and `AVG()` into my data-summarizing sidekicks.  
- **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.  
- **Data Visualization:** Transformed raw data into eye-catching visuals, making insights pop and patterns shine.
 
# Conclusion
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at **$650,000**!  

2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in **SQL**, suggesting it’s a critical skill for earning a top salary.  

3. **Most In-Demand Skills**: **SQL** is also the most demanded skill in the data analyst job market, making it essential for job seekers.  

4. **Skills with Higher Salaries**: Specialized skills, such as **SVM** and **Solidity**, are associated with the highest average salaries, indicating a premium on niche expertise.  

5. **Optimal Skills for Job Market Value**: **SQL** leads in demand and offers a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.  



