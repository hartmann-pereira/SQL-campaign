--This SQL file contains queries about a walmart retail dataset between 2012 and 2015--
--Built importing a csv file into sqloteonline.com and querying the data--
--Skills used: select, select distinct, where, and/or, order by, min/max/average/sum/count, aliases, group by, subquery--
--Dataset consisted of 25 columns and around 8400 rows having text, numbers values and also null values--

--Created by Ricardo Hartmann--
--Available on github--


-- State wise average profits--
select state, avg(profit) as average_profit
from walmartRetailData
group by state
order by average_profit desc;

--Showing between what dates is our walmart dataset
select min(order_date), max(order_date)
from walmartRetailData;

-- In wich age the company is getting the maximum profit--
SELECT DISTINCT(customer_age), avg(profit) as average_profit
FROM walmartRetailData
WHERE customer_age is NOT NULL
GROUP BY customer_age
order by average_profit DESC;

--Showing the average sales of the company--
Select avg(sales) as average_sales
from walmartRetailData;

--Showing the average discount per state--
SELECT state, avg(discount) as average_discount
from walmartRetailData
group by state
order by average_discount DESC;

--Showing a comparison of average profit between consumer and corporate customers--
select customer_segment as customer_type, avg(profit) as average_profit 
from walmartRetailData
where customer_type like 'Consumer' or customer_type like 'Corporate' 
group by customer_segment;

--Showing all records with order id ending in 74
select order_id
from walmartRetailData
where order_id like '%74'

-- sales by segment and category--
select customer_segment as Customer_type, product_category, avg(sales) as average_sales
from walmartRetailData
group by customer_segment, product_category;

--Showing the order quantity per Customer type and the profit for each customer customer type
select customer_segment as customer_type, sum(order_quantity), sum(profit)
from walmartRetailData
group BY customer_segment;

--Using a subquery to show what % of profit are coming from corporate clients, 
--With this query only by changing one word we can get the % for the other customer segments as shown in query below
select customer_segment, sum(profit)/
	(select sum(walm.profit)
     from walmartRetailData as walm
     )*100 as Percentage_of_profit_coming_from_corporate_clients
from walmartRetailData
where customer_segment like 'Corporate';

--Using a subquery to show what % of profit are coming from consumer clients
select customer_segment, sum(profit)/
	(select sum(walm.profit)
     from walmartRetailData as walm)*100 as Percentage_of_profit_coming_from_corporate_clients
from walmartRetailData
where customer_segment like 'Consumer';

--Showing the number of products bought with a discount of 0.1--
select DISTINCT(discount),
	(select count(discount)
     from walmartRetailData
     where discount=0.1) as number_of_products_with_discount
from walmartRetailData
where discount=0.1;

--With this query we can see the variation of discounts that are present in Xerox products"
SELECT discount, product_name
from walmartRetailData
where product_name like 'Xerox %'
order by discount;

--Showing the min and max discount for each product category, we can see that only furniture has products with 0.25% discount
select max(discount), min(discount), product_category
from walmartRetailData
GROUP by product_category;


--Showing the profits and number of orders for each type of order (high, low, medium, critical and null) and profits per order
select DISTINCT(order_priority) as type_of_order,
	sum(profit) as profits_per_type_of_order,
	sum(number_of_records) as number_of_orders,
    sum(profit)/sum(number_of_records) as profits_per_order
from walmartRetailData
GROUP by type_of_order
order by sum(profit) DESC;





