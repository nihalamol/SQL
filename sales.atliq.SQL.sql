use sales

select * from customers;

select count(*) from customers;

select * from date;

select count(*) from date;

select * from products;

select count(*) from products;

select * from markets;

select count(*) from markets;

select * from transactions;

select count(*) from transactions; 

#product analysis

#distinct number of product type

select product_type,count(product_type)
from products
group by product_type;

#top frequent selling products

select t.product_code,p.product_type,count(t.product_code) as product_count
from transactions t left join products p on t.product_code=p.product_code
group by t.product_code
order by product_count desc

#top profit generating product

select t.product_code,p.product_type,round(sum(t.profit_margin_percentage),2) as total_profit_margin,
sum(t.sales_qty) as total_sales_qty,
count(t.product_code) as product_count
from transactions t left join products p on t.product_code=p.product_code
group by t.product_code
order by total_profit_margin desc

select distinct sales_qty from transactions

#top selling products

select t.product_code,sum(t.sales_qty) as total_sales_qty,p.product_type,
count(t.product_code) as number_of_product_order
from transactions t left join products p on t.product_code=p.product_code
group by t.product_code
order by total_sales_qty desc

#top selling product type

select
 p.product_type,
 sum(t.sales_qty) as total_sales
from transactions t
inner join products p on p.product_code=t.product_code
group by
 p.product_type
order by total_sales desc;

#profit analysis

#distinct number of zone markets
select zone,group_concat(markets_name) as markets_name,count(zone) as market_Count
from markets
group by zone;

#most profit generating market zone

select m.zone,round(sum(t.profit_margin_percentage),2) as total_profit_margin,
sum(t.sales_qty) as total_sales_qty
from markets m
inner join transactions t on m.markets_code=t.market_code
group by m.zone
order by total_profit_margin desc

#product demand in each zone base on profit margin

select m.zone,t.product_code,p.product_type,round(sum(t.profit_margin_percentage),2) as total_profit_margin,
sum(t.sales_qty) as total_sales_qty
from transactions t 
left join products p on t.product_code=p.product_code
left join markets m on m.markets_code=t.market_code
group by m.zone,t.product_code
order by total_profit_margin desc;

#most profit generating market

select m.markets_name,round(sum(t.profit_margin_percentage),2) as total_profit_margin,
sum(t.sales_qty) as total_sales_qty
from markets m
inner join transactions t on m.markets_code=t.market_code
group by m.markets_name
order by total_profit_margin desc

#product demand in each market place based on profit margin

select m.zone,m.markets_name,t.product_code,p.product_type,round(sum(t.profit_margin_percentage),2) as total_profit_margin,
sum(t.sales_qty) as total_sales_qty
from transactions t 
left join products p on t.product_code=p.product_code
left join markets m on m.markets_code=t.market_code
group by m.zone,m.markets_name,t.product_code
order by total_profit_margin desc

#sales analysis

#product demand in each zone baesd on qty of pdt sold

select m.zone,t.product_code,p.product_type,
sum(t.sales_qty) as total_sales_qty,round(sum(t.profit_margin_percentage),2) as total_profit_margin
from transactions t 
left join products p on t.product_code=p.product_code
left join markets m on m.markets_code=t.market_code
group by m.zone,t.product_code
order by total_sales_qty desc;

#product demand in each market based on total qty sold

select m.zone,m.markets_name,t.product_code,p.product_type,
sum(t.sales_qty) as total_sales_qty,round(sum(t.profit_margin_percentage),2) as total_profit_margin
from transactions t 
left join products p on t.product_code=p.product_code
left join markets m on m.markets_code=t.market_code
group by m.zone,m.markets_name,t.product_code
order by total_sales_qty desc;

#sale by time period

select * from transactions;

#total sales and profit in each sale year

SELECT
  YEAR(order_date) AS sales_year,
  SUM(sales_qty) AS total_sales,
  round(sum(profit_margin),2) as total_profit
FROM
  transactions
GROUP BY
  sales_year
ORDER BY
  total_profit desc;

#total sales in each order date sort by order date

select order_date,sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS ranking
from transactions
group by order_date
order by order_date; 

#total sales in each order date sort by total sales

select order_date,sum(sales_qty) as total_sales
from transactions
group by order_date
order by total_sales desc;
 
#total sales in the sale period of 2017

SELECT
  order_date,
  SUM(sales_qty) AS total_sales,
  RANK() OVER (ORDER BY SUM(sales_qty) DESC) AS ranking
FROM
  transactions
WHERE
  order_date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY
  order_date
ORDER BY
  order_date;

#total sales in the sale period of 2018

select order_date,sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS ranking
from transactions
where order_date between '2018-01-01' and '2018-12-31'
group by order_date
order by order_date 

#total sales in the sale period of 2019

select order_date,sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS ranking
from transactions
where order_date between '2019-01-01' and '2019-12-31'
group by order_date
order by order_date 

#total sales in the sale period of 2020

select order_date,sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS ranking
from transactions
where order_date between '2020-01-01' and '2020-12-31'
group by order_date
order by order_date 

#sales profit and total sales by time period

select * from transactions;

select order_date,round(sum(profit_margin),2) as total_profit,
RANK() OVER (ORDER BY SUM(profit_margin) desc ) as profit_ranking,
sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS sales_ranking
from transactions
group by order_date
order by order_date; 

#sales profit and total sales in 2017

SELECT
  order_date,
  round(sum(profit_margin),2) as total_profit,
  RANK() OVER (ORDER BY SUM(profit_margin) desc) as profit_ranling,
  SUM(sales_qty) AS total_sales,
  RANK() OVER (ORDER BY SUM(sales_qty) DESC) AS sales_ranking
FROM
  transactions
WHERE
  order_date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY
  order_date
ORDER BY
  order_date;

#sales profit and total sales in 2018

select order_date,sum(sales_qty),
RANK() OVER (ORDER BY sum(sales_qty) desc) AS ranking
from transactions
where order_date between '2018-01-01' and '2018-12-31'
group by order_date
order by order_date 

#sales profit and total sales in 2019

select order_date,round(sum(profit_margin),2) as total_profit,
RANK() OVER (ORDER BY SUM(profit_margin) desc ) as profit_ranking,
sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS sales_ranking
from transactions
where order_date between '2019-01-01' and '2019-12-31'
group by order_date
order by order_date 

#sales profit and total sales in 2020

select order_date,round(sum(profit_margin),2) as total_profit,
RANK() OVER (ORDER BY SUM(profit_margin) desc ) as profit_ranking,
sum(sales_qty) as total_sales,
RANK() OVER (ORDER BY sum(sales_qty) desc) AS sales_ranking
from transactions
where order_date between '2020-01-01' and '2020-12-31'
group by order_date
order by order_date; 
  
#product demand in each sales period
use sales;
select * from transactions;

SELECT
  YEAR(order_date) AS sales_year,
  product_code,
  SUM(sales_qty) AS total_sales,
  rank() over (partition by YEAR(order_date) order by sum(sales_qty) desc) as sales_ranking,
  round(sum(profit_margin),2) as total_profit
FROM
  transactions
GROUP BY
  sales_year,product_code
ORDER BY
  total_profit desc;
  

SELECT
  YEAR(order_date) AS sales_year,
  product_code,
  SUM(sales_qty) AS total_sales,
  rank() over (partition by YEAR(order_date) order by sum(sales_qty) desc) as sales_ranking,
  round(sum(profit_margin),2) as total_profit,
  rank() over (partition by YEAR(order_date) order by sum(profit_margin) desc) as profit_ranking 
FROM
  transactions
GROUP BY
  sales_year,product_code
ORDER BY
  sales_year;
  
 #customers in each sales year
 
select * from transactions;
 
select
 year(order_date) as sales_year,
 customer_code,
 sum(sales_qty),
 rank() over (partition by year(order_date) order by sum(sales_qty) desc) as sales_ranking
from
 transactions
group by
 sales_year,
 customer_code
order by
 sales_year;
 
#customers in each sales period

#2017

 SELECT
  order_date,
  customer_code,
  SUM(sales_qty) AS total_sales,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales_qty) DESC) AS sales_ranking,
  ROUND(SUM(profit_margin), 2) AS total_profit,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(profit_margin) DESC) AS profit_ranking
FROM
  transactions
WHERE
  YEAR(order_date) = 2017
GROUP BY
  order_date,
  customer_code
ORDER BY
  order_date;
  
#2018

 SELECT
  order_date,
  customer_code,
  SUM(sales_qty) AS total_sales,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales_qty) DESC) AS sales_ranking,
  ROUND(SUM(profit_margin), 2) AS total_profit,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(profit_margin) DESC) AS profit_ranking
FROM
  transactions
WHERE
  YEAR(order_date) = 2018
GROUP BY
  order_date,
  customer_code
ORDER BY
  order_date;
  
#2019

 SELECT
  order_date,
  customer_code,
  SUM(sales_qty) AS total_sales,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales_qty) DESC) AS sales_ranking,
  ROUND(SUM(profit_margin), 2) AS total_profit,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(profit_margin) DESC) AS profit_ranking
FROM
  transactions
WHERE
  YEAR(order_date) = 2019
GROUP BY
  order_date,
  customer_code
ORDER BY
  order_date;
  
#2020

 SELECT
  order_date,
  customer_code,
  SUM(sales_qty) AS total_sales,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales_qty) DESC) AS sales_ranking,
  ROUND(SUM(profit_margin), 2) AS total_profit,
  RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(profit_margin) DESC) AS profit_ranking
FROM
  transactions
WHERE
  YEAR(order_date) = 2020
GROUP BY
  order_date,
  customer_code
ORDER BY
  order_date;
#customer segmentation
 
select * from customers;

#distict number of customer type
select customer_type,count(customer_type) 
from customers
group by customer_type;

#distimct number of customers
select custmer_name,count(custmer_name) 
from customers
group by custmer_name;

#top customers by order

select t.customer_code,c.custmer_name,count(c.customer_code) as order_count
from transactions t left join customers c on t.customer_code=c.customer_code
group by t.customer_code
order by order_count desc
                          
#top customer by sales quantity

select t.customer_code,c.custmer_name,sum(t.sales_qty) as sales_quantity
from transactions t left join customers c on t.customer_code=c.customer_code
group by t.customer_code
order by sales_quantity desc

#top customers by profit

select t.customer_code,c.custmer_name,round(sum(t.profit_margin),2) as profit_margin
from transactions t left join customers c on t.customer_code=c.customer_code
group by t.customer_code
order by profit_margin desc

select * from transactions;
select * from markets;
select * from products;

#top customers by sale with their corresponding zone
select 
 t.customer_code,
 m.zone,
 sum(t.sales_qty) as total_sales
from 
 transactions t
inner join markets m on m.markets_code=t.market_code
group by m.zone,t.customer_code
order by total_sales desc;

#top customers by sale with their corresponding zone and market_name

select 
 t.customer_code,
 m.zone,
 m.markets_name,
 sum(t.sales_qty) as total_sales
from 
 transactions t
inner join markets m on m.markets_code=t.market_code
group by m.zone,m.markets_name,t.customer_code
order by total_sales desc;

#top customers by sale with their corresponding product,zone and market_name
select 
 t.customer_code,
 p.product_code,
 p.product_type,
 m.zone,
 m.markets_name,
 sum(t.sales_qty) as total_sales
from 
 transactions t
inner join markets m on m.markets_code=t.market_code
inner join products p on t.product_code=p.product_code
group by m.zone,m.markets_name,t.customer_code,p.product_code
order by total_sales desc;

#customer segmentation by region
#top customer in each region by sales
#in each zone

select 
 m.zone,
 t.customer_code,
 sum(t.sales_qty) as total_sales
from 
 transactions t 
inner join markets m on m.markets_code=t.market_code
group by
 m.zone,t.customer_code
order by 
 m.zone,total_sales desc;
 
#in each market_name

select 
 m.zone,
 m.markets_name,
 t.customer_code,
 sum(t.sales_qty) as total_sales
from 
 transactions t 
inner join markets m on m.markets_code=t.market_code
group by
 m.zone,m.markets_name,t.customer_code
order by 
 m.zone,m.markets_name,total_sales desc;
 
#top customer in each zone with their product demand

select 
 m.zone,
 t.customer_code,
 t.product_code,
 sum(t.sales_qty) as total_sales
from 
 transactions t 
inner join markets m on m.markets_code=t.market_code
group by
 m.zone,t.customer_code,product_code
order by 
 m.zone,total_sales desc;
 
 #top customer in each market with their product demand
 
 select 
 m.zone,
 m.markets_name,
 t.customer_code,
 t.product_code,
 sum(t.sales_qty) as total_sales
from 
 transactions t 
inner join markets m on m.markets_code=t.market_code
group by
 m.zone,m.markets_name,t.customer_code,t.product_code
order by 
 m.zone,m.markets_name,total_sales desc;
 
#cost analysis

select * from transactions;

#analysing cost and sales amount of product

select 
 product_code,
 sum(sales_amount) as total_sales_amount,
 round(sum(cost_price),2) as total_cost,
 round(sum(profit_margin),2) as total_profit
from 
 transactions
group by product_code
order by total_profit;

#analysing cost and sales amount by customers

select 
 customer_code,
 sum(sales_amount) as total_sales_amount,
 round(sum(cost_price),2) as total_cost,
 round(sum(profit_margin),2) as total_profit
from 
 transactions
group by customer_code
order by total_profit;

#analysing cost and sales for customers with their respective product

select 
 customer_code,
 product_code,
 sum(sales_amount) as total_sales_amount,
 round(sum(cost_price),2) as total_cost,
 round(sum(profit_margin),2) as total_profit
from 
 transactions
group by customer_code,product_code
order by total_profit;

#qty orderd vs profit

select
 sales_qty,
 sales_amount,
 cost_price,
 profit_margin
from 
 transactions
order by profit_margin;

#cost analysis by region

#analysing cost and profit with their zone

select
 m.zone,
 sum(sales_amount) as total_sales_amount,
 round(sum(t.cost_price),2) as total_cost,
 round(sum(t.profit_margin),2) as total_profit
from transactions t
inner join markets m on m.markets_code=t.market_code
group by 
 m.zone
order by total_profit;

#anlysing cost and profit with thier market

select
 m.zone,
 m.markets_name,
 sum(sales_amount) as total_sales_amount,
 round(sum(t.cost_price),2) as total_cost,
 round(sum(t.profit_margin),2) as total_profit
from transactions t
inner join markets m on m.markets_code=t.market_code
group by 
 m.zone,m.markets_name
order by total_profit;

#anlysing cost and profit of products with thier market 

select
 m.zone,
 m.markets_name,
 t.product_code,
 sum(sales_amount) as total_sales_amount,
 round(sum(t.cost_price),2) as total_cost,
 round(sum(t.profit_margin),2) as total_profit
from transactions t
inner join markets m on m.markets_code=t.market_code
group by 
 m.zone,m.markets_name,t.product_code
order by total_profit;