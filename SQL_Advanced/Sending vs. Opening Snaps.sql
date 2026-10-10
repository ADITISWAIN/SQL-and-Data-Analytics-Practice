#Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output

WITH TT AS(
SELECT A.user_id, A.activity_type, A.time_spent, S.age_bucket, 
 RANK() OVER( PARTITION BY S.age_bucket ) as rnk 
  FROM activities A JOIN age_breakdown S ON A.user_id=S.user_id
),
OPN AS(
 SELECT age_bucket,SUM(time_spent) as open FROM TT WHERE activity_type= 'open' GROUP BY age_bucket
),
SPN AS(
 SELECT age_bucket,SUM(time_spent) as send FROM TT WHERE activity_type= 'send' GROUP BY age_bucket
),
BOT AS (
SELECT OPN.age_bucket, OPN.open,SPN.send FROM OPN JOIN SPN ON OPN.age_bucket=SPN.age_bucket
) 

SELECT DISTINCT age_bucket, ROUND((100.0 * send /  (send + open))::numeric, 2) AS send_perc,
    ROUND((100.0 * open /  (send + open))::numeric, 2) AS open_perc  FROM BOT 
