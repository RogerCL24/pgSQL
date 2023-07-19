# CUSTOM 

<sub> Check out [``Comp_type.pgsql``](Comp_type.pgsql) file to follow the code </sub>

You already know the standard data types: _INTEGER_, _VARCHAR()_, _UUID_, _SERIAL_...

But you know you can create your own data types? For example 

```SQL
CREATE TYPE customer_info AS (
    _name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(50)
);
```

And now we use it like a normal data type

```SQL
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
```

As you see the var ``customer_data`` is _customer_info_ type, we only have to give to the var the proper fields, they have to be VARCHAR(50)!

> Execution

foto(1ref)
