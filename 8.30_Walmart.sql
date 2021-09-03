-- Step 1 : (CTE) Join tables transactions and products using join key product_id to get
-- 				        user_id, product_name and transaction_id
-- Step 2 : With above CTE, self join to fetch products purchased by single user in same transaction (i.e self join on transaction_id)
-- Step 3 : To avoid overcount, use condition product_id of 1st user < product_id of 2nd user (Eg. User 1 purchases two items X and Y, we want to count only (X,Y) transaction and not (Y,X))
-- Step 4 : Count and Group By
-- Step 5 : Top (10) products only

WITH purchase_info AS
(
 SELECT
  t.user_id,
  p.product_id,
  p.product_name,
  t.transaction_id
  FROM transactions t INNER JOIN 
  products p ON t.product_id=p.product_id
)

SELECT Top(10) 
        p1.product_name AS Product1,
				p2.product_name AS Product2,
        COUNT(*) AS num_products
FROM purchase_info p1 JOIN
			purchase_info p2 ON p1.transaction_id=p2.transaction_id
      AND p1.product_id < p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY num_products DESC
