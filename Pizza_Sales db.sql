select * from pizza_sales;

----------------------------------------------------------KPI'S----------------------------

---Total Revenue
select sum(total_price) as Total_Revenue
from pizza_sales;

---Average Order Value
select cast(cast(sum(total_price) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2))as decimal(10,2)) as AVG_Order_Value
from pizza_sales;

---Total Pizzas sold
select sum(quantity) as Total_Pizza_Sold
from pizza_sales;

---Total Orders
select count(distinct order_id) as Total_Orders
from pizza_sales;

--Average pizzas quantity per order 
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal (10,2)) as decimal(10,2)) as AVG_Quantity_of_Pizza
from pizza_sales;



-------------------------------------------CHARTS REQUIREMENTS-------------------------------------

--Daily Trend for Total Orders
Select TO_CHAR(order_date::date, 'Day') as Day, count(distinct order_id) as total_orders
from pizza_sales
group by TO_CHAR(order_date::date, 'Day');


--- Monthly Trend for Total Orders
Select TO_CHAR(order_date::date, 'Month') as Month, count(distinct order_id) as total_orders
from pizza_sales
group by TO_CHAR(order_date::date, 'Month');


--- Percentage of Total Sales by Pizza Category
select pizza_category,cast(sum(total_price) as decimal(10,2)) as total_sales, cast(cast(sum(total_price) *100 as decimal(10,2))/ cast((select sum(total_price) from pizza_sales as PCT) as decimal(10,2)) as decimal(10,2))
from pizza_sales
group by pizza_category;


---Percentage of Sales by Pizza Size
select pizza_size, cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as Total_Sales_Percentage
from pizza_sales
WHERE EXTRACT(MONTH FROM order_date::date) = 1
group by pizza_size
order by Total_Sales_Percentage desc;


---- Pizza With Top 5 Revenue
select pizza_name, cast(sum(total_price) as decimal(10,2)) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;


---- Pizza With top 5 Quantity
select pizza_name, cast(sum(quantity) as decimal(10,2)) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5;


---- Pizza With top 5 Orders
select pizza_name, cast(sum(order_id) as decimal(10,2)) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc
limit 5;







