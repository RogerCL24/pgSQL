-- Ordering

-- Order the query output

    -- ORDER BY field number 
SELECT *
FROM persons
ORDER BY 2; -- ASC by DEFAULT

SELECT *
FROM persons
ORDER BY 3 DESC, 5;

    -- ORDER BY field name
SELECT *
FROM persons
ORDER BY birthday; 