# 📊 ModuWork Sales Analysis

### Goals: Support data-driven decision making by transforming raw sales data into meaningful KPIs and business metrics.
---
## 📌 Project Overview
This project analyzes ModuWork's transactional sales data using SQL to uncover 
actionable business insights around revenue performance, product trends, and 
customer behavior patterns.

---
## 📁 Project Structure
  * **[SQL/](./SQL)**: Contains all the SQL scripts, queries, data aggregations, relational database             analyses executed in pgAdmin and dashboards made in Looker Studio

  * **[01. Data/](./01.Data)**: Source data files in CSV format (`01.customer.csv`, `02.product.csv`, `03.sales.csv`).
---

## 🛠️ SQL Toolset 

* **CTEs & Subqueries:** Build modular, highly readable, and maintainable analytical pipelines.
* **Window Functions:** Applied for ranking algorithms (e.g., Top N products) and behavioral partitioning.
* **JOINS & UNIONS:** multi-table transactional schema blending
* **CASE Statements:** dynamic customer classification and metric segmentation
* **Aggregation Functions:** Used alongside grouping to compute revenue and performance KPIs.
* **DDL Basics & Data Types:** optimal schema definitions to ensure data integrity
---

## 📊 Key Findings

- **Technology** is the top-performing category with **$836,154** in total sales (36.4%),
  followed by Furniture (32.25%) and Office Supplies (31.3%).

- The **West region** leads in revenue with **$764,634**, while South is the 
  lowest with $402,031.

- **Canon imageCLASS 2200 Advanced Copier** is the #1 best-selling product 
  with **$61,599** in sales.

- The majority of sales (**$1.47M**) come from transactions over $500 USD,
  indicating a high-ticket purchase pattern.

- The **Adult segment (30–55)** represents the largest customer group with 
  387 customers, followed by Seniors (241) and Young (<30) with 165.

- **West region** also concentrates the highest number of customers (32.2%),
  consistent with its revenue dominance.

- **Top customer Sean Miller** generated **$25,043** in total spending,
  nearly 32% more than the second-highest spender.

- Average discount is relatively consistent across categories: 
  Furniture (0.17), Technology (0.16), Office Supplies (0.13).
---

## 💡 Conclusion

The analysis reveals that ModuWork's revenue is primarily driven by high-ticket 
transactions (>$500 USD), with Technology leading category performance and the 
West region dominating both sales and customer concentration. The adult segment 
(30–55) represents the core customer base.

However, the South and Central regions show a significant revenue gap compared 
to West and East, representing an untapped growth opportunity. Targeted 
strategies such as region-specific promotions, expanded product availability, 
and discount adjustments in underperforming categories could help close this 
gap. Additionally, the low representation of Young customers (<30) suggests 
potential for customer base expansion — particularly through promotions focused 
on the **Phones sub-category within Technology**, which aligns naturally with 
younger demographics' preferences and purchasing behavior in the South and 
Central regions.


---

## 📊 Interactive Dashboard
You can view the live, dynamic, and interactive report at the following link:
👉 **[Looker Studio Live Dashboard](https://datastudio.google.com/s/usoeKXuaCL4)**

