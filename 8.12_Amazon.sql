-- Step 1: 2 CTEs
--		CTE 1: Finding total spend by product and category using SUM and GROUP BY.
--						Filter transaction date for only 2020
--		CTE 2: From CTE 1, rank based on each category and order by total spend in desc since we want highest grossing items
-- Step 2: Top 3 rank ordered by category and rnk in desc

WITH product_category_spend AS
(
  SELECT  
  	product_id,
  	category_id,
  	SUM(spend) AS total_spend
  FROM product_spend
  WHERE transaction_date BETWEEN '2020-01-01'
  	AND '2020-12-31'
  GROUP BY product_id,
  					category_id
),

top_spend AS
(
  SELECT
	p.*,
  RANK() OVER
  	(PARTITION BY category_id
    ORDER BY total_spend DESC) AS rnk
  
  FROM product_category_spend p
)

SELECT *
FROM top_spend
WHERE rnk<=3
ORDER BY category_id,
				rnk DESC
