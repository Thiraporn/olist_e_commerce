# E-commerce Sales Analysis 
 
This project builds on my SQL skills and applies them to real-world business analysis, focusing on transforming data into meaningful insights that support data-driven decision-making in an e-commerce environment.
 

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
                                          | Star Schema  |
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
     <summary> View Diagram</summary> 
     <img src="diagrams/StarSchema.png" width="700"/> 
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
 
<!-- ## 🎯 Business Insights
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
</details> -->


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

 

<!-- ## 📊 Dashboard Layout  

<details>
  <summary>📊 View Dashboard Structure</summary>

  ### 🟦 Page 1 — Sales Overview
  - Total Revenue  
  - Total Orders  
  - Average Order Value (AOV)  
  - Monthly Revenue Trend  

    <img src="dashboard/sales_overview.png" width="700"/>  

  💡 Focus: Overall business performance

  ### 🟩 Page 2 — Customer Insights
  - Customers by State  
  - Top Customers  
  - Repeat Purchase Rate  
    ค่าใกล้ 1 → ลูกค้าส่วนใหญ่ซื้อครั้งเดียว
    Revenue is highly distributed across customers, with the top 10 customers contributing less than 1% of total revenue.

    The analysis shows that revenue is widely distributed across customers, with minimal contribution from top customers. Customer behavior is dominated by one-time purchases, indicating low retention. Growth opportunities lie in improving customer loyalty and increasing average order value.

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

</details>  -->
## 📊 Dashboard Layout  

<details>
  <summary>📊 View Dashboard Structure</summary>

  ### 🟦 Page 1 — Sales Overview

   <img src="dashboard/sales_overview.png" width="700"/> 
   
   🛒 Key Insights
   - Revenue growth driven by order volume, not AOV; early spikes due to low base; recent slowdown suggests market maturity.
   

  ### 🟩 Page 2 — Customer Insights
      
   <img src="dashboard/customer_insights.png" width="700"/> 
   
   🛒 Key Insights
   - Most customers are in SP and RJ, revenue is evenly distributed across segments, and frequent orders drive high average CLV
   - focus marketing on top states, retain high-value clients, and tailor promotions to buying behaviors.

  ### 🟨 Page 3 — Product Performance
      
   <img src="dashboard/product_performance.png" width="700"/> 
   
   
   🛒 Key Insights
   - Top categories like bed_bath_table and health_beauty drive the highest order volume and should be prioritized for growth.
Meanwhile, products with high revenue but fewer orders represent valuable high-margin opportunities to expand profitability.

  ### 🟥 Page 4 — Delivery & Reviews

   <img src="dashboard/delivery_reviews.png" width="700"/> 
   
   🛒 Key Insights
   - Sellers keep high review scores even with slower delivery, but faster shipping can boost satisfaction; most customers give 5-star reviews.
   
</details> 
 
<!-- ## 📊 Dashboard Layout  

<details>
  <summary>📊 View Dashboard Structure</summary>

  ### 🟦 Page 1 — Sales Overview

   <img src="dashboard/sales_overview.png" width="700"/> 
   
   🛒 Key Insights
   - Growth is driven by volume (more orders), not value per order
   - Early-stage spikes in MoM are influenced by a low initial base
   - Recent trends show slowing growth, which may indicate market saturation or maturity 
      
     แนวโน้มจากกราฟ: 
       รายได้รวมเติบโตตามจำนวนคำสั่งซื้อ (Volume-driven)
       AOV ค่อนข้างคงที่ ไม่เพิ่มมาก → การเติบโตไม่ใช่เพราะราคาต่อออเดอร์สูงขึ้น
       การเติบโต MoM ช่วงแรกสูงเพราะฐานน้อย → Spikes เริ่มต้น
       หลัง ๆ การเติบโตชะลอลง → ตลาดเริ่มอิ่มตัวหรือเข้าสู่ช่วงโตช้า

  ### 🟩 Page 2 — Customer Insights
      
   <img src="dashboard/customer_insights.png" width="700"/> 
   
   🛒 Key Insights
   - The majority 46% of customers are concentrated in a few states.Focus marketing efforts in states with the highest customer concentration.
   - High-value customers (top 20%) drive a majority of revenue → prioritize retention and loyalty programs.
   - Consider segment-based strategies, as revenue is fairly evenly split among segments but profitability differs.
   - Customers display two main behaviors , followed by Many orders, lower revenue per order (frequent buyers) , Fewer orders, higher revenue per order (big spenders).Use order and revenue patterns to design targeted promotions and improve customer engagement.
      
     แนวโน้มจากกราฟ: 
       ลูกค้าส่วนใหญ่ 46% กระจุกตัวอยู่ในไม่กี่รัฐ → ควรมุ่งเน้นการตลาดในรัฐที่มีลูกค้ามากที่สุด
       ลูกค้ามีมูลค่าสูง (top 20%) สร้างรายได้หลัก → ให้ความสำคัญกับการรักษาลูกค้าและโปรแกรมความภักดี
       ควรวางกลยุทธ์ตามเซ็กเมนต์ เนื่องจากรายได้กระจายค่อนข้างเท่า ๆ กัน แต่ความสามารถในการทำกำไรต่างกัน
       ลูกค้าแสดงพฤติกรรมหลัก 2 แบบ: สั่งซื้อบ่อย รายได้ต่อออร์เดอร์ต่ำ (ผู้ซื้อบ่อย) และ สั่งซื้อน้อย รายได้ต่อออร์เดอร์สูง (ผู้ใช้จ่ายสูง) → ใช้รูปแบบคำสั่งซื้อและรายได้เพื่อออกโปรโมชั่นเฉพาะกลุ่มและเพิ่มการมีส่วนร่วมของลูกค้า

  ### 🟨 Page 3 — Product Performance
      
   <img src="dashboard/product_performance.png" width="700"/> 
   
   
   🛒 Key Insights
   - The top 10 product categories by number of orders show that bed_bath_table, health_beauty, and sports_leisure are the most popular among customers.Focus on top categories with high orders and revenue for marketing campaigns.
   - Products with many orders but lower revenue may indicate lower-priced items, while those with fewer orders but high revenue are high-value items.Monitor products with high revenue but fewer orders — potential high-margin opportunities. 
    แนวโน้มจากกราฟ: 
       10 หมวดสินค้าที่มียอดสั่งซื้อสูงสุด แสดงให้เห็นว่า bed_bath_table, health_beauty และ sports_leisure  เป็นที่นิยมที่สุดในกลุ่มลูกค้า      ควรมุ่งเน้นการตลาดไปที่หมวดสินค้าท็อปที่มียอดสั่งซื้อและรายได้สูง
       สินค้าที่มียอดสั่งซื้อสูงแต่รายได้น้อย อาจบ่งชี้ว่าสินค้าเป็นราคาต่ำ ในขณะที่สินค้าที่มียอดสั่งซื้อน้อยแต่รายได้สูง เป็นสินค้าที่มีมูลค่าสูง ควรติดตามสินค้าที่มีรายได้สูงแต่ยอดสั่งซื้อน้อย — เป็นโอกาสสำหรับกำไรสูง

       สรุปภาพรวมจากแดชบอร์ดนี้ได้ดังนี้: 
              1) หมวดหมู่ขายดี (ออเดอร์สูงสุด)

              หมวด bed_bath_table, health_beauty, และ sports_leisure มียอดสั่งซื้อสูงที่สุด
              → เป็นหมวด “ตัวทำยอด” ควรเน้นทำการตลาด โปรโมชัน และสต็อกสินค้าให้เพียงพอ

              2) รายได้รวมตามหมวดหมู่

              หมวดที่ทำรายได้สูง ได้แก่
              health_beauty (~1.44M)
              bed_bath_table (~1.24M)
              watches_gifts (~1.31M)
              → บางหมวดออเดอร์ไม่สูงมาก แต่สร้างรายได้ดี แปลว่าเป็นสินค้ามูลค่าสูง

              3) ความสัมพันธ์ ออเดอร์ vs รายได้ (Scatter Plot)

              สินค้าที่ “ออเดอร์เยอะ แต่รายได้ไม่สูงมาก”
              → มักเป็นสินค้าราคาถูก (ขายปริมาณ)
              สินค้าที่ “ออเดอร์น้อย แต่รายได้สูง”
              → เป็นสินค้าราคาสูง / กำไรต่อชิ้นดี (high-value items)

              4) Insight สำคัญ

              ควร โฟกัส 2 กลุ่มหลัก
              หมวดที่ “ออเดอร์สูง + รายได้สูง” → ตัวหลักของธุรกิจ
              สินค้า “รายได้สูง แต่ออเดอร์น้อย” → โอกาสเพิ่มกำไร (ควรผลักดันเพิ่ม)
              ใช้กลยุทธ์แยกกัน:
              สินค้าราคาถูก → เน้น volume + โปรโมชัน
              สินค้าราคาสูง → เน้น value + targeting ลูกค้าคุณภาพ

              สรุปสั้นๆ:

              Top categories = ตัวทำยอด
              High revenue but low orders = โอกาสกำไรสูง
              ควรทำการตลาดแบบแยกกลยุทธ์ตามประเภทสินค้า

  ### 🟥 Page 4 — Delivery & Reviews

   <img src="dashboard/delivery_reviews.png" width="700"/> 
   
   🛒 Key Insights
   - Sellers keep high review scores even with slower delivery, but faster shipping can boost satisfaction; most customers give 5-star reviews.
   
</details>   -->

<!-- ## 📚 Jupyter Notebook  
<details>
        อธิบาย flow....    
</details> -->
  
     
<!-- ## 🗺️Data Dictionary
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

</details>  -->
 

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
       - Add Jupyter Notebook 
       - Improve data model/star schema
       - Improve data validation pipeline
       - Improve cleansing and transaform data
       - Improve data story telling/Presentation Skill
</details>

## 🛢️ Dataset
<details>
     <div>
       I would like to thank 
       <a href="https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce" target="_blank">Olist</a> 🥰🤗
       for releasing this version of the Brazilian e-commerce dataset.
     </div>
       
</details> 
