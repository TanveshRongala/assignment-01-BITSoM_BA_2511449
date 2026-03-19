# Normalization Report

## Anomaly Analysis

### Insert Anomaly
The flat file mixes order, customer, product, and sales representative data in one row. Because of that, a new product cannot be inserted unless there is also an order for it.

For example, product details are stored only inside order rows using:
- `product_id`
- `product_name`
- `category`
- `unit_price`

A product such as `P008 | Webcam | Electronics | 2100` appears only because order row **11** (`order_id = ORD1185`) exists. If the company wants to add a new product before any customer orders it, there is no clean place to store it without inventing an order, customer, and sales rep combination. That is an **insert anomaly**.

### Update Anomaly
Sales representative details are repeated across many rows, so one real-world change requires multiple row updates, which can easily create inconsistencies.

A clear example is `sales_rep_id = SR01`:
- Row **1**: `office_address = Mumbai HQ, Nariman Point, Mumbai - 400021`
- Row **37**: `office_address = Mumbai HQ, Nariman Pt, Mumbai - 400021`
- Row **152**: `office_address = Mumbai HQ, Nariman Pt, Mumbai - 400021`
- Row **158**: `office_address = Mumbai HQ, Nariman Pt, Mumbai - 400021`
- Row **170**: `office_address = Mumbai HQ, Nariman Pt, Mumbai - 400021`
- Row **180**: `office_address = Mumbai HQ, Nariman Pt, Mumbai - 400021`

The same sales rep (`SR01`, `Deepak Joshi`, `deepak@corp.com`) has two different office address spellings in the same dataset: **“Nariman Point”** and **“Nariman Pt”**. This is an **update anomaly** caused by duplicated rep data.

### Delete Anomaly
Deleting a row can unintentionally delete important master data about a product.

Example:
- Row **11** contains:
  - `product_id = P008`
  - `product_name = Webcam`
  - `category = Electronics`
  - `unit_price = 2100`
  - `order_id = ORD1185`

`P008` appears only in this one row. If row **11** is deleted because order `ORD1185` is removed or corrected, the database also loses all record that product `P008 (Webcam)` exists. That is a **delete anomaly**.

## Normalization Justification

The manager’s claim that one big table is “simpler” is only true at first glance. In this dataset, the single-table design creates repeated facts and makes the data unreliable. Customer details such as `customer_name`, `customer_email`, and `customer_city` are repeated in every order. Product information such as `product_name`, `category`, and `unit_price` is also repeated across many rows. Sales representative details are repeated too, and this has already caused inconsistency: `SR01` appears with both “Nariman Point” and “Nariman Pt” in the `office_address` column. That is a real sign that duplication is hurting data quality.

The table also creates anomalies. A new product cannot be added unless an order exists for it, which is an insert anomaly. Deleting the only row for `P008 (Webcam)` would erase the product completely, which is a delete anomaly. If a sales rep office address changes, many rows must be updated, and missing even one row creates conflicting values, which is an update anomaly.

Normalizing to 3NF solves these problems by separating entities into `Customers`, `Products`, `SalesReps`, `Orders`, and `OrderItems`. Each fact is stored once, and relationships are maintained using foreign keys. This reduces redundancy, prevents inconsistent updates, and makes the database easier to maintain and trust. So in this case, normalization is not over-engineering; it is the correct design choice.
