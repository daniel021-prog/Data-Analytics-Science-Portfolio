# 📊 HR Analytics & Workforce Intelligence

### Goals: Support strategic decisions in talent management, diversity initiatives, and organizational planning by transforming raw HR data into actionable workforce KPIs.

---

## 📌 Project Overview
This project analyzes a comprehensive human resources dataset containing over **22,214 records** spanning from 2000 to 2020. Utilizing SQL for data engineering and PowerBI for data visualization, the analysis deep-dives into workforce demographics, retention patterns, turnover rates, and geographic distribution.

---

## 📁 Project Structure
* SQL: Contains all the SQL scripts, DDL schemas, cleaning pipelines, and analytical business queries executed in PostgreSQL (pgAdmin 4).
* Data: Source workforce data files containing employee profiles, departmental records, and historical termination tracking.

---

## 🛠️ SQL & BI Toolset
* **Data Engineering & Cleaning**: Processed in **PostgreSQL (pgAdmin 4)** using robust filtering, age validation algorithms, and timestamp parsing to handle data inconsistencies.
* **Analytical Queries**: Leveraged advanced aggregations, grouping, conditional logic (`CASE` statements), and subqueries to calculate key organizational performance indicators.
* **Data Visualization**: Developed dynamic, production-ready corporate dashboards using **PowerBI** to present workforce distribution and time-series trends.

---

## 📊 Key Findings

* **Gender Dynamics**: The workforce shows a higher proportion of male employees compared to female employees. However, the **Engineering department** stands out with the highest representation of women, highlighting strong gender diversity in technical roles.
* **Race & Ethnicity**: The predominant race/ethnicity segment among the organization's workforce is White.
* **Workplace Modality**: Headquarters-based employees significantly outnumber those working from remote locations.
* **Age & Career Stage**: The most common age range among employees is **33–42 years**, indicating a mature, experienced, and mid-career workforce.
* **Tenure & Retention**: The average length of employment is approximately **8 years**, serving as a solid indicator of organizational stability and robust talent retention.
* **Turnover Hotspots**: The **Auditing department** records the highest turnover rate across the entire company, pointing to potential areas for retention strategy review.
* **Geographic Concentration**: **Ohio** hosts the single largest concentration of employees, positioning it as the company's primary employment and operational hub.
* **Growth Vectors**: The vast majority of employee start dates fall between 2020 and 2023, reflecting a sharp trajectory of recent organizational growth and workforce expansion.

---

## ⚠️ Data Constraints & Limitations
To ensure maximum metrics accuracy, strict data quality rules were applied during the SQL processing phase:
* **Age Validation**: Records with anomalous negative ages (**967 rows**) were filtered out. The final analysis strictly includes adult labor force data (employees aged 18 and above).
* **Termination Date Filtering**: Records containing anomalous termination dates set far into the future (**1,075 rows**) were excluded. Only termination entries less than or equal to the current historical execution date were evaluated to maintain calculation integrity.

---

## 💡 Conclusion
The analysis reveals a highly stable organization experiencing rapid recent expansion, anchored by a solid mid-career workforce with an outstanding average tenure of 8 years. Additionally, progress in diversity is evident in key areas such as female integration into technical engineering paths.

To capitalize on these insights, leadership should focus on addressing localized retention bottlenecks, specifically within the **Auditing department**, which displays the highest turnover risk. Furthermore, given the heavy talent concentration in Ohio and at headquarters, developing structured framework policies for remote workers and cross-state employees could optimize recruitment pipelines and support sustainable multi-regional scaling.
