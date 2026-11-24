-- ============================================================================
-- PROCEDURE: bronze.load_bronze
-- PURPOSE: Load all source data into the bronze (raw) layer
-- DESCRIPTION:
--   Loads data from 6 different CSV sources:
--   - 3 CRM tables (Customer, Product, Sales Details)
--   - 3 ERP tables (Customer AZ12, Location A101, Price Category G1V2)
-- ============================================================================

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
	DECLARE @start_time DATETIME;
	DECLARE @end_time DATETIME;
	DECLARE @batch_start_time DATETIME;
	DECLARE @batch_end_time DATETIME;

BEGIN TRY
	
	SET @batch_start_time = GETDATE();
	
	PRINT('');
	PRINT('============================================================================');
	PRINT('LOADING THE BRONZE LAYER');
	PRINT('============================================================================');
	PRINT('');

	-- ============================================================================
	-- SECTION 1: CRM CUSTOMER INFO LOAD
	-- ============================================================================
	-- Purpose: Load customer information from CRM source system
	-- Source File: cust_info.csv
	-- Target Table: bronze.crm_cust_info (bronze/raw layer)
	-- ============================================================================

	PRINT('============================================================================');
	PRINT('TABLE 1: LOADING CRM CUSTOMER INFO');
	PRINT('============================================================================');


	SET @start_time = GETDATE();

	PRINT('TRUNCATING TABLE : bronze.crm_cust_info');
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT('INSERTING DATA INTO : bronze.crm_cust_info');
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_crm\cust_info.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	PRINT('VERIFYING THE RESULT');
	SELECT COUNT(*) AS [Row Count] FROM bronze.crm_cust_info;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');
	-- ============================================================================
	-- SECTION 2: CRM PRODUCT INFO LOAD
	-- ============================================================================
	-- Purpose: Load product information from CRM source system
	-- Source File: prd_info.csv
	-- Target Table: bronze.crm_prd_info (bronze/raw layer)
	-- ============================================================================

	PRINT('============================================================================');
	PRINT('TABLE 2: LOADING CRM PRODUCT INFO');
	PRINT('============================================================================');

	SET @start_time = GETDATE();

	PRINT('TRUNCATING TABLE : bronze.crm_prd_info');
	TRUNCATE TABLE bronze.crm_prd_info;

	PRINT('INSERTING DATA INTO : bronze.crm_prd_info');
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_crm\prd_info.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	PRINT('VERIFYING THE RESULT');
	SELECT COUNT(*) AS [Row Count] FROM bronze.crm_prd_info;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');
	-- ============================================================================
	-- SECTION 3: CRM SALES DETAILS LOAD
	-- ============================================================================
	-- Purpose: Load sales transaction details from CRM source system
	-- Source File: sales_details.csv
	-- Target Table: bronze.crm_sales_details (bronze/raw layer)
	-- ============================================================================

	PRINT('============================================================================');
	PRINT('TABLE 3: LOADING CRM SALES DETAILS');
	PRINT('============================================================================');

	SET @start_time = GETDATE();

	PRINT('TRUNCATING TABLE : bronze.crm_sales_details');
	TRUNCATE TABLE bronze.crm_sales_details;

	PRINT('INSERTING DATA INTO : bronze.crm_sales_details');
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_crm\sales_details.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	PRINT('VERIFYING THE RESULT');
	SELECT COUNT(*) AS [Row Count] FROM bronze.crm_sales_details;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');

	-- ========================================================================
	-- ERP SECTION START
	-- ========================================================================

	PRINT('============================================================================');
	PRINT('LOADING ERP TABLES');
	PRINT('============================================================================');
	PRINT('');

	-- ============================================================================
	-- SECTION 4: ERP CUSTOMER AZ12 LOAD
	-- ============================================================================
	-- Purpose: Load customer data from ERP source system (AZ12 module)
	-- Source File: CUST_AZ12.csv
	-- Target Table: bronze.erp_cust_az12 (bronze/raw layer)
	-- ============================================================================

	PRINT('============================================================================');
	PRINT('TABLE 4: LOADING ERP CUSTOMER AZ12');


	SET @start_time = GETDATE();

	PRINT('TRUNCATING TABLE : bronze.erp_cust_az12');
	TRUNCATE TABLE bronze.erp_cust_az12;

	PRINT('INSERTING DATA INTO : bronze.erp_cust_az12');
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_erp\CUST_AZ12.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	PRINT('VERIFYING THE RESULT');
	SELECT COUNT(*) AS [Row Count] FROM bronze.erp_cust_az12;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');

	-- ============================================================================
	-- SECTION 5: ERP LOCATION A101 LOAD
	-- ============================================================================
	-- Purpose: Load location/warehouse data from ERP source system (A101 module)
	-- Source File: loc_a101.csv
	-- Target Table: bronze.erp_loc_a101 (bronze/raw layer)
	-- ============================================================================

	PRINT('============================================================================');
	PRINT('TABLE 5: LOADING ERP LOCATION A101');
	PRINT('============================================================================');

	SET @start_time = GETDATE();

	PRINT('TRUNCATING TABLE : bronze.erp_loc_a101');
	TRUNCATE TABLE bronze.erp_loc_a101;

	PRINT('INSERTING DATA INTO : bronze.erp_loc_a101');
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_erp\loc_a101.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	PRINT('VERIFYING THE RESULT');
	SELECT COUNT(*) AS [Row Count] FROM bronze.erp_loc_a101;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');
	-- Purpose: Load price category hierarchy from ERP source system (G1V2 module)
	-- Source File: px_cat_g1v2.csv
	-- Target Table: bronze.erp_px_cat_g1v2 (bronze/raw layer)

	SET @start_time = GETDATE()

	PRINT 'TRUNCATING TABLE : bronze.erp_px_cat_g1v2'
	-- Step 1: Clear existing data
	TRUNCATE TABLE bronze.erp_px_cat_g1v2 ;


	PRINT 'INSERT DATA INTO : bronze.erp_px_cat_g1v2'
	-- Step 2: Bulk insert ERP price category data
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
	);

	-- Step 3: Verify row count
	SELECT count(*) FROM bronze.erp_px_cat_g1v2;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');

	-- ============================================================================
	-- SECTION 6: ERP PRICE CATEGORY G1V2 LOAD
	-- ============================================================================
	-- Purpose: Load price category hierarchy from ERP source system (G1V2 module)
	-- Source File: px_cat_g1v2.csv
	-- Target Table: bronze.erp_px_cat_g1v2 (bronze/raw layer)
	-- ============================================================================

	PRINT('============================================================================');
	PRINT('TABLE 6: LOADING ERP PRICE CATEGORY G1V2');
	PRINT('============================================================================');

	SET @start_time = GETDATE();

	PRINT('TRUNCATING TABLE : bronze.erp_px_cat_g1v2');
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	PRINT('INSERTING DATA INTO : bronze.erp_px_cat_g1v2');
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\Abanoub\Desktop\Data_Warehouse_Project\datasets\source_erp\px_cat_g1v2.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	PRINT('VERIFYING THE RESULT');
	SELECT COUNT(*) AS [Row Count] FROM bronze.erp_px_cat_g1v2;

	SET @end_time = GETDATE();
	PRINT('LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds');
	PRINT('');

	-- ========================================================================
	-- SECTION 7: PROCEDURE END
	-- ========================================================================

	SET @batch_end_time = GETDATE();

	PRINT('============================================================================');
	PRINT('BRONZE LAYER LOAD COMPLETED SUCCESSFULLY');
	PRINT('============================================================================');
	PRINT('')
	PRINT('TOTAL LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds');


END TRY
BEGIN CATCH

	-- ========================================================================
	-- ERROR HANDLING
	-- ========================================================================

	PRINT('');
	PRINT('============================================================================');
	PRINT('ERROR OCCURRED DURING BRONZE LAYER LOAD');
	PRINT('============================================================================');
	PRINT('ERROR MESSAGE : ' + ERROR_MESSAGE());
	PRINT('ERROR LINE    : ' + CAST(ERROR_LINE() AS NVARCHAR));
	PRINT('ERROR NUMBER  : ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('============================================================================');
	PRINT('');

END CATCH;

END;
GO