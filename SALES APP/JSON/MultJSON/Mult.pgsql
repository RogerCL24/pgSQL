-- Multiple JSON objects

CREATE TABLE products2 (
    id SERIAL PRIMARY KEY NOT NULL,
    description JSONB NOT NULL,
    opts JSONB NOT NULL     -- options
);

INSERT INTO products2 (description, opts)
VALUES ('{"name":"Lenovo LED screen","price":2000.99,"category":"Electronics"}',
        '{"size":["13 inches","17 inches","27 inches"],"color":["black","white","blue"]}');

SELECT prod.description ->> 'name' AS name,
       prod.description ->> 'price' AS price,
       jsonb_array_elements(prod.opts -> 'size') AS size
FROM products2 AS prod;