
-- Q1: Total sales revenue by product category for each month

SELECT 
    d.year,
    d.month,
    p.product_name,
    c.category,
    SUM(f.sales_amount) AS total_revenue
FROM TBL_FACT_SALES f
JOIN TBL_DIM_DATE d ON f.date_key = d.date_key
JOIN TBL_DIM_PRODUCT p ON f.product_key = p.product_key
JOIN TBL_DIM_CATEGORY c ON c.category_id = p.category_id
GROUP BY d.year, d.month, p.product_name, c.category
ORDER BY d.year, d.month, p.product_name, total_revenue DESC;


-- Q2: Top 2 performing stores by total revenue

SELECT 
    s.store_name,
    SUM(f.sales_amount) AS total_revenue
FROM TBL_FACT_SALES f
JOIN TBL_TBL_DIM_STORE s ON f.store_key = s.store_key
GROUP BY s.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores

WITH monthly AS (
  SELECT
    d.year,
    d.month,
    d.month_name,
    ROUND(SUM(f.sales_amount), 2) AS revenue
  FROM TBL_FACT_SALES f
  JOIN TBL_DIM_DATE d ON d.date_key = f.date_key
  GROUP BY d.year, d.month, d.month_name
)
SELECT
  year,
  month,
  month_name,
  revenue,
  LAG(revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
  CASE
    WHEN LAG(revenue) OVER (ORDER BY year, month) IS NULL OR LAG(revenue) OVER (ORDER BY year, month) = 0
      THEN NULL
    ELSE ROUND( (revenue - LAG(revenue) OVER (ORDER BY year, month)) / LAG(revenue) OVER (ORDER BY year, month) * 100, 2)
  END AS mom_change_pct
FROM monthly
ORDER BY year, month;
