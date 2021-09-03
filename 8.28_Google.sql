-- Step 1 : CTE for: CAST(measurement_time AS DATE)
--  				Since we want odd and even numbered values-> ROW_NUMBER() 
-- Step 2 : SUM (Check condition for odd or even and output measurement_value) by Date
-- Step 3 : GROUP BY, ORDER BY Date

WITH measurements_by_numbering AS
(
  SELECT CAST(measurement_time AS DATE) AS measurement_day,
  				measurement_value,
  				ROW_NUMBER() OVER (PARTITION BY CAST(measurement_time AS DATE)
                             ORDER BY measurement_time ASC) AS measurements_rnk
  FROM measurements
) 


SELECT measurement_day,
			SUM(IF(measurements_rnk%2!=0, measurement_value,0)) AS odd_sum,
      SUM(IF(measurement_rnk%2=0, measurement_value,0)) AS even_sum
FROM measurements_by_numbering
GROUP BY measurement_day
ORDER BY measurement_day ASC
