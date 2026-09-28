/*
======================================================================================================================================================
Product Report
======================================================================================================================================================
Purpose:
    - This report consolidates key product and behaviours.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, Low-Performers.
    3. Aggregates product-level metrics:
      - total sales
      - total orders
      - total quantity sold
      - total customers (unique)
      - lifespan (in months)
    4. Calculates valuable KPIs:
      - recency (months since last sale)
      - average order revenue (AOR)
      - average monthly income
======================================================================================================================================================
*/
CREATE VIEW gold.product_report AS
/*----------------------------------------------------------------------------------------------------------------------------------------------------
1) Retrieve base columns from the table.
-----------------------------------------------------------------------------------------------------------------------------------------------------*/
WITH base_query AS(
SELECT
f.order_number,
f.customer_key,
f.order_date,
f.sales_amount,
f.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE f.order_date IS NOT NULL)

/*--------------------------------------------------------------------------------------------------------------------------------------------------
2) Product Aggregation: Summarize keymetrics at product level
---------------------------------------------------------------------------------------------------------------------------------------------------*/
,product_aggregation AS(
SELECT
   product_key,
   product_name,
   category,
   subcategory,
   cost,
   COUNT(DISTINCT order_number) AS total_orders,
   SUM(sales_amount) AS total_sales,
   COUNT(DISTINCT customer_key) AS total_customer,
   SUM(quantity) AS total_quantity,
   MAX(order_date) AS last_sale_date,
   DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
   ROUND(AVG(CAST(sales_amount AS FLOAT)/NULLIF(quantity,0)),1) AS avg_selling_price
FROM base_query
GROUP BY
  product_key,
  product_name,
  category,
  subcategory,
  cost)
/*---------------------------------------------------------------------------------------------------------------------------------------------
3)Final Query: Combines all product results into one output
-----------------------------------------------------------------------------------------------------------------------------------------------*/

  SELECT
  product_key,
  product_name,
  category,
  subcategory,
  cost,
  total_orders,
  total_sales,
  total_customer,
  total_quantity,
  avg_selling_price,
  CASE 
     WHEN total_sales>100000 THEN 'High-Performers'
     WHEN total_sales BETWEEN 50000 AND 100000 THEN 'Mid-Performers'
     ELSE 'Low-Performers'
  END AS performance_range,
  last_sale_date,
  DATEDIFF(MONTH,last_sale_date, GETDATE()) AS recency_in_month,  --KPI
  --Average Order Revenue
  CASE WHEN total_sales=0 THEN 0
       ELSE total_sales/total_orders
    END AS  avg_order_revenue,
 lifespan,
  --Average Monthly Order
  CASE 
      WHEN lifespan = 0 THEN total_sales
      ELSE total_sales/lifespan
  END AS avg_monthly_order
  FROM product_aggregation

