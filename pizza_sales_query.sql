Create database Pizza_db;
use Pizza_db;
/* changing data type of column order_date to DATE and column order_time to TIME */

ALTER TABLE pizza_sales MODIFY COLUMN order_time TIME;
ALTER TABLE pizza_sales MODIFY COLUMN order_date DATE;

SET SQL_SAFE_UPDATES = 0;

-- To convert the existing text values in the order_date column to date format. %d-%m-%Y
UPDATE pizza_sales SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
ALTER TABLE pizza_sales MODIFY COLUMN order_date DATE;

SET SQL_SAFE_UPDATES = 1;

Select * FROM pizza_sales;
-- 1) Finding KPI
-- a) Total revenue 
Select sum(total_price) as total_revenue FROM pizza_sales;

-- b) Average Order value
Select sum(total_price)/count(distinct order_id) as average_order_value FROM pizza_sales;

-- c) Total pizzas Sold
Select sum(quantity) from pizza_sales;

-- d) Total Orders
SELECT COUNT(DISTINCT order_id) AS total_ordes_placed FROM pizza_sales;

-- e) Average pizzas per order
SELECT Round(sum(quantity)/COUNT(DISTINCT order_id),2) AS average_pizzas_per_order FROM pizza_sales;

-- 2) Daily Trend for Total Orders
SELECT Dayname(order_date) AS day, count(distinct order_id) as total_orders FROM pizza_sales group by day;

-- 3) Monthly Trend for orders
SELECT monthname(order_date) AS month, count(distinct order_id) as total_orders FROM pizza_sales group by month;

-- 4) % of Sales by Pizza Category
Select pizza_category,Round(sum(total_price)/(select sum(total_price) from pizza_sales)*100,2) AS percentage from pizza_sales group by pizza_category;

-- 5) % of sales by pizza size
Select pizza_size , Round(sum(total_price)/(select sum(total_price) from pizza_sales)*100,2) AS percentage from pizza_sales group by pizza_size;

-- 6) total pizza sold by pizza category
Select pizza_category,sum(quantity) AS pizza_sold  from pizza_sales group by pizza_category;

-- 7) Top 5 pizza by Revenue
Select pizza_name,sum(total_price) as total_revenue  from pizza_sales group by pizza_name order by sum(total_price) DESC LIMIT 5;

-- 8) Bottom 5 pizza by Revenue
Select pizza_name,round(sum(total_price),2) as total_revenue  from pizza_sales group by pizza_name order by sum(total_price) ASC LIMIT 5;

-- 9) Top 5 Pizzas by Quantity
Select pizza_name, sum(quantity)  from pizza_sales group by pizza_name order by sum(quantity) DESC LIMIT 5;

-- 10) Bottom 5 Pizzas by Quantity
Select pizza_name, sum(quantity)  from pizza_sales group by pizza_name order by sum(quantity) ASC LIMIT 5;

-- 11) Top 5 Pizzas by Total Orders
Select pizza_name,count(distinct order_id) as total_orders  from pizza_sales group by pizza_name order by total_orders DESC LIMIT 5;

-- 12) Borrom 5 Pizzas by Total Orders
Select pizza_name,count(distinct order_id) as total_orders  from pizza_sales group by pizza_name order by total_orders ASC LIMIT 5;
