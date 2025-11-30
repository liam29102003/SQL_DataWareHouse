/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
    DROP VIEW gold.dim_customer;
GO
  
CREATE VIEW gold.dim_customer as
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
    ci.cst_id as customer_id,
    ci.cst_key as customer_number,
    ci.cst_firstname as first_name,
    ci.cst_lastname as last_name  ,
    la.cntyr as country,
    ci.cst_material_status as marital_status,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
    	ELSE COALESCE(ca.gen, 'n/a')
    	END AS gender,
    	ca.bdate as birthdate,
    ci.cst_create_date as create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
  ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
  ON	ci.cst_key = la.cid  
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
  
CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_data, pn.prd_key) AS product_key,
    pn.prd_id AS product_id,
    pn.prd_key AS product_number ,
    pn.prd_nm AS product_name,
    pn.cat_id category_id,
    pc.cat AS category,
    pc.subcat AS subcategory,
    pc.maintenance,
    
    pn.prd_cost AS cost,
    pn.prd_line AS product_line,
    pn.prd_start_data AS start_date

FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL --Filter out all historical data

GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
  
CREATE VIEW gold.fact_sales AS
SELECT 
  sd.sls_ord_num AS order_number,
  pr.product_key,
  cu.customer_key,
  sd.sls_order_dt AS order_date,
  sd.sls_ship_dt AS shipping_date,
  sd.sls_due_dt AS due_date,
  sd.sls_sales AS sales_amount,
  sd.sls_quantity AS quantity,
  sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFt JOIN gold.dim_products pr
  ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu
  ON sd.sls_cust_id = cu.customer_id
GO
