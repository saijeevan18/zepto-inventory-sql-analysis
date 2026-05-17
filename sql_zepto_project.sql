create table zepto(
s_no serial primary key,
category varchar(120),
name varchar(150) not null,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity int,
discountSellingPrice numeric(8,2),
weightInGms int,
outOfStock bool,
quantity int
);

select category,sum(availableQuantity)
from zepto
group by category;

select * from zepto;


## products categories

select distinct category 
from zepto
order by category;

## products in Stocks

select outOfStock, count(s_no) as Products_Stock_info
from zepto
group by outOfStock;

## products duplicates

select name, count(s_no) as No_of_duplicates
from zepto
group by name
having No_of_duplicates >1
order by No_of_duplicates desc;

## Data Cleaning 
select *
from zepto
where mrp =0;

delete from zepto 
where s_no =3603 and mrp=0;

select * from zepto;

## Changing paise to rupees

"update zepto
set mrp = mrp/100.0,
discountSellingPrice =discountSellingPrice/100.0
where s_no = 1;"

## Business Insight Questions From Chatgpt
## 1. Which categories contain the highest number of products?

select category, count(distinct name) as product_count
from zepto
group by category
order by product_count desc
limit 1;

##2. Which products have the highest discount percentage?

select name, discountPercent
from zepto
order by discountPercent desc
limit 1;

## 3. Which categories offer the highest average discount?

select category,avg(discountPercent) as Average_DiscountPercent
from zepto
group by category
order by Average_DiscountPercent desc;

## 4. Which products are currently Out of Stock?

select * from zepto
where outOfStock =true;

## 5.Which category has the most out-of-stock products?

select category, count(*) as Count_outOfStock
from zepto
where outOfStock =1
group by category
order by Count_outOfStock desc 
limit 1;


##6. Which are the most expensive products in the inventory?

select name,discountSellingPrice
from zepto
order by discountSellingPrice desc;

##7. Which categories have the highest average product price?

select category,avg(discountSellingPrice) as Avg_prod_Price
from zepto
group by category
order by Avg_prod_Price desc;

## 8. Which products have the largest package sizes or weights?

select name,weightInGms
from zepto
where weightInGms is not null and weightInGms > 0
order by weightInGms desc
limit 5;

## 9. Which categories have the highest total available stock?

select  category, sum(availableQuantity) as Tot_Ava_stock
from zepto
where availableQuantity is not null
group by category
order by Tot_Ava_stock desc
limit 5;

## 10. Which products have very low stock remaining?

select name, availableQuantity
from zepto
where availableQuantity is not null and availableQuantity < 5
order by availableQuantity
;