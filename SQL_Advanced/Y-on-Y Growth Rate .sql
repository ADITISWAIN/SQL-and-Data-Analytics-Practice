#Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

WITH sppend AS
(
 SELECT *,TO_CHAR(transaction_date,'YYYY')As "year" ,SUM(spend) OVER(PARTITION BY product_id ORDER BY TO_CHAR(transaction_date,'YYYY') DESC)As sum_spend
   FROM user_transactions
),
new AS
( 
 SELECT year, product_id, spend As curr_year_spend FROM sppend 
),
prv AS
(
 SELECT year, product_id,LAG(spend)OVER(PARTITION BY product_id ORDER BY year) 
   As prev_year_spend FROM sppend
),
yoy AS
(SELECT new.year, 
        new.product_id, 
        new.curr_year_spend As curr_year_spend, 
        prv.prev_year_spend FROM new JOIN prv ON new.product_id=prv.product_id AND new."year" = prv."year"
)

SELECT year,product_id,curr_year_spend,prev_year_spend,ROUND((
 (curr_year_spend-prev_year_spend)/prev_year_spend)*100,2)As yoy_rate
FROM yoy 
