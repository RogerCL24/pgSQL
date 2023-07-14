-- Adding functions
-- MAX, MIN, AVG, COUNT, SUM

-- Sum of the id
SELECT SUM(sale.id)
FROM sales2 AS sale;

-- Ex: Get the total price of all products
-- Sum of the object total

SELECT SUM((sale.sale_details ->> 'total')::NUMERIC) AS total
FROM sales2 AS sale;

-- Get the max value from total OBJECT

SELECT MAX((sale.sale_details ->> 'total')::NUMERIC) AS total_max
FROM sales2 AS sale;

-- Sum of the object price

SELECT SUM((product_detail ->> 'price')::NUMERIC) AS real_total_price
FROM sales2 AS sale,
    jsonb_array_elements(sale.sale_details -> 'products') AS product_detail;

    
