# Star Schema Design – FlexiMart Data Warehouse

## Section 1: Schema Overview

### FACT TABLE: fact_sales
**Grain:** One row per product per order line item  
**Business Process:** Sales transactions

**Measures (Numeric Facts):**
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied on the sale
- total_amount: Final sale amount (quantity × unit_price − discount)

**Foreign Keys:**
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

---

### DIMENSION TABLE: dim_date
**Purpose:** Supports time-based analysis  
**Type:** Conformed dimension

**Attributes:**
- date_key (PK): Surrogate key in YYYYMMDD format
- full_date: Actual calendar date
- day_of_week: Day name
- day_of_month: Day number
- month: Month number
- month_name: Month name
- quarter: Q1, Q2, Q3, Q4
- year: Calendar year
- is_weekend: Indicates weekend

---

### DIMENSION TABLE: dim_product
**Purpose:** Stores descriptive product information

**Attributes:**
- product_key (PK): Surrogate key
- product_id: Business product identifier
- product_name: Name of product
- category: Product category
- subcategory: Product subcategory
- unit_price: Standard unit price

---

### DIMENSION TABLE: dim_customer
**Purpose:** Stores customer descriptive attributes

**Attributes:**
- customer_key (PK): Surrogate key
- customer_id: Business customer identifier
- customer_name: Full name of customer
- city: Customer city
- state: Customer state
- customer_segment: Customer classification

---

## Section 2: Design Decisions (150 words)

The grain of the fact table is defined at the transaction line-item level to support detailed analysis of sales performance at the product level. This allows analysts to drill down from high-level summaries to individual product sales.

Surrogate keys are used instead of natural keys to improve performance and handle changes in source system identifiers. They also simplify joins between fact and dimension tables.

This star schema supports both drill-down and roll-up analysis. Analysts can roll up sales data by month, quarter, or year using the date dimension, and drill down by product category or customer segment using product and customer dimensions. The design is simple, efficient, and optimized for analytical queries.

---

## Section 3: Sample Data Flow

**Source Transaction:**
Order #101, Customer "John Doe", Product "Laptop", Qty: 2, Price: 50000

**Data Warehouse Representation:**

fact_sales:
- date_key: 20240115
- product_key: 5
- customer_key: 12
- quantity_sold: 2
- unit_price: 50000
- total_amount: 100000

dim_date:
- date_key: 20240115
- full_date: 2024-01-15
- month: 1
- quarter: Q1

dim_product:
- product_key: 5
- product_name: Laptop
- category: Electronics

dim_customer:
- customer_key: 12
- customer_name: John Doe
- city: Mumbai
