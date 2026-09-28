
--ADVANCE ANALYTICS
--1.Change-Over-Time Trends: Analyze how a measure evolves over time. Helps track trends and identify seasonality in your data 
--Task: Analyze the sales performance over time
SELECT
YEAR(order_date) AS order_year,
SUM(sales_amount) sales,
COUNT(DISTINCT customer_key) AS total_customers,
COUNT(quantity) AS item_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date) 

--2.Cumulative Analysis: Aggregating the data progressively over time. Helps to understand whether our business is growing or declining over time.
--Task: Calculate the total sales per month and the running total of sales over time.
SELECT
order_time,
total_sales,
SUM(total_sales) OVER(ORDER BY order_time) AS running_total_sales,
AVG(avg_sales) OVER(ORDER BY order_time) AS moving_avg
FROM
(
	SELECT
	DATETRUNC(YEAR,order_date) AS order_time,
	SUM(sales_amount) total_sales,
	AVG(sales_amount) avg_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date)
)t 
 
--Performance Analysis: Comparing the current value to a target value, helps measure success and compare performance.
--Task: Analyse the yearly performance of the products by comparing each product's sales to both it's average sales performance and the previous year's sales.
;WITH yearly_product_sales AS
(
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY
        YEAR(f.order_date),
        p.product_name
)
SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
current_sales-AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales-AVG(current_sales) OVER(PARTITION BY product_name)>0 THEN 'Above Avg'
     WHEN current_sales-AVG(current_sales) OVER(PARTITION BY product_name)<0 THEN 'Below Avg'
     ELSE 'AVG'
END avg_change,
current_sales-LAG(current_sales) OVER(ORDER BY current_sales) AS diff_sales,
CASE WHEN current_sales-LAG(current_sales) OVER(ORDER BY current_sales)>0 THEN 'Increse'
     WHEN current_sales-LAG(current_sales) OVER(ORDER BY current_sales)<0 THEN 'Decrease'
     ELSE 'No Change'
END sales_change
FROM yearly_product_sales;


--Part to whole analysis
--Analyze how an individual part is performing compared to the overall, allowing us to understand which category has the greatest impact on the business.
--Task: Which category contribute the most to the overall sales
;WITH category_sales AS (
SELECT
p.category,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.category)

SELECT
category,
total_sales,
SUM(total_sales) OVER() AS overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER())*100, 2), '%') AS sales_contribution
FROM category_sales
ORDER BY total_sales DESC

--Data Segmentation
--Group the data based on specific range, helps understand correlation between two measures.
--Task: Segment products into cost ranges and count how many products fall into each segment
;WITH product_segment AS(
SELECT
product_key,
product_name,
cost,
CASE WHEN cost<100 THEN 'Below 100'
     WHEN cost BETWEEN 100 AND 500 THEN '100-500'
     WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
     ELSE 'Above 1000'
END cost_range
FROM gold.dim_products)
SELECT
cost_range,
COUNT(*) AS no_of_product
FROM product_segment
GROUP BY cost_range  
ORDER BY no_of_product DESC

/*Task: Group customers into three segments based on their spending behaviour:
   - VIP: Customers with atleast 12 months of history and spending more than 5,000.
   - Regular: Customers with atleast 12 months of history but spending 5,000 or less.
   - New: Customers with a lifespan of less than 12 months.
And find the total number of customers by each group.
*/
;WITH customer_segment AS(
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(f.order_date) AS first_order,
MAX(f.order_date) AS last_order,
DATEDIFF(MONTH,MIN(f.order_date),MAX(f.order_date)) AS lifespan,
CASE WHEN SUM(f.sales_amount)>5000 AND DATEDIFF(MONTH,MIN(f.order_date),MAX(f.order_date))>=12 THEN 'VIP'
     WHEN SUM(f.sales_amount)<=5000 AND DATEDIFF(MONTH,MIN(f.order_date),MAX(f.order_date))>=12 THEN 'Regular'
     ELSE 'New'
END cust_group
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key=f.customer_key
GROUP BY c.customer_key)

SELECT
COUNT(customer_key) AS total_customer,
cust_group
FROM customer_segment
GROUP BY cust_group 
ORDER BY total_customer DESC
