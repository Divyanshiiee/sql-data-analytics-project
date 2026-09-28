# 📊 SQL Data Analytics Project

## 📌 Project Overview

This project demonstrates the use of **SQL Server and advanced SQL techniques** to explore, analyze, and generate insights from structured sales data.

The project covers multiple stages of data analysis, including exploratory data analysis, time-based analysis, performance analysis, customer analysis, and product analysis.

The analysis was performed using relational sales data containing information about customers, products, and sales transactions.

The project focuses on applying SQL concepts to answer business-oriented questions and transform raw transactional data into meaningful analytical outputs.

## 🎯 Project Objectives

The main objectives of this project are to:

- Explore and understand structured sales data using SQL
- Analyze sales performance across different dimensions
- Calculate key business metrics and KPIs
- Identify trends and patterns in sales over time
- Analyze product performance and contribution to sales
- Analyze customer-level sales behavior and performance
- Apply advanced SQL techniques to perform deeper analysis
- Create reusable customer and product reporting views
- Translate analytical results into business-oriented insights

## 📊 Dataset

The project uses a relational sales dataset organized into multiple tables representing sales transactions, customers, and products.

The main tables used in the analysis are:

- `gold.fact_sales` — Contains sales transaction records and measures such as sales amount, quantity, and order-related information.
- `gold.dim_customers` — Contains customer-level information used for customer analysis and segmentation.
- `gold.dim_products` — Contains product information used for product performance and sales analysis.
## 🔍 Exploratory Data Analysis

The exploratory data analysis was performed using SQL to understand the structure, scale, and overall characteristics of the sales data.

The analysis included:

### Database Exploration

- Examined the available tables and their columns
- Reviewed the structure of the sales, customer, and product data
- Identified the relevant dimensions and measures used throughout the analysis

### Date & Time Analysis

- Examined the date range of the available sales data
- Identified the earliest and latest sales dates
- Analyzed the time period covered by the dataset

### Key Performance Indicators

Calculated important business metrics including:

- Total Sales
- Total Quantity Sold
- Total Number of Orders
- Total Number of Products
- Total Number of Customers
- Average Selling Price

### Magnitude Analysis

Analyzed sales performance across different dimensions, including:

- Customers
- Products
- Product categories
- Customer demographics

This helped identify differences in sales performance across the available business dimensions.

### Ranking Analysis

Used SQL ranking techniques to identify:

- Top-performing products
- Lowest-performing products
- Top customers based on sales
- Customers and products based on other relevant performance metrics

  ## 🧠 Advanced SQL Analytics

The project applies advanced SQL techniques to perform deeper analysis beyond basic aggregations.

### Time-Based Analysis

Analyzed sales performance over time to identify:

- Yearly sales trends
- Monthly sales trends
- Changes in sales performance across different time periods

### Cumulative Analysis

Used window functions to calculate:

- Running total of sales
- Cumulative sales performance over time
- Cumulative contribution of sales across periods

### Performance Analysis

Compared product performance against historical and benchmark values to identify changes and performance patterns.

The analysis included techniques such as:

- Previous-period comparisons
- Performance changes over time
- Product-level performance evaluation

### Part-to-Whole Analysis

Analyzed how individual products and categories contribute to overall sales.

This included calculating:

- Percentage contribution to total sales
- Contribution of individual products
- Contribution of product categories

### Data Segmentation

Used conditional logic to segment products based on their performance and characteristics.

This demonstrates the use of SQL to transform raw transactional data into meaningful business classifications.

### Advanced SQL Techniques Used

The analysis makes use of:

- Common Table Expressions (CTEs)
- Window Functions
- LAG()
- SUM() OVER()
- RANK()
- CASE WHEN
- Aggregate Functions
- GROUP BY
- PARTITION BY
- Date Functions
- Subqueries
- Multi-table Joins

  ## 📋 Customer & Product Reporting

The project includes reusable SQL reports for analyzing customer and product performance.

The reports cover metrics such as:

- Total sales, orders, and quantity
- Customer and product performance
- Average order value and average selling price
- Customer and product recency
- Customer and product segmentation
- Monthly performance metrics

The reports use **CTEs, aggregations, date calculations, conditional logic, and SQL views** to organize analytical metrics into reusable reporting structures.

## 👩‍💻 About Me

Hi! I'm **Divyanshi**, a B.Com Honours student developing my skills in **Data Analytics and Business Intelligence**.

I have a growing interest in using **SQL, Python, Excel, and Power BI** to analyze data, identify patterns, and generate meaningful business insights.

I'm currently building hands-on projects to strengthen my analytical and technical skills.
