-- Q1: List all customers from Mumbai along with their total order value
SELECT c.customer_name, 
	SUM(p.unit_price * oi.quantity) AS total_order_value
FROM TBL_CUSTOMERS c
	JOIN TBL_ORDERS o ON c.customer_id = o.customer_id
	JOIN TBL_ORDER_ITEMS oi ON o.order_id = oi.order_id
	JOIN TBL_PRODUCTS p ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM TBL_PRODUCTS p
	JOIN TBL_ORDER_ITEMS oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT sr.sales_rep_name,
       COUNT(DISTINCT o.customer_id) AS unique_customers
FROM TBL_SALES_REP sr
	JOIN TBL_ORDERS o ON sr.sales_rep_id = o.sales_rep_id
GROUP BY sr.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000
SELECT o.order_id,
       SUM(p.unit_price * oi.quantity) AS total_value
FROM TBL_ORDERS o
	JOIN TBL_ORDER_ITEMS oi ON o.order_id = oi.order_id
	JOIN TBL_PRODUCTS p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING SUM(p.unit_price * oi.quantity) > 10000
ORDER BY total_value DESC;

-- Q5: Identify any products that have never been ordered
SELECT p.product_name
FROM TBL_PRODUCTS p
LEFT JOIN TBL_ORDER_ITEMS oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;