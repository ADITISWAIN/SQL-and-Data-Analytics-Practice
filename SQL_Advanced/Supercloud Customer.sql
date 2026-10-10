#A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.

WITH PRD AS(
 SELECT p.customer_id,p.product_id,p.amount,ps.product_category,
  ps.product_name,DENSE_RANK()OVER(PARTITION BY product_category ORDER BY
   product_name DESC) as rnK
    FROM customer_contracts p JOIN products ps ON p.product_id=ps.product_id
)
SELECT customer_id 
FROM PRD 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category)
FROM products);
