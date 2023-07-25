
-- Function that returns a TRIGGER type

-- Create a TRIGGER for the suppliers table
-- Validate that the given email is correct

INSERT INTO suppliers(_names, address,phone_num,email)
VALUES ('Toy manufacturer','Km. 17 Toluca, Toluca', '722-234-5555', 'emailexamplecom');

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

CREATE TRIGGER tr_new_supplier
    BEFORE INSERT
    ON suppliers
    FOR EACH ROW
    EXECUTE FUNCTION insert_supplier();


-- Scalar triggers BEFORE or AFTER
    -- Validate that the new price has to be equal or greater than 10
    -- Modification trigger
INSERT INTO products (_names, description, price, inventory_quantity, supplier_id, category_id)
VALUES ('Canon printer', 'Canon printer 4540KJ', '-1', 1, 3,1);

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

CREATE TRIGGER tr_update_product_price
    BEFORE UPDATE
    ON products
    FOR EACH ROW
    EXECUTE FUNCTION modify_product_price();

UPDATE products 
SET price = -1
WHERE product_id = 7;

-- DB AUDITORY triggers 
CREATE TABLE shipping_detail_auditory
(
    id SERIAL PRIMARY KEY,
    _user VARCHAR(50) NOT NULL,
    date TIMESTAMP NOT NULL,
    _action VARCHAR(15) NOT NULL,
    shipping_detail_data JSONB NOT NULL -- can use composite type as well
);

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

CREATE TRIGGER tr_shippment_detail_auditory
    AFTER INSERT OR UPDATE OR DELETE
    ON shipping_detail
    FOR EACH ROW
    EXECUTE FUNCTION shippment_detail_auditory();


INSERT INTO shipping_detail 
VALUES (4, 1, 4, '4th Ave N', 70.00);

DELETE FROM shipping_detail
WHERE shipping_id = 3 AND product_id = 2;

-- Error handling with TRIGGERS (EXCEPTIONS)
-- If it is wednesday, the data base will be in maintenance 

SELECT date_part('dow', now());

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

CREATE TRIGGER tr_delete_product
    BEFORE DELETE
    ON  ALL
    FOR EACH ROW
    EXECUTE FUNCTION delete_product();
