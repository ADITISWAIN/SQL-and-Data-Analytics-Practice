# Correct the swapping error and return the proper pairing of order ID and item.
  
  WITH FOOD AS (
  SELECT 
    order_id, 
    CASE 
      WHEN order_id % 2 <> 0 THEN COALESCE(LEAD(item) OVER (ORDER BY order_id), item)
      ELSE LAG(item) OVER (ORDER BY order_id)
    END AS item
  FROM orders
)
SELECT order_id, item 
FROM FOOD;
