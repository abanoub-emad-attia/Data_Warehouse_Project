-- ============================================================================
-- SCRIPT NAME: ddl_bronze_layer.sql
-- SCRIPT PURPOSE:
--   Create all tables in the 'bronze' schema (raw data layer)
--   This script will DROP existing tables if they exist and recreate them
--   with proper DDL structure
-- 
-- TABLES CREATED:
--   1. bronze.crm_cust_info       - CRM Customer Information
--   2. bronze.crm_prd_info        - CRM Product Information
--   3. bronze.crm_sales_details   - CRM Sales Details/Transactions
--   4. bronze.erp_cust_az12       - ERP Customer Data (AZ12 Module)
--   5. bronze.erp_loc_a101        - ERP Location/Warehouse Data (A101 Module)
--   6. bronze.erp_px_cat_g1v2     - ERP Price Category Hierarchy (G1V2 Module)
--
-- NOTES:
--   - All tables are created in the 'bronze' schema
--   - Tables accept NULL values for data flexibility
--   - No primary keys or constraints (raw layer design)
--   - Compatible with BULK INSERT operations
-- ============================================================================

USE DataWarehouse;
GO


-- ============================================================================
-- TABLE 1: bronze.crm_cust_info
-- ============================================================================
-- Purpose: Store customer information from CRM source system
-- ============================================================================

PRINT('Creating TABLE: bronze.crm_cust_info...');
GO

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

GO

CREATE TABLE bronze.crm_cust_info
(
	cst_id              INT,
	cst_key             NVARCHAR(50),
	cst_firstname       NVARCHAR(100),
	cst_lastname        NVARCHAR(100),
	cst_marital_status  NVARCHAR(50),
	cst_gndr            NVARCHAR(50),
	cst_create_date     DATE
);

GO

PRINT('TABLE bronze.crm_cust_info created successfully.');
GO


-- ============================================================================
-- TABLE 2: bronze.crm_prd_info
-- ============================================================================
-- Purpose: Store product information from CRM source system
-- ============================================================================

PRINT('Creating TABLE: bronze.crm_prd_info...');
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

GO

CREATE TABLE bronze.crm_prd_info
(
	prd_id              INT,
	prd_key             NVARCHAR(50),
	prd_name            NVARCHAR(200),
	prd_category        NVARCHAR(100),
	prd_subcategory     NVARCHAR(100),
	prd_price           DECIMAL(10, 2),
	prd_cost            DECIMAL(10, 2),
	prd_status          NVARCHAR(50),
	prd_create_date     DATE
);

GO

PRINT('TABLE bronze.crm_prd_info created successfully.');
GO


-- ============================================================================
-- TABLE 3: bronze.crm_sales_details
-- ============================================================================
-- Purpose: Store sales transaction details from CRM source system
-- ============================================================================

PRINT('Creating TABLE: bronze.crm_sales_details...');
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

GO

CREATE TABLE bronze.crm_sales_details
(
	sal_id              INT,
	sal_key             NVARCHAR(50),
	sal_cust_id         INT,
	sal_prd_id          INT,
	sal_quantity        INT,
	sal_unit_price      DECIMAL(10, 2),
	sal_total_amount    DECIMAL(10, 2),
	sal_discount        DECIMAL(10, 2),
	sal_net_amount      DECIMAL(10, 2),
	sal_date            DATE,
	sal_create_date     DATE
);

GO

PRINT('TABLE bronze.crm_sales_details created successfully.');
GO


-- ============================================================================
-- TABLE 4: bronze.erp_cust_az12
-- ============================================================================
-- Purpose: Store customer data from ERP source system (AZ12 Module)
-- ============================================================================

PRINT('Creating TABLE: bronze.erp_cust_az12...');
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

GO

CREATE TABLE bronze.erp_cust_az12
(
	cst_id              INT,
	cst_code            NVARCHAR(50),
	cst_name            NVARCHAR(200),
	cst_type            NVARCHAR(50),
	cst_industry        NVARCHAR(100),
	cst_country         NVARCHAR(50),
	cst_region          NVARCHAR(50),
	cst_payment_terms   NVARCHAR(50),
	cst_credit_limit    DECIMAL(12, 2),
	cst_status          NVARCHAR(50),
	cst_create_date     DATE,
	cst_update_date     DATE
);

GO

PRINT('TABLE bronze.erp_cust_az12 created successfully.');
GO


-- ============================================================================
-- TABLE 5: bronze.erp_loc_a101
-- ============================================================================
-- Purpose: Store location/warehouse data from ERP source system (A101 Module)
-- ============================================================================

PRINT('Creating TABLE: bronze.erp_loc_a101...');
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

GO

CREATE TABLE bronze.erp_loc_a101
(
	loc_id              INT,
	loc_code            NVARCHAR(50),
	loc_name            NVARCHAR(200),
	loc_type            NVARCHAR(50),
	loc_country         NVARCHAR(50),
	loc_state_province  NVARCHAR(50),
	loc_city            NVARCHAR(100),
	loc_address         NVARCHAR(200),
	loc_capacity        INT,
	loc_manager         NVARCHAR(100),
	loc_status          NVARCHAR(50),
	loc_create_date     DATE,
	loc_update_date     DATE
);

GO

PRINT('TABLE bronze.erp_loc_a101 created successfully.');
GO


-- ============================================================================
-- TABLE 6: bronze.erp_px_cat_g1v2
-- ============================================================================
-- Purpose: Store price category hierarchy from ERP source system (G1V2 Module)
-- ============================================================================

PRINT('Creating TABLE: bronze.erp_px_cat_g1v2...');
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

GO

CREATE TABLE bronze.erp_px_cat_g1v2
(
	px_cat_id           INT,
	px_cat_code         NVARCHAR(50),
	px_cat_name         NVARCHAR(200),
	px_cat_level        INT,
	px_cat_parent_id    INT,
	px_cat_description  NVARCHAR(500),
	px_cat_discount     DECIMAL(5, 2),
	px_cat_margin       DECIMAL(5, 2),
	px_cat_status       NVARCHAR(50),
	px_cat_create_date  DATE,
	px_cat_update_date  DATE
);

GO

PRINT('TABLE bronze.erp_px_cat_g1v2 created successfully.');
GO


-- ============================================================================
-- SECTION: SUMMARY
-- ============================================================================

PRINT('');
PRINT('============================================================================');
PRINT('ALL BRONZE LAYER TABLES CREATED SUCCESSFULLY');
PRINT('============================================================================');
PRINT('Tables created:');
PRINT('  1. bronze.crm_cust_info');
PRINT('  2. bronze.crm_prd_info');
PRINT('  3. bronze.crm_sales_details');
PRINT('  4. bronze.erp_cust_az12');
PRINT('  5. bronze.erp_loc_a101');
PRINT('  6. bronze.erp_px_cat_g1v2');
PRINT('============================================================================');
PRINT('');

GO