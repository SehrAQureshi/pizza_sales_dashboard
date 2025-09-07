USE pizza;

-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS TOTAL_ORDER
FROM
    pizza.orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    SUM(order_details.quantity * pizzas.price) AS total_Revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizzas.pizza_id, pizzas.price
FROM
    pizzas
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    SUM(order_details.quantity) AS Common_Ordered_Pizzas
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY Common_Ordered_Pizzas DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.pizza_type_id,
    SUM(order_details.quantity) AS top5
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.pizza_type_id
ORDER BY top5 DESC
LIMIT 5;