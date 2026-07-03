-- =================================================================
-- Bank Customer Churn Analysis
-- Step 6: Window Functions
-- =================================================================



-- 6.1 Rank customers by balance within each country
SELECT customer_id, country, balance, 
RANK() OVER (PARTITION BY country 
ORDER BY balance DESC) AS balance_rank,
ROUND(AVG(balance) OVER (PARTITION BY country), 2) AS avg_balance_in_country
FROM bank_customers
ORDER BY country, balance_rank;


-- 6.2 Running total of churned customers by age group
SELECT CASE 
	WHEN age < 30 THEN '1. Under 30'
	WHEN age BETWEEN 30 AND 40 THEN '2. 30-40'
	WHEN age BETWEEN 41 AND 50 THEN '3. 41-50'
	WHEN age BETWEEN 51 AND 60 THEN '4. 51-60'
	ELSE '5. Over 60'
END AS age_group,
COUNT(*) AS churned_customers,
SUM(churn) AS churned_customers,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct,
SUM(SUM(churn)) OVER(ORDER BY MIN(age)) AS running_total_churned
FROM bank_customers
GROUP BY age_group
ORDER BY age_group;


-- 6.3 Customer balance percentile within their country
SELECT customer_id, country, balance, NTILE(4) 
OVER(PARTITION BY country
ORDER BY balance) AS balance_quartile
FROM bank_customers
ORDER BY country, balance_quartile;


-- 6.4 Compare each customer's balance to country average
SELECT customer_id, country, balance, 
ROUND(AVG(balance) OVER(PARTITION BY country), 2) AS country_avg_balance,
ROUND(balance - AVG(balance) OVER(PARTITION BY country), 2) AS diff_from_avg
FROM bank_customers
ORDER BY country, diff_from_avg DESC;


-- Customers significantly BELOW country average who also churned
SELECT * FROM (
    SELECT 
        customer_id, country, balance, churn,
        ROUND(balance - AVG(balance) OVER (
            PARTITION BY country), 2) AS diff_from_avg
    FROM bank_customers
) diff_data
WHERE diff_from_avg < -50000
AND churn = 1;



-- 6.4b Do customers significantly below country average actually churn more?
SELECT 
    CASE 
        WHEN diff_from_avg < -50000 THEN '1. Way Below Average (< -50K)'
        WHEN diff_from_avg BETWEEN -50000 AND 0 THEN '2. Slightly Below Average'
        WHEN diff_from_avg BETWEEN 0 AND 50000 THEN '3. Slightly Above Average'
        ELSE '4. Way Above Average (> +50K)'
    END AS balance_vs_avg_group,
    COUNT(*) AS customer_count,
    SUM(churn) AS churned_customers,
    ROUND(AVG(churn) * 100, 2) AS churn_rate_pct,
    ROUND(AVG(balance), 2) AS avg_balance
FROM (
    SELECT 
        customer_id,
        country,
        balance,
        churn,
        ROUND(balance - AVG(balance) OVER (
            PARTITION BY country
        ), 2) AS diff_from_avg
    FROM bank_customers
) diff_data
GROUP BY balance_vs_avg_group
ORDER BY balance_vs_avg_group;



--6.5 Top 3 highest balance customers per country
SELECT * FROM (
	SELECT customer_id, country, balance, churn, RANK() OVER ( 
	PARTITION BY country 
	ORDER BY balance DESC) AS balance_rank
	FROM bank_customers) ranked
WHERE balance_rank <= 3
ORDER BY country, balance_rank;
	