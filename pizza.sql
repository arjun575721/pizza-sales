
select * from pizza_sales
-- total revenue
select sum(total_price) as total_revenue 
from pizza_sales
--avg order value
select 
sum(total_price)/count(distinct order_id) as avg_order_ val
from pizza_sales

--total pizza sold (use sum bcoz quantity can be 1 or more)
select sum(quantity) as total_pizzas_sold from pizza_sales

total_orders
select count(distinct order_id) from pizza_sales

average_pizzas_perorder
select sum(quantity) / count(distinct order_id) as avg_pizza_perorder from pizza_sales

-- to group orders based on days
SELECT DAYOFWEEK(order_date) AS day_of_week, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYOFWEEK(order_date);

to group orders based on months
select monthname(order_date) as month_name, count(distinct order_id) as total_orders
from pizza_sales
group by monthname(order_date)

-- for the above if date is not in daate format
SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS month_name, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE order_date IS NOT NULL
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%Y-%m-%d'));

-- grouping pizza percentage by pizza category

select pizza_category, sum(total_price) *100 /(select sum(total_price) from pizza_sales) 
as percentage
from pizza_sales
group by pizza_category 

-- for order_date like months

SELECT 
    pizza_category, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1) AS percentage
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1
GROUP BY pizza_category;

-- categorizing based on pizza size

SELECT 
    pizza_size, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) as total_sales FROM pizza_sales WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1) AS percentage
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1
GROUP BY pizza_size;
order by percentage

--- top 5 best sellers by revenue , quantity and total orders
select  pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5

select  pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5

-- category based on orders
select  pizza_name, count( distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc
limit 5









