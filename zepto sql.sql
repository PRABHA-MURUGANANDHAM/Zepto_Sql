drop table if exists zepto;

create table zepto(
sku_id serial primary key,
category varchar(120),
name varchar(150) not null,
mrp numeric (8,2),
discountPercent Numeric(5,2),
availabeQuantity integer,
discountedSellingPrice Numeric(8,2),
weightInGms integer,
outOfStock boolean,
quantity integer

);

--data exploration


---count of rows
select count(*) from zepto;



--sampe data

select * from zepto 
limit 10;

--null values
select * from zepto
where name is null 
or
 category is null 
or
mrp is null
or 
discountpercent is null
or availabeQuantity is null or
discountedsellingprice is null 
or weightingms is null
or outofstock is null 
or quantity is null;

--different product categories

select distinct category
from zepto
order by category;

--products in stock vs out of stock

select outOfStock, count(sku_id)
from zepto 
group by outOfStock;


---product names present multiple times

select name, count(sku_id) as "Number of SKUs"
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;


--data cleaning

--proudcts with price = 0

select * from zepto
where mrp = 0 or discountedSellingprice = 0;

--delete
delete from zepto 
where mrp = 0;

--convert paise to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingprice = discountedSellingPrice/100;

select mrp,discountedSellingprice from zepto;

--1.find the top 10 best-value products baased on discount-percentage.
select distinct name,mrp,discountPercent
from zepto
order by discountPercent desc
limit 10;

--what are the products with high mrp but out of stock.
select distinct name , mrp , outOfStock
from zepto
where outOfStock = true and mrp > 300
order by mrp desc;

---calculate estimated revenue for each category
select category,
sum(discountedSellingPrice * availabeQuantity) as total_revenue
from zepto
group by category
order by total_revenue;

--find all products where mrp is greater than 500 and disc is less than 10%.
select  distinct name,mrp,discountPercent
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc , discountPercent desc;

--identify the top 5 categories offering he highest average discount percentage.
select category,
round(avg(discountPercent),2) as 
avg_dis
from zepto
group by category
order by avg_dis desc
limit 5;

--find the price per gram for products above 100g and sort by best value.

select distinct name ,weightInGms , discountedSellingPrice,
round (discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto
where weightInGms >= 100
order by price_per_gram;


--group the products into categories like low,medium,bulk

select distinct name,weightInGms ,
case when weightInGms < 1000 then 'low'
when weightInGms < 5000 then 'medium'
else 'bulk'
end as weight_category
from zepto


--what is the total inventory weight per category
select category,
sum(weightInGms * availabeQuantity) as total_weight
from zepto
group by category
order by total_weight;