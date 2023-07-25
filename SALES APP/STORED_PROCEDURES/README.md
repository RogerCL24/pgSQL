# STORED PROCEDURES 

<sub> Check out [`SP.pgsql`](SP.pgsql) file to follow the code </sub>

## 1. Adding, Deleting & Updating rows

1. First we will create a procedure to add new rows into the `products` table

```SQL
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
```

- Same structure as the functions, but now we can define the parameters as input, output or inp/out parameters with `IN`, `OUT`, `INOUT` <sub> By default is `IN` </sub>

- When we use the `INSERT INTO` instead of `VALUES` we use `SELECT` to select the parameters that will be inserted into the `products` tables 

- We can add the `COMMIT` clause to confirm the changes of the operation (otherwise use `ROLLBACK`), and `RAISE INFO` with a message

- The main differences is that we do not use the `RETURNS` clause, is not necessary in this case because we are changing the table

- Another difference is the way we execute the procedure, we use `CALL` instead of ``SELECT``
```SQL
CALL add_product('LG monitor', '27 inches 4K monitor', 350.00, 20, 2, 1);
```
2. Second we will create a procedure to delete a row of the table but in a different way

```SQL
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
```
- We can execute operations as text with `EXECUTE` var_name `USING` parameter_name, notice in the text is defined as $1, that's because PLpostgreSQL define by default the parameters in order $1,$2, $3...

3. Finally a procedure to update the table

```SQL
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
```
- Same as before, the var `pr` corresponds to $2 and prod_id to $1

## 2. SETOF/COMPOSITE TYPE

### Exercise

Determine all the employees hired from 2020

1. First we create a composite type

```SQL
CREATE TYPE employee_info AS (
    _name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    hired date
);
```

- And then, we create the function 

```SQL
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
```

- As you can see we use `SETOF` and then the composite type `employee_info`

- We use `RETURN QUERY` to return the ``employee_info`` value, notice that in the `SELECT` clause we select the 4 fields that matches with ``employee_info`` fields

2. Now the same but we return the table `employees`

```SQL
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
```
> Obviously this one will return all the `employees` fields 

## 3. SETOF RECORD

### EXERCISE
Show the name, description and inventory quantity of the products with less than 15 on stock.
The function receives 4 parameters (1 is IN and the others are OUT).

- We create the function `products_to_buy`
```SQL
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
```
- In this case we return a `SETOF RECORD`, **RECORD** is a row/ tuple the table, this means `_row` stated in the code is row type var
- In this example we introduce the _loops_ and the _for_, `FOR` var `IN`, and then the condition we want to satisfy 
- Now we use `LOOP` and we give the table values which satisfy the condition to the `OUT` parameters
- We implement `RETURN NEXT` to iterate though the rows of the table

> Observation: we can save a parameter deleting **inventory** and using **stock** as _INOUT_ parameter, because the have data type we can do that

## 4. RETURN TABLE 

Yes, we can return a table from a function as well

```SQL
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
```

- `RETURNS TABLE` and then you define the fields you want to return 
- `ALIAS` is used to set a var name to a unnamed parameter, with this we mean that is not necessary name your parameters, you can use $1, $2, $3... 
