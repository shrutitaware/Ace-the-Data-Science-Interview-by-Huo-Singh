-- Step 1 : CTE with total session duration by user_id, session_type between 2021-01-01 and 2021-02-01
-- Step 2 : rank() partition by session_type and ordering by total_duration

WITH total_session AS
(
  SELECT user_id,
  				session_type,
  				SUM(duration) AS total_duration
  FROM sessions
  WHERE start_time BETWEEN '2021-01-01' AND '2021-02-01'
  GROUP BY user_id,
  					session_type
  )
  
  SELECT
  			user_id,
        session_type,
        RANK() OVER (PARTITION BY user_id, session_type
                    ORDER BY user_id, total_duration DESC) AS rnk
  FROM total_session
  ORDER BY session_type,
  					rnk DESC
