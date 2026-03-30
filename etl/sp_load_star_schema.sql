CREATE PROCEDURE sp_load_star_schema
AS
BEGIN
    SET NOCOUNT ON;

    -- 0. Truncate Tables before Insert
    IF OBJECT_ID('fact_sales', 'U') IS NOT NULL
	BEGIN
	    PRINT 'Truncating fact_sales...'+ CHAR(13) + CHAR(10);;
	    TRUNCATE TABLE fact_sales;
	END
	ELSE
	BEGIN
	    PRINT 'fact_sales does not exist.'+ CHAR(13) + CHAR(10);;
	END
	
	IF OBJECT_ID('dim_sellers', 'U') IS NOT NULL
	BEGIN
	    PRINT 'Truncating dim_sellers...'+ CHAR(13) + CHAR(10);;
	    TRUNCATE TABLE dim_sellers;
	END
	ELSE
	BEGIN
	    PRINT 'dim_sellers does not exist.'+ CHAR(13) + CHAR(10);;
	END
	
	IF OBJECT_ID('dim_customers', 'U') IS NOT NULL
	BEGIN
	    PRINT 'Truncating dim_customers...'+ CHAR(13) + CHAR(10);;
	    TRUNCATE TABLE dim_customers;
	END
	ELSE
	BEGIN
	    PRINT 'dim_customers does not exist.'+ CHAR(13) + CHAR(10);;
	END
	
	IF OBJECT_ID('dim_products', 'U') IS NOT NULL
	BEGIN
	    PRINT 'Truncating dim_products...'+ CHAR(13) + CHAR(10);;
	    TRUNCATE TABLE dim_products;
	END
	ELSE
	BEGIN
	    PRINT 'dim_products does not exist.'+ CHAR(13) + CHAR(10);;
	END
	
	IF OBJECT_ID('dim_date', 'U') IS NOT NULL
	BEGIN
	    PRINT 'Truncating dim_date...'+ CHAR(13) + CHAR(10);;
	    TRUNCATE TABLE dim_date;
	END
	ELSE
	BEGIN
	    PRINT 'dim_date does not exist.';
	END

    -- 1. Create Dimension Tables if can not find
    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dim_customers') AND type='U')
    BEGIN
        CREATE TABLE dim_customers (
            customer_id VARCHAR(100) PRIMARY KEY,
            customer_unique_id VARCHAR(100),
            customer_state VARCHAR(50),
            customer_city VARCHAR(50),
            total_revenue_by_orderitems DECIMAL(18,2), 
            total_revenue_by_payment DECIMAL(18,2),
            customer_segment VARCHAR(50) ,
            customer_rank INT
               
        );
    END

    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dim_products') AND type='U')
    BEGIN
        CREATE TABLE dim_products (
            product_id VARCHAR(100) PRIMARY KEY,
            product_category_name VARCHAR(100),
            product_category_name_english VARCHAR(100) 
        );
    END

    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dim_date') AND type='U')
    BEGIN
        CREATE TABLE dim_date (
            date_id INT PRIMARY KEY,
            date DATE NOT NULL,             -- real date
            year INT NOT NULL,
            month INT NOT NULL,
            year_month VARCHAR(6) NOT NULL,  -- YYYYMM
            day INT NOT NULL,
            week_of_year INT NOT NULL,
            month_name VARCHAR(20) NOT NULL,
            quarter INT NOT NULL,
            is_weekend BIT NOT NULL
        );
    END

    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'dim_sellers')
    BEGIN
        CREATE TABLE dim_sellers (
            seller_id VARCHAR(100) PRIMARY KEY,
            seller_city VARCHAR(100),
            seller_state VARCHAR(50)
        );
    END

    -- 2. Create Fact Table if can not find
    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fact_sales') AND type='U')
    BEGIN
        CREATE TABLE fact_sales (
            sales_id VARCHAR(100) PRIMARY KEY,
            order_id VARCHAR(50) NOT NULL,
            order_item_id VARCHAR(50) NOT NULL,
            seller_id VARCHAR(50) NOT NULL,
            customer_id VARCHAR(50) NOT NULL,
            product_id VARCHAR(50) NOT NULL,
            order_date_id INT  NULL,
            price DECIMAL(18,2),
            delivery_fee DECIMAL(18,2),
            revenue DECIMAL(18,2),
            estimated_delivery_days INT,
            delivery_time_days INT,
            on_time INT
        );
    END
    PRINT 'Populating dim_customers...'+ CHAR(13) + CHAR(10);;
    -- 3. Populate dim_customers
    INSERT INTO dim_customers (customer_id, customer_unique_id, customer_state, customer_city
                 , total_revenue_by_orderitems, total_revenue_by_payment, customer_segment,customer_rank)
    SELECT 
        c.customer_id,
        c.customer_unique_id,
        c.customer_state,
        c.customer_city,
        ISNULL(o.total_order_value,0) AS total_revenue_by_orderitems,
        ISNULL(o.total_payment_value,0) AS total_revenue_by_payment,
        CASE 
            WHEN ISNULL(o.total_payment_value,0) < 1000 THEN 'Low Value'
            WHEN ISNULL(o.total_payment_value,0) BETWEEN 1000 AND 5000 THEN 'Medium Value'
            ELSE 'High Value'
        END AS customer_segment,
        RANK() OVER (ORDER BY  total_payment_value DESC) AS customer_rank
    FROM stg_customers c
    LEFT JOIN (
        SELECT 
            so.customer_id,
            SUM(soi.price + soi.freight_value) AS total_order_value,
            SUM(sp.payment_value) AS total_payment_value
	        FROM stg_orders so
	        JOIN stg_order_items soi ON so.order_id = soi.order_id
	        LEFT JOIN stg_order_payments sp ON so.order_id = sp.order_id
	        WHERE so.order_approved_at IS NOT NULL
	        GROUP BY so.customer_id
    ) o ON c.customer_id = o.customer_id 
    WHERE NOT EXISTS(  SELECT 1 FROM dim_customers dc WHERE dc.customer_id = c.customer_id );
    
    
    PRINT 'Populating dim_products...'+ CHAR(13) + CHAR(10);;
    -- 4. Populate dim_products
    INSERT INTO dim_products (product_id, product_category_name, product_category_name_english)
    SELECT DISTINCT
        p.product_id,
        p.product_category_name,
        t.product_category_name_english
    FROM stg_products p
    LEFT JOIN stg_product_category_name_translation t ON p.product_category_name = t.product_category_name;
    
    PRINT 'Populating dim_date...'+ CHAR(13) + CHAR(10);;
    -- 5. Populate dim_date
    INSERT INTO dim_date (date_id, date, year, month, year_month, day, week_of_year, month_name, quarter, is_weekend)
    SELECT DISTINCT
        CAST(FORMAT(order_purchase_timestamp,'yyyyMMdd') AS INT) AS date_id,
        CAST(order_purchase_timestamp AS DATE) AS date,
        YEAR(order_purchase_timestamp) AS year,
        MONTH(order_purchase_timestamp) AS month,
        FORMAT(order_purchase_timestamp,'yyyyMM') AS year_month,
        DAY(order_purchase_timestamp) AS day,
        DATEPART(week, order_purchase_timestamp) AS week_of_year,
        DATENAME(month, order_purchase_timestamp) AS month_name,
        DATEPART(quarter, order_purchase_timestamp) AS quarter,
        CASE WHEN DATENAME(weekday, order_purchase_timestamp) IN ('Saturday','Sunday') THEN 1 ELSE 0 END AS is_weekend
    FROM stg_orders;
    
    PRINT 'Populating dim_sellers...'+ CHAR(13) + CHAR(10);;
    -- 6. Populate dim_sellers
    INSERT INTO dim_sellers (seller_id, seller_city, seller_state)
    SELECT DISTINCT seller_id, seller_city, seller_state
    FROM stg_sellers;
    
    PRINT 'Populating fact_sales...'+ CHAR(13) + CHAR(10);;
    -- 7. Populate fact_sales
    INSERT INTO fact_sales (
        sales_id, order_id, order_item_id, seller_id, customer_id, product_id, order_date_id,
        price, delivery_fee, revenue, estimated_delivery_days, delivery_time_days, on_time
    )
    SELECT 
        CONCAT(o.order_id,'-',oi.order_item_id ) AS sales_id,
        o.order_id,
        oi.order_item_id,
        oi.seller_id,
        o.customer_id,
        oi.product_id,
        CAST(FORMAT(o.order_approved_at,'yyyyMMdd') AS INT) AS order_date_id,
        oi.price,
        oi.freight_value AS delivery_fee,
        oi.price + oi.freight_value AS revenue,
        DATEDIFF(DAY, o.order_approved_at, o.order_estimated_delivery_date) AS estimated_delivery_days,
        DATEDIFF(DAY, o.order_approved_at, o.order_delivered_customer_date) AS delivery_time_days,
        CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 1 ELSE 0 END AS on_time
    FROM stg_order_items oi
    JOIN stg_orders o ON oi.order_id = o.order_id;
END;