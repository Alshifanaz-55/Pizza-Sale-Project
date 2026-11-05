CREATE DATABASE Project

USE Project

SELECT*FROM pizza_sale

--1) Write an SQL query to calculate the total revenue generated from all pizza sales.

SELECT ROUND(SUM(total_price),2)AS total_revenew
FROM pizza_sale

--2) Write an SQL query to find the average order value of all customer orders.

SELECT ROUND ( SUM(Total_price)/
COUNT(DISTINCT order_id),2) AS Avg_order_value
FROM pizza_sale 

--3) Write an SQL query to calculate the total number of pizzas sold.

SELECT SUM(quantity)AS total_pizza_sale
FROM pizza_sale

--4) Write an SQL query to determine the total number of orders placed.

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sale

--5 Write an SQL query to calculate the average number of pizzas sold per order.

SELECT ROUND(SUM(quantity)/
COUNT(DISTINCT order_id),2) AS avg_pizza_per_order
FROM pizza_sale

--6) Write an SQL query to analyze the daily trend of total orders, showing the number of orders placed each day.

SELECT DATENAME(DW, Order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sale
GROUP BY DATENAME(DW, order_date)

--7) Write an SQL query to analyze the hourly trend of orders, showing the number of orders placed during each hour of the day.

SELECT Order_time,
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sale
GROUP BY order_time
ORDER BY Order_time

--8) Write an SQL query to calculate the percentage contribution of sales by each pizza category.

SELECT pizza_category,
ROUND(SUM(Total_price)*100/
(SELECT SUM(Total_price)FROM pizza_sale),2) AS Sales_percentage
FROM Pizza_sale
GROUP BY pizza_category
ORDER BY Sales_percentage DESC

--9) Write an SQL query to calculate the percentage contribution of sales by each pizza size.

SELECT pizza_size,
ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sale),2) AS sales_percentage
FROM pizza_sale
GROUP BY pizza_size
ORDER BY sales_percentage DESC