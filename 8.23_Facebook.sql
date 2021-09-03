-- Step 1 : user retention- continued use of products by user
-- 				To calculate rentetion, check users-> this month vs last month
-- Step 2 : Users exists against previous month- > users from last month also in current month
-- Step 3 : count unique users (Monthly Active Users- MAU)

SELECT
		DATEPART(MONTH, curr_month.timestamp) AS month,
    COUNT(DISTINCT curr_month.user_id) AS mau
FROM user_actions curr_month
WHERE
	EXIST
  
(
  SELECT *
  FROM user_actions last_month
  WHERE DATEPART(MONTH, DATEADD(MONTH, -1, last_month.timestamp)) = 
  			DATEPART(MONTH, curr_month.timestamp)
  )
  GROUP BY DATEPART(MONTH, curr_month.timestamp)
  ORDER BY month ASC
