USE fleximart_dw;

-- =========================
-- dim_date (30 rows: Jan–Feb 2024)
-- =========================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,0),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,0),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,0),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,0),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,0),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,1),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,1),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,0),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,0),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,0),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,0),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,1),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,0),
(20240130,'2024-01-30','Tuesday',30,1,'January','Q1',2024,0),

(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,0),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,0),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,1),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,1),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,0),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,0),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,0),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,1),
(20240212,'2024-02-12','Monday',12,2,'February','Q1',2024,0),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,0),
(20240218,'2024-02-18','Sunday',18,2,'February','Q1',2024,1),
(20240220,'2024-02-20','Tuesday',20,2,'February','Q1',2024,0),
(20240222,'2024-02-22','Thursday',22,2,'February','Q1',2024,0),
(20240225,'2024-02-25','Sunday',25,2,'February','Q1',2024,1),
(20240227,'2024-02-27','Tuesday',27,2,'February','Q1',2024,0),
(20240228,'2024-02-28','Wednesday',28,2,'February','Q1',2024,0);

-- =========================
-- dim_product (15 products, 3 categories)
-- =========================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop Pro','Electronics','Computers',75000),
('P002','Smartphone X','Electronics','Mobiles',45000),
('P003','Wireless Earbuds','Electronics','Audio',5000),
('P004','LED TV 42','Electronics','TV',38000),
('P005','Bluetooth Speaker','Electronics','Audio',6000),

('P006','Running Shoes','Fashion','Footwear',4500),
('P007','Casual Shirt','Fashion','Apparel',2000),
('P008','Jeans','Fashion','Apparel',3000),
('P009','Jacket','Fashion','Outerwear',5500),
('P010','Sneakers','Fashion','Footwear',6500),

('P011','Rice 5kg','Groceries','Grains',1200),
('P012','Wheat Flour','Groceries','Grains',800),
('P013','Cooking Oil','Groceries','Essentials',1600),
('P014','Sugar 2kg','Groceries','Essentials',400),
('P015','Tea Powder','Groceries','Beverages',900);

-- =========================
-- dim_customer (12 customers, 4 cities)
-- =========================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','Retail'),
('C002','Priya Patel','Mumbai','Maharashtra','Retail'),
('C003','Amit Verma','Delhi','Delhi','Retail'),
('C004','Sneha Reddy','Hyderabad','Telangana','Retail'),
('C005','Arjun Nair','Bangalore','Karnataka','Retail'),
('C006','Kavya Iyer','Chennai','Tamil Nadu','Retail'),
('C007','Rohit Gupta','Delhi','Delhi','Retail'),
('C008','Meera Joshi','Mumbai','Maharashtra','Retail'),
('C009','Suresh Rao','Hyderabad','Telangana','Retail'),
('C010','Anjali Das','Kolkata','West Bengal','Retail'),
('C011','Vikram Singh','Pune','Maharashtra','Retail'),
('C012','Neha Kapoor','Jaipur','Rajasthan','Retail');

-- =========================
-- fact_sales (40 transactions)
-- =========================
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101,1,1,1,75000,0,75000),
(20240102,2,2,1,45000,0,45000),
(20240103,3,3,2,5000,0,10000),
(20240104,4,4,1,38000,0,38000),
(20240105,5,5,2,6000,500,11500),
(20240106,6,6,3,4500,0,13500),
(20240107,7,7,2,2000,0,4000),
(20240108,8,8,1,3000,0,3000),
(20240109,9,9,1,5500,0,5500),
(20240110,10,10,2,6500,500,12500),

(20240115,11,11,5,1200,0,6000),
(20240120,12,12,3,800,0,2400),
(20240125,13,1,2,1600,0,3200),
(20240130,14,2,4,400,0,1600),

(20240201,15,3,2,900,0,1800),
(20240202,1,4,1,75000,2000,73000),
(20240203,2,5,1,45000,0,45000),
(20240204,3,6,3,5000,0,15000),
(20240205,4,7,1,38000,0,38000),
(20240206,5,8,2,6000,0,12000),

(20240207,6,9,2,4500,0,9000),
(20240210,7,10,3,2000,0,6000),
(20240212,8,11,2,3000,0,6000),
(20240215,9,12,1,5500,0,5500),
(20240218,10,1,2,6500,0,13000),

(20240220,11,2,4,1200,0,4800),
(20240222,12,3,3,800,0,2400),
(20240225,13,4,2,1600,0,3200),
(20240227,14,5,5,400,0,2000),
(20240228,15,6,3,900,0,2700),

(20240106,1,7,1,75000,0,75000),
(20240107,2,8,1,45000,0,45000),
(20240120,3,9,4,5000,0,20000),
(20240203,4,10,1,38000,0,38000),
(20240218,5,11,3,6000,0,18000),
(20240225,6,12,2,4500,0,9000);