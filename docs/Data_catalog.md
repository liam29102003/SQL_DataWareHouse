# Gold Layer – Data Catalog

## Overview
The **Gold Layer** represents curated, business-ready data optimized for **analytics, dashboards, and reporting**.  
It contains **dimension tables** that provide descriptive context and **fact tables** that capture measurable business events.

---

## 1. `gold.dim_customers`

### Purpose
Stores enriched customer information, including demographic and geographic attributes, to support customer-focused analysis.

### Columns

| Column Name     | Data Type    | Description |
|-----------------|--------------|-------------|
| customer_key    | INT          | Surrogate key that uniquely identifies each customer record in the dimension table. |
| customer_id     | INT          | Business identifier assigned to the customer in source systems. |
| customer_number | NVARCHAR(50) | Alphanumeric customer reference used for tracking and reporting. |
| first_name      | NVARCHAR(50) | Customer’s first name. |
| last_name       | NVARCHAR(50) | Customer’s last name or family name. |
| country         | NVARCHAR(50) | Customer’s country of residence (e.g., Australia). |
| marital_status  | NVARCHAR(50) | Customer’s marital status (e.g., Married, Single). |
| gender          | NVARCHAR(50) | Customer’s gender (e.g., Male, Female, n/a). |
| birthdate       | DATE         | Customer’s date of birth in `YYYY-MM-DD` format. |
| create_date     | DATE         | Date when the customer record was created in the system. |

---

## 2. `gold.dim_products`

### Purpose
Contains descriptive product attributes used for product-level reporting and analysis.

### Columns

| Column Name            | Data Type    | Description |
|------------------------|--------------|-------------|
| product_key            | INT          | Surrogate key uniquely identifying each product record. |
| product_id             | INT          | Business identifier for the product from source systems. |
| product_number         | NVARCHAR(50) | Alphanumeric product code used for inventory and categorization. |
| product_name           | NVARCHAR(50) | Descriptive product name including key attributes. |
| category_id            | NVARCHAR(50) | Identifier representing the product’s category. |
| category               | NVARCHAR(50) | High-level product classification (e.g., Bikes, Components). |
| subcategory            | NVARCHAR(50) | Detailed product classification within the category. |
| maintenance_required   | NVARCHAR(50) | Indicates whether the product requires maintenance (Yes/No). |
| cost                   | INT          | Base cost of the product in monetary units. |
| product_line           | NVARCHAR(50) | Product line or series (e.g., Road, Mountain). |
| start_date             | DATE         | Date when the product became available for sale. |

---

## 3. `gold.fact_sales`

### Purpose
Stores transactional sales data used for revenue, volume, and performance analysis.

### Columns

| Column Name   | Data Type    | Description |
|---------------|--------------|-------------|
| order_number  | NVARCHAR(50) | Unique identifier for the sales order (e.g., SO54496). |
| product_key   | INT          | Foreign key referencing `gold.dim_products`. |
| customer_key  | INT          | Foreign key referencing `gold.dim_customers`. |
| order_date    | DATE         | Date when the order was placed. |
| shipping_date | DATE         | Date when the order was shipped. |
| due_date      | DATE         | Payment due date for the order. |
| sales_amount  | INT          | Total sales value for the line item. |
| quantity      | INT          | Number of units sold for the line item. |
| price         | INT          | Unit price of the product at the time of sale. |

---

### Notes
- All **dimension tables** use **surrogate keys** to ensure consistency and support historical tracking.
- The **fact table** is designed to support analytical use cases such as revenue trends, customer behavior, and product performance.
