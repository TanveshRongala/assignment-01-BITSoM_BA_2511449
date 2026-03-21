## ETL Decisions

### Decision 1 — Date Standardization
Problem: The raw dataset contained inconsistent date formats (e.g., DD-MM-YYYY, MM/DD/YYYY, and text-based formats). This made it difficult to group and analyze data by time dimensions such as month or year.

Resolution: All dates were converted into a standard ISO format (YYYY-MM-DD) before loading into the `dim_date` table. Additionally, derived fields such as `year`, `month`, `day`, and `quarter` were extracted to support efficient analytical queries.

---

### Decision 2 — Category Normalization
Problem: Product categories in the raw data had inconsistent casing and naming variations (e.g., "electronics", "ELECTRONICS", "Electronics"). This would lead to incorrect aggregations in reports.

Resolution: Categories were cleaned and standardized to a consistent format (e.g., "Electronics", "Clothing", "Groceries") before inserting into the `dim_product` table. This ensures accurate grouping and reporting in BI queries.

---

### Decision 3 — Handling NULL and Missing Values
Problem: Some records in the raw dataset contained NULL or missing values for critical fields such as store location or product details. This could break joins or produce incomplete analysis.

Resolution: Missing values were either filled with appropriate defaults (e.g., "Unknown" for text fields) or excluded if the record was invalid. Dimension tables were designed with NOT NULL constraints to enforce data completeness and maintain referential integrity in the warehouse.
