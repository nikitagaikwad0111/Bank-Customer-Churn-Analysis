-- ===============================================================
-- Bank Customer Churn Analysis
-- Step 5: Churn Analysis by Demographics
-- ===============================================================


-- 5.1 Churn Rate by Age Group
SELECT CASE
	WHEN age < 30 THEN '1. Under 30'
	WHEN age BETWEEN 30 AND 40 THEN '2. 30-40'
	WHEN age BETWEEN 41 AND 50 THEN '3. 41-50'
	WHEN age BETWEEN 51 AND 60 THEN '4. 51-60'
	ELSE '5. Over 60'
END AS age_group,
COUNT(*) AS total_customers,
SUM(churn) AS churned_customers,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY age_group
ORDER BY age_group;


-- 5.2 Churn Rate by Country
SELECT country, COUNT(*) AS total_customers,
SUM(churn) AS churned_customers,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY country
ORDER BY churn_rate_pct DESC;


-- 5.3 Churn Rate by Country + Gender
SELECT country, gender, 
COUNT(*) AS total_customers,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY country, gender
ORDER BY country, gender;


-- 5.4 Churn Rate by Tenure
SELECT tenure, 
COUNT(*) AS total_customers,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY tenure
ORDER BY tenure;


-- 5.5 Product Distribution by Region
SELECT country, products_number,
COUNT(*) AS customer_count,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY country, products_number
ORDER BY country, products_number;