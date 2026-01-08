\# FlexiMart Data Architecture Project



\*\*Student Name:\*\* Arjun M Pillai  

\*\*Student ID:\*\* 25071981 

\*\*Email:\*\* :  arjunmpillai999@gmail.com

\*\*Date:\*\* 2nd January 2026



---



\## Project Overview



This project demonstrates the design and implementation of a complete data architecture for an e-commerce platform named FlexiMart. It covers data ingestion and cleaning using an ETL pipeline, NoSQL data modeling with MongoDB, and a star schema–based data warehouse with OLAP analytical queries to support business decision-making.



---



\## Repository Structure



├── data/  

│   ├── customers\_raw.csv  

│   ├── products\_raw.csv  

│   └── sales\_raw.csv  

│  

├── part1-database-etl/  

│   ├── etl\_pipeline.py  

│   ├── schema\_documentation.md  

│   ├── business\_queries.sql  

│   └── data\_quality\_report.txt  

│  

├── part2-nosql/  

│   ├── nosql\_analysis.md  

│   ├── mongodb\_operations.js  

│   └── products\_catalog.json  

│  

├── part3-datawarehouse/  

│   ├── star\_schema\_design.md  

│   ├── warehouse\_schema.sql  

│   ├── warehouse\_data.sql  

│   └── analytics\_queries.sql  

│  

└── README.md  



---



\## Technologies Used



\- Python 3.x, pandas, mysql-connector-python  

\- MySQL 8.0  

\- MongoDB 6.0  



---



\## Setup Instructions



\### Database Setup



```bash

\# Create databases

mysql -u root -p -e "CREATE DATABASE fleximart;"

mysql -u root -p -e "CREATE DATABASE fleximart\_dw;"



\# Run ETL Pipeline

python part1-database-etl/etl\_pipeline.py



\# Run Business Queries

mysql -u root -p fleximart < part1-database-etl/business\_queries.sql



\# Data Warehouse Setup

mysql -u root -p fleximart\_dw < part3-datawarehouse/warehouse\_schema.sql

mysql -u root -p fleximart\_dw < part3-datawarehouse/warehouse\_data.sql

mysql -u root -p fleximart\_dw < part3-datawarehouse/analytics\_queries.sql

