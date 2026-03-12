#### E-commerce Sales Analysis ####

## Preparing project 
   onece before start the etl pipline please run below step to install all required libraries 
   ```text
              +----------------------------------------------------+
              |             pip install -r requirements.txt        |
              +----------------------------------------------------+
 
   ``` 

     

## Architecture for ETL  


              +-------------+
              | Raw Dataset |
              +-------------+
                     │
                     ▼
              +-------------+
              |   Extract   |  (read csv,xlsx,json)
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
                     │
                     ▼
              +-------------+
              |  Dimension  |
              +-------------+
                     │
                     ▼
              +-------------+
              |     Fact    |
              +-------------+   


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



## Reference
dataset : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce 