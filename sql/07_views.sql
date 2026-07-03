-- =====================================================
-- Bank Customer Churn Analysis
-- Step 7: Creating Views
-- =====================================================


-- 7.1 Master Customer Segments View
-- Combines all segmentation logic in one reusable view
CREATE VIEW vw_customer_segments AS 
SELECT 
	customer_id,
	country,
	gender,
	age,
	balance,
	products_number,
	active_member,
	credit_score,
	tenure,
	estimated_salary,
	churn,
	---- Age Group
	CASE 
		WHEN age < 30 THEN '1. Under 30'
		WHEN age BETWEEN 30 AND 40 THEN '2. 30-40'
		WHEN age BETWEEN 41 AND 50 THEN '3. 41-50'
		WHEN age BETWEEN 51 AND 60 THEN '4. 51-60'
		ELSE '5. Over 60'
	END AS age_group,
	--- Balance Tier
	CASE 
		WHEN balance = 0 THEN '1. Zero Balance'
		WHEN balance < 50000 THEN '2. low (< 50K)'
		WHEN balance BETWEEN 50000 AND 100000 THEN '3. Mid (50K-100K)'
		WHEN balance BETWEEN 100001 AND 150000 THEN '4. High (100K-150K)'
		ELSE '5. Premium (> 150K)'
	END AS balance_tier,
	--- Activity Status
	CASE 
		WHEN active_member = 1 THEN 'Active'
		ELSE 'Inactive'
	END AS activity_status,
	--- Risk Segment
	CASE
		WHEN products_number= 1 AND active_member= 0 THEN 'High Risk'
		WHEN products_number= 1 AND active_member= 1 THEN 'Medium Risk'
		WHEN products_number> 1 AND active_member= 0 THEN 'Medium Risk'
		WHEN products_number> 1 AND active_member= 1 THEN 'Low Risk'
	END AS risk_segment,
	---Credit Tier
	CASE 
		WHEN credit_score < 500 THEN '1. Poor (< 500)'
		WHEN credit_score BETWEEN 500 AND 650 THEN '2. Fair (500-650)'
		WHEN credit_score BETWEEN 651 AND 750 THEN '3. Good (651-750)'
		ELSE '4. Excellent (> 750)'
	END AS credit_tier
FROM bank_customers;


-- 7.2 Churn Summary View
-- High level churn KPIs by country and segment
CREATE VIEW vw_churn_summary AS 
SELECT country, 
	CASE 
		WHEN products_number=1 AND active_member=0 THEN 'High Risk'
		WHEN products_number=1 AND active_member=1 THEN 'Medium Risk'
		WHEN products_number>1 AND active_member=0 THEN 'Medium Risk'
		WHEN products_number>1 AND active_member=1 THEN 'Low Risk'
	END AS risk_segment,
	COUNT(*) AS total_customers,
	SUM(churn) AS churned_customers,
	ROUND(AVG(churn)*100, 2) AS churn_rate_pct,
	ROUND(AVG(balance), 2) AS avg_balance
FROM bank_customers
GROUP BY country, risk_segment;


-- --------------------------------------------------------

SELECT * FROM vw_customer_segments LIMIT 10;

SELECT * FROM vw_churn_summary 
ORDER BY country, churn_rate_pct DESC;