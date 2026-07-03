-- =========================================================================
-- Bank Customer Churn Analysis 
-- Step 2: Data Validation & Quality Checks
-- =========================================================================

-- 3.1 Total record count 
SELECT COUNT(*) AS total_records
FROM bank_customers;

-- 3.2 Check for NULL values in every column
SELECT 
COUNT(*)- COUNT(customer_id) AS null_customer_id,
COUNT(*)- COUNT(credit_score) AS null_credit_score,
COUNT(*)- COUNT(country) AS null_country,
COUNT(*)- COUNT(gender) AS null_gender,
COUNT(*)- COUNT(tenure) AS null_tenure,
COUNT(*)- COUNT(balance) AS null_balance,
COUNT(*)- COUNT(products_number) AS null_products_number,
COUNT(*)- COUNT(credit_card) AS null_credit_card,
COUNT(*)- COUNT(active_member) AS null_active_member,
COUNT(*)- COUNT(estimated_salary) AS null_estimated_salary,
COUNT(*)- COUNT(churn) AS null_churn
FROM bank_customers;


-- 3.3 Check for duplicate customer IDs 
SELECT customer_id, COUNT(*) AS occurences
FROM bank_customers
GROUP BY customer_id
HAVING COUNT(*)>1;


-- 3.4 Value ranges checks
SELECT
MIN(age) AS min_age,
MAX(age) AS max_age,
MIN(credit_score) AS min_credit_score,
MAX(credit_score) AS max_credit_score,
MIN(balance) AS min_balance,
MAX(balance) AS max_balance,
MIN(tenure) AS min_tenure,
MAX(tenure) AS max_tenure,
MIN(estimated_salary) AS min_estimated_salary,
MAX(estimated_salary) AS max_estimated_salary
FROM bank_customers;


-- 3.5 Validate categorical columns
SELECT DISTINCT country FROM bank_customers ORDER BY country;
SELECT DISTINCT gender FROM bank_customers ORDER BY gender;


-- 3.6 Validate binary flag columns
SELECT DISTINCT credit_card FROM bank_customers;
SELECT DISTINCT active_member FROM bank_customers;
SELECT DISTINCT churn FROM bank_customers;


-- 3.7 Validate products_number
SELECT DISTINCT products_number
FROM bank_customers
ORDER BY products_number;


-- 3.8 Overall churn split
SELECT churn, COUNT(*) AS customer_count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage 
FROM bank_customers
GROUP BY churn;