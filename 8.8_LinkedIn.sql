-- Step 1: Find all companies with duplicate listing based on title, description
--	CTE- Rank by partitioning by company, title, description; order by porting date
-- Step 2: To find duplicate entries, retrive companies having rank more than 1
-- Step 3: Count these companies

WITH job_listing_ranks AS
(
  SELECT
  	company_id,
  	title,
  	description,
  	RANK() OVER
  		(PARTITION BY company_id,
  									title,
  									description
      ORDER BY post_date) AS rnk
  FROM job_listings
)

SELECT COUNT(DISTINCT company_id)
FROM
(SELECT 
	company_id
FROM job_listing_ranks
WHERE MAX(rnk) > 1)
