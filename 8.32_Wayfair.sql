-- Step 1: Total weekly spend by product using SUM and GROUP BY, WEEK can be retrived from transaction date using DATPART()
-- Step 2: Prior year's weekly spend can be retrived by using LAG for 52 weeks, PARTITION BY product
-- Step 3: total spend/ prev total spend

WITH weekly_spend AS
(
  SELECT
  	DATEPART(WEEK, transaction_date) AS week,
  	product_id,
  	SUM(spend) AS total_spend
  FROM user_transactions
  GROUP BY week, product_id
  ),
  
  total_weekly_spend AS
  (
    SELECT
    	w.*,
    	LAG(total_spend, 52) OVER (PARTITION BY product_id ORDER BY week ASC) AS prev_total_spend
    FROM weekly_spend w
    )
    
  SELECT
  	product_id,
    total_spend,
    prev_total_spend,
    total_spend / prev_total_spend AS spend_yoy
  FROM total_weekly_spend
