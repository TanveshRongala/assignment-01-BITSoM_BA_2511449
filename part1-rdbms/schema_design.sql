---------------------------------------------
## Drop tables first (child before parent)
---------------------------------------------
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales_reps;

-- =========================================================
## 1. CUSTOMERS
-- =========================================================
CREATE TABLE customers (
    customer_id    VARCHAR(10) PRIMARY KEY,
    customer_name  VARCHAR(100) NOT NULL,
    customer_email VARCHAR(150) NOT NULL,
    customer_city  VARCHAR(100) NOT NULL
);

INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi'),
('C007', 'Arjun Nair', 'arjun@gmail.com', 'Bangalore'),
('C008', 'Kavya Rao', 'kavya@gmail.com', 'Hyderabad');

-- =========================================================
## 2. PRODUCTS
-- =========================================================
CREATE TABLE products (
    product_id    VARCHAR(10) PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50) NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL
);

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000.00),
('P002', 'Mouse', 'Electronics', 800.00),
('P003', 'Desk Chair', 'Furniture', 8500.00),
('P004', 'Notebook', 'Stationery', 120.00),
('P005', 'Headphones', 'Electronics', 3200.00),
('P006', 'Standing Desk', 'Furniture', 22000.00),
('P007', 'Pen Set', 'Stationery', 250.00),
('P008', 'Webcam', 'Electronics', 2100.00);

-- =========================================================
## 3. SALES REPRESENTATIVES
-- =========================================================
CREATE TABLE sales_reps (
    sales_rep_id     VARCHAR(10) PRIMARY KEY,
    sales_rep_name   VARCHAR(100) NOT NULL,
    sales_rep_email  VARCHAR(150) NOT NULL,
    office_address   VARCHAR(255) NOT NULL
);

-----------------------------------------------------
## Standardized SR01 address to remove inconsistency
-----------------------------------------------------
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road, Bangalore - 560001');

-- =========================================================
## 4. ORDERS
-- =========================================================
CREATE TABLE orders (
    order_id       VARCHAR(10) PRIMARY KEY,
    order_date     DATE NOT NULL,
    customer_id    VARCHAR(10) NOT NULL,
    sales_rep_id   VARCHAR(10) NOT NULL,
    product_id     VARCHAR(10) NOT NULL,
    quantity       INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO orders (order_id, order_date, customer_id, sales_rep_id, product_id, quantity) VALUES
('ORD1000', '2023-05-21', 'C002', 'SR03', 'P001', 2),
('ORD1001', '2023-02-22', 'C004', 'SR03', 'P002', 5),
('ORD1002', '2023-01-17', 'C002', 'SR02', 'P005', 1),
('ORD1003', '2023-09-16', 'C002', 'SR01', 'P002', 5),
('ORD1004', '2023-11-29', 'C001', 'SR01', 'P005', 5),
('ORD1005', '2023-10-29', 'C007', 'SR02', 'P002', 3),
('ORD1006', '2023-12-24', 'C001', 'SR01', 'P007', 4),
('ORD1007', '2023-04-21', 'C006', 'SR01', 'P003', 3);

-- =========================================================
-- Why this is in 3NF
-- =========================================================
-- customers:   customer_id -> customer_name, customer_email, customer_city
-- products:    product_id  -> product_name, category, unit_price
-- sales_reps:  sales_rep_id -> sales_rep_name, sales_rep_email, office_address
-- orders:      order_id -> order_date, customer_id, sales_rep_id, product_id, quantity
--
-- Non-key attributes depend only on the key of their own table.
-- Repeating descriptive data has been removed from orders.
-- This eliminates:
-- 1. Insert anomaly  -> products/customers/sales reps can be inserted without creating an order
-- 2. Update anomaly  -> sales rep address is stored once in sales_reps
-- 3. Delete anomaly  -> deleting an order does not delete product/customer/sales rep master data
