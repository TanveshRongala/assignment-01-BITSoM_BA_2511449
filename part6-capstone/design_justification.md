--------------------
## Storage Systems
--------------------
The architecture uses multiple storage systems tailored to specific use cases. For transactional patient data such as medical history, treatments, and appointments, a relational database like MySQL or PostgreSQL is used. This ensures strong consistency and ACID properties, which are critical in healthcare systems.

For reporting and analytics, a data warehouse such as Snowflake or BigQuery is used. This system stores cleaned and structured data optimized for queries like bed occupancy and department-wise costs. It supports fast aggregations and business intelligence dashboards.

A data lake or lakehouse (e.g., Amazon S3 with Delta Lake) is used to store raw and historical data, including large volumes of treatment records and ICU device logs. This storage is ideal for machine learning workloads, such as predicting patient readmission risk.

For natural language querying, a vector database (such as FAISS or Pinecone) is used. Patient notes and medical records are converted into embeddings, allowing doctors to perform semantic searches like “Has this patient had a cardiac event before?”

Finally, real-time vitals from ICU devices are ingested through a streaming system (e.g., Kafka) and stored in a time-series or streaming-friendly storage system for immediate analysis and alerting.


--------------------------
## OLTP vs OLAP Boundary
--------------------------
The OLTP system consists of the operational database (MySQL/PostgreSQL), where real-time patient interactions occur. This includes patient registration, updates to medical records, and live hospital operations. These systems prioritize fast writes and strong consistency.

The OLAP system begins once data is extracted from the OLTP system through ETL pipelines. Data is cleaned and loaded into the data warehouse and data lake. These systems are optimized for analytical queries, reporting, and machine learning.

Thus, the boundary lies at the ETL/ELT layer. Data flows from OLTP systems into analytical storage, where it is transformed and used for insights rather than transactions.


----------------
## Trade-offs
----------------
A key trade-off in this design is increased system complexity due to the use of multiple storage systems (OLTP database, data warehouse, data lake, and vector database). While each system is optimized for a specific purpose, managing data consistency, synchronization, and maintenance across them can be challenging.

To mitigate this, a well-defined data pipeline strategy is required. Using orchestration tools like Apache Airflow can ensure reliable data movement and transformation. Additionally, adopting a lakehouse architecture can reduce fragmentation by combining data lake and warehouse capabilities. Proper data governance, schema management, and monitoring tools can further ensure consistency and reliability across the system.

Despite the complexity, this trade-off is justified because it enables scalability, flexibility, and advanced AI capabilities required for modern healthcare systems.
