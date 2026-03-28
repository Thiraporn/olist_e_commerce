# E-commerce Sales Analysis 
  ## 📊 E-commerce Sales Analysis

This project extends my SQL skills into real-world business analysis, focusing on how data can be used to generate actionable insights and support decision-making in an e-commerce environment.
 

 ---
## 📦Preparing project 
<details> 
      <summary> Install Dependencies</summary>    
       onece before start the etl pipline please run below step to install all required libraries 
        
                     +----------------------------------------------------+
                     |             pip install -r requirements.txt        |
                     +----------------------------------------------------+
       
        
</details>
   

## 🏗️ Data Architecture Diagram  
<details>
       <summary> Run ETL Pipeline</summary>    
                            
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
    
</details> 

## 🧩 ER Diagram (Staging Table) 
<details>
  <summary> View ER Diagram</summary> 
     <img src="diagrams/ER%20Diagram.png" width="700"/> 
</details>

## 🧩 Activity Diagram 
<details>
  <summary> View Diagram</summary> 
     <img src="diagrams/Activity%20Diagram.png" width="700"/> 
</details>


## ⭐ Star Schema 
<details>
       ... 
</details>  


<!-- ##  🔖Topics
<details>
      - 📌 Business Problem  
      - 📊 Dataset  
</details> -->


  
<!-- ##  Data Pipeline
<details>
       ... 
</details> -->

## 📌 SQL Analysis  
<details>
    <summary> 20 Business Questions</summary>
    
   ### 🟦 Sales Performance 
     - 1. What is the total revenue generated each month?    
     - 2️. How does monthly revenue change over time (Month-over-Month growth)?
     - 3. Which product categories generate the highest revenue? 
     - 4. What are the top 10 best-selling products by number of orders?  
     - 5. What is the Average Order Value (AOV)?  
    
   ### 🟩 Customer Analytics  
     - 6️. How many unique customers have made purchases on the platform?   
     - 7️. What percentage of customers are repeat customers?   
     - 8️. What is the average spending per customer (Customer Lifetime Value)?  
     - 9️. Which cities or states have the highest number of customers?    
     - 10.Do the top 20% of customers generate the majority of the revenue (Pareto analysis)?    
     
  ### 🟨  Delivery Performance
     - 11. What is the average delivery time from purchase to delivery?
     - 12️. What percentage of orders are delivered later than the estimated delivery date?   
     - 13️. Which sellers have the fastest average delivery times? 
     - 14. Which regions experience the longest delivery times?  
     - 15️. What is the average shipping cost (freight value) per order?  

 

  ### 🟥 Product & Seller Performance
    - 16️. Which sellers generate the highest total revenue?   
    - 17️. Which sellers receive the highest average customer review scores?  
    - 18. Which product categories have the lowest customer satisfaction scores?  
    - 19️. What is the average price of products in each category?    
    - 20. Is there a relationship between shipping cost and customer review scores?  

   

</details>
 
## 🎯 Business Insights
<details>
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
</details>


<!-- Key Insights

1. Top 10 sellers generate ~X% of total revenue
2. Average delivery time is X days
3. Late delivery rate is X%
4. States with longest delivery time: XX
5. Shipping cost has slight negative relationship with review score
6. Some product categories have lower customer satisfaction -->

<!-- Boleto payments introduce a delay in revenue recognition 
and have a higher drop-off rate compared to credit card payments, 
which can impact both conversion rate and cash flow. 
Brazil	       ไทย
boleto	        QR payment / ใบแจ้งชำระ
voucher	 coupon / ส่วนลด

-->
 

 <!-- ⚠️ Revenue Definition Note: "ตัวเลขนี้ represent ธุรกิจจริงไหม?"

This analysis separates product revenue and shipping fees.
Freight value is treated as a pass-through cost, not net profit,
due to the absence of logistics cost data.
✔ price = core revenue
✔ freight_value = customer-paid shipping fee
❌ freight_value ≠ profit -->

 

## 📊 Dashboard Layout  

<details>
  <summary>📊 View Dashboard Structure</summary>

  ### 🟦 Page 1 — Sales Overview
  - Total Revenue  
  - Total Orders  
  - Average Order Value (AOV)  
  - Monthly Revenue Trend  

  💡 Focus: Overall business performance

  ### 🟩 Page 2 — Customer Insights
  - Customers by State  
  - Top Customers  
  - Repeat Purchase Rate  

  💡 Focus: Customer behavior & retention

  ### 🟨 Page 3 — Product Performance
  - Top Product Categories  
  - Revenue by Category  

  💡 Focus: Product contribution to revenue

  ### 🟥 Page 4 — Delivery & Reviews
  - Delivery Time Distribution  
  - Review Score Distribution  
  - Delivery vs Review Correlation  

  💡 Focus: Logistics impact on satisfaction

</details> 

## 📚 Jupyter Notebook  
<details>
        อธิบาย flow....    
</details>
  
     
## 🗺️Data Dictionary
<details>  
  <summary>view Table </summary>

  
   ### 🟦 Table: orders
  | Column | Meaning (EN) | Meaning (TH) |
  |--------|-------------|--------------|
  | order_purchase_timestamp | Customer placed the order | ลูกค้ากดสั่งซื้อ |
  | order_approved_at | Payment approved | อนุมัติการชำระเงิน |
  | order_delivered_carrier_date | Order handed to carrier | ส่งให้บริษัทขนส่ง |
  | order_delivered_customer_date | Customer received the order | ลูกค้าได้รับสินค้า |

   ### 🟦 Table: order_items
  | Column | Meaning (EN) | Meaning (TH) |
  |--------|-------------|--------------|
  | order_purchase_timestamp | Customer placed the order | ลูกค้ากดสั่งซื้อ |
  | order_approved_at | Payment approved | อนุมัติการชำระเงิน |
  | order_delivered_carrier_date | Order handed to carrier | ส่งให้บริษัทขนส่ง |
  | order_delivered_customer_date | Customer received the order | ลูกค้าได้รับสินค้า |
 
  
  ### 🟦 Table: custormers 
  ### 🟦 Table: products 
  ### 🟦 Table: .... 
  ### 🟦 Table: .... 
  ### 🟦 Table: .... 

</details> 
 

## 🛠 Tech Stack
<details>
      
       - 🛢️SQL
       - 🐍Python
       - 🐼Pandas
       - 🧱Data Modeling 
       - 🔄ETL Pipeline Design 
       - 📊PowerBI

     
</details>

## 📈 Future Improvements
<details>
      
       - Build interactive dashboard (Power BI / Tableau)
       - Add real shipping cost for accurate profit calculation
       - Improve data validation pipeline
</details>

## 🛢️ Dataset
<details>
   Reference : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce   
</details> 
