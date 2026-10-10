#Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.

WITH session_durations AS (
    SELECT
        server_id,
        status_time AS start_time,
        LEAD(status_time) OVER (PARTITION BY server_id ORDER BY status_time) AS stop_time,
        session_status
    FROM server_utilization
)
SELECT
    DATE_PART('days', JUSTIFY_HOURS(SUM(stop_time - start_time))) AS total_uptime_days
FROM session_durations
WHERE session_status = 'start';
