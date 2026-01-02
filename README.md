# Modern SQL Data Warehouse Project (From Scratch)

This repository contains a **full end-to-end SQL Data Warehouse project** built to learn how to design modern data architecture, implement SQL-based ETL pipelines, and prepare analytics-ready datasets.

---

## 🧠 Project Summary

This project demonstrates how to:

- Use Medallion Architecture: **Bronze → Silver → Gold layers**  
- Implement ETL using SQL (cleaning, transformation, integration)  
- Build analytics tables optimized for business reporting  
- Version control everything with Git and GitHub best practices :contentReference[oaicite:3]{index=3}

---

## 🏗️ Architecture Overview

The warehouse follows a **Medallion Architecture:**


**Bronze:** Raw CSV data ingested into the database  
**Silver:** Data cleansed, normalized, and standardized  
**Gold:** Analytical tables ready for reporting and dashboards :contentReference[oaicite:4]{index=4}

---

## 💡 Key Components

### Data Layers
- **Bronze:** Raw ingestion tables
- **Silver:** Cleaned, validated, transformed data
- **Gold:** Final fact/dimension or analytical tables

### Workflow Steps
1. Understand business requirements  
2. Design data architecture & models  
3. Create staging tables  
4. Clean and transform data  
5. Load into analytical tables  
6. Run sample analytics queries  
7. Document & commit changes

   ## 🧪 Running Instructions (Example)

1. Create database in SQL Server  
2. Run scripts in this order:
   - `sql/bronze/load_raw.sql`
   - `sql/silver/transform_data.sql`
   - `sql/gold/load_analytics.sql`
3. Run sample business queries  
4. Explore results

---

## 📺 Based On Tutorial

This project is built by following the hands-on tutorial:
https://youtu.be/9GVqKuTVANE?si=cCkAgXI-egIzVoLj
---




