# TRIGGERS

<sub> Check out [`triggers.pgsql`](triggers.pgsql) file to follow the code </sub>

- A trigger is a server object, alike to stored procedures, associated with tables and/or views.
- It's executed automatically when a ``INSERT``, ``UPDATE`` or ``DELETE`` operation is executed as well.
- It can be summoned before or after the event.
- _OBJECTS_ that access table fields: 
    - Insert - **NEW** -> NEW.field_name
    - Update - **NEW - OLD** -> NEW/OLD.field_name
    - Delete - **OLD** -> OLD.
    
## Insert TRIGGER
### EXERCISE 1
Validate that the given email is correct

- We create the function which will validate the email

```SQL
CREATE FUNCTION insert_supplier()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        DECLARE regex_email TEXT := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._%+-]+\.[A-Z|a-z]{2,}$';
        BEGIN
            IF NEW.email ~ regex_email
                THEN 
                    RETURN NEW;
                ELSE 
                    RAISE EXCEPTION 'Email "%" not valid!', NEW.email;
            END IF;
        END;
    $$;
```
- First, we return a `TRIGGER` in the `RETURNS` clause.
- We declare a _TEXT_ data type var (regex_email), indicating what the email inserted into the `suppliers` table must have.
- Then, in the `IF` clause we check the email field with **NEW** <sub> Is an `INSERT`</sub> and the operataor `~` to match with the regex var <sub> Basically it must have _word@word.word_ </sub>.
- So if the `IF` condition is satisfied we return that tuple 
```SQL
RETURN NEW;
```
- If not we raise an exception

The final step is create the trigger

```SQL
CREATE TRIGGER tr_new_supplier
    BEFORE INSERT
    ON suppliers
    FOR EACH ROW
    EXECUTE FUNCTION insert_supplier();
```
- We need to specify if it would be a before or an after type, that means the trigger will be executed before the changes or after.

- After that we write next to the `ON`clause from which table is going to be used.

- We specify changes in the INSERT execution will be checked for each row.

- And then, what function we are going to execute.

## Modification TRIGGER
### EXERCISE 2 
Validate that the new price has to be equal or greater than 10.
 If not, update the value to 10.

The function would be:
```SQL
CREATE FUNCTION modify_product_price ()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        BEGIN
            IF validate_price(NEW.price)
                THEN
                    RETURN NEW;
                ELSE
                    NEW.price := 10::NUMERIC(10,2);
                    RETURN NEW;
            END IF;

        END;
    $$;
```

> Observation: we use the function _validate_price_ from [``Functions.pgsql``](../FUNCTIONS/SRF_UDF
/Functions.pgsql)

And the trigger would be:

```SQL
CREATE TRIGGER tr_update_product_price
    BEFORE UPDATE
    ON products
    FOR EACH ROW
    EXECUTE FUNCTION modify_product_price();
```
- Now we use the `UPDATE` clause instead of `INSERT` as the former one, because the trigger will be triggered when an `UPDATE` clause on the `products` table is executed, for example:

```SQL
UPDATE products 
SET price = -1
WHERE product_id = 7;
```

## Auditory TRIGGERS
The main role of the triggers is the data base auditory, in order to monitorize all the operations in a table/s we add triggers and tables where you can store the changes, for example:

- We create the table `shipping_detail_auditory`:

```SQL
CREATE TABLE shipping_detail_auditory
(
    id SERIAL PRIMARY KEY,
    _user VARCHAR(50) NOT NULL,
    date TIMESTAMP NOT NULL,
    _action VARCHAR(15) NOT NULL,
    shipping_detail_data JSONB NOT NULL -- can use composite type as well
);
```

- Now the function that expects 3 different clauses, `INSERT`, `UPDATE`, `DELETE`
```SQL
CREATE FUNCTION shippment_detail_auditory()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        BEGIN
            CASE TG_OP -- 'INSERT - UPDATE - DELETE'
                WHEN 'INSERT' THEN
                    INSERT INTO shipping_detail_auditory(_user, date, _action, shipping_detail_data)
                    VALUES (user, now(), TG_OP, row_to_json(NEW));
                    RETURN NEW;
                WHEN 'UPDATE' THEN
                    INSERT INTO shipping_detail_auditory(_user, date, _action, shipping_detail_data)
                    VALUES (user, now(), TG_OP, row_to_json(NEW));
                    RETURN NEW;
                WHEN 'DELETE' THEN
                    INSERT INTO shipping_detail_auditory(_user, date, _action, shipping_detail_data)
                    VALUES (user, now(), TG_OP, row_to_json(OLD));
                    RETURN OLD;
            END CASE; 
        END;
    $$;
```
- We use the `CASE` clause and the special var `TG_OP` which tell us as a string (is data type _text_) what operation fired the trigger, `INSERT`, `UPDATE` or `DELETE`.

- In order to create a 'log' of what happened, we insert into the `shipping_detail_auditory` table the following information.

- ``user``: what user is executing the operation.

- ``now()``: when the op was executed.

- ``TG_OP``: what clause fired the trigger.

- ``row_to_json()``: we tranform the row inserted, deleted or updated to a json object.

- Finally we return the tuple inserted <sub>**NEW**</sub>, updated <sub>**NEW** or **OLD**</sub> or deleted <sub>**OLD**</sub>, so as to keep the normal execution of the operation.

To finsih we create the trigger:
```SQL
CREATE TRIGGER tr_shippment_detail_auditory
    AFTER INSERT OR UPDATE OR DELETE
    ON shipping_detail
    FOR EACH ROW
    EXECUTE FUNCTION shippment_detail_auditory();
```
> **Observation**: It can be _BEFORE_ as well, and now we fire the trigger when 
the 3 clauses are executed.

So for example if we execute:

```SQL
INSERT INTO shipping_detail 
VALUES (4, 1, 4, '4th Ave N', 70.00);
```

The user who executed this operation will see:
foto(3)

And the DBA will see as well:
foto(4)

If we delete it will also work:
```SQL
DELETE FROM shipping_detail
WHERE shipping_id = 3 AND product_id = 2;
```
The DBA will see the ``shipping_detail_auditory`` table updated:
foto(6)

## Error handling with TRIGGERS

### Exercise 

If it is wednesday, the data base will be in maintenance

We create the function `delete_product`:

```SQL
CREATE FUNCTION delete_product()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS 
    $$
        BEGIN
            SELECT date_part('dow',now()) INTO day_of_the_week;
            IF day_of_the_week = 3
                THEN
                    RAISE EXCEPTION 'Data base maintenance, DELETE operations will not be allowed';
            END IF;
            RETURN OLD;
        END;
    $$;
```

- We use the function `date_part()` which returns us a number depending in 
the day we are, in this case we indicate `'dow'`, namely, it will return a **3**.

