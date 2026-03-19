## Anomaly Analysis

### Insert Anomaly
In this flat file, a new entity cannot be added independently unless a full order row is also created.

For example, product details are stored only inside order records using the columns `product_id`, `product_name`, `category`, and `unit_price`. This means a new product such as a future item cannot be inserted unless it is tied to an order.

Evidence from the CSV:
- Existing product data appears only as part of order rows, e.g. row 13:
  - `order_id = ORD1185`
  - `product_id = P008`
  - `product_name = Webcam`
  - `category = Electronics`
  - `unit_price = 2100`

So, if the company wants to add a new product record before it has been sold, the current table design does not allow that without inventing an order. This is an **insert anomaly**.

### Update Anomaly
The same sales representative details are repeated across many rows, so updating one fact requires changing multiple records. If some rows are updated and others are not, the data becomes inconsistent.

A clear example is `sales_rep_id = SR01`, where the `office_address` appears in two different forms:
- Row 3:
  - `sales_rep_id = SR01`
  - `sales_rep_name = Deepak Joshi`
  - `office_address = Mumbai HQ, Nariman Point, Mumbai - 400021`
- Row 39:
  - `sales_rep_id = SR01`
  - `sales_rep_name = Deepak Joshi`
  - `office_address = Mumbai HQ, Nariman Pt, Mumbai - 400021`

Relevant columns:
- `sales_rep_id`
- `sales_rep_name`
- `sales_rep_email`
- `office_address`

This shows an **update anomaly** because one real-world value (SR01’s office address) is stored repeatedly, and inconsistent updates have already produced conflicting values.

### Delete Anomaly
Deleting an order row can accidentally remove the only stored information about a product.

For example, `product_id = P008` appears only once in the file:
- Row 13:
  - `order_id = ORD1185`
  - `product_id = P008`
  - `product_name = Webcam`
  - `category = Electronics`
  - `unit_price = 2100`

If row 13 is deleted, all information about product `P008` (Webcam) is lost from the database, even though the product itself may still exist in the business. This is a **delete anomaly**.
