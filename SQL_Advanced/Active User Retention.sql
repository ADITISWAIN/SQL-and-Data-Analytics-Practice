# Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022,including the month in numerical format "1, 2, 3".

WITH july_users AS (
  SELECT DISTINCT user_id
  FROM user_actions
  WHERE EXTRACT(MONTH FROM event_date) = 7
    AND EXTRACT(YEAR FROM event_date) = 2022
),
june_users AS (
  SELECT DISTINCT user_id
  FROM user_actions
  WHERE EXTRACT(MONTH FROM event_date) = 6
    AND EXTRACT(YEAR FROM event_date) = 2022
)
SELECT 
  7 AS month,
  COUNT(j.user_id) AS monthly_active_users
FROM july_users j
JOIN june_users p 
  ON j.user_id = p.user_id;
