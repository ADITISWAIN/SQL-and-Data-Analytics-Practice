# Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns. Refer to the Example Output below for the desired format.

WITH ranked AS (
    SELECT 
        measurement_value,
        measurement_time,
        CAST(measurement_time AS DATE) AS measurement_day,
        ROW_NUMBER() OVER (PARTITION BY CAST(measurement_time AS DATE) ORDER BY measurement_time ASC) AS rn
    FROM measurements
),
H AS (
    SELECT measurement_day, SUM(measurement_value) AS odd_sum
    FROM ranked
    WHERE rn % 2 <> 0
    GROUP BY measurement_day
),
V AS (
    SELECT measurement_day, SUM(measurement_value) AS even_sum
    FROM ranked
    WHERE rn % 2 = 0
    GROUP BY measurement_day
)
SELECT H.measurement_day, H.odd_sum, V.even_sum
FROM H 
JOIN V ON H.measurement_day = V.measurement_day ORDER BY measurement_day ;
