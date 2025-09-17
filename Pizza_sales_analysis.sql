SELECT * FROM MINI_PROJECTS.PIZZA.PIZZA_SALES;

-- Checking Null values and duplicates
SELECT COUNT(*) AS Null_count
FROM MINI_PROJECTS.PIZZA.PIZZA_SALES
WHERE PIZZA_INGREDIENTS IS NULL;




SELECT PIZZA_ID, COUNT(*) AS count_duplicates
FROM MINI_PROJECTS.pizza.pizza_sales
GROUP BY PIZZA_ID
HAVING COUNT(*) > 1;

-- Key statistics
SELECT MAX(ORDER_TIME), MIN(ORDER_TIME) 
FROM PIZZA_SALES;

------------------------------------------
-- Overall Query for analysis


-- Converting date to the correct format
SELECT 
    SUM(TOTAL_PRICE) AS total_revenue,
    SUM(QUANTITY) AS number_of_units_sold,
    COUNT(PIZZA_ID) AS number_of_sales,
  COALESCE(
    TRY_TO_DATE(ORDER_DATE, 'DD-MM-YYYY'),
    TRY_TO_DATE(ORDER_DATE, 'MM/DD/YYYY')
  ) AS CLEAN_ORDER_DATE,
  
-- Extracting the day and month names
  MONTHNAME(CLEAN_ORDER_DATE) AS month_name,
  DAYNAME(CLEAN_ORDER_DATE) AS day_name,
  
--Time buckets
  CASE 
        WHEN order_time BETWEEN '09:00:00' AND '11:59:59' THEN 'Morning'
        WHEN order_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN order_time BETWEEN '16:00:00' AND '20:59:59' THEN 'Evening'
        WHEN order_time BETWEEN '21:00:00' AND '23:59:59' THEN 'Late Night'
END AS time_bucket,

    PIZZA_CATEGORY,
    PIZZA_NAME,
    PIZZA_SIZE
    
FROM MINI_PROJECTS.PIZZA.PIZZA_SALES

GROUP BY PIZZA_CATEGORY,
         PIZZA_NAME,
         ORDER_DATE,
         ORDER_TIME,
         PIZZA_SIZE;

