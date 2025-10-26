# Zepto_Sql
Zepto Dataset Analysis using PostgreSQL
1. Project Overview



This project performs data analysis on the Zepto dataset using PostgreSQL to uncover key business insights related to product pricing, discount strategies, and inventory management.
By using SQL-based analysis, this project highlights how relational data querying can drive better decisions in retail operations.

2. Objectives
Identify best-value products and categories based on discount percentages.
Understand pricing patterns for high-MRP and out-of-stock products.
Estimate total potential revenue per product category.
Group products by weight and analyze inventory performance.
3. Tools and Technologies
Database: PostgreSQL
Language: SQL
Interface: pgAdmin / DBeaver
Dataset: Zepto product dataset (columns include name, category, mrp, discountedSellingPrice, discountPercent, availableQuantity, outOfStock, weightInGms)
4. SQL Analysis Queries
1️⃣ Top 10 Best-Value Products (Highest Discounts)



Find the top 10 products offering the highest discount percentages.

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;




Insight: Helps marketing teams identify products ideal for promotional campaigns.

2️⃣ High-MRP Products That Are Out of Stock



Identify premium-priced products currently unavailable in inventory.

SELECT DISTINCT name, mrp, outOfStock
FROM zepto
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;




Insight: Indicates potential demand-supply gaps for high-value items.

3️⃣ Estimated Revenue by Category



Calculate estimated total revenue per category based on current stock.

SELECT category,
       SUM(discountedSellingPrice * availabeQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;




Insight: Determines which categories contribute most to total potential revenue.

4️⃣ High-MRP, Low-Discount Products



List premium products (MRP > 500) with low discount offers.

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;




Insight: Useful for pricing strategy — may indicate premium or exclusive items.

5️⃣ Top 5 Categories with Highest Average Discount



Identify which product categories offer the largest average discounts.

SELECT category,
       ROUND(AVG(discountPercent), 2) AS avg_dis
FROM zepto
GROUP BY category
ORDER BY avg_dis DESC
LIMIT 5;




Insight: Helps understand which product lines are most discounted — good for evaluating profitability.

6️⃣ Price per Gram (Best Value by Weight)



Compute product value efficiency based on weight.

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;




Insight: Useful for comparing per-unit value — helpful in FMCG or grocery analysis.

7️⃣ Weight-Based Product Categorization



Group products based on their total weight category (Low, Medium, Bulk).

SELECT DISTINCT name, weightInGms,
CASE
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto;




Insight: Classifies items for inventory or logistics optimization.

8️⃣ Total Inventory Weight per Category



Compute the total weight of available products in each category.

SELECT category,
       SUM(weightInGms * availabeQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;




Insight: Useful for warehouse space planning and shipment optimization.

5. Key Business Insights (Summary)
Discount Patterns: Certain categories offer consistently higher discounts — can boost customer acquisition.
Out-of-Stock Premium Products: These signal unmet demand opportunities.
Revenue Estimation: Reveals top revenue-generating categories for prioritization.
Value-for-Money Items: Identified by high weight-based efficiency (low price per gram).
Logistics Optimization: Weight analysis supports inventory management and supply chain decisions.
6. Future Enhancements
Automate SQL execution using Python (psycopg2 or SQLAlchemy) for real-time analytics.
Integrate with Power BI or Tableau for dashboard visualization.
Expand dataset to include order and customer data for deeper retail insights.
7. Conclusion



This project demonstrates how PostgreSQL and SQL queries can be leveraged to gain actionable business intelligence from the Zepto dataset.
The analysis uncovers valuable insights about discounts, product availability, pricing efficiency, and category-level performance — empowering data-driven retail decisions.




Author: Prabha M
Domain: Data Analysis | PostgreSQL | Business Intelligence
Dataset: Zepto Product Dataset
Objective: Extract and analyze business insights using SQL queries
