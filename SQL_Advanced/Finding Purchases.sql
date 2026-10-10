# Identify returning active users by finding users who made a repeat purchase within 7 days or less of their previous transaction, excluding same-day purchases. Output a list of these user_id.

WITH H AS (
    SELECT 
        *, 
        created_at - LAG(created_at) OVER (PARTITION BY user_id ORDER BY created_at) AS rnk 
    FROM amazon_transactions
)
SELECT DISTINCT user_id 
FROM H 
WHERE rnk <= 7 AND rnk > 0;
