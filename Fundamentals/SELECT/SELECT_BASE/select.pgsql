-- SELECT

-- SELECT can receive constants, expressions, functions and tables fields

-- Constants
SELECT 'This is a constant';

-- Expressions
SELECT 4*5+5/1;

-- Cast
SELECT 3::numeric/4::numeric; -- int to numeric

-- from 'string' to 'int' cannot be done for example

-- Functions 
SELECT now();
SELECT upper('Hi Mike');
SELECT lower('Hi Mike');

-- Table fields
SELECT * FROM students;
SELECT id, first_name, is_active
FROM students;

-- Example 
SELECT id, upper(first_name) 
AS first_name, 2+4/3 AS math, 'Estudiante' AS word
FROM students;