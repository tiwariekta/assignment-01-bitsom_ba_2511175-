# 🏗️ Design Justification

---

## 🗄️ Storage Systems

To support a scalable and modern data architecture, different storage systems were selected based on specific workload requirements.

- 🟢 **OLTP System (MySQL)**  
  Used for transactional operations such as order placement, customer management, and payments. MySQL ensures **ACID compliance**, making it suitable for systems where data consistency and integrity are critical.

- 🔵 **NoSQL Database (MongoDB)**  
  Used for handling flexible and semi-structured data such as product catalogs, reviews, and user activity logs. MongoDB allows schema flexibility, making it ideal for evolving data models.

- 🟡 **Data Lake (Object Storage + DuckDB)**  
  Raw data from multiple sources (CSV, JSON, Parquet) is stored in a data lake. DuckDB is used for querying this data directly, enabling **schema-on-read** and fast analytical exploration.

- 🟣 **Data Warehouse / Lakehouse Layer**  
  A structured analytical layer is built using a **star schema** for reporting and BI use cases. This supports fast aggregations, trend analysis, and business dashboards.

➡️ This combination ensures the system can handle **transactions, flexibility, and analytics efficiently**.

---

## 🔄 OLTP vs OLAP Boundary

The system clearly separates transactional and analytical workloads.

- 🟢 **OLTP Layer**
  - Handles real-time operations such as:
    - Order creation  
    - Customer updates  
    - Payment processing  
  - Optimized for **fast inserts and updates**

- 🟣 **OLAP Layer**
  - Begins once data is moved from OLTP systems into the data lake/warehouse  
  - Used for:
    - Reporting  
    - Trend analysis  
    - Business intelligence  

➡️ The transition occurs through an **ETL/ELT pipeline**, where:
- Data is extracted from OLTP systems  
- Cleaned and transformed  
- Loaded into analytical storage  

This separation ensures:
- High performance for both workloads  
- No interference between transactional and analytical queries  

---

## ⚖️ Trade-offs

### 🚧 Trade-off: Complexity vs Scalability

A multi-system architecture (MySQL + MongoDB + Data Lake + Warehouse) increases:
- System complexity  
- Maintenance overhead  
- Data synchronization challenges  

However, it provides significant benefits in scalability, flexibility, and performance.

---

### 🛠️ Mitigation Strategy

To address this trade-off:

- 🔹 **Use ETL orchestration tools**  
  (e.g., Airflow) to automate data pipelines  

- 🔹 **Implement data validation checks**  
  Ensures consistency across systems  

- 🔹 **Adopt a Lakehouse approach**  
  Reduces duplication by combining data lake and warehouse capabilities  

- 🔹 **Monitoring & logging**  
  Helps quickly detect and resolve failures  

---

## 🎯 Conclusion

This architecture balances:
- ✔ Strong consistency for transactions  
- ✔ Flexibility for evolving data  
- ✔ High performance for analytics  

> 🔥 By combining multiple storage systems strategically, the design achieves both **scalability and reliability**, which are essential for modern data-driven applications.