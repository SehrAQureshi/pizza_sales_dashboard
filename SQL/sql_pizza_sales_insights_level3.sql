USE pizza;
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category ,
(SUM(order_details.quantity*pizzas.price) *100/(SELECT SUM(order_details.quantity*pizzas.price)
FROM order_details
JOIN pizzas
ON pizzas.pizza_id=order_details.pizza_id)) AS revenue_percentage
FROM order_details
JOIN pizzas
ON pizzas.pizza_id=order_details.pizza_id
JOIN pizza_types
ON pizza_types.pizza_type_id = pizzas.pizza_type_id group by category;

-- Analyze the cumulative revenue generated over time     
SELECT 
    HOUR(orders.order_time) AS hour,
    SUM(SUM(order_details.quantity * pizzas.price)) 
        OVER (ORDER BY HOUR(orders.order_time)) AS cumulative_revenue
FROM order_details
JOIN pizzas
    ON pizzas.pizza_id = order_details.pizza_id
JOIN orders
    ON orders.order_id = order_details.order_id
GROUP BY hour
ORDER BY hour;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT name, revenue, category from (select category, name, revenue, 
rank() over(partition by category ORDER BY Revenue DESC) as rn 
FROM 
(SELECT pizza_types.category ,pizza_types.name, 
SUM((order_details.quantity)*pizzas.price) AS Revenue
FROM order_details
JOIN pizzas
ON pizzas.pizza_id=order_details.pizza_id 
JOIN pizza_types
ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
group by category, name) as a) as b
where rn<=3;

