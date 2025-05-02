# sql_retail_analysis-
Project Overview
Project Title: Retail Sales Analysis
Level: Beginner
Database: p1_retail_db

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.
Project Structure
1. Database Setup
Database Creation: The project starts by creating a database named p1_retail_db.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

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

My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


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
