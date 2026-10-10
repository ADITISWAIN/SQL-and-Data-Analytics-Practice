# You're given a table containing the item count for each order on Alibaba, along with the frequency of orders that have the same item count. Write a query to retrieve the mode of the order occurrences. Additionally, if there are multiple item counts with the same mode, the results should be sorted in ascending order.

select item_count as mode
from items_per_order
where order_occurrences = (SELECT max(order_occurrences)
FROM items_per_order)
order by item_count
;
