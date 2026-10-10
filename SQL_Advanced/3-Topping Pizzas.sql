# Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.
Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.

SELECT 
    CONCAT(t1.topping_name, ',', t2.topping_name, ',', t3.topping_name) AS pizza,
    t1.ingredient_cost + t2.ingredient_cost + t3.ingredient_cost AS total_cost
FROM pizza_toppings t1
JOIN pizza_toppings t2 ON t1.topping_name < t2.topping_name
JOIN pizza_toppings t3 ON t2.topping_name < t3.topping_name
ORDER BY total_cost DESC, pizza ASC;
