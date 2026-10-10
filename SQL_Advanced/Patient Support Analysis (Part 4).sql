#To analyze the performance of the program, write a query to determine the month-over-month growth rate specifically for long-calls. A long-call is defined as any call lasting more than 5 minutes (300 seconds).

WITH monthly_long_calls AS (
    SELECT 
        EXTRACT(YEAR FROM call_date) AS yr,
        EXTRACT(MONTH FROM call_date) AS mnth,
        COUNT(case_id) AS current_calls
    FROM callers
    WHERE call_duration_secs > 300
    GROUP BY EXTRACT(YEAR FROM call_date), EXTRACT(MONTH FROM call_date)
),
with_previous AS (
    SELECT 
        yr,
        mnth,
        current_calls,
        LAG(current_calls) OVER (ORDER BY yr, mnth) AS prev_calls
    FROM monthly_long_calls
)
SELECT 
    yr,
    mnth,
    ROUND(
        ((current_calls - prev_calls)::numeric / NULLIF(prev_calls, 0)) * 100, 
        1
    ) AS long_calls_growth_pct
FROM with_previous
ORDER BY yr, mnth;
