# Database Schema Documentation – FlexiMart

## 1️⃣ Entity–Relationship Description

### ENTITY: customers
**Purpose:** Stores registered customer information  
**Attributes:**
- **customer_id** (PK): Unique internal identifier
- **first_name**: Customer first name
- **last_name**: Customer last name
- **email**: Unique email address for communication and login
- **phone**: Standardized contact number
- **city**: Customer location for delivery insights
- **registration_date**: When the customer registered

**Relationships**
- One customer can place **many** orders  
  (1:M relationship with **orders**)

---

### ENTITY: products
**Purpose:** Contains product catalog information  
**Attributes:**
- **product_id** (PK): Unique identifier for each product
- **product_name**: Name of the product
- **category**: Standardized product category
- **price**: Selling price of product
- **stock_quantity**: Available inventory

**Relationships**
- One product can appear in **many** order line items  
  (1:M with **order_items**)

---

### ENTITY: orders
**Purpose:** Stores overall order information  
**Attributes:**
- **order_id** (PK)
- **customer_id** (FK → customers.customer_id)
- **order_date**: Purchase date
- **total_amount**: Final payable amount
- **status**: Order status (Completed/Pending/Cancelled)

**Relationships**
- One order contains **many** order items  
  (1:M with **order_items**)

---

### ENTITY: order_items
**Purpose:** Stores product‑level items within each order  
**Attributes:**
- **order_item_id** (PK)
- **order_id** (FK → orders.order_id)
- **product_id** (FK → products.product_id)
- **quantity**: Units bought
- **unit_price**: Price per unit at time of purchase
- **subtotal**: Calculated as quantity × unit_price

---

## 2️⃣ Normalization Explanation (3NF Justification)

This database schema is designed in **Third Normal Form (3NF)** to ensure data integrity and reduce redundancy.

### Functional Dependencies
- customer_id → first_name, last_name, email, phone, city, registration_date  
- product_id → product_name, category, price, stock_quantity  
- order_id → customer_id, order_date, total_amount, status  
- order_item_id → order_id, product_id, quantity, unit_price, subtotal  

Each non‑key attribute depends **only on the primary key** of its own table.

### How 3NF avoids anomalies
| Anomaly Type | Prevention in this Design |
|-------------|-------------------------|
| **Update Anomaly** | Changing a product price happens only once inside `products` table |
| **Insert Anomaly** | We can add new customers without requiring an order |
| **Delete Anomaly** | Deleting an order does not remove customer or product records |

### Why it is 3NF
✔ No composite primary keys with partial dependencies  
✔ No transitive dependencies (e.g., customer city does not depend on order_id)  
✔ Data is separated logically into strong entities and linking relationships  

Therefore, the schema supports scalable queries and ensures integrity.

---

## 3️⃣ Sample Data Representation

| customer_id | first_name | last_name | email | city |
|------------|------------|-----------|------|------|
| 1 | Rahul | Sharma | rahul.sharma@gmail.com | Bangalore |
| 2 | Priya | Patel | priya.patel@yahoo.com | Mumbai |

| product_id | product_name | category | price |
|------------|--------------|----------|------|
| 1 | Samsung Galaxy S21 | Electronics | 45999.00 |
| 2 | Sony Headphones | Electronics | 1999.00 |

| order_id | customer_id | order_date | total_amount |
|---------|-------------|-------------|--------------|
| 1 | 1 | 2024‑01‑15 | 45999.00 |
| 2 | 2 | 2024‑01‑16 | 5998.00 |

| order_item_id | order_id | product_id | quantity | subtotal |
|---------------|----------|------------|----------|----------|
| 1 | 1 | 1 | 1 | 45999.00 |
| 2 | 2 | 2 | 2 | 3998.00 |
