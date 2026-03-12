#### E-commerce Sales Analysis ####

## Preparing project 
   onece before start the etl pipline please run below step to install all required libraries 
   ```text
              +----------------------------------------------------+
              |             pip install -r requirements.txt        |
              +----------------------------------------------------+
 
   ``` 
 

<!-- ## Architecture for ETL 
 ```text
              +------------+
              |   Raw Data |  (csv,xlsx,json) 
              +------------+
                     │
                     ▼
              +-------------+
              |   Extract   | 
              +-------------+
                     │
                     ▼
              +-------------+
              |    Merge    |  (muli-transaction files)
              +-------------+
                     │
                     ▼
              +-------------+
              |  Transform  |  (clean data) 
              +-------------+
                     │
                     ▼
              +-------------+
              |  Bulk Load  |  (map data type)
              +-------------+
                     │
                     ▼
              +-------------+
              | SQL Server  | (staging tables)
              +-------------+
  ```    -->

## Data Architecture Diagram  

  ```text
              +--------------+
              |  Raw CSV     |
              | (Olist Data) |
              +--------------+
                     │
                     ▼
              +--------------+
              |   Extract    |
              |  Python ETL  |
              +--------------+
                     │
                     ▼
              +--------------+
              |   Transform  |
              | Data Cleaning|
              +--------------+
                     │
                     ▼
              +--------------+
              |  Staging DB  |
              | SQL Server   |
              +--------------+
                     │
                     ▼
              +--------------+
              | Data Warehouse|
              |  Star Schema  |
              +--------------+
                     │
                     ▼
              +--------------+
              | SQL Analysis |
              +--------------+
                     │
                     ▼
              +--------------+
              |  Dashboard   |
              | Power BI / BI|
              +--------------+
  ```   
 
 


## Topics
## 1. Business Problem
## 2. Dataset

## 3. ER Diagram (Staging Table)    

   ![alt text](diagrams/ER%20Diagram.png)  


## 4. Star Schema 
  
## 5. Data Pipeline
## 6. SQL Analysis  
 
## 7. Business Insights
จดไว้ๆๆก่อน
Does higher shipping cost lead to lower customer satisfaction?
Electronics products generate the highest revenue but also experience longer delivery times.

20% of customers contribute over 60% of total revenue.

-Sales
Revenue grows strongly in Q4
-Product
Electronics generates the highest revenue
-Customer
Most customers come from São Paulo
-Delivery
Late deliveries correlate with low review scores
-Seller
Top 5 sellers generate 40% of revenue

## Dashboard layout
Page 1 — Sales Overview
       Total Revenue
       Total Orders
       Average Order Value
       Monthly Revenue Trend
Page 2 — Customer
       Customer by state
       Top customers
       Repeat rate
Page 3 — Product
       Top product categories
       Revenue by category
Page 4 — Delivery & Review
       Delivery time distribution
       Review score distribution
       Delivery vs review correlation
## Jupyter Notebook
   อธิบาย flow
## Reference
dataset : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce 