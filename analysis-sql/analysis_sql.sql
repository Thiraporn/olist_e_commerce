--###################################################################### /*Business Questions*/ #####################################################################################################      
--- Using data on staging table
--################ Sales Performance (ยอดขาย) #######################
--1. What is the total revenue generated each month?   รายได้รวมของบริษัทต่อเดือนเป็นเท่าไร
   select * 
   from stg_orders

   select * 
   from  stg_order_items 

--2️. How does monthly revenue change over time (Month-over-Month growth)?  ยอดขายเติบโตหรือหดตัวเทียบกับเดือนก่อน (MoM Growth)

--3. Which product categories generate the highest revenue?  หมวดสินค้าที่สร้างรายได้สูงสุดคืออะไร

--4. What are the top 10 best-selling products by number of orders?  10 สินค้าที่ขายดีที่สุดคืออะไร

--5. What is the Average Order Value (AOV)?  Average Order Value (AOV) ของร้านค้าเท่าไร    สูตร AOV = total_revenue / total_orders

 --################ Customer Analytics  #######################
 

--6️. How many unique customers have made purchases on the platform?  ลูกค้าทั้งหมดมีกี่คน และลูกค้าใหม่ต่อเดือนเท่าไร

--7️. What percentage of customers are repeat customers?  ลูกค้าซื้อซ้ำ (Repeat Customers) มีกี่เปอร์เซ็นต์
 
--8️. What is the average spending per customer (Customer Lifetime Value)?  ลูกค้าใช้เงินเฉลี่ยต่อคนเท่าไร (Customer Lifetime Value)

--9️. Which cities or states have the highest number of customers? เมืองหรือรัฐไหนมีลูกค้ามากที่สุด

--10.Do the top 20% of customers generate the majority of the revenue (Pareto analysis)?  ลูกค้ากลุ่มไหนสร้างรายได้มากที่สุด เช่น Top 20% customers generate how much revenue?

 --################ Delivery Performance  ####################### 
--11️. What is the average delivery time from purchase to delivery? ระยะเวลาจัดส่งเฉลี่ยกี่วัน

--12️. What percentage of orders are delivered later than the estimated delivery date? เปอร์เซ็นต์การส่งล่าช้า (Late Delivery Rate) สูตร late_delivery = delivered_date > estimated_delivery_date

--13️. Which sellers have the fastest average delivery times? seller ไหนส่งของเร็วที่สุด

--14. Which regions experience the longest delivery times?  รัฐไหนมี delivery time ช้าที่สุด

--15️. What is the average shipping cost (freight value) per order? shipping cost (freight_value) เฉลี่ยเท่าไรต่อ order


 --################ Product & Seller Performance  ####################### 

--16️. Which sellers generate the highest total revenue? seller คนไหนสร้างรายได้มากที่สุด

--17️. Which sellers receive the highest average customer review scores? seller คนไหนมี rating สูงที่สุด

--18. Which product categories have the lowest customer satisfaction scores? หมวดสินค้าที่ได้รับ review ต่ำที่สุดคืออะไร

--19️. What is the average price of products in each category? ราคาเฉลี่ยของสินค้าในแต่ละหมวด

--20. Is there a relationship between shipping cost and customer review scores? freight_value มีผลต่อ review score หรือไม่

--เช่น

--Does high shipping cost lead to lower review scores?

































--###########################################################################################################################################################################
--SELECT * FROM INFORMATION_SCHEMA.TABLES  
--select count(*) from stg_customers                   ---99441 
--select count(*) from stg_geolocation                 ---1000163
--select count(*) from stg_orders                      ---99441
--select count(*) from stg_order_items                 ---112650
--select count(*) from stg_order_payments              ---103886
--select count(*) from stg_order_reviews               ---99224
--select count(*) from stg_products                    ---32951
--select count(*) from stg_product_category_name_translation   ---71
--select count(*) from stg_sellers                     ---3095


--select * from stg_customers                  
--select * from stg_geolocation                
--select * from stg_orders   where order_delivered_customer_date is null                  
--select * from stg_order_items                
--select * from stg_order_payments             
--select * from stg_order_reviews              
--select * from stg_products                   
--select * from stg_product_category_name_translation  
--select * from stg_sellers     

--drop table stg_customers                  
--drop table stg_geolocation                
--drop table stg_orders                     
--drop table stg_order_items                
--drop table stg_order_payments             
--drop table stg_order_reviews              
--drop table stg_products                   
--drop table stg_product_category_name_translation  
--drop table stg_sellers       