-- Step 1: Bucket users based on their transaction date (i.e. rank() and partition by users, order by trans date desc) -CTE
-- Step 2: From CTE: COUNT(DISTINCT user_id) and count (product_id), grouping by trans date, ordering date in desc
-- Step 3: Since we want only the latest transaction for each user-> rank=1

WITH latest_date AS
(
  SELECT
  	transaction_date,
  	user_id,
  	product_id,
 		RANK() OVER
  		(PARTITION BY user_id
  		ORDER BY CAST(transaction_date AS DATE) DESC
  		) AS rnk
  
  FROM user_transactions
)

SELECT
	transaction_date,
  COUNT(DISTINCT user_id) AS num_users,
  COUNT(product_id) AS total_products
FROM latest_date
WHERE rnk=1
GROUP BY transaction_date
ORDER BY transaction_date DESC
