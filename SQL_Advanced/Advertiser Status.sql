# Write a query to update the payment status of Facebook advertisers based on the information in the daily_pay table. The output should include the user ID and their current payment status, sorted by the user id.

SELECT COALESCE(adv.user_id,dp.user_id) AS user_id,
CASE WHEN adv.user_id IS NULL THEN 'NEW'
ELSE
  CASE WHEN dp.user_id IS NULL THEN 'CHURN'
  ELSE
    CASE STATUS
    WHEN 'NEW' THEN 'EXISTING'
    WHEN 'EXISTING' THEN 'EXISTING'
    WHEN 'CHURN' THEN 'RESURRECT'
    WHEN 'RESURRECT' THEN 'EXISTING'
    END
  END
END AS new_status
FROM
   advertiser adv
FULL OUTER JOIN 
   daily_pay dp
ON adv.user_id=dp.user_id
ORDER BY user_id
