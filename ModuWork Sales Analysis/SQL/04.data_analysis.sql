/*
===============================================================================
SQL Analytics Script: Comprehensive Retail & Customer Intelligence
===============================================================================
Author: [Daniel Mercedes]
Database Engine: PostgreSQL (pgAdmin)

This script demonstrates SQL capabilities by solving data 
aggregation and segmentation problems. 

Key SQL Features :
  - Joins & Unions (Combining transactional and dimensional data)
  - Common Table Expressions (CTEs) & Subqueries (Modular, readable logic)
  - Window Functions (Analytical positioning, ranking, and running totals)
  - Aggregation Functions & CASE Statements (Conditional business logic)
  - Data Types & DDL Basics (Schema structure and type casting)
===============================================================================
*/

⭐ 1. JOINS y UNIONS

select distinct category from product

'List sales with customer name - JOIN between sales and customer'

select * from sales
select * from customer
select * from product

select 
   c.customer_name, c.segment, s.sales
from sales s
join customer c on c.customer_id = s.customer_id

'List sales with product name and category - JOIN between sales and product'

select 
    p.product_name, p.category, s.sales
from sales s 
join product p on p.product_id = s.product_id

'Customers who have purchased and customers who have not purchased – LEFT JOIN + filter'
   
select * from customer c
left join sales s on c.customer_id = s.customer_id
where s.sales is null 

'Customers who have not purchased - LEFT JOIN + filter'

select * from product p
full join sales s on p.product_id = s.product_id
where s.sales is null

'Combine sales from two different years'

select * from sales 
where extract (year from order_date) in (2016,2017)

'Sales by region, Join between sales and customer'

select 
    c.region, sum(s.sales) as total_sales
from sales s 
join customer c on c.customer_id = s.customer_id
group by c.region

⭐ 2. 'Windows Functions' ------------------------------

'Ranking of best-selling products by category- ROW_NUMBER()'

with totals as( 
   select
       p.product_name, p.category, sum(s.sales) as total_sales
   from sales s 
   join product p on p.product_id = s.product_id
   group by p.product_name, p.category
)
select *,
   row_number() over (partition by category order by total_sales desc) as rank_category
from totals

'Top 3 best-selling products by category'

with product_totals as (
    select 
        p.product_name, p.category, sum(s.sales) as total_sales
    from sales s
    join product p on s.product_id = p.product_id
    group by p.product_name, p.category
),
ranked as (
    select *,
        dense_rank() over (partition by category order by total_sales desc) as rnk
    from product_totals
)
select * from ranked
where rnk <= 3
order by category, total_sales desc;

'Cumulative sales by customers - sum() over()'

select 
    c.customer_name,
    s.order_date,
    s.sales,
    sum(s.sales) over (partition by c.customer_id order by s.order_date) as cumulative_sales
from sales s
join customer c on s.customer_id = c.customer_id

'Difference in sales between consecutive days - lag()'

select 
    order_id,
    sales,
    lag(sales) over (order by order_date) as previous_sales,
    sales - lag(sales) over (order by order_date) as difference
from sales;

'Moving average of sales - avg()'

select 
    order_date
    sales,
    avg(sales) over (
        order by order_date
        rows between 6 preceding and current row
    ) as moving_avg_7
from sales
order by order_date;

select * from sales

⭐ 3. CTEs y Subqueries

'CTE to acquire customers with more than 5 purchases'

with counts as (
    select 
        customer_id,
        count(*) as num_orders
    from sales
    group by customer_id
)
select c.customer_name, counts.num_orders
from counts
join customer c on counts.customer_id = c.customer_id
where num_orders > 5;

'Subquery to retrieve above-average sales products'

select 
    p.product_name,
    sum(s.sales) as total_sales
from sales s
join product p on s.product_id = p.product_id
group by p.product_name
having sum(s.sales) > (
    select avg(sales) from sales
);

'CTE to calculate daily sales and then group by month'
'Simpler version (daily sales only)'

select 
    order_date,
    sum(sales) as total_daily_sales
from sales
group by order_date
order by order_date;

'Simpler version (monthly sales only)'

select 
    date_trunc('month', order_date) as month,
    sum(sales) as total_monthly_sales
from sales
group by date_trunc('month', order_date)
order by month;

'Correlated subquery to obtain the maximum sale per customer'

select 
    c.customer_name,
    s.order_id,
    s.sales as max_sale
from sales s
join customer c 
    on s.customer_id = c.customer_id
where s.sales = (
    select max(s2.sales)
    from sales s2
    where s2.customer_id = s.customer_id
)
order by max_sale desc

'Version with CTE (cleaner)'

with max_sales as (
    select 
        customer_id,
        max(sales) as max_sale
    from sales
    group by customer_id
)
select 
    c.customer_name,
    m.max_sale
from max_sales m
join customer c 
    on m.customer_id = c.customer_id
order by m.max_sale desc;

⭐ 4. 'Aggregation Functions'

'Number of customers per region'

select region, count(*) as total_customers
from customer
group by region;

'Average discount per category'

select 
    p.category,
    avg(s.discount) as avg_discount
from sales s
join product p 
    on s.product_id = p.product_id
group by p.category;

'Customers with the highest total spending'

select 
    c.customer_name,
    c.region,
    sum(s.sales) as total_spent
from sales s
join customer c 
    on s.customer_id = c.customer_id
group by c.customer_name, c.region
order by total_spent desc


'Product with the highest total sales (standard solution)'

select 
    p.product_name,
    p.category,
    sum(s.sales) as total_sales
from sales s
join product p 
    on s.product_id = p.product_id
group by p.product_name, p.category
order by total_sales desc
limit 5;

⭐ 5. CASE Statements

'Classify customers by age (young, adult, senior)'

select 
    customer_name,
    age,
    case 
        when age < 30 then 'Young'
        when age between 30 and 55 then 'Adult'
        else 'Senior'
    end as age_group
from customer;

'Classify sales as high, medium, or low'

select 
    order_id,
    sales,
    case 
        when sales > 500 then 'High'
        when sales between 200 and 500 then 'Medium'
        else 'Low'
    end as sales_level
from sales;

'Assign discount category'

select 
    order_id,
    discount,
    case
        when discount = 0 then 'No discount'
        when discount < 0.10 then 'Low discount'
        when discount between 0.10 and 0.25 then 'Average discount'
        else 'High discount'
    end as discount_category
from sales
order by discount desc;

'Determine if a product is 'OFFICE', 'Tech' or Furniture'

select 
    product_name,
    category,
    sub_category,
    case
        when category = 'Furniture' then 'Furniture'
        when category = 'Office Supplies' then 'OFFICE'
        when category = 'Technology' then 'Tech'
        else 'Other category'
    end as product_group
from product
order by product_group, product_name;

'Mark whether a sale was profitable or not'

select 
    p.product_name,
    p.category,
    s.sales,
    s.profit,
    case
        when s.profit > 0 then 'Profitable'
        when s.profit = 0 then 'Break-even point'
        else 'Not profitable'
    end as rentabilidad
from sales s
join product p 
    on s.product_id = p.product_id
order by s.profit desc;

⭐ 6. Data Types y DDL Basic 

'Create an audit table'

create table audit_log (
    audit_id serial primary key,
    table_name varchar(50),
    record_id int,
    action varchar(10),             
    old_data jsonb,                 
    new_data jsonb,                 
    changed_by varchar(100),        
    changed_at timestamp default now()
);

'Create table product'

create table product (
    product_id serial primary key,
    category varchar(50),
    sub_category varchar(50),
    product_name varchar(150)
);


 'Change sales to numeric'

alter table sales
alter column sales type numeric(12,2);

'total sales by year' 
select 
    extract(year from order_date) as year,
    sum(sales) as total_sales
from sales
group by extract(year from order_date)
order by year;



