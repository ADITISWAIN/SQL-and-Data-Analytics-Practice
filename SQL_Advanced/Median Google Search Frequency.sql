# Write a query to report the median of searches made by a user. Round the median to one decimal point.

WITH expanded_searches AS (
    SELECT searches
    FROM search_frequency
    CROSS JOIN GENERATE_SERIES(1, num_users)
)
SELECT ROUND(CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY searches) AS NUMERIC), 1) AS median
FROM expanded_searches;
