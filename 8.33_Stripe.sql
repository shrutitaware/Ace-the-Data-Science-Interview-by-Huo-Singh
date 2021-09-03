-- Step 1: find total daily transaction by SUM and GROUP BY
-- Step 2: Self join using 2 conditions:
--				1. Transaction date for one transaction occurs within 7 days of other
--				2. Earlier transaction date doesn't precede the later date


WITH daily_transaction AS
(
  SELECT CAST(transaction_date AS DATE),
  				SUM(amount) AS total_amount
  FROM user_transactions
  GROUP BY transaction_date
)

SELECT t2.transaction_date,
				SUM(t1.amount) AS weekly_rolling_amount
FROM daily_transaction t1
INNER JOIN daily_transaction t2 ON
t1.transaction_date > DATEADD(DAY, -7, t2.transaction_date) AND
t1.transaction_date <= t2.transaction_date
GROUP BY t2.transaction_date
ORDER BY t2.transaction_date ASC
