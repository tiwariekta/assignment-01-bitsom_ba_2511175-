-- Star Schema (DDL) for Retail Data Warehouse
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS TBL_DIM_DATE;
CREATE TABLE  TBL_DIM_DATE (
  date_key INT PRIMARY KEY,
  `date` DATE NOT NULL,
  day TINYINT NOT NULL,
  month TINYINT NOT NULL,
  month_name VARCHAR(10) NOT NULL,
  quarter TINYINT NOT NULL,
  year SMALLINT NOT NULL,
  day_of_week_name VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS TBL_DIM_STORE;
CREATE TABLE TBL_DIM_STORE (
  store_key INT AUTO_INCREMENT PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  store_city VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS TBL_DIM_CATEGORY;
CREATE TABLE TBL_DIM_CATEGORY (
  category_id int UNSIGNED NOT NULL AUTO_INCREMENT,
  category VARCHAR(50) NOT NULL,
  PRIMARY KEY (`category_id`)
);

DROP TABLE IF EXISTS TBL_DIM_PRODUCT;
CREATE TABLE TBL_DIM_PRODUCT (
  product_key INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category_id int UNSIGNED NOT NULL,
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `TBL_DIM_CATEGORY` (`category_id`)
);

DROP TABLE IF EXISTS TBL_FACT_SALES;
CREATE TABLE TBL_FACT_SALES (
  sales_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  transaction_id VARCHAR(20) NOT NULL,
  date_key INT NOT NULL,
  store_key INT NOT NULL,
  product_key INT NOT NULL,
  customer_id VARCHAR(20) NOT NULL,
  units_sold INT NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  sales_amount DECIMAL(14,2) NOT NULL,
  CONSTRAINT fk_fact_date FOREIGN KEY (date_key) REFERENCES  TBL_DIM_DATE(date_key),
  CONSTRAINT fk_fact_store FOREIGN KEY (store_key) REFERENCES TBL_DIM_STORE(store_key),
  CONSTRAINT fk_fact_product FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

INSERT INTO  TBL_DIM_DATE (date_key, `date`, day, month, month_name, quarter, year, day_of_week_name) 
VALUES (20230115, '2023-01-15', 15, 1, 'Jan', 1, 2023, 'Sun'),
(20230205, '2023-02-05', 5, 2, 'Feb', 1, 2023, 'Sun'),
(20230220, '2023-02-20', 20, 2, 'Feb', 1, 2023, 'Mon'),
(20230331, '2023-03-31', 31, 3, 'Mar', 1, 2023, 'Fri'),
(20230604, '2023-06-04', 4, 6, 'Jun', 2, 2023, 'Sun'),
(20230809, '2023-08-09', 9, 8, 'Aug', 3, 2023, 'Wed'),
(20230815, '2023-08-15', 15, 8, 'Aug', 3, 2023, 'Tue'),
(20230829, '2023-08-29', 29, 8, 'Aug', 3, 2023, 'Tue'),
(20231020, '2023-10-20', 20, 10, 'Oct', 4, 2023, 'Fri'),
(20231026, '2023-10-26', 26, 10, 'Oct', 4, 2023, 'Thu'),
(20231208, '2023-12-08', 8, 12, 'Dec', 4, 2023, 'Fri'),
(20231212, '2023-12-12', 12, 12, 'Dec', 4, 2023, 'Tue');

INSERT INTO TBL_DIM_STORE (store_key, store_name, store_city) 
VALUES (1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

INSERT INTO TBL_DIM_CATEGORY ( category) 
VALUES  ('Electronics'),
('Grocery'),
('Clothing');

INSERT INTO TBL_DIM_PRODUCT (product_key, product_name, category_id) 
VALUES (1, 'Speaker', 1),
(2, 'Tablet', 1),
(3, 'Phone', 1),
(4, 'Smartwatch', 1),
(5, 'Atta 10kg', 2),	
(6, 'Jeans', 3),
(7, 'Biscuits', 2),
(8, 'Jacket', 3);

INSERT INTO TBL_FACT_SALES (transaction_id, date_key, store_key, product_key, customer_id, units_sold, unit_price, sales_amount) 
VALUES ('TXN5000', 20230829, 1, 1, 'CUST045', 3, 49262.78, 147788.34),
('TXN5001', 20231212, 1, 2, 'CUST021', 11, 23226.12, 255487.32),
('TXN5002', 20230205, 1, 3, 'CUST019', 20, 48703.39, 974067.80),
('TXN5003', 20230220, 2, 2, 'CUST007', 14, 23226.12, 325165.68),
('TXN5004', 20230115, 1, 4, 'CUST004', 10, 58851.01, 588510.10),
('TXN5005', 20230809, 3, 5, 'CUST027', 12, 52464.00, 629568.00),
('TXN5006', 20230331, 4, 4, 'CUST025', 6, 58851.01, 353106.06),
('TXN5007', 20231026, 4, 6, 'CUST041', 16, 2317.47, 37079.52),
('TXN5008', 20231208, 3, 7, 'CUST030', 9, 27469.99, 247229.91),
('TXN5009', 20230815, 3, 4, 'CUST020', 3, 58851.01, 176553.03),
('TXN5010', 20230604, 1, 8, 'CUST031', 15, 30187.24, 452808.60),
('TXN5011', 20231020, 5, 6, 'CUST045', 13, 2317.47, 30127.11);


SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
	