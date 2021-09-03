-- Step 1 : self join,  Finding concurrent sessions so no two sessions_ids can be same
-- Step 2 : Sessions are concurrent if:
-- 		a. s1 starts first, s2 start >= s1 start
--		b. s2 starts first, s2 start <= s1 end
--	i.e s2 start between s1 start and s1 end
-- COUNT concurrent sessions and find only largest number


SELECT TOP (1) 
		s1.session_id,
		COUNT(s2.session_id) AS concurrents
FROM sessions s1 INNER JOIN
sessions s2 ON s1.session_id!=s2.session_id
AND s2.start_time BETWEEN s1.start_time
		  AND s1.end_time
GROUP BY s1.session_id
ORDER BY concurrents DESC
