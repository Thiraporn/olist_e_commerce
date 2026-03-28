#### E-commerce Sales Analysis ####

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

 

##  📚Topics
<details>
      - 📌 Business Problem  
      - 📊 Dataset  
</details>

## 4. Star Schema 
<details>
       ... 
</details>
  
## 5. Data Pipeline
<details>
       ... 
</details>

## 6. SQL Analysis  
<details>
       ... 
</details>
 
## 7. Business Insights
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


## 📊 Dashboard layout 
Dashboard layout
<details>
      <summary>  View ER Diagram  </summary> 
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
</details>
 

## Jupyter Notebook  
<details>
        อธิบาย flow....    
</details>
  
     
## Data Dictionary
<details>
        ... 
</details>
<!--
|column|meaning|
|order_purchase_timestamp|ลูกค้ากดสั่งซื้อ|
|order_approved_at|payment ได้รับการอนุมัติ|
|order_delivered_carrier_date|ส่งให้บริษัทขนส่ง|
|order_delivered_customer_date|ลูกค้าได้รับของ|
-->



### table: orders
<details>
       | column | meaning |
       |------|------|
       | order_purchase_timestamp | Customer placed the order |
       | order_approved_at | Payment approved |
       | order_delivered_carrier_date | Order handed to carrier |
       | order_delivered_customer_date | Customer received the order |  


## 🛠 Tools & Technologies
<details>
       - SQL
       - Python
       - Pandas
       - Data Modeling
       - ETL Pipeline Design
</details>

## 📈 Future Improvements
<details>
      
       - Build interactive dashboard (Power BI / Tableau)
       - Add real shipping cost for accurate profit calculation
       - Improve data validation pipeline
</details>

## 👤 Autor
<details>
   dataset : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce   
</details> 
