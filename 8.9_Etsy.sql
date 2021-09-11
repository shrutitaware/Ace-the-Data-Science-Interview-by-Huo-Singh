-- Step 1: user_id, spend, transaction_date
-- CTE - Number them by partitioning by user and ordering by transaction_date
-- Step 2: Retrieve only 1st transaction by rowrnk=1 and filtering spend>=$450


WITH trans_num AS
(
  SELECT
  	user_id,
  	spend,
  	ROW_NUMBER() OVER
  		(PARTITION BY user_id
      ORDER BY transaction_date ASC) AS rowrnk
  FROM user_transactions
)

SELECT
	user_id
FROM trans_num
WHERE rowrnk = 1
	AND spend >= 50
