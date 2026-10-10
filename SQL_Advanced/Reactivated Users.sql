#Output the month in numerical format along with the count of reactivated users.

WITH HI AS(
SELECT *,EXTRACT(MONTH FROM login_date) As mth FROM user_logins),

AH AS(
SELECT user_id,mth,LAG(mth)OVER(PARTITION BY user_id ORDER BY mth) as prv FROM HI  ),

AG AS(
SELECT user_id,mth FROM AH WHERE prv IS NULL OR mth - prv > 1 )

SELECT mth,COUNT(user_id) FROM AG GROUP BY  mth ORDER BY mth
