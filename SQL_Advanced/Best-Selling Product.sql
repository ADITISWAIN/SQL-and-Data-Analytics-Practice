# Write an SQL query to find the best-selling product in each product category. If there are two or more products with the same sales quantity, go by whichever product which has the higher review rating.

WITH ranked_products AS (
    SELECT 
        p.category_name,
        p.product_name,
        DENSE_RANK() OVER (
            PARTITION BY p.category_name 
            ORDER BY ps.sales_quantity DESC, ps.rating DESC
        ) AS rnk
    FROM products p
    JOIN product_sales ps 
      ON p.product_id = ps.product_id
)
SELECT 
    category_name, 
    product_name 
FROM ranked_products 
WHERE rnk = 1 
ORDER BY category_name ASC;
  
