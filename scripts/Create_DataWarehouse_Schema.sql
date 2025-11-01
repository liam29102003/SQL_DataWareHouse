/***********************************************************************************************
 Script Name   : Create_DataWarehouse_Schema.sql
 Description   : This script initializes the Data Warehouse environment by recreating the 
                 'DataWarehouse' database and establishing a three-tier schema structure 
                 aligned with the Data Lakehouse architecture.

                 Key Operations:
                   • Drops the existing 'DataWarehouse' database if it exists.
                   • Creates a new 'DataWarehouse' database.
                   • Defines the following schemas:
                        - bronze: Stores raw, unprocessed data (landing zone).
                        - silver: Contains cleansed and transformed data.
                        - gold: Holds curated, aggregated, and business-ready data.

 Usage Notes   : Ensure no active connections to the existing 'DataWarehouse' database 
                 before executing this script. Running this script will permanently remove 
                 existing data in 'DataWarehouse'.

 Author        : Lynn Khant Aung
 Created Date  : [31.10.2025]
 Version       : 1.0
***********************************************************************************************/



USE master;
GO

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;
GO

Use DataWarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


