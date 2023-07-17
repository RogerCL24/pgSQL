-- Single row functions and conversion functions (CAST)

-- Exercise
-- Given the product_discounts VIEW
    -- Convert in uppercase the CATEGORY field
    -- Add 2 decimals to the DISCOUNTED_PRICE field

-- CREATE OR REPLACE VIEW product_discounts_v2 AS
SELECT prod._names AS product,
       prod.price AS price,
       supp._names AS supplier,
       supp.email AS email,
       UPPER(cat._names) AS category,
       (
        CASE cat._names
            WHEN 'Electronic' THEN '8%'
            WHEN 'Home' THEN '5%'
            ELSE '1%'
        END 
       ) AS discounts,
       (
        CASE cat._names 
            WHEN 'Electronic' THEN price * 0.92
            WHEN 'Home' THEN price * 0.95
            ELSE price * 0.99
        END
       )::NUMERIC(10,2) AS discounted_price -- Can use CAST() as well
FROM products AS prod
INNER JOIN suppliers AS supp
ON supp.supplier_id = prod.supplier_id
INNER JOIN categories AS cat
ON cat.category_id = prod.category_id;


-- Conditional functions (IF - THEN - CASE)

-- Example
-- Create a function that allows validate the product price
-- Prices under 10.00 are not allowed (company policies)

CREATE OR REPLACE FUNCTION validate_price(price NUMERIC(10,2))
    RETURNS bool
    LANGUAGE plpgsql AS
    $$
        DECLARE answer bool := false;
        BEGIN
            IF price >= 10.00 THEN
                answer := true;
            end if;
            RETURN answer; 
        END;
    $$;

SELECT validate_price(1.00);

DROP FUNCTION validate_price();

-- Exercise 

CREATE FUNCTION calc_discount (price NUMERIC(10,2), catName VARCHAR(50))
    RETURNS NUMERIC 
    LANGUAGE plpgsql AS
    $$
        DECLARE answer NUMERIC;
        BEGIN
            CASE catName
                WHEN 'Electronic' THEN answer:= price * 0.92;
                WHEN 'Home' THEN answer:= price * 0.95;
                ELSE answer:= price * 0.99;
            END CASE;
            RETURN answer;
        END;
    $$;

SELECT calc_discount (10.00, 'Home');

CREATE OR REPLACE VIEW product_discounts AS
SELECT prod._names AS product,
       prod.price AS price,
       supp._names AS supplier,
       supp.email AS email,
       cat._names AS category,
       (
        CASE cat._names
            WHEN 'Electronic' THEN '8%'
            WHEN 'Home' THEN '5%'
            ELSE '1%'
        END 
       ) AS discounts,
       calc_discount(prod.price, cat._names) AS discounted_price
FROM products AS prod
INNER JOIN suppliers AS supp
ON supp.supplier_id = prod.supplier_id
INNER JOIN categories AS cat
ON cat.category_id = prod.category_id;

SELECT * FROM product_discounts;