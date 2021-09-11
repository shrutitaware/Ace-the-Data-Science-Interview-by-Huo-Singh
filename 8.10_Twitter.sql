-- Step 1: CTE- Finding total number of tweets made by each user on each date
-- Step 2: Using window function, finding avg number of tweets over 6 prior rows and current row (7-day rolling average), ordering by user_id and tweet_date


WITH tweet_count AS
(
 SELECT
  	user_id,
  	CAST(tweet_date AS DATE)  AS tweet_date,
  	COUNT(*) AS num_tweets
  FROM tweets
  GROUP BY 
  	user_id,
  	CAST(tweet_date AS DATE)
)


SELECT 
	user_id,
  tweet_date,
  AVG(num_tweets) OVER
  	(PARTITION BY user_id
    	ORDER BY 
     	user_id,
    	tweet_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_7days
FROM tweet_count
