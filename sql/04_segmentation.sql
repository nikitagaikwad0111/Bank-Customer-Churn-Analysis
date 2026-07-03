-- ===============================================================
-- Bank Customer Churn Analysis
-- Step 4: Segmentation
-- ===============================================================


-- 4.1 Segment customers by Balance Tier
SELECT CASE 
WHEN balance=0 THEN '1. Zero Balance'
WHEN balance < 50000 THEN '2. Low (<50K)'
WHEN balance BETWEEN 50000 AND 100000 THEN '3. Mid (50K-100K)'
WHEN balance BETWEEN 100001 AND 150000 THEN '4. High (100K-150K)'
ELSE '5. Premium (>150K)'
END AS balance_tier,
  COUNT(*) AS customer_count,
  ROUND(AVG(churn)*100, 2) AS churn_rate_pct
  FROM bank_customers
  GROUP BY balance_tier
  ORDER BY balance_tier;


-- 4.2 Segment customers by Product Count
SELECT products_number,
COUNT(*) AS customer_count,
ROUND(AVG(churn)*100 ,2) AS churn_rate_pct,
ROUND(AVG(balance), 2) AS avg_balance
FROM bank_customers
GROUP BY products_number
ORDER BY products_number;


-- 4.3 Segment customers by Activity Level
SELECT CASE 
WHEN active_member = 1 THEN 'Active'
ELSE 'Inactive'
END AS activity_status,
COUNT(*) AS customer_count,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct,
ROUND(AVG(balance),2) AS avg_balance
FROM bank_customers
GROUP BY active_member;


-- 4.4 Segment by Gender
SELECT gender, COUNT(*) AS customer_count,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct,
ROUND(AVG(balance), 2) AS avg_balance
FROM bank_customers
GROUP BY gender;


-- 4.5 Segment by Credit Score Tier
SELECT CASE 
	WHEN credit_score < 500 THEN '1. Poor (<500)'
	WHEN credit_score BETWEEN 500 AND 650 THEN '2. Fair (500-650)'
	WHEN credit_score BETWEEN 651 AND 750 THEN '3. Good (651-750)'
	ELSE '4. Excellent (>750)'
END AS credit_tier,
COUNT(*) AS customer_count,
ROUND(AVG(churn)* 100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY credit_tier
ORDER BY credit_tier;


-- 4.6 High Churn-Risk Segment
-- Single product + Inactive = highest churn risk
SELECT COUNT(*) AS high_risk_customers,
ROUND(AVG(churn)*100, 2) AS churn_rate_pct,
ROUND(AVG(balance), 2) AS avg_balance
FROM bank_customers
WHERE products_number=1
AND active_member=0;


-- 4.6b Risk Segment Comparison
-- Compare High Risk vs all other customer combinations
SELECT CASE 
	WHEN products_number = 1 AND active_member=0 THEN '1. High Risk: 1 Product + Inactive'
    WHEN products_number = 1 AND active_member=1 THEN '2. 1 Product + Active'
    WHEN products_number > 1 AND active_member=0 THEN '3. 2+ Products + Inactive'
    WHEN products_number > 1 AND active_member=1 THEN '4. Low Risk: 2+ Products + Active'
    END AS risk_segment,
COUNT(*) AS customer_count,
ROUND(AVG(churn) * 100, 2) AS churn_rate_pct,
ROUND(AVG(balance), 2) AS avg_balance
FROM bank_customers
GROUP BY risk_segment
ORDER BY risk_segment;