-- Step 1 : Find all the users who did not login last month: 
--	    users between current month and current month - 1 (ie. last month)
-- Step 2 : WHERE EXISTS against previous month
-- Step 3 : COUNT no. of users satisfying this condition

SELECT
      DATEPART(MONTH, curr_month.login_date) AS current_month,
      COUNT(*) AS num_reactivated_users
FROM user_logins curr_month
WHERE EXISTS

(
  SELECT *
  FROM user_logins last_month
  WHERE
  DATEPART(MONTH, last_month.login_date) BETWEEN
  DATEPART(MONTH, curr_month.login_date) AND DATEPART(MONTH, DATEADD(MONTH, -1, curr_month.login_date))
)
