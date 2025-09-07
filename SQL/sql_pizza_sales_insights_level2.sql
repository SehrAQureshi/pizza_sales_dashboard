USE pizza;
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category, SUM(order_details.quantity) AS total_quantity
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_quantity;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(orders.order_time) AS hours, 
    COUNT(orders.order_id)
FROM
    orders
GROUP BY hours
ORDER BY hours;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pizza_types.category, COUNT(name) AS Types_of_pizza
FROM
    pizza_types 
GROUP BY pizza_types.category
ORDER BY Types_of_pizza;

-- Group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    AVG(number_ofpizzas) AS Average
FROM
    (SELECT 
        DATE(orders.order_date) AS date,
            SUM(order_details.quantity) AS number_ofpizzas
    FROM
        orders
    JOIN order_details ON order_details.order_id = orders.order_id
    GROUP BY date) AS pizza_ordered;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.pizza_type_id,
    SUM(order_details.quantity * pizzas.price) AS total_Revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.pizza_type_id
ORDER BY total_Revenue DESC
LIMIT 3;

