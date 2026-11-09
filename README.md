# 🍕 Pizza Sales Analysis Project

Welcome to the **Pizza Sales Analysis** repository! This project features a comprehensive SQL-based analysis of pizza restaurant sales data using Microsoft SQL Server.

The project evaluates key business metrics—ranging from overall revenue and order values to temporal trends and product category distributions—to help management make informed operational and marketing decisions.

---

## 📊 Project Overview

The underlying database (`Project`) centers around the `pizza_sale` table, which captures transaction-level details including order IDs, pizza names, categories, sizes, quantities, unit prices, total prices, and exact order timestamps.

---

## 🔍 Key Business Metrics & SQL Analyses Explored

The analysis script addresses 9 core business questions to uncover sales patterns and customer purchasing behavior:

1. **Total Revenue Generation:** Calculates the overall gross revenue generated from all pizza sales (`SUM(total_price)`).
2. **Average Order Value (AOV):** Determines the average amount spent per customer order by dividing total revenue by total unique orders.
3. **Total Pizzas Sold:** Computes the aggregate volume of individual pizza units purchased.
4. **Total Orders Placed:** Counts the total number of distinct customer orders (`COUNT(DISTINCT order_id)`).
5. **Average Pizzas per Order:** Evaluates the average quantity of pizzas included in a single order.
6. **Daily Order Trends:** Analyzes demand patterns by grouping orders according to the day of the week (`DATENAME(DW, Order_date)`).
7. **Hourly Order Trends:** Breaks down order volumes across specific hours of the day to identify peak business hours.
8. **Sales Contribution by Category:** Calculates the percentage share of total revenue contributed by each pizza category using subquery aggregation.
9. **Sales Contribution by Size:** Evaluates customer preference and revenue distribution across different pizza sizes (e.g., Regular, Medium, Large).

---

## 💡 Conclusion & Business Insights

Analyzing this pizza sales dataset provides actionable intelligence for restaurant optimization:

* **Peak Demand Windows:** Tracking daily and hourly trends allows management to anticipate high-traffic periods, ensuring sufficient kitchen staff and delivery personnel are scheduled during peak hours.
* **Menu Performance:** Category and size contribution metrics highlight top-performing menu items and sizing preferences, enabling targeted promotions and optimized inventory planning.
* **Order Value Optimization:** Monitoring average order values helps in designing effective upselling strategies, such as combo meals or side-item add-ons, to boost overall revenue per customer.
