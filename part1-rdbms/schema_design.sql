-- Schema Design: 3NF
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS TBL_CUSTOMERS;
CREATE TABLE TBL_CUSTOMERS (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS TBL_PRODUCTS;
CREATE TABLE TBL_PRODUCTS (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2) NOT NULL
);

DROP TABLE IF EXISTS TBL_OFFICES;
CREATE TABLE TBL_OFFICES (
  office_id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  office_address TEXT NOT NULL,
  PRIMARY KEY (`office_id`)
);

DROP TABLE IF EXISTS TBL_SALES_REP;
CREATE TABLE TBL_SALES_REP (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100),
    office_id int(11) unsigned NOT NULL,
    CONSTRAINT `fk_office_id` FOREIGN KEY (`office_id`) REFERENCES `TBL_OFFICES` (`office_id`)
);

DROP TABLE IF EXISTS TBL_ORDERS;
CREATE TABLE TBL_ORDERS (
    order_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`order_id`),
	KEY `indx_customer_id` (`customer_id`),
	KEY `idx_sales_rep_id` (`sales_rep_id`),
    CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `TBL_CUSTOMERS` (`customer_id`),
    CONSTRAINT `fk_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `TBL_SALES_REP` (`sales_rep_id`)
);

DROP TABLE IF EXISTS TBL_ORDER_ITEMS;
CREATE TABLE TBL_ORDER_ITEMS (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `TBL_ORDERS` (`order_id`),
    CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `TBL_PRODUCTS` (`product_id`)    
);

INSERT INTO TBL_CUSTOMERS (customer_id, customer_name, customer_email, customer_city) VALUES
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C007','Arjun Nair','arjun@gmail.com','Bangalore'),
('C008','Kavya Rao','kavya@gmail.com','Hyderabad'),
('C006','Neha Gupta','neha@gmail.com','Delhi'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C004','Sneha Iyer','sneha@gmail.com','Chennai'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai');

INSERT INTO TBL_PRODUCTS (product_id, product_name, category, unit_price) VALUES
('P007','Pen Set','Stationery',250.00),
('P002','Mouse','Electronics',800.00),
('P006','Standing Desk','Furniture', 22000.00),
('P001','Laptop','Electronics', 55000.00),
('P004','Notebook','Stationery', 120.00),
('P003','Desk Chair','Furniture',8500.00),
('P005','Headphones','Electronics',3200.00),
('P008','Webcam','Electronics',2100.00);

INSERT INTO TBL_OFFICES (office_address) VALUES
('Delhi Office, Connaught Place, New Delhi - 110001'),
('Mumbai HQ, Nariman Point, Mumbai - 400021'),
('South Zone, MG Road, Bangalore - 560001'),
('Lane 2, Sarjapur Park, Bangalore - 440051'),
('Nextgen, Baner Garden, Hyderabas - 440067');

INSERT INTO TBL_SALES_REP (sales_rep_id, sales_rep_name, sales_rep_email, office_id) VALUES
('SR02','Anita Desai','anita@corp.com',1),
('SR01','Deepak Joshi','deepak@corp.com',2),
('SR03','Ravi Kumar','ravi@corp.com',3),
('SR04','Jon Hander','jhander@corp.com',4),
('SR05','Sofia Mark','smark@corp.com',5);

INSERT INTO TBL_ORDERS (order_id, customer_id, order_date, sales_rep_id) VALUES
('ORD1132','C003','2023-03-07','SR02'),
('ORD1124','C003','2023-12-22','SR02'),
('ORD1148','C007','2023-02-05','SR01'),
('ORD1049','C007','2023-01-28','SR02'),
('ORD1113','C007','2023-05-05','SR02'),
('ORD1017','C008','2023-11-24','SR03'),
('ORD1154','C008','2023-10-19','SR02'),
('ORD1164','C008','2023-05-09','SR02'),
('ORD1106','C006','2023-08-15','SR03'),
('ORD1168','C006','2023-01-08','SR02'),
('ORD1027','C002','2023-11-02','SR03'),
('ORD1002','C002','2023-01-17','SR04'),
('ORD1035','C002','2023-05-03','SR02'),
('ORD1034','C001','2023-09-08','SR02'),
('ORD1019','C001','2023-07-25','SR05'),
('ORD1042','C004','2023-01-11','SR02'),
('ORD1018','C004','2023-01-29','SR02'),
('ORD1137','C005','2023-05-10','SR02'),
('ORD1101','C005','2023-06-17','SR02'),
('ORD1070','C005','2023-02-05','SR02'),
('ORD1166','C003','2023-09-05','SR01'),
('ORD1169','C003','2023-01-28','SR01');


INSERT INTO TBL_ORDER_ITEMS (order_id, product_id, quantity) 
VALUES
('ORD1132','P007',5),
('ORD1124','P002',2),
('ORD1148','P006',5),
('ORD1049','P004',1),
('ORD1113','P004',2),
('ORD1017','P004',5),
('ORD1154','P002',5),
('ORD1164','P003',2),
('ORD1106','P004',2),
('ORD1168','P002',5),
('ORD1027','P004',4),
('ORD1002','P005',1),
('ORD1035','P003',1),
('ORD1034','P005',1),
('ORD1019','P007',3),
('ORD1042','P001',5);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
