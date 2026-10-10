#Write a query to obtain the number of unique callers who made calls within a 7-day interval of their previous calls. If a caller made more than two calls within the 7-day period, count them only once.

WITH HI AS(
SELECT policy_holder_id	,case_id ,call_category	,call_date ,call_duration_secs, LEAD(call_date)
 OVER(PARTITION BY policy_holder_id ORDER BY call_date) As next_call FROM callers),
 
AH AS(
SELECT policy_holder_id,
        next_call - call_date AS time_diff FROM HI )

SELECT COUNT(DISTINCT policy_holder_id) AS policy_holder_count
FROM AH
WHERE time_diff <= INTERVAL '7 days'
