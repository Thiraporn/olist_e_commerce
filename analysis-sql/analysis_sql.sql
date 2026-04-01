--###################################################################### /*Business Questions*/ #####################################################################################################      
--- Using data on staging table
--- select  @@version  ---Microsoft SQL Server 2022
--################ Sales Performance (ยอดขาย) #######################
--1. What is the total revenue generated each month?   รายได้รวมของบริษัทต่อเดือนเป็นเท่าไร
		   /*Remarks : Revenue => full payment_value ,order_approved_at => Revenue is recognized when payment is approved.
		              payment_installments > 1   ===> start from order_approved_at     sum_rev/payment_installments  in order_approved_at ?
           */
   select  YEAR(order_approved_at) _year,MONTH(order_approved_at) _month, ROUND(sum(soi.price +soi.freight_value ),4) total_revenue
   from stg_orders so 
   join stg_order_items soi on  so.order_id  = soi.order_id 
   where order_approved_at is not null
   group by YEAR(order_approved_at) ,MONTH(order_approved_at)
   order by YEAR(order_approved_at) ,MONTH(order_approved_at)  
 
--2️. How does monthly revenue change over time (Month-over-Month growth)?  ยอดขายเติบโตหรือหดตัวเทียบกับเดือนก่อน (MoM Growth) ช่วยดูว่า ธุรกิจกำลังโตหรือกำลังชะลอ ดู trend โต หรือ ไม่โต
     /* MoM Growth (%) = (Current Month Value − Previous Month Value) / Previous Month Value × 100  */
   with total_reveue_by_month as(
	   select  YEAR(order_approved_at) _year,MONTH(order_approved_at) _month
	   , sum(soi.price +soi.freight_value ) total_revenue
	   from stg_orders so 
	   join stg_order_items soi on  so.order_id  = soi.order_id 
	   where order_approved_at is not null
	   group by YEAR(order_approved_at) ,MONTH(order_approved_at) 
   ) ,current_prev_total_reveue  as (
	    select * ,  LAG(total_revenue) OVER (ORDER BY _year,_month)  AS prev_month_revenue
	    from total_reveue_by_month
   )
   select _year,_month,ROUND(total_revenue,4) current_total_revenue
   ,ROUND(isnull(prev_month_revenue,0),4) prev_month_revenue  
   ,ROUND(case when prev_month_revenue > 0 then (total_revenue - isnull(prev_month_revenue,0) )/isnull(prev_month_revenue,0)*100  else 0 end,2) MoM_Growth
   from current_prev_total_reveue
   
   
     
--3. Which product categories generate the highest revenue?  หมวดสินค้าที่สร้างรายได้สูงสุดคืออะไร 
  --using window functions และ ANSI SQL  rank()
  with revenue_by_product_cat as(
	   select  product_category_name_english,ROUND(SUM(soi.price +soi.freight_value ),2) as total_revenue 
	   from stg_orders so 
	   join stg_order_items soi on  so.order_id  = soi.order_id 
	   join stg_products sp on soi.product_id = sp.product_id 
	   join stg_product_category_name_translation n  on   sp.product_category_name = n.product_category_name
	   where order_approved_at is not null
	   group by product_category_name_english
	   
 ) ,revenue_by_product_cat_sort as (
	 select * , rank() over(order by total_revenue desc) _rank_total_revenue
	 from revenue_by_product_cat  
 )	 
  select * from revenue_by_product_cat_sort where _rank_total_revenue = 1; 
    
--4. What are the top 10 best-selling products by number of orders?  สินค้า 10 รายการที่ถูกสั่งซื้อบ่อยที่สุด (จำนวน order มากที่สุด)  
  with revenue_by_orderid as(
	   select   soi.product_id, product_category_name_english 
	   ,count(distinct so.order_id) _count_order
	   ,rank() over(order by count(distinct so.order_id) desc) _rank_count_orderid
	   from stg_orders so 
	   join stg_order_items soi on  so.order_id  = soi.order_id 
	   join stg_products sp on soi.product_id = sp.product_id 
	   join stg_product_category_name_translation n  on   sp.product_category_name = n.product_category_name
	   --where order_approved_at is not null
	   group by soi.product_id, product_category_name_english
	   
 )  
  select * from revenue_by_orderid  where _rank_count_orderid < 11 
 
--5. What is the Average Order Value (AOV)?      Average Order Value (AOV)  ของร้านค้าเท่าไร    สูตร AOV = total_revenue / total_orders  
     /*---> ลูกค้าโดยเฉลี่ยใช้เงินเท่าไรต่อ order, มูลค่าเฉลี่ยของเงินที่ลูกค้าใช้ต่อ 1 คำสั่งซื้อ 
      *---> ลูกค้าใช้เงินต่อครั้งมากแค่ไหน    
      *---> ประสิทธิภาพของโปรโมชั่น
      *
      **/ 
  
   select   SUM(soi.price +soi.freight_value ) total_revenue
   , count(distinct soi.order_id ) total_orders  
   , SUM(soi.price +soi.freight_value )/count(distinct soi.order_id ) AOV
   from stg_orders so 
   join stg_order_items soi on  so.order_id  = soi.order_id 
   where order_approved_at is not null ;

 --################ Customer Analytics  ####################### 

--6️. How many unique customers have made purchases on the platform?  ลูกค้าทั้งหมดมีกี่คน หรือ จำนวนลูกค้าทั้งหมดที่เคยสั่งซื้อสินค้า (นับลูกค้าแต่ละคนแค่ครั้งเดียว)
     with  _made_purchases_customers as (
          select  count(distinct so.customer_id  ) _made_purchases_customers  
		  from stg_orders so  where order_approved_at is not null 
	 ) ,_all_customers as (
	    select count(   customer_id  ) _all_customers  from stg_customers sc 
	 )   
	 select * 
	 from _made_purchases_customers 
	 cross join  _all_customers 

--7️. What percentage of customers are repeat customers?  ลูกค้าซื้อซ้ำ (Repeat Customers) มีกี่เปอร์เซ็นต์
	/* Repeat Customer Rate (%) = (จำนวนลูกค้าที่ซื้อซ้ำ / จำนวนลูกค้าทั้งหมด) × 100  */
    with   _repeat_customer as(
       select count(*) _repeat_customer 
       from( select so.customer_id  ,count(so.order_id  ) _count_orders  
			from stg_orders so 
			group by so.customer_id 
			having count(*) > 1
		) rp
	),_made_purchases_customers as (
          select count(distinct so.customer_id  ) _made_purchases_customers  
		  from stg_orders so  where order_approved_at is not null 
    )  
    select * ,(isnull(_repeat_customer,0)/isnull(_made_purchases_customers,1)) * 100  _Repeat_Customer_Rate
    from _repeat_customer
    cross join _made_purchases_customers
    
--8️. What is the average spending per customer (Customer Lifetime Value)?  ลูกค้าใช้เงินเฉลี่ยต่อคนเท่าไร (Customer Lifetime Value)   ---> ลูกค้าหนึ่งคนสร้างรายได้ให้บริษัททั้งหมดเท่าไร
     /*   sum by customer ---> avg ค่าใช้จ่ายเฉลี่ยต่อลูกค้า 1 คน  */ 
    with _customer_lift_value as(
	    select so.customer_id  ,count(distinct so.order_id  ) _purchase_frequency  
	    , MIN(order_approved_at) first_order_place
	    , MAX(order_approved_at) lasted_order_place
	   , SUM(soi.price +soi.freight_value )  CLV
		from stg_orders so 
		join stg_order_items soi on  so.order_id  = soi.order_id 
		where order_approved_at is not null  
		group by so.customer_id  
	) 
   select AVG(CLV ) avg_spending from _customer_lift_value
    
--9️. Which cities or states have the highest number of customers? เมืองหรือรัฐไหนมีลูกค้ามากที่สุด
   with _ranking_customer_city as (
      select sc.customer_city  
    , count(distinct so.customer_id ) _count_purchased_customers   
    , count(distinct sc.customer_id ) _count_registered_customers 
    , dense_rank() over( order by count(distinct so.customer_id ) desc) _rank
	from stg_orders so 
	right join stg_customers sc  on  so.customer_id  = sc.customer_id  
	group by sc.customer_city  
   
   ) 
   select * from _ranking_customer_city where _rank = 1 
--10.Do the top 20% of customers generate the majority of the revenue (Pareto analysis)?  ลูกค้ากลุ่มไหนสร้างรายได้มากที่สุด เช่น Top 20% customers generate how much revenue?
   /*เพื่อยิ่ง ad,promotion ให้ลค กลุ่มนี้*/
    ---Result  53.32788604218788   ---> Top 20% of customers generate 53.3% of total revenue.
    /*
     * Interpretation: Revenue กระจุกตัวอยู่ในลูกค้าบางส่วน แต่ ยังไม่ถึง 80/20 rule แบบ classic Pareto   
     *                 (Revenue concentration ปานกลาง Customer base กระจายพอสมควร Business risk ไม่พึ่งลูกค้ากลุ่มเล็กมากเกินไป(ดูจาก 20% → 40–55% revenue เสี่ยงต่ำ))
     * 
     * 
     * 
     * 
     * Revenue is moderately concentrated among high-value customers.
      The top 20% of customers contribute 53.3% of total revenue, 
      indicating that while high-spending customers are important, 
      the revenue base is still relatively diversified.
      ลูกค้ากลุ่มบนมีบทบาทสำคัญ แต่รายได้ยังไม่ได้พึ่งลูกค้ากลุ่มเล็กมากเกินไป -->กลุ่ม 20%
      */
   with  total_revenue_by_customer as(
	    select   SUM(soi.price +soi.freight_value )  _total_revenue_by_customer
	    ----prevent same total c1 200    c2 200   ====> _rank c1 1,c2 2
	    ,row_number() over(order by  SUM(soi.price +soi.freight_value )  desc) _rank
		from stg_orders so 
		join stg_order_items soi on  so.order_id  = soi.order_id 
		where order_approved_at is not null  
		group by so.customer_id  
	) 
	, total_revenue as (
	    select sum(_total_revenue_by_customer) total_revenue
	   ,count(*) count_customer 
	   , cast(count(*)*0.2 as INT) _20percent
	    from total_revenue_by_customer
	) , _20percent_segment as (
		select *  
		from total_revenue_by_customer
		cross join total_revenue
		where _rank <= _20percent
	)
    --find Revenue share
	select sum(_total_revenue_by_customer)*100 /total_revenue.total_revenue
	from _20percent_segment
	cross join total_revenue
	group by  total_revenue.total_revenue
 
	
 --################ Delivery Performance  ####################### 
--11️. What is the average delivery time from purchase to delivery? ระยะเวลาจัดส่งเฉลี่ยกี่วัน
	with find_delivered as (
	 select 
	  --carrier -> customer
	  DATEDIFF(day,so.order_delivered_carrier_date,so.order_delivered_customer_date ) logistics_delivery_days
	 ,DATEDIFF(hour,so.order_delivered_carrier_date,so.order_delivered_customer_date ) logistics_delivery_hours
	  --purchase -> customer
	 ,DATEDIFF(day,so.order_approved_at ,so.order_delivered_customer_date ) purchase_delivery_days
						   --,case when so.order_estimated_delivery_date is null or so.order_delivered_carrier_date  is null or so.order_delivered_customer_date   is null  then so.order_status  when so.order_delivered_customer_date <=  so.order_estimated_delivery_date  then 'On Time' else 'Delay' end status_of_delivery 
						   --, case when  so.order_delivered_customer_date <=  so.order_estimated_delivery_date  then 'On Time' else 'Delay' end status_of_delivery
	  --delay : customer(estimated time) -> customer(actual)   --negative = fast
	 , case when  DATEDIFF(day,so.order_estimated_delivery_date,so.order_delivered_customer_date ) <= 0  then 'On Time' else 'Delay' end status_of_delivery
	 , DATEDIFF(day,so.order_estimated_delivery_date,so.order_delivered_customer_date  ) delay_delivery
	 ,* 
	 from stg_orders so 
	 where  order_approved_at is not null 
	 and so.order_delivered_customer_date is not null
	 and so.order_status in ('delivered')
	 )
	select AVG(purchase_delivery_days) avg_days_of_delivery from find_delivered

--12️. What percentage of orders are delivered later than the estimated delivery date? เปอร์เซ็นต์การส่งล่าช้า (Late Delivery Rate) สูตร late_delivery = delivered_date > estimated_delivery_date
    /*
     *  A late delivery rate of 6.77% suggests that the majority of orders meet the
		promised delivery timeline, indicating efficient logistics operations and
		accurate delivery estimates.
     * 
     * 
     * */
	with find_delivered as (
	 select 
	  --carrier -> customer
	  DATEDIFF(day,so.order_delivered_carrier_date,so.order_delivered_customer_date ) logistics_delivery_days
	 ,DATEDIFF(hour,so.order_delivered_carrier_date,so.order_delivered_customer_date ) logistics_delivery_hours
	  --purchase -> customer
	 ,DATEDIFF(day,so.order_approved_at ,so.order_delivered_customer_date ) purchase_delivery_days
						   --,case when so.order_estimated_delivery_date is null or so.order_delivered_carrier_date  is null or so.order_delivered_customer_date   is null  then so.order_status  when so.order_delivered_customer_date <=  so.order_estimated_delivery_date  then 'On Time' else 'Delay' end status_of_delivery 
						   --, case when  so.order_delivered_customer_date <=  so.order_estimated_delivery_date  then 'On Time' else 'Delay' end status_of_delivery
	  --delay : customer(estimated time) -> customer(actual)   --negative = fast
	 , case when  DATEDIFF(day,so.order_estimated_delivery_date,so.order_delivered_customer_date ) <= 0  then 'On Time' else 'Delay' end status_of_delivery
	 , DATEDIFF(day,so.order_estimated_delivery_date,so.order_delivered_customer_date  ) delay_delivery
	 ,* 
	 from stg_orders so 
	 where  order_approved_at is not null 
	 and so.order_delivered_customer_date is not null
	 and so.order_status in ('delivered')
	 )
	select count(status_of_delivery ) count_all_delivery  
	,count(CASE WHEN status_of_delivery = 'Delay' THEN 1 END) AS   count_delay  
	, round(count(CASE WHEN status_of_delivery = 'Delay' THEN 1 END)*100.0 /  count(status_of_delivery ) ,2) percent_of_delay
	, round(count(CASE WHEN status_of_delivery != 'Delay' THEN 1 END)*100.0/  count(status_of_delivery ) ,2) percent_of_ontime
	 
	from find_delivered
	 
--13️. Which sellers have the fastest average delivery times? seller ไหนส่งของเร็วที่สุด 
/* ปัญหา data ที่พบ 
 * 1. A small number of records contain inconsistent timestamps where the
	carrier pickup date occurs after the customer delivery date,
	indicating potential data quality issues.
 * ====> show comment in : imposible case so.order_delivered_carrier_date >  so.order_delivered_customer_date 
 * 
 * 
 * 2. in order to prevent small sample bias  ---> HAVING COUNT(*) >= 10 
 * 
 * 
 * Insight :
		Sellers were ranked based on their average delivery time 
		from carrier pickup to customer delivery.
		
		To ensure statistical reliability, only sellers with at least 
		20 delivered orders were included in the analysis.
 * 
 * 
 * 
 * */
with sellers_delivered as (
	 select 
	  --carrier -> customer
	  DATEDIFF(day,so.order_delivered_carrier_date,so.order_delivered_customer_date ) logistics_delivery_days 
	 ,seller_id ,so.*
	 from stg_orders so 
	 join stg_order_items soi on  so.order_id  = soi.order_id 
	 where  order_approved_at is not null 
	 and so.order_delivered_customer_date is not null
	 and so.order_status in ('delivered')
	 --เจอปัญหา data เพราะลูกค้าไม่สามารถได้รับของก่อน carrier รับของ    อาจจะเป็นเพราะว่า timestamp  , timezone mismatch,   ETL error ,data entry error
	 --imposible case so.order_delivered_carrier_date >  so.order_delivered_customer_date 
	 and so.order_delivered_carrier_date <=  so.order_delivered_customer_date 
	 
	 )
	select seller_id,COUNT(*) AS total_orders,avg(logistics_delivery_days )  avg_seller_delivered
	from sellers_delivered
	group by    seller_id
	--prevent small sample bias
	HAVING COUNT(*) >= 10
    order by    avg_seller_delivered  
	
    
--   select order_id,count(distinct seller_id )
--   from stg_order_items group by order_id having count(*) > 2 
--   select *   from stg_order_items where order_id = '00bcee890eba57a9767c7b5ca12d3a1b'
--   select *   from stg_orders 
   
   
--14. Which regions experience the longest delivery times?  รัฐไหนมี delivery time ช้าที่สุด
    /*
     * 
     *  Delivery performance varies significantly across regions.
		The states such as RR, AM, and AP experience the longest
		delivery times, averaging over 20 days.
		
		In contrast, highly urbanized states such as MG, PR, and SP
		show significantly faster deliveries, averaging below 10 days.
     * 
     * 
     * 
     * 
     * 
     * */
    with customer_region_delivered as (
		 select 
		  --carrier -> customer
		  DATEDIFF(day,so.order_delivered_carrier_date,so.order_delivered_customer_date ) logistics_delivery_days 
		  ,so.*,sc.customer_state 
		 from stg_orders so  
		 join stg_customers sc   on so.customer_id = sc.customer_id 
		 where  order_approved_at is not null 
		 and so.order_delivered_customer_date is not null
		 and so.order_status in ('delivered')
		 --เจอปัญหา data เพราะลูกค้าไม่สามารถได้รับของก่อน carrier รับของ    อาจจะเป็นเพราะว่า timestamp  , timezone mismatch,   ETL error ,data entry error
		 --imposible case so.order_delivered_carrier_date >  so.order_delivered_customer_date 
		 and so.order_delivered_carrier_date <=  so.order_delivered_customer_date 
	 
	 )
	select customer_state , COUNT(*) AS total_orders,avg(logistics_delivery_days )  avg_customer_delivered
	from customer_region_delivered crd 
	group by customer_state 
	--prevent small sample bias
	--HAVING COUNT(*) >= 10 
    order by avg_customer_delivered desc;
    
     --select *   from stg_geolocation  
    

--15️. What is the average shipping cost (freight value) per order? shipping cost (freight_value) เฉลี่ยเท่าไรต่อ order
  with find_total_freight_per_order as(
      select SUM(soi.freight_value ) total_freight_per_order 
	   from stg_orders so 
	   join stg_order_items soi on  so.order_id  = soi.order_id 
	   where order_approved_at is not null  
	   group by soi.order_id 
   )
   select AVG(total_freight_per_order) 
   from find_total_freight_per_order

 --################ Product & Seller Performance  ####################### 

--16️. Which sellers generate the highest total revenue? seller คนไหนสร้างรายได้มากที่สุด
   with sellers_revenue as (
		 select  soi.seller_id 
		 , SUM(soi.price +soi.freight_value ) sellers_revenue
		 from stg_orders so 
		 join stg_order_items soi on  so.order_id  = soi.order_id 
		 where  order_approved_at is not null  
		 group by soi.seller_id 
	 )
	 select * from sellers_revenue  sn
	 where sellers_revenue = ( select MAX(sellers_revenue) highest_sellers_revenue from sellers_revenue _max   )
     --249640.7
	  
	 
	   
	 
	
--17️. Which sellers receive the highest average customer review scores? seller คนไหนมี rating สูงที่สุด
	 /*
	  * 
	  * Seller performance was evaluated using average customer
		review scores. To avoid bias from small sample sizes,
		only sellers with at least 50 reviews were included.
	  * 
	  * */
  select seller_id ,count(sor.review_id ) count_reviews, AVG(sor.review_score) review_score_by_seller
  from stg_order_reviews sor 
  left join stg_orders so  on sor.order_id = so.order_id 
  left join (select distinct order_id,seller_id from stg_order_items   ) soi on  so.order_id  = soi.order_id 
  where  order_approved_at is not null and seller_id is not null
  group by seller_id
  --prevent small sample bias
  having count(sor.review_id ) > 50
  order by review_score_by_seller desc
  
  
  
  
--18. Which product categories have the lowest customer satisfaction scores? หมวดสินค้าที่ได้รับ review ต่ำที่สุดคืออะไร
	  select top 1 n.product_category_name_english   ,count(sor.review_id ) count_reviews, AVG(sor.review_score) review_score_by_product_cate
	  from stg_order_reviews sor 
	  left join stg_orders so  on sor.order_id = so.order_id 
	  left join (select distinct order_id,product_id  
	             from stg_order_items   ) soi on  so.order_id  = soi.order_id 
	  join stg_products sp on soi.product_id = sp.product_id 
	  join stg_product_category_name_translation n  on   sp.product_category_name = n.product_category_name
	  where  order_approved_at is not null 
	  group by  n.product_category_name_english  
	  --prevent small sample bias
	  --having count(sor.review_id ) > 50
	  order by review_score_by_product_cate asc
	  
	  
	  
--19️. What is the average price of products in each category? ราคาเฉลี่ยของสินค้าในแต่ละหมวด
	  select n.product_category_name_english ,ROUND(AVG(soi.price) ,2)  avg_price  ,COUNT(*) total_items_sold 
	  from  stg_orders so  
	  join  stg_order_items soi on  so.order_id  = soi.order_id 
	  join stg_products sp on soi.product_id = sp.product_id  
	  full outer join stg_product_category_name_translation n  on   sp.product_category_name = n.product_category_name
	  where  order_approved_at is not null 
	  group by n.product_category_name_english  
	  
	  --select * from dim_products dp  where dp.product_category_name ='pc_gamer'
	  --select * from stg_product_category_name_translation dp  where dp.product_category_name ='pc_gamer'
	  
--------------> not complted yet ----> need to grouping
--20. Is there a relationship between shipping cost and customer review scores? freight_value มีผลต่อ review score หรือไม่
 with find_total_freight_per_order as(
       select soi.order_id ,SUM(soi.freight_value ) total_freight_per_order 
	   from stg_orders so 
	   join stg_order_items soi on  so.order_id  = soi.order_id 
	   where order_approved_at is not null  
	   group by soi.order_id 
   ) , find_review_order as(
         select so.order_id   ,count(sor.review_id ) count_reviews, AVG(sor.review_score) review_score_by_order
		  from stg_order_reviews sor 
		  left join find_total_freight_per_order so  on sor.order_id = so.order_id   
		  group by so.order_id  
		  --prevent small sample bias
		  --having count(sor.review_id ) > 50
		 
   )
  select *
  from find_total_freight_per_order a1
  join find_review_order a2 on a1.order_id = a2.order_id
  order by review_score_by_order desc
  
  
  
 /* WITH order_freight AS (
	SELECT
	    order_id,
	    SUM(freight_value) AS total_freight
	FROM stg_order_items
	GROUP BY order_id
)

	SELECT
	CASE
	    WHEN total_freight < 10 THEN '0-10'
	    WHEN total_freight < 20 THEN '10-20'
	    WHEN total_freight < 50 THEN '20-50'
	    ELSE '50+'
	END freight_range,
	
	AVG(review_score) avg_review
	
	FROM order_freight ofr 
	JOIN stg_order_reviews sor
	ON ofr.order_id = sor.order_id
	
	GROUP BY
	CASE
	    WHEN total_freight < 10 THEN '0-10'
	    WHEN total_freight < 20 THEN '10-20'
	    WHEN total_freight < 50 THEN '20-50'
	    ELSE '50+'
	END
     */

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
   
   
   
    ---where so.order_id = '009ac365164f8e06f59d18a08045f6c4';
 
   --select  *  from  stg_order_items where order_id = '009ac365164f8e06f59d18a08045f6c4';
   --group by   YEAR(order_approved_at) _year,MONTH(order_approved_at)

--   select * 
--   from  stg_order_payments where payment_installments  = 1;
   
   /*select *
   from   stg_order_payments sop  where --payment_installments  > 1
   --and 
   exists(select 1 FROM stg_orders so WHERE so.order_id = sop.order_id )  
   and order_id = '009ac365164f8e06f59d18a08045f6c4' 
   and exists(select 1  from stg_order_payments sop1 WHERE sop.order_id = sop1.order_id GROUP BY  sop1.order_id having COUNT(*)>1 )
   order by sop.order_id ,payment_sequential ;
   --select count(*) ,sop.order_id  from stg_order_payments sop GROUP BY  sop.order_id having COUNT(*)>1 ;
    
  select * from stg_sellers ss  where ss.seller_id ='f8db351d8c4c4c22c6835c19a46f01b0';
  select * from stg_customers sc   where  sc.customer_id ='7887f43daaa91055f85b6dd23cccdfcb'
  */
 
  /* with revenue_by_product_cat as(
	   select  sp.product_category_name ,ROUND(SUM(soi.price +soi.freight_value ),2) as total_revenue 
	   from stg_orders so 
	   join stg_order_items soi on  so.order_id  = soi.order_id 
	   join stg_products sp on soi.product_id = sp.product_id 
	   where order_approved_at is not null
	   group by sp.product_category_name 
	   
 )	 
 select * 
 from revenue_by_product_cat 
 where total_revenue  in  (select MAX(total_revenue) from revenue_by_product_cat );
 */