-- Step 1 : Top 100 topics for that day 2021-01-01 (CTE)
-- Step 2 : Existing users as of 2021-01-01
-- Step 3 : Users who do not follow top 100 topics (Minus from step 2)
--				Since, we want users create join with CTE

WITH top_topics AS
(
  SELECT *
  FROM topic_rankings
  WHERE ranking_date='2021-01-01'
  			AND ranking<=100
  )
  
  SELECT DISTINCT user_id
  FROM user_topics
  WHERE follow_date<='2021-01-01'     -- existing users as of 2021-01-01
  
  EXCEPT
  
  SELECT
  		u.user_id
  FROM user_topics INNER JOIN top_topics ON              -- users who follow top 100 topics
  u.topic_id=t.topic_id
