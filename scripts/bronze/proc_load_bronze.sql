EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		
		SET @batch_start_time = GETDATE();

		PRINT '=========================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=========================================================';

		PRINT '---------------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '---------------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Table : bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\Dell\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		Print '--------------------'

		--SELECT * FROM bronze.crm_cust_info;--
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Table : bronze.crm_cust_info'
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\Users\Dell\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		Print '--------------------'

		--SELECT * FROM bronze.crm_prd_info;
		SET @start_time = GETDATE();

		PRINT '>> Truncating Table : bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Table : bronze.crm_cust_info'
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\Dell\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		Print '--------------------'


		--SELECT * FROM bronze.crm_sales_details;

		PRINT '---------------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '---------------------------------------------------------';
		SET @start_time = GETDATE();

		PRINT '>> Truncating Table : bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Table : bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12 
		FROM 'C:\Users\Dell\Downloads\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 

		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		Print '--------------------'

		--SELECT * FROM bronze.erp_cust_az12;
		SET @start_time = GETDATE();

		PRINT '>> Truncating Table : bronze.erp_loc_a101'

		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Table : bronze.erp_cust_az12'

		BULK INSERT bronze.erp_loc_a101 
		FROM 'C:\Users\Dell\Downloads\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 

		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		Print '--------------------'

		--SELECT * FROM bronze.erp_loc_a101;

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2'

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Table : bronze.erp_px_cat_g1v2'

		BULK INSERT bronze.erp_px_cat_g1v2 
		FROM 'C:\Users\Dell\Downloads\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 

		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		Print '--------------------'

		--SELECT * FROM bronze.erp_px_cat_g1v2;

		SET @batch_end_time = GETDATE();
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer is completed';
		PRINT '>> TOTAL LOAD DURATION: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';

		PRINT '===================================================';


	END TRY
	BEGIN CATCH
		PRINT '===================================================';
		PRINT 'ERROR OCCUR DURING LOADING BRONZE LAYER';
		PRINT 'ERROR Message ' + ERROR_MESSAGE();
		PRINT '===================================================';
	END CATCH
END
