-- Step 1 : Users joined within past week ie signups within past week
--				  signup_date > DATEADD(DAY, -7, GETDATE())
-- Step 2 : %users = purchased users / total users irrespective of purchase or no purchase * 100
-- Step 3 : Left Join  using join key user_id since we want total users irrespective of purchase or no purchase

SELECT
			COUNT(DISTINCT p.user_id) / COUNT(DISTINCT s.user_id) * 100 AS percent_users_last_week
FROM signups s LEFT JOIN
			user_purchases p ON s.user_id = p.user_id
WHERE s.signup_date > DATEADD(DAY, -7, GETDATE())
