-- Materialized VIEW
-- Who is the employee with more sales?
    -- Show the complete name and number of sales

CREATE MATERIALIZED VIEW month_employee AS
    SELECT CONCAT (emp._names,' ', emp.last_name) AS full_name,
        COUNT(sale.employee_id) AS total_sales
    FROM sales AS sale
    INNER JOIN employees AS emp
    ON sale.employee_id = emp.employee_id
    GROUP BY full_name
    ORDER BY total_sales DESC
    LIMIT 1;

SELECT * FROM month_employee;

-- Show the products with 8% of discount
SELECT *
FROM product_discounts AS pd
WHERE pd.discounts = '8%';

-- Show the employees with more than 3 sales
SELECT * FROM month_employee AS me
WHERE me.total_sales > 3;

INSERT INTO sales (date, employee_id, customer_id)
SELECT date,employee_id, customer_id FROM sales
WHERE employee_id = 1;

SELECT * FROM month_employee;

REFRESH MATERIALIZED VIEW month_employee;

SELECT * FROM month_employee;