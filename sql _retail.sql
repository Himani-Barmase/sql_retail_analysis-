create database retail;
select * from retail_analysis_yt;
alter table retail_analysis_yt rename column ï»¿transactions_id to transactions_id ;
select count(*) from retail_analysis_yt;
-- data cleaning 
SELECT *FROM retail_analysis_yt 
WHERE 
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null 
or price_per_unit is null
or cogs is null
or total_sale is null ; 


delete from retail_analysis_yt where 
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null 
or price_per_unit is null
or cogs is null
or total_sale is null ; 

-- data exploration
-- 1 how many sales we have 
select count(*) from retail_analysis_yt;
-- 2 how many unique customer we have 
 select distinct(count(customer_id)) from retail_analysis_yt;
 -- 3 which are catogry present here
 select distinct category from retail_analysis_yt;

-- data analysis key problem and ans

 -- 1 retrive all the sales for 2022-11-05
 select * from retail_analysis_yt where sale_date ='2022-11-05';
  
  -- 2 retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
  
  select category , 
  quantiy ,sale_date ,  
  DATE_FORMAT(sale_date, '%Y-%m') AS sale_month 
  from retail_analysis_yt
  where category = 'clothing' 
  and quantiy > 2
  and DATE_FORMAT(sale_date, '%Y-%m') = '2022-10';
  
  -- 3  calculate the total sales (total_sale) for each category.
  select category ,sum(total_sale) , count(*)as num_sales  from retail_analysis_yt
  group by category ;
  
  -- 4 find the average age of customers who purchased items from the 'Beauty' category.
select category , avg(age) from retail_analysis_yt 
where category ='beauty' ;

 -- 5 find all transactions where the total_sale is greater than 1000.
 select * from retail_analysis_yt where total_sale >= 1000 ;
  
  -- 6 find the total number of transactions (transaction_id) made by each gender in each category
  select  gender ,category,  count(transactions_id) as total_transactions from retail_analysis_yt
  group by category , gender; 
  
  -- 7 calculate the average sale for each month. Find out best selling month in each year

select  extract(year from sale_date) as years ,
extract(month from sale_date) as months,
avg(total_sale) , 
rank() over(partition by extract(year from sale_date) order by avg(total_sale)desc) as ranking  from retail_analysis_yt
group by years, months ;

-- 8 find the top 5 customers based on the highest total sales 
select * from retail_analysis_yt;
select customer_id , total_sale from retail_analysis_yt
order by total_sale desc
limit 5 ;

-- 9 find the number of unique customers who purchased items from each category.
select category , count(distinct(customer_id)) as unique_cs from retail_analysis_yt 
group by category ;
 
 -- 10 create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 WITH hourly_sales as (
 select *,
 case 
 when extract( hour from sale_time ) <12 then ' morning'
 when extract( hour from sale_time) between 12 and 17  then 'afternoon' 
 else 'evening' 
 end as shift from retail_analysis_yt)
 select shift , count(*) as total_order from hourly_sales 
 group by shift;