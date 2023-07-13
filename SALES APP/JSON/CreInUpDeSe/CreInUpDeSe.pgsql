CREATE TABLE sales2 (
    id SERIAL PRIMARY KEY NOT NULL,
    sale_date DATE NOT NULL,
    sale_details JSONB NOT NULL
);

-- INSERT 
INSERT INTO sales2 (sale_date, sale_details)
VALUES ('2023-02-28','{
    "customer": "Juan Perez",
    "total": 26.75,
    "dni": "6775699LP",
    "address": {
        "description": "6th of August Av.",
        "num": "7B",
        "city": "La Paz"
    },
    "products": [
        {
            "name": "Product 1",
            "price": 10.50,
            "quantity": 2
        },
        {
            "name": "Product 2",
            "price": 5.75,
            "quantity": 1
        }
    ]
}'),
    ('2023-02-28','{
    "customer": "Roger Cot",
    "total": 15.55,
    "dni": "5663345SC",
    "address": {
        "description": "Student square",
        "num": "1234",
        "city": "La Paz"
    },
    "products": [
        {
            "name": "Product 1",
            "price": 10.50,
            "quantity": 2
        },
        {
            "name": "Product 3",
            "price": 15.75,
            "quantity": 1
        }
    ]
}');

-- First level modification
UPDATE sales2 
SET sale_details = jsonb_set(sale_details, '{customer}','"Roger Cot Fernandez"'::jsonb)
WHERE id = 2;

-- Second level modification
UPDATE sales2
SET sale_details = jsonb_set(sale_details, '{address, city}','"Bogota"'::jsonb)
WHERE id = 2;

-- 'Third' level modification
UPDATE sales2
SET sale_details = jsonb_set(sale_details, '{products, 1, price}', '10.75'::jsonb)
WHERE id = 2;

INSERT INTO sales2 (sale_date, sale_details)
VALUES ('2023-02-28','{
    "customer": "Borrador",
    "total": 26.75,
    "dni": "6775699LP",
    "address": {
        "description": "6th of August Av.",
        "num": "7B",
        "city": "La Paz"
    },
    "products": [
        {
            "name": "Product 1",
            "price": 10.50,
            "quantity": 2
        },
        {
            "name": "Product 2",
            "price": 5.75,
            "quantity": 1
        }
    ]
}')

-- Delete tuples
DELETE FROM sales2 WHERE id = 3;

-- Delete JSON objects
DELETE FROM sales2
WHERE sale_details ->> 'customer' = 'Borrador';

-- SELECT
SELECT sale.id, sale.sale_date, sale.sale_details
FROM sales2 AS sale;

-- Showing the JSON OBJECT customer key 
-- Array object
SELECT sale.id, 
       sale.sale_date,
       sale.sale_details ->> 'customer' AS customer,
       sale.sale_details -> 'products' -> 0 ->> 'name' AS product
FROM sales2 AS sale;

-- or
SELECT sale.id, 
       sale.sale_date,
       sale.sale_details ->> 'customer' AS customer,
       jsonb_array_element(sale.sale_details -> 'products', 0) ->> 'name' AS product
FROM sales2 AS sale;

-- Object inside an object
SELECT sale.id, 
       sale.sale_date,
       sale.sale_details ->> 'customer' AS customer,
       sale.sale_details -> 'address'->> 'city' AS city,
       sale.sale_details -> 'products' -> 0 ->> 'name' AS product
FROM sales2 AS sale;
