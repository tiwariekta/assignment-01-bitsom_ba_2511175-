# Anomaly Analysis

## 🔹 Insert Anomaly
    
        An insertion anomaly occurs when it is not possible to insert data into a database because some required information is missing or incomplete. Occurs when data cannot be added to the database without the presence of other unrelated data.


**Example:** 

If you want to insert a new product:

Product: **Laptop Stand**

Price: **1200**

But since the table requires:

    * Order_ID
    * Customer_ID
    * Customer_Name
    * Sales_rep_id

➡️ You cannot insert product independently → leads to missing product catalog entries. 

__Conclusion: You cannot add a new product unless an order exists.__

## 🔹 Update Anomaly
    
        An update anomaly is a data inconsistency issue in databases caused by improper normalization, where updating a specific data point requires modifying multiple rows due to redundancy. If some, but not all, instances are updated, the database enters an inconsistent state, leading to unreliable data.


**Example:** 

| order_id | customer_id | customer_name | customer_email | customer_city |
|----------|-------------|----------------|----------------|----------------|
| ORD1132  | C003        | Amit Verma     | amit@gmail.com | Bangalore      |
| ORD1185  | C003        | Amit Verma     | amit@gmail.com | Bangalore      |
| ORD1166  | C003        | Amit Verma     | amit@gmail.com | Bangalore      |
| ORD1143  | C003        | Amit Verma     | amit@gmail.com | Bangalore      |


If Amit Verma moves to __Pune__:

You must update multiple rows

Missing one row → inconsistent data

➡️ Same customer having different cities = data inconsistency

__Conclusion: Customer data is repeated across multiple rows.__

## 🔹 Delete Anomaly
    
        A deletion anomaly occurs when deleting a record unintentionally results in the loss of other important data. Occurs when deleting a set of data leads to the unintended loss of other unrelated data


**Example:** 

| order_id | customer_id | customer_name | customer_email | product_id |
|----------|-------------|----------------|----------------|-----------|
| ORD1132  | C003        | Amit Verma     | amit@gmail.com | Mouse     |
| ORD1185  | C003        | Amit Verma     | amit@gmail.com | Pen Set   |
| ORD1166  | C003        | Amit Verma     | amit@gmail.com | Webcam    |
| ORD1143  | C003        | Amit Verma     | amit@gmail.com | Headphones|


Deleting this order details:
➡️ You lose product info entirely

__Conclusion: Deleting an order may delete important data.__

# Normalization Justification

Keeping all data in a single flat table may appear simple initially, but it introduces significant data integrity and maintenance challenges. In the denormalized structure, every order repeats customer details, product information, sales‑rep attributes, and office addresses. This redundancy leads directly to update anomalies—for example, the same sales representative appears with multiple office address variations due to inconsistent formatting in the source records. A genuine address change (or even a typo correction) would require updating many rows manually, increasing the chance of data becoming inconsistent.

The design also suffers from insert anomalies. Because product attributes (name, category, and price) are embedded within each order row, the business cannot add a new product to the catalog unless an order is simultaneously created for it. This is impractical and prevents maintaining product master data independently.

Additionally, the dataset demonstrates delete anomalies. Products that appear in only one order lose their entire definition if that order is deleted; for example, if the only order referencing a specific product is removed, the business loses all knowledge of that product’s existence.

By normalizing the data into separate tables (Customers, Products, Orders, Sales Representatives, and Order Items), we eliminate redundancy and enforce data integrity using primary and foreign keys. Each entity is stored only once, and relationships are maintained through references.

This structure ensures consistency, improves query performance for analytical operations, and makes the database scalable. Therefore, normalization is not over-engineering but a necessary step for building a reliable and maintainable database system.
