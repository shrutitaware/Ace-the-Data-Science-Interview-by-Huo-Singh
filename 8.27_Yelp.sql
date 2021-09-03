-- Step 1 : CTE for: lowest number of reviews given to a business across all its reviews
--		     business_id, min(review_stars)
-- Step 2 : Total top-rated business (ie. 4 or 5 stars) / total number of businesses *100
--	    (SUM(Check condition if reviews >= 4) / count(*)) * 100


WITH min_reviews AS 
(
  SELECT business_id,
  	 min(review_stars) AS min_stars
  FROM reviews
  GROUP BY business_id
)

SELECT
	(SUM (IF(min_stars>=4, 1, 0)) / COUNT(*)) * 100 AS percent_top_places
FROM min_reviews
