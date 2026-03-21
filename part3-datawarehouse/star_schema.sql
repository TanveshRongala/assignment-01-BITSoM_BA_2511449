----------------------------------------------------
## Drop tables (fact first due to FK dependencies)
----------------------------------------------------
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- =========================================================
## DIMENSION TABLES
-- =========================================================

------------------------------------------------
## 1. DATE DIMENSION (standardized YYYY-MM-DD)
------------------------------------------------
CREATE TABLE dim_date (
    date_id      DATE PRIMARY KEY,
    year         INT NOT NULL,
    month        INT NOT NULL,
    day          INT NOT NULL,
    quarter      INT NOT NULL
);

INSERT INTO dim_date (date_id, year, month, day, quarter) VALUES
('2023-01-15', 2023, 1, 15, 1),
('2023-02-20', 2023, 2, 20, 1),
('2023-03-05', 2023, 3, 5, 1),
('2023-04-10', 2023, 4, 10, 2),
('2023-05-18', 2023, 5, 18, 2),
('2023-06-25', 2023, 6, 25, 2);

------------------------------------------------------
## 2. STORE DIMENSION (cleaned city names, no NULLs)
------------------------------------------------------
CREATE TABLE dim_store (
    store_id     VARCHAR(10) PRIMARY KEY,
    store_name   VARCHAR(100) NOT NULL,
    city         VARCHAR(100) NOT NULL,
    region       VARCHAR(50) NOT NULL
);

INSERT INTO dim_store (store_id, store_name, city, region) VALUES
('S001', 'Central Mall Store', 'Mumbai', 'West'),
('S002', 'City Center Store', 'Delhi', 'North'),
('S003', 'Tech Park Store', 'Bangalore', 'South');

--------------------------------------------------------
## 3. PRODUCT DIMENSION (standardized category casing)
--------------------------------------------------------
CREATE TABLE dim_product (
    product_id    VARCHAR(10) PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50) NOT NULL
);

INSERT INTO dim_product (product_id, product_name, category) VALUES
('P001', 'Laptop', 'Electronics'),
('P002', 'T-Shirt', 'Clothing'),
('P003', 'Rice Bag', 'Groceries'),
('P004', 'Headphones', 'Electronics'),
('P005', 'Jeans', 'Clothing');


-- =========================================================
## FACT TABLE
-- =========================================================

CREATE TABLE fact_sales (
    sales_id     INT PRIMARY KEY,
    date_id      DATE NOT NULL,
    store_id     VARCHAR(10) NOT NULL,
    product_id   VARCHAR(10) NOT NULL,
    quantity     INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- =========================================================
## FACT DATA (CLEANED)
-- - Dates standardized to YYYY-MM-DD
-- - Categories consistent via dim_product
-- - No NULL values
-- =========================================================

INSERT INTO fact_sales (sales_id, date_id, store_id, product_id, quantity, total_amount) VALUES
(1, '2023-01-15', 'S001', 'P001', 2, 110000.00),
(2, '2023-01-15', 'S002', 'P002', 5, 2500.00),
(3, '2023-02-20', 'S003', 'P003', 10, 800.00),
(4, '2023-02-20', 'S001', 'P004', 3, 9000.00),
(5, '2023-03-05', 'S002', 'P005', 4, 8000.00),
(6, '2023-03-05', 'S003', 'P001', 1, 55000.00),
(7, '2023-04-10', 'S001', 'P002', 6, 3000.00),
(8, '2023-04-10', 'S002', 'P003', 8, 640.00),
(9, '2023-05-18', 'S003', 'P004', 2, 6000.00),
(10, '2023-06-25', 'S001', 'P005', 3, 6000.00);

-- =========================================================
## DESIGN NOTES
-- =========================================================
-- fact_sales captures measurable metrics: quantity, total_amount
-- dim_date standardizes inconsistent date formats
-- dim_product fixes category casing issues (Electronics, Clothing, Groceries)
-- dim_store removes NULLs and standardizes location data
--
-- This star schema supports BI queries like:
-- - sales by region/month
-- - product category performance
-- - store-wise revenue analysis
