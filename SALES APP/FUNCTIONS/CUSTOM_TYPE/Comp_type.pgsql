-- Exercise

-- Print ON CONSOLE the name, last name and phone of the customer

SELECT cust.names, cust.last_name, cust.phone_num
FROM customers AS cust
WHERE cust.customer_id = 5;

CREATE TYPE customer_info AS (
    _name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(50)
);

CREATE OR REPLACE FUNCTION print_customer(customerid INTEGER)
    RETURNS VOID
    LANGUAGE plpgsql AS
    $$
        DECLARE customer_data customer_info;
        BEGIN
           SELECT cust.names, cust.last_name, cust.phone_num INTO customer_data
           FROM customers AS cust
           WHERE cust.customer_id = customerid;

           RAISE INFO 'Customer -> Name: %, Last name: %, Phone: %',
           customer_data._name, customer_data.last_name, customer_data.phone;
        END;
    $$;

SELECT print_customer(5);


