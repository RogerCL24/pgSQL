
-- 1. Procedures for adding, deleting and updating rows

-- Add a register to the products table

INSERT INTO products (_names, description, price, inventory_quantity, supplier_id, category_id)
VALUES ()

CREATE PROCEDURE add_product(
    IN _name VARCHAR(50),
    IN descript text,
    IN pr NUMERIC(10,2),
    IN inv_q INTEGER,
    IN supp_id INTEGER,
    IN cat_id INTEGER
)
    LANGUAGE plpgsql AS
    $$
        BEGIN
            INSERT INTO products (_names, description, price, inventory_quantity, supplier_id, category_id)
            SELECT _name, descript, pr, inv_q, supp_id, cat_id;

            COMMIT;

            RAISE INFO 'Data inserted correctly into PRODUCTS table';

        END;
    $$; 

CALL add_product('LG monitor', '27 inches 4K monitor', 350.00, 20, 2, 1);

-- Delete a register from the PRODUCTS table 
--  The item ID = 6 (the new one)

CREATE PROCEDURE delete_register(prod_id INTEGER) --> $1, $2...
    LANGUAGE plpgsql AS
    $$
        DECLARE sql TEXT;
        BEGIN
            sql := 'DELETE FROM products WHERE product_id = $1';
            EXECUTE sql USING prod_id; 
            
            COMMIT;
            RAISE INFO 'Register with id =  % deleted succesfully ', prod_id;
        END;
    $$;

CALL delete_register(6);

-- Update a register from PRODUCTS table

CREATE OR REPLACE PROCEDURE update_price (prod_id INTEGER, pr NUMERIC(10,2))
    LANGUAGE plpgsql AS
    $$
        DECLARE sql TEXT;
        BEGIN
           sql := 'UPDATE products SET price = $2 WHERE product_id = $1'; 
           EXECUTE sql USING prod_id, pr;

           RAISE INFO '% register price updated succesfully (%)', pr, prod_id;
        END;
    $$;

CALL update_price(4, 16.20);


-- 2. Procedures for return tables (SETOF/COMPOSITE TYPE)

-- Determine all the employees hired from 2020

SELECT emp._names, emp.last_name, emp.hire_date
FROM employees emp
WHERE extract(year from emp.hire_date) >= 2020;

CREATE TYPE employee_info AS (
    _name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    hired date
);

-- As composite type

CREATE OR REPLACE FUNCTION hired_since(date_year INTEGER)
    RETURNS SETOF employee_info                             -- can be a table 
    LANGUAGE plpgsql AS 
    $$
        BEGIN
            RETURN QUERY (
                SELECT emp._names, emp.last_name,emp.phone_num, emp.hire_date
                FROM employees emp
                WHERE extract(year from emp.hire_date) >= date_year
            );
        END;    
    $$;

SELECT * FROM hired_since(2020);

-- As a table 

CREATE FUNCTION hired_since_v2(date_year INTEGER)
    RETURNS SETOF employees                             
    LANGUAGE plpgsql AS 
    $$
        BEGIN
            RETURN QUERY (
                SELECT emp.*
                FROM employees emp
                WHERE extract(year from emp.hire_date) >= date_year
            );
        END;    
    $$;

SELECT * FROM hired_since_v2(2020);

-- 3. Procedures for return tables (SETOF RECORD)

-- Show the name, description and inventory quantity of the products with less than 15 on stock
    -- The function receives 4 parameters (1 is IN and the others are OUT)

CREATE OR REPLACE FUNCTION products_to_buy(
    IN inventory INTEGER,
    OUT prod_name VARCHAR(50),
    OUT desc_prod text,
    OUT stock INTEGER
)
    RETURNS SETOF RECORD 
    LANGUAGE plpgsql AS 
    $$
        DECLARE _row RECORD;
        BEGIN
            FOR _row IN 
                SELECT *
                FROM products AS prod
                WHERE prod.inventory_quantity <= inventory

                LOOP
                    prod_name := _row._names;
                    desc_prod := _row.description;
                    stock := _row.inventory_quantity;
                    RETURN NEXT;
                END LOOP;
                RETURN;

        END;
    $$;

SELECT * FROM products_to_buy(15);

-- 4. IN, OUT, INOUT, $

CREATE OR REPLACE FUNCTION products_to_buy_v2(
    INOUT stock INTEGER,
    OUT prod_name VARCHAR(50),
    OUT desc_prod text
)
    RETURNS SETOF RECORD 
    LANGUAGE plpgsql AS 
    $$
        DECLARE _row RECORD;
        BEGIN
            FOR _row IN 
                SELECT *
                FROM products AS prod
                WHERE prod.inventory_quantity <= stock

                LOOP
                    prod_name := _row._names;
                    desc_prod := _row.description;
                    stock := _row.inventory_quantity;
                    RETURN NEXT;
                END LOOP;
                RETURN;

        END;
    $$;

SELECT * FROM products_to_buy_v2(15);

-- 5. Loop & AS 

CREATE FUNCTION products_to_buy_v3 (IN INTEGER)
    RETURNS TABLE (product VARCHAR(50),prod_desc text, stock INTEGER)
    LANGUAGE plpgsql AS 
    $$
        DECLARE _row RECORD;
        DECLARE inventory ALIAS FOR $1;
        BEGIN
            FOR _row IN
                SELECT prod._names, prod.description, prod.inventory_quantity
                FROM products AS prod
                WHERE prod.inventory_quantity <= inventory

                LOOP
                    product := _row._names;
                    prod_desc := _row.description;
                    stock := _row.inventory_quantity;
                    RETURN NEXT;
                END LOOP;
                RETURN;
        END;    
    $$;

SELECT * FROM products_to_buy_v3(15);
