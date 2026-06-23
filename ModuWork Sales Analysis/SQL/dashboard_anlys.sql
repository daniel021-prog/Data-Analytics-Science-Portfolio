
1.'Sales by region with JOINs'

select 
    c.region, sum(s.sales) as total_sales
from sales s 
join customer c on c.customer_id = s.customer_id
group by c.region


2.'Top 3 products by category'

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

3.'CTE to acquire customers with more than 5 purchases'

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

4.'Number of customers by region'

select region, count(*) as total_customers
from customer
group by region;

5.'Average discount by category'
select 
    p.category,
    avg(s.discount) as avg_discount
from sales s
join product p 
    on s.product_id = p.product_id
group by p.category;

6.'Product with the highest total sales (standard solution)'
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

7.'Customers with the highest total spending'

select 
    c.customer_name,
    c.region,
    sum(s.sales) as total_spent
from sales s
join customer c 
    on s.customer_id = c.customer_id
group by c.customer_name, c.region
order by total_spent desc
limit 5

8.'Classify customers by age (young, adult, senior)'

select 
    customer_name,
    age,
    case 
        when age < 30 then 'Young'
        when age between 30 and 55 then 'Adult'
        else 'Senior'
    end as age_group
from customer;

9.'Classify sales as high, medium, or low'

select 
    order_id,
    sales,
    case 
        when sales > 500 then 'High'
        when sales between 200 and 500 then 'Medium'
        else 'Low'
    end as sales_level
from sales;

10.'Sales by state'

select 
    c.state, sum(s.sales) as total_sales
from sales s
join customer c on c.customer_id = s.customer_id
group by c.state
order by total_sales desc

11.'Classify sales as high, medium, or low'

select 
    order_id,
    sales,
    case 
        when sales > 500 then 'Sales >500(USD)'
        when sales between 200 and 500 then 'b/W 200 and 500 (USD)'
        else 'Sales <200(USD)'
    end as sales_level
from sales;

12.'Classify customers by age (young, adult, senior)'

select 
    customer_name,
    age,
    case 
        when age < 30 then '(<30) Young'
        when age between 30 and 55 then '(30 to 55) Adult'
        else '(>55) Senior'
    end as age_group
from customer;

13.'sales by category'

select
    p.category,
    sum(s.sales) as total_sales,
    round((sum(s.sales) * 100.0 / (select sum(s2.sales) from sales s2))::numeric, 2) as percentage
from sales s
join product p on p.product_id = s.product_id
group by p.category;

14.'Total sales by category'
select
    p.category,
    sum(s.sales) as total_sales
from sales s
join product p on p.product_id = s.product_id
group by p.category;


