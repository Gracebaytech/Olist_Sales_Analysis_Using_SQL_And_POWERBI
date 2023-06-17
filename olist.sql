CREATE TABLE olist_customers_dataset (
    customer_id INTEGER,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);
ALTER TABLE olist_customers_dataset ALTER COLUMN customer_id TYPE VARCHAR(255);

copy olist_customers_dataset(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state) FROM 'C:/Users/Dell/Documents/sql-course-materials/Olist/archive/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER
SELECT * FROM olist_customers_dataset;

-- 10 What are the top-selling products on Olist, and how have their sales trends changed over time?

SELECT
    products.product_id,
    products.product_category_name,
    COUNT(order_items.order_id) AS sales_count,
    EXTRACT(YEAR FROM orders.order_purchase_timestamp) AS order_year,
    EXTRACT(MONTH FROM orders.order_purchase_timestamp) AS order_month
FROM
    olist_products_dataset products
    JOIN olist_order_items_dataset order_items ON products.product_id = order_items.product_id
    JOIN olist_orders_dataset orders ON order_items.order_id = orders.order_id
WHERE
    orders.order_status = 'delivered'
GROUP BY
    products.product_id,
    products.product_category_name,
    order_year,
    order_month
ORDER BY
    sales_count DESC;


ALTER TABLE olist_customers_dataset
ADD CONSTRAINT unique_customer_zip_code_prefix UNIQUE (customer_zip_code_prefix);


-- Create the olist_geolocation_dataset table
CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city TEXT,
    geolocation_state TEXT,
    PRIMARY KEY (geolocation_zip_code_prefix));
	
COPY olist_geolocation_dataset(geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state) 
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_geolocation_dataset.csv' 
DELIMITER ',' CSV HEADER;

ALTER TABLE olist_geolocation_dataset
DROP CONSTRAINT olist_geolocation_dataset_pkey;

-- Create the olist_order_items_dataset table
CREATE TABLE olist_order_items_dataset (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);

-- Import data from CSV file
COPY olist_order_items_dataset(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_order_items_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Create the olist_order_payments_dataset table
CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value NUMERIC(10, 2)
);

-- Import data from CSV file
COPY olist_order_payments_dataset(order_id, payment_sequential, payment_type, payment_installments, payment_value)
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_order_payments_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Select the first 5 rows from the table
SELECT *
FROM olist_order_payments_dataset
LIMIT 5;

-- Create the olist_order_reviews_dataset table
CREATE TABLE olist_order_reviews_dataset (
    review_id TEXT,
    order_id TEXT,
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

\
-- Copy data from CSV file into the olist_order_reviews_dataset table
COPY olist_order_reviews_dataset(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp)
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_order_reviews_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Select the top 10 rows from the olist_order_reviews_dataset table
SELECT *
FROM olist_order_reviews_dataset
LIMIT 10;

-- Create the olist_orders_dataset table
CREATE TABLE olist_orders_dataset (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- Copy data from CSV file into the olist_orders_dataset table
COPY olist_orders_dataset(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date) 
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_orders_dataset.csv' 
DELIMITER ',' CSV HEADER;


-- Create the olist_products_dataset table
CREATE TABLE olist_products_dataset (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- Import data from CSV file
COPY olist_products_dataset(product_id, product_category_name, product_name_length, product_description_length, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_products_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Select first 10 rows from the table
SELECT *
FROM olist_products_dataset
LIMIT 10;

-- Create the olist_sellers_dataset table
CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(255),
    seller_zip_code_prefix INT,
    seller_city TEXT,
    seller_state TEXT
);

-- Copy data from the CSV file
COPY olist_sellers_dataset (seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\olist_sellers_dataset.csv'
DELIMITER ',' CSV HEADER;


-- Create the product_category_name_translation table
CREATE TABLE product_category_name_translation (
    product_category_name TEXT,
    product_category_name_english TEXT
);

-- Copy data from CSV file into the table
COPY product_category_name_translation (product_category_name, product_category_name_english) 
FROM 'C:\Users\Dell\Documents\sql-course-materials\Olist\archive\product_category_name_translation.csv' 
DELIMITER ',' CSV HEADER;

-- Select the first 10 rows from the table
SELECT *
FROM product_category_name_translation
LIMIT 10;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'olist_customers_dataset';

-- Data Cleaning and 
SELECT *
FROM olist_customers_dataset
WHERE customer_city IS NULL;

-- Question to Answer
--1 : What is the total revenue generated by Olist, and how has it changed over time?
SELECT date_trunc('month', ood.order_purchase_timestamp) AS month,
       SUM(oid.price + oid.freight_value) AS total_revenue
FROM olist_orders_dataset AS ood
JOIN olist_order_items_dataset AS oid ON ood.order_id = oid.order_id
GROUP BY month
ORDER BY month;

--

--2 . How many orders were placed on Olist, and how does this vary by month or season?
SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
       EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
       COUNT(*) AS order_count
FROM olist_orders_dataset
GROUP BY year, month
ORDER BY year, month;

--3 What are the most popular product categories on Olist, and how do their sales volumes compare to each other?
SELECT p.product_category_name,
       COUNT(*) AS sales_volume
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY sales_volume DESC;

--4  What is the average order value (AOV) on Olist, and how does this vary by product category or payment method?
SELECT p.product_category_name,
       op.payment_type,
       AVG(oi.price + oi.freight_value) AS average_order_value
FROM olist_order_items_dataset oi
JOIN olist_order_payments_dataset op ON oi.order_id = op.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY p.product_category_name, op.payment_type
ORDER BY average_order_value DESC;

--5 How many sellers are active on Olist, and how does this number change over time?
SELECT EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
       EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
       COUNT(DISTINCT s.seller_id) AS active_sellers
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
GROUP BY year, month
ORDER BY year, month;

--6 6: What is the distribution of seller ratings on Olist, and how does this impact sales performance?

SELECT s.seller_id,
       AVG(r.review_score) AS average_rating,
       SUM(oi.price) AS total_sales
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
GROUP BY s.seller_id
ORDER BY SUM(oi.price) DESC;



-- 7  How many customers have made repeat purchases on Olist, and what percentage of total sales do they account for?

WITH repeat_customers AS (
  SELECT customer_id
  FROM olist_orders_dataset
  GROUP BY customer_id
  HAVING COUNT(DISTINCT order_id) > 1
),
repeat_orders AS (
  SELECT order_id
  FROM olist_orders_dataset
  WHERE customer_id IN (SELECT customer_id FROM repeat_customers)
),
total_sales AS (
  SELECT SUM(price) AS total_sales
  FROM olist_order_items_dataset
  WHERE order_id IN (SELECT order_id FROM repeat_orders)
)
SELECT COUNT(DISTINCT customer_id) AS repeat_customer_count,
       (COUNT(DISTINCT customer_id) * 100.0) / (SELECT COUNT(DISTINCT customer_id) FROM olist_orders_dataset) AS repeat_customer_percentage,
       (SELECT total_sales FROM total_sales) AS total_sales
FROM repeat_customers;


--8 What is the average customer rating for products sold on Olist, and how does this impact sales performance?
SELECT AVG(op.review_score) AS average_rating,
       SUM(oi.price) AS total_sales
FROM olist_order_items_dataset oi
JOIN olist_order_reviews_dataset op ON oi.order_id = op.order_id


SELECT average_order_rating, COUNT(*) AS sales_count
FROM (
    SELECT ROUND(AVG(order_reviews.review_score), 1) AS average_order_rating
    FROM olist_orders_dataset orders
    JOIN olist_order_items_dataset order_items ON orders.order_id = order_items.order_id
    JOIN olist_order_reviews_dataset order_reviews ON orders.order_id = order_reviews.order_id
    GROUP BY orders.order_id
) subquery
GROUP BY average_order_rating
ORDER BY average_order_rating;

-- 9 What is the average order cancellation rate on Olist, and how does this impact seller performance?.

SELECT
  s.seller_id,
  s.seller_city,
  s.seller_state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNT(DISTINCT CASE WHEN o.order_status = 'canceled' THEN o.order_id END) AS cancelled_orders,
  COUNT(DISTINCT CASE WHEN o.order_status = 'canceled' THEN o.order_id END) * 100.0 / COUNT(DISTINCT o.order_id) AS cancellation_rate
FROM
  olist_sellers_dataset s
JOIN
  olist_order_items_dataset oi ON s.seller_id = oi.seller_id
JOIN
  olist_orders_dataset o ON oi.order_id = o.order_id
GROUP BY
  s.seller_id, s.seller_city, s.seller_state
ORDER BY
  cancellation_rate DESC;

-- 11 Which payment methods are most commonly used by Olist customers, and how does this vary by product category or geographic region?

SELECT
    orders.order_id,
    orders.customer_id,
    orders.order_status,
    orders.order_purchase_timestamp,
    order_payments.payment_type,
    products.product_id,
    products.product_category_name,
    geolocation.geolocation_state
FROM
    olist_orders_dataset orders
    JOIN olist_order_payments_dataset order_payments ON orders.order_id = order_payments.order_id
    JOIN olist_order_items_dataset order_items ON orders.order_id = order_items.order_id
    JOIN olist_products_dataset products ON order_items.product_id = products.product_id
    JOIN olist_customers_dataset customers ON orders.customer_id = customers.customer_id
    JOIN olist_geolocation_dataset geolocation ON customers.customer_zip_code_prefix = geolocation.geolocation_zip_code_prefix
ORDER BY
    orders.order_purchase_timestamp;
	
	
-- 12 : How do customer reviews and ratings affect sales and product performance on Olist?
SELECT
    products.product_id,
    products.product_category_name,
    AVG(order_reviews.review_score) AS average_review_score,
    COUNT(order_reviews.review_id) AS review_count,
    COUNT(order_reviews.review_score) AS rating_count,
    COUNT(order_items.order_item_id) AS items_sold
FROM
    olist_orders_dataset orders
    JOIN olist_order_items_dataset order_items ON orders.order_id = order_items.order_id
    JOIN olist_products_dataset products ON order_items.product_id = products.product_id
    JOIN olist_order_reviews_dataset order_reviews ON orders.order_id = order_reviews.order_id
GROUP BY
    products.product_id,
    products.product_category_name
ORDER BY
    items_sold DESC;

-- 13 Which product categories have the highest profit margins on Olist, and how can the company increase profitability across different categories?

SELECT
    products.product_category_name,
    AVG((order_items.price * order_items.order_item_id - costs.total_cost) / (order_items.price * order_items.order_item_id) * 100) AS average_profit_margin
FROM
    olist_orders_dataset orders
    JOIN olist_order_items_dataset order_items ON orders.order_id = order_items.order_id
    JOIN olist_products_dataset products ON order_items.product_id = products.product_id
    JOIN (
        SELECT
            order_items.product_id,
            SUM(order_items.price * order_items.order_item_id) AS total_cost
        FROM
            olist_order_items_dataset order_items
            JOIN olist_sellers_dataset sellers ON order_items.seller_id = sellers.seller_id
        GROUP BY
            order_items.product_id
    ) AS costs ON products.product_id = costs.product_id
GROUP BY
    products.product_category_name
ORDER BY
    average_profit_margin DESC;
-- 14 ow does Olist's marketing spend and channel mix impact sales and customer acquisition costs, and how can the company optimize its marketing strategy to increase ROI?

SELECT
    order_payments.payment_type,
    SUM(order_payments.payment_value) AS total_marketing_spend,
    SUM(order_items.price * order_items.order_item_id) AS total_sales_revenue,
    SUM(order_payments.payment_value) / COUNT(DISTINCT orders.customer_id) AS customer_acquisition_cost,
    (SUM(order_items.price * order_items.order_item_id) / SUM(order_payments.payment_value)) * 100 AS return_on_investment
FROM
    olist_orders_dataset orders
    JOIN olist_customers_dataset customers ON orders.customer_id = customers.customer_id
    JOIN olist_order_items_dataset order_items ON orders.order_id = order_items.order_id
    JOIN olist_order_payments_dataset order_payments ON orders.order_id = order_payments.order_id
GROUP BY
    order_payments.payment_type
ORDER BY
    return_on_investment DESC;
	
-- 15 Geolocation having high customer density. Calculate customer retention rate according to geolocations

SELECT
    geolocation.geolocation_zip_code_prefix,
    COUNT(DISTINCT orders.customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN repeat_orders.customer_count > 1 THEN orders.customer_id END) AS repeat_customers,
    (COUNT(DISTINCT CASE WHEN repeat_orders.customer_count > 1 THEN orders.customer_id END) / COUNT(DISTINCT orders.customer_id)) * 100 AS customer_retention_rate
FROM
    olist_customers_dataset customers
    JOIN olist_geolocation_dataset geolocation ON customers.customer_zip_code_prefix = geolocation.geolocation_zip_code_prefix
    JOIN olist_orders_dataset orders ON customers.customer_id = orders.customer_id
    JOIN (
        SELECT
            customer_id,
            COUNT(DISTINCT order_id) AS customer_count
        FROM
            olist_orders_dataset
        GROUP BY
            customer_id
    ) repeat_orders ON orders.customer_id = repeat_orders.customer_id
GROUP BY
    geolocation.geolocation_zip_code_prefix
ORDER BY
    customer_retention_rate DESC;
