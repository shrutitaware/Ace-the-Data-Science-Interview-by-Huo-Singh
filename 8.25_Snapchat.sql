-- Step 1 : CTE with total time spent sending, total time spent opening using SUM and IF, total time spent: group by age
-- type= 'send', 'open'
-- Percentage of sending/ opening vs overall time spent

WITH time_stats AS
(
  SELECT
  			 age_breakdown.age_bucket,
  				SUM(IF(type='send', time_spent, 0)) AS send_timespent,
  				SUM(IF(type='open', time_spent, 0)) AS open_timespent,
  				SUM(time_spent) AS total_timespent
  FROM  activities INNER JOIN age_breakdown ON
  activities.user_id=age_breakdown.user_id
  WHERE activities.type IN ('send', 'open')
  GROUP BY age_breakdown.age_bucket
  )
  
  SELECT age_bucket,
  				(send_timespent / total_timespent) * 100 AS pct_send,
          (open_timespent / total_timespent) * 100 AS pct_open
  FROM time_stats
