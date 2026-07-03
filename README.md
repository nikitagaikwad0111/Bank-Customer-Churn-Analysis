# 🏦 Bank Customer Churn Analysis | SQL

![SQL](https://img.shields.io/badge/Tool-SQL-blue) ![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791) ![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Business Problem Statement

The bank is experiencing customer churn which directly impacts revenue and growth. Retaining existing customers is significantly more cost-effective than acquiring new ones. However, the bank lacks visibility into which customer segments are most likely to leave and why.

This project analyzes 10,000 bank customers across France, Spain, and Germany to identify churn patterns based on demographics, account behaviour, and product usage — enabling the business to take targeted retention action before customers leave.

---

## 🎯 Objectives

1. Identify which customer segments have the highest churn rate
2. Analyze the relationship between account balance, product holdings, and churn behaviour
3. Segment customers by balance tier, activity level, and product count to pinpoint high-risk groups
4. Derive actionable insights to support targeted retention strategies for the bank's marketing and customer success teams

---

## 📂 Project Structure

```
Bank-Customer-Churn-Analysis/
│
├── README.md
├── data/
│   └── Bank_Customer_Churn_Prediction.csv
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_import_data.sql
│   ├── 03_data_validation.sql
│   ├── 04_segmentation.sql
│   ├── 05_churn_analysis.sql
│   ├── 06_window_functions.sql
│   └── 07_views.sql
└── insights/
    └── key_findings.md
```

---

## 📊 Dataset

- **Source:** [Kaggle — Bank Customer Churn Dataset](https://www.kaggle.com/datasets/gauravtopre/bank-customer-churn-dataset)
- **Rows:** 10,000 customers
- **Columns:** 12 features

| Column | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `credit_score` | Customer credit score |
| `country` | France, Spain, or Germany |
| `gender` | Male or Female |
| `age` | Customer age |
| `tenure` | Years with the bank |
| `balance` | Account balance |
| `products_number` | Number of bank products held (1–4) |
| `credit_card` | Has credit card (1=Yes, 0=No) |
| `active_member` | Is active member (1=Yes, 0=No) |
| `estimated_salary` | Estimated annual salary |
| `churn` | Churned (1=Yes, 0=No) — Target variable |

---

## 🛠️ Tools & Technologies

- **Database:** PostgreSQL 18
- **Interface:** pgAdmin 4
- **Language:** SQL (DDL, DML, Aggregations, Window Functions, Subqueries, Views)

---

## 🔍 Analysis Performed

### Step 1 — Table Creation & Data Import
Created the database schema and imported 10,000 rows from CSV.

### Step 2 — Data Validation
Validated data quality across all 12 columns — checked for NULLs, duplicates, value ranges, and categorical consistency.

### Step 3 — Customer Segmentation
Segmented customers by balance tier, product count, activity level, gender, and credit score tier.

### Step 4 — Churn Analysis
Analyzed churn rates by age group, country, gender, tenure, and product distribution across regions.

### Step 5 — Window Functions
Applied RANK(), NTILE(), AVG() OVER(), and SUM() OVER() for advanced individual-level analysis.

### Step 6 — Views
Created reusable views combining all segmentation logic for Power BI connectivity and reporting.

---

## 💡 Key Findings

| # | Finding |
|---|---|
| 1 | Customers with **1 product + inactive** churn at **36.65%** — the highest risk segment |
| 2 | **4-product customers churn at 100%** across all three countries |
| 3 | **Germany's High Risk** segment churns at **52.08%** — nearly 2x France and Spain |
| 4 | **Inactive customers** churn at **26.85%** vs **14.27%** for active customers |
| 5 | **Slightly below average balance** customers churn at **35.47%** — higher than even the poorest customers |
| 6 | **2 products = lowest churn** across all countries — the retention sweet spot |
| 7 | France and Spain's **highest balance customers** are churning — losing maximum-value clients |

---

## 📋 Business Recommendations

1. **Urgent action needed in Germany** — High Risk churn at 52% with avg balance of 120K
2. **Re-engage inactive customers** — they churn at nearly 2x the rate of active ones
3. **Cross-sell a second product** to single-product customers to move them to the retention sweet spot
4. **Avoid over-selling** — customers with 3-4 products churn at extremely high rates (79–100%)
5. **Target slightly-below-average balance customers** with personalized offers — they churn at 35.47% despite having ~96K balance

---

## 👩‍💻 Author

**Nikita Gaikwad**
- GitHub: [@nikitagaikwad0111](https://github.com/nikitagaikwad0111)
- LinkedIn: [linkedin.com/in/nikita-gaikwad](#)
