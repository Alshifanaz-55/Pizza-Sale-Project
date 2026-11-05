CREATE DATABASE Project

USE Project


-- Check negative value

SELECT * FROM pizza_sale
WHERE 
total_price <=0 OR unit_price<=0 OR quantity<=0

--Check incorrect total price

SELECT * FROM pizza_sale
WHERE ROUND(quantity * unit_price, 2) <> ROUND(total_price, 2);

--Check extra spaces in 
SELECT *
FROM pizza_sale
WHERE pizza_name <> LTRIM(RTRIM(pizza_name))
   OR pizza_category <> LTRIM(RTRIM(pizza_category))
   OR pizza_size <> LTRIM(RTRIM(pizza_size))

-- Check valid pizza size 
SELECT DISTINCT pizza_size
FROM pizza_sale

-- Check valid pizza category
SELECT DISTINCT  pizza_category
FROM pizza_sale


-- 1 Write an SQL query to calculate the total revenue generated from all pizza sales.

Select ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sale

--2 Write an SQL query to find the average order value of all customer orders.

SELECT ROUND(SUM( total_price)/ COUNT ( DISTINCT order_id),2) AS avg_order_value
FROM pizza_sale

--3 Write an SQL query to calculate the total number of pizzas sold.

SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sale

-- 4 Write an SQL query to determine the total number of orders placed.

SELECT COUNT(DISTINCT order_id) AS total_order_placed
FROM pizza_sale

--5 Write an SQL query to calculate the average number of pizzas sold per order.

SELECT ROUND(SUM(quantity)/
COUNT(DISTINCT order_id),2) AS avg_pizza_per_order
FROM pizza_sale

--6 Write an SQL query to analyze the daily trend of total orders, showing the number of orders placed each day.

SELECT order_date,
COUNT(DISTINCT Order_id) AS total_orders
FROM Pizza_sale
GROUP BY Order_date
ORDER BY Order_date

--ANOTHER WAY

SELECT DATENAME(DW, Order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sale
GROUP BY DATENAME(DW, order_date)

--7 Write an SQL query to analyze the hourly trend of orders, showing the number of orders placed during each hour of the day.

SELECT Order_time,
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sale
GROUP BY order_time
ORDER BY Order_time

--8 Write an SQL query to calculate the percentage contribution of sales by each pizza category.

SELECT pizza_category,
ROUND(SUM(Total_price)*100/
(SELECT SUM(Total_price)FROM pizza_sale),2) AS Sales_percentage
FROM Pizza_sale
GROUP BY pizza_category
ORDER BY Sales_percentage DESC

--9 Write an SQL query to calculate the percentage contribution of sales by each pizza category.

SELECT pizza_size,
ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sale),2) AS sales_percentage
FROM pizza_sale
GROUP BY pizza_size
ORDER BY sales_percentage DESC


--the daily trends accoding to each date 

SELECT TOP 5 
order_date, COUNT(DISTINCT order_id) AS total_order
FROM pizza_sale
GROUP BY order_date
ORDER BY order_date

--the daily trends accoding to each day

SELECT DATENAME (DW ,order_date) AS day_name, COUNT (DISTINCT order_id) AS total_order
FROM pizza_sale
GROUP BY DATENAME (DW ,order_date)
ORDER BY DATENAME (DW ,order_date)

-- hourly trends of orders, showing no. of orders placed during each hour of the day

SELECT DATENAME( HOUR , order_time) AS Hourly_order, COUNT (DISTINCT order_id) AS total_order
FROM pizza_sale
GROUP BY DATENAME( HOUR , order_time)
ORDER BY DATENAME( HOUR , order_time)





-----------------------FOR PRACTICE ONLY

-- data validation and cleaning process

SELECT
SUM (CASE WHEN pizza_id IS NULL THEN 1 ELSE 0 END ) AS Null_pizza_id,
SUM (CASE WHEN order_id IS NULL THEN 1 ELSE 0 END ) AS Null_order_id,
SUM (CASE WHEN pizza_name_id IS NULL THEN 1 ELSE 0 END ) AS Null_pizza_name_id,
SUM (CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS Null_quantity,
SUM (CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS Null_order_date,
SUM( CASE WHEN order_time IS NULL THEN 1 ELSE 0 END) AS Null_order_time,
SUM (CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS Null_unit_price,
SUM (CASE WHEN pizza_size IS NULL THEN 1 ELSE 0 END) AS Null_pizza_size,
SUM (CASE WHEN pizza_category IS NULL THEN 1 ELSE 0 END) AS Null_pizza_category,
SUM (CASE WHEN pizza_ingredients IS NULL THEN 1 ELSE 0 END) AS Null_pizza_igredients,
SUM( CASE WHEN pizza_name IS NULL THEN 1 ELSE 0 END) AS Null_pizza_name 
FROM pizza_sale

-- check cell string is null or not

SELECT COUNT (*) AS blank_cell
FROM pizza_sale
WHERE pizza_id ='' OR order_id='' OR pizza_name_id='' OR quantity='' OR order_date ='' OR order_time='' OR unit_price=''
OR pizza_size='' OR pizza_category='' OR pizza_ingredients='' OR pizza_name=''

--do not have null cell

--check duplicate 

SELECT
pizza_id , order_id, pizza_name_id, quantity, order_date ,order_time, unit_price,pizza_size, pizza_category, pizza_ingredients, pizza_name, COUNT(*) AS total_duplicate
FROM pizza_sale
GROUP BY pizza_id , order_id, pizza_name_id, quantity, order_date ,order_time, unit_price,pizza_size, pizza_category, pizza_ingredients, pizza_name
HAVING COUNT(*) >1;
-- no duplicate value in this data 



-- 2) data transformation

CREATE TABLE date_table(
date_id INT IDENTITY(1,1) PRIMARY KEY,
Full_date Date,
YEAR INT,
MONTH INT,
Month_name VARCHAR(20),
QUARTER INT,
DAY INT,
WEEK INT
);

INSERT INTO date_table( full_date, year, month,month_name,quarter,day, week)
SELECT DISTINCT 
order_date,
year(order_date),
month(order_date),
DATENAME(Month, order_date),
DATEPART(quarter, order_date),
day(order_date),
DATEPART (week, order_date)
FROM pizza_sale
WHERE order_date IS NOT NULL;

SELECT * FROM date_table



CREATE TABLE time_table(
time_id INT IDENTITY (1,1) PRIMARY KEY,
full_time time,
hour INT,
minute int,
sec int,
AM_PM VARCHAR(2),
time_period VARCHAR(20)
);

INSERT INTO time_table(full_time,hour, minute, sec, AM_PM, time_period)
SELECT DISTINCT 
order_time,
DATEPART (hour, order_time),
DATEPART (minute, order_time),
DATEPART (second,order_time),

CASE
WHEN DATEPART(hour, order_time) <12 THEN 'AM' ELSE 'PM' END,

CASE 
 WHEN DATEPART(HOUR, order_time) BETWEEN 6 AND 11 THEN 'Morning'
 WHEN DATEPART(HOUR, order_time) BETWEEN 12 AND 16 THEN 'Afternoon'
 WHEN DATEPART(HOUR, order_time) BETWEEN 17 AND 20 THEN 'Evening'
 ELSE 'Night'
 END
FROM pizza_sale

WHERE order_time IS NOT NULL;

SELECT * FROM time_table



CREATE TABLE category_table(
category_id INT IDENTITY(1,1) PRIMARY KEY,
pizza_category VARCHAR(200)
);

INSERT INTO category_table( pizza_category)
SELECT DISTINCT
pizza_category
FROM pizza_sale

SELECT * FROM category_table



CREATE TABLE ingredients_table(
ingredients_id INT IDENTITY (1,1) PRIMARY KEY,
ingredients_name VARCHAR (200)
);

INSERT INTO ingredients_table(ingredients_name)
SELECT DISTINCT 
pizza_ingredients
FROM pizza_sale

SELECT * FROM ingredients_table



CREATE TABLE pizza_name_table(
pizza_id VARCHAR(100) PRIMARY KEY ,
pizza_name VARCHAR(200)
)

INSERT INTO pizza_name_table(pizza_id, pizza_name)
SELECT DISTINCT
pizza_name_id,
pizza_name
FROM pizza_sale
WHERE pizza_name_id IS NOT NULL
AND pizza_name IS NOT NULL

SELECT * FROM pizza_name_table;


CREATE TABLE pizza_orders(
order_id INT IDENTITY(1,1) PRIMARY KEY,
pizza_id VARCHAR(100),
quantity INT,
unit_price DECIMAL (10,2),
total_price DECIMAL (10,2),
date_id INT,
time_id INT,
pizza_size VARCHAR(20),
category_id INT,
ingredients_id INT,
FOREIGN KEY (date_id) REFERENCES date_table (date_id),
FOREIGN KEY (time_id) REFERENCES time_table (time_id),
FOREIGN KEY (category_id)REFERENCES category_table (category_id),
FOREIGN KEY (ingredients_id) REFERENCES ingredients_table (ingredients_id),
FOREIGN KEY (pizza_id) REFERENCES pizza_name_table (pizza_id)
)


INSERT INTO pizza_orders (
    pizza_id,
    quantity,
    unit_price,
    total_price,
    date_id,
    time_id,
    pizza_size,
    category_id,
    ingredients_id
)
SELECT 
    pnt.pizza_id,
    ps.quantity,
    ps.unit_price,
    ps.total_price,
    dt.date_id,
    tt.time_id,
    ps.pizza_size,
    ct.category_id,
    it.ingredients_id

FROM pizza_sale ps

JOIN date_table dt
    ON dt.full_date = ps.order_date

JOIN time_table tt
    ON tt.full_time = ps.order_time

JOIN category_table ct
    ON ct.pizza_category = ps.pizza_category

JOIN ingredients_table it
    ON it.ingredients_name = ps.pizza_ingredients

JOIN pizza_name_table pnt
    ON pnt.pizza_id = ps.pizza_name_id



 SELECT * FROM pizza_orders po
 JOIN date_table dt ON po.date_id = dt.date_id
 JOIN time_table tt ON po.time_id = tt.time_id
 JOIN category_table ct ON po.category_id = ct.category_id
 JOIN ingredients_table it ON po.ingredients_id = it.ingredients_id
 JOIN pizza_name_table pnt ON po.pizza_id = pnt.pizza_id





SELECT * FROM pizza_orders

SELECT * FROM pizza_sale



