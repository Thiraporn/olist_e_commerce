#### E-commerce Sales Analysis ####

## Prepaging project 
   onece before start the etl pipline please run below step to install all required libraries 
                            +----------------------------------------------------+
                            |             pip install -r requirements.txt        |
                            +----------------------------------------------------+
     

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


##Topics
## Business Problem
## Dataset

## ER Diagram (Staging Table)  

                                          ![alt text](<diagrams/ER Diagram.png>)  



## Star Schema 
  
## Data Pipeline
## SQL Analysis  
 
## Business Insights
จดไว้ๆๆก่อน
Does higher shipping cost lead to lower customer satisfaction?
Electronics products generate the highest revenue but also experience longer delivery times.

20% of customers contribute over 60% of total revenue.



## Reference
dataset : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce 