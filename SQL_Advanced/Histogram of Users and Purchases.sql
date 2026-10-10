# Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, write a query that retrieve the users along with the number of products they bought.

WITH AH AS(
SELECT product_id,user_id,transaction_date,DENSE_RANK()OVER(PARTITION BY user_id ORDER BY transaction_date DESC)
 AS rnk FROM user_transactions),
HI AS(
SELECT transaction_date, user_id,COUNT(user_id) as purchase_count ,rnk
 FROM AH GROUP BY transaction_date, user_id,rnk)

SELECT transaction_date, user_id, purchase_count FROM HI WHERE rnk=1
