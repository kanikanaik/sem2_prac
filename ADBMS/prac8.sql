-- ==========================================
-- STAR SCHEMA DATA WAREHOUSE
-- ==========================================

-- Dimension Table: Customer
CREATE TABLE dim_customer (
    id INT PRIMARY KEY,
    name TEXT,
    city TEXT
);

-- Dimension Table: Product
CREATE TABLE dim_product (
    id INT PRIMARY KEY,
    name TEXT,
    category TEXT
);

-- Dimension Table: Time
CREATE TABLE dim_time (
    id INT PRIMARY KEY,
    day INT,
    month INT,
    year INT
);

-- Fact Table: Sales
CREATE TABLE fact_sales (
    id SERIAL PRIMARY KEY,
    cust_id INT REFERENCES dim_customer(id),
    prod_id INT REFERENCES dim_product(id),
    time_id INT REFERENCES dim_time(id),
    amount DECIMAL(10,2)
);

-- ==========================================
-- INSERT DATA INTO DIMENSION TABLES
-- ==========================================

INSERT INTO dim_customer VALUES
(1, 'Kuku', 'Virar'),
(2, 'Puku', 'Mumbai');

INSERT INTO dim_product VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Phone', 'Electronics');

INSERT INTO dim_time VALUES
(1001, 1, 3, 2025),
(1002, 4, 3, 2026);

-- ==========================================
-- INSERT DATA INTO FACT TABLE
-- ==========================================

INSERT INTO fact_sales (cust_id, prod_id, time_id, amount)
VALUES
(1, 101, 1001, 12000),
(2, 102, 1002, 5000),
(1, 102, 1002, 4055);

-- ==========================================
-- OLAP QUERIES
-- ==========================================

-- 1. Total Sales By Month
SELECT t.month,
       SUM(f.amount) AS total_sales
FROM fact_sales f
JOIN dim_time t
ON f.time_id = t.id
GROUP BY t.month;


-- 2. Total Sales By Customer
SELECT c.name,
       SUM(f.amount) AS total_sales
FROM fact_sales f
JOIN dim_customer c
ON f.cust_id = c.id
GROUP BY c.name;


-- 3. Total Sales By Product Category
SELECT p.category,
       SUM(f.amount) AS total_sales
FROM fact_sales f
JOIN dim_product p
ON f.prod_id = p.id
GROUP BY p.category;