-- Error handling I -> RAISE ERRORS (DEBUG, LOG, INFO/NOTICE)

-- Determine the quantity of suppliers

SELECT COUNT(supp.supplier_id) quantity
FROM suppliers AS supp;

CREATE OR REPLACE FUNCTION suppliers_quantity()
    RETURNS INTEGER
    LANGUAGE plpgsql AS
    $$
        DECLARE ans int;
        BEGIN
            SELECT COUNT(supp.supplier_id) INTO ans
            FROM suppliers AS supp;

            RAISE INFO 'Suppliers quantity INFO: %', ans;
            RAISE NOTICE 'Suppliers quantity NOTICE: %', ans;
            RAISE LOG 'Suppliers quantity LOG: %', ans;
            RAISE DEBUG 'Suppliers quantity DEBUG: %', ans;

            RETURN ans;
        END;
    $$;

SELECT suppliers_quantity();


-- Error handling II -> RAISE ERRORS (WARNING, EXCEPTION)

-- Determine the quantity of employees 

CREATE FUNCTION employees_quantity()
    RETURNS INTEGER
    LANGUAGE plpgsql AS
    $$
        DECLARE ans int;
        BEGIN
            SELECT COUNT(emp.employee_id) INTO ans
            FROM employees AS emp;

            RAISE WARNING 'Employees quantity WARNING: %', ans;

            RETURN ans;
        END;
    $$;


CREATE FUNCTION validate_price_v2(price NUMERIC(10,2))
    RETURNS bool
    LANGUAGE plpgsql AS
    $$
        BEGIN
            IF price >= 10.00 THEN
                RETURN true;
            end if;
            RAISE EXCEPTION 'The received price: % has to be equal or greater than 10.00', price;
        END;
    $$;

SELECT validate_price_v2(9.00);