# 🏗️ Data Warehouse Project

A structured data warehousing project that integrates data from two source systems — **CRM** and **ERP** — to build a unified, analytics-ready data warehouse following the **Medallion Architecture** (Bronze → Silver → Gold).

---

## 📁 Project Structure

```
Data_Warehouse_Project/
├── datasets/
│   ├── source_crm/           # CRM source data
│   │   ├── cust_info.csv     # Customer demographics & profile
│   │   ├── prd_info.csv      # Product catalog with pricing & lifecycle
│   │   └── sales_details.csv # Sales orders & transactions
│   └── source_erp/           # ERP source data
│       ├── CUST_AZ12.csv     # Customer birth dates & gender
│       ├── LOC_A101.csv      # Customer country/location
│       └── PX_CAT_G1V2.csv  # Product categories & sub-categories
├── scripts/                  # SQL / ETL transformation scripts
├── tests/                    # Data quality & validation tests
├── docs/                     # Project documentation & diagrams
└── README.md
```

---

## 🗂️ Data Sources

### CRM System (`datasets/source_crm/`)

| File | Description | Key Columns |
|------|-------------|-------------|
| `cust_info.csv` | Customer master data | `cst_id`, `cst_key`, `cst_firstname`, `cst_lastname`, `cst_marital_status`, `cst_gndr`, `cst_create_date` |
| `prd_info.csv` | Product catalog | `prd_id`, `prd_key`, `prd_nm`, `prd_cost`, `prd_line`, `prd_start_dt`, `prd_end_dt` |
| `sales_details.csv` | Sales transactions | `sls_ord_num`, `sls_prd_key`, `sls_cust_id`, `sls_order_dt`, `sls_ship_dt`, `sls_due_dt`, `sls_sales`, `sls_quantity`, `sls_price` |

### ERP System (`datasets/source_erp/`)

| File | Description | Key Columns |
|------|-------------|-------------|
| `CUST_AZ12.csv` | Customer birth dates & gender | `CID`, `BDATE`, `GEN` |
| `LOC_A101.csv` | Customer location/country | `CID`, `CNTRY` |
| `PX_CAT_G1V2.csv` | Product categories | `ID`, `CAT`, `SUBCAT`, `MAINTENANCE` |

---

## 🏛️ Architecture — Medallion Layers

```
┌─────────────────────────────────────────────────────────┐
│                  Source Systems                         │
│           CRM                      ERP                  │
│  (cust_info, prd_info,    (CUST_AZ12, LOC_A101,        │
│   sales_details)           PX_CAT_G1V2)                 │
└────────────────────┬────────────────────────────────────┘
                     │  Raw Ingestion
                     ▼
┌─────────────────────────────────────────────────────────┐
│  🥉 BRONZE Layer  — Raw / As-Is                         │
│  • No transformations applied                           │
│  • Full history preserved                               │
│  • Audit columns (load date, source)                    │
└────────────────────┬────────────────────────────────────┘
                     │  Cleanse & Standardize
                     ▼
┌─────────────────────────────────────────────────────────┐
│  🥈 SILVER Layer  — Cleaned & Conformed                 │
│  • Data type casting & null handling                    │
│  • Deduplication & trimming                             │
│  • Standardized codes (gender, marital status, etc.)   │
│  • Key normalization across CRM ↔ ERP                  │
└────────────────────┬────────────────────────────────────┘
                     │  Integrate & Model
                     ▼
┌─────────────────────────────────────────────────────────┐
│  🥇 GOLD Layer    — Business-Ready                      │
│  • Star schema: Fact + Dimension tables                 │
│  • dim_customers, dim_products, fact_sales              │
│  • Optimized for analytics & reporting                  │
└─────────────────────────────────────────────────────────┘
```

---

## 🔗 Data Integration

The two source systems are joined using customer and product keys:

- **Customer:** `cst_key` (CRM) ↔ `CID` (ERP) — links demographics with birth date, gender, and location
- **Product:** `prd_key` (CRM) ↔ `ID` (ERP) — links product details with category & sub-category
- **Sales:** `sls_cust_id` and `sls_prd_key` link transactions to customers and products

---

## ⚙️ Getting Started

### Prerequisites

- A SQL database engine (e.g., SQL Server, PostgreSQL, Snowflake, or DuckDB)
- Access to the `datasets/` folder

### Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Data_Warehouse_Project
   ```

2. **Load source data**  
   Import all CSV files from `datasets/source_crm/` and `datasets/source_erp/` into your database's raw/staging schema.

3. **Run ETL scripts**  
   Execute the scripts in `scripts/` in order (Bronze → Silver → Gold).

4. **Validate data quality**  
   Run the test suite in `tests/` to verify row counts, null checks, and referential integrity.

---

## 📊 Key Entities

| Entity | Source | Description |
|--------|--------|-------------|
| **Customers** | CRM + ERP | Full customer profile: name, gender, marital status, birth date, country |
| **Products** | CRM + ERP | Product details with cost, line, category, sub-category, and active date range |
| **Sales** | CRM | Order-level transactions with quantity, price, and dates |

---

## 🧪 Data Quality Checks

The `tests/` directory contains validation scripts to ensure:

- No duplicate customer or order records
- Valid date ranges (`start_dt` ≤ `end_dt`)
- No orphaned sales records (every sale links to a valid customer and product)
- Standardized categorical values (gender, marital status, product line)
- Non-negative sales amounts and quantities

---

## 📄 License

This project is intended for educational and analytical purposes.
