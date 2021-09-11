-- Step 1: Transaction number for eah user
--		ROW_NUMBER() by partitioning by user and irder by trans date (CTE
-- Step 2: retrive transaction details for rnk=3

WITH nums AS
(
  SELECT *,
  ROW_NUMBER() OVER
  	(PARTITION BY user_id 
    ORDER BY transaction_date) AS rnk

  FROM transactions
)

SELECT 
	user_id,
  spend,
  transaction_date
FROM nums
WHERE rnk = 3
