-- GROUPINGS

-- 1. We create some tables for the grouping exercise

-- Products
    CREATE TABLE products (
        id UUID DEFAULT gen_random_uuid() NOT NULL,
        product_name VARCHAR(30) NOT NULL,
        price NUMERIC (10,2) NOT NULL,
        CONSTRAINT products_id_pk PRIMARY KEY (id),
        CONSTRAINT products_product_name_uk UNIQUE (product_name)
    );

    -- Invoice
    CREATE TABLE invoices (
        id UUID DEFAULT gen_random_uuid() NOT NULL,
        invoice_date DATE DEFAULT NOW() NOT NULL,
        person_id UUID NOT NULL,
        CONSTRAINT invoices_id_pk PRIMARY KEY (id),
        CONSTRAINT invoices_person_id_fk FOREIGN KEY (person_id)
        REFERENCES persons (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT

    );

    -- Invoice detail
    CREATE TABLE invoice_items (
        id UUID DEFAULT gen_random_uuid() NOT NULL,
        invoice_id UUID NOT NULL,
        product_id UUID NOT NULL,
        price NUMERIC(10,2) NOT NULL,
        quantity INT DEFAULT 1 NOT NULL,
        CONSTRAINT invoice_items_id_pk PRIMARY KEY (id),
        CONSTRAINT invoice_items_invoice_id_fk FOREIGN KEY (invoice_id)
        REFERENCES invoices (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
        CONSTRAINT invoice_items_product_id_fk FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
    );

    -- We insert data to products table
    INSERT INTO products VALUES
    (DEFAULT, 'RICE', 12.31),
    (DEFAULT, 'POTATOE', 1.44),
    (DEFAULT, 'MEAT', 20);

    -- We insert data to invoices table 
    INSERT INTO invoices (person_id) VALUES ('95347e00-b76e-4f66-aecc-53a088b7dc96') RETURNING id;
    INSERT INTO invoice_items
    VALUES (DEFAULT, '415e7128-f10e-41f3-9ae1-b768aa633015', 'f64a8366-402a-4017-afe6-bdcd2febdf1b', 14.11, 2),
           (DEFAULT, '415e7128-f10e-41f3-9ae1-b768aa633015', '66c32759-5403-46d3-9dd2-6ce25bdd6894', 1.44, 1),
           (DEFAULT, '415e7128-f10e-41f3-9ae1-b768aa633015', '360f4101-9795-4932-bb5b-dd38e765a1ff', 21, 3);

    INSERT INTO invoices (person_id) VALUES ('4a1dd58c-f92c-4f66-a1e3-5d2b4f106610') RETURNING id;
    INSERT INTO invoice_items
    VALUES (DEFAULT, '449bd001-af85-459f-87fe-db5e5469312f', '66c32759-5403-46d3-9dd2-6ce25bdd6894', 1.44, 3),
           (DEFAULT, '449bd001-af85-459f-87fe-db5e5469312f', '360f4101-9795-4932-bb5b-dd38e765a1ff', 21, 12);
        
    INSERT INTO invoices (person_id ) VALUES ('57b801a9-4b8a-4ec7-b67b-05521f82f8f4') RETURNING id;
    INSERT INTO invoice_items
    VALUES (DEFAULT, '3d36ed0b-7763-4fc7-b7df-760736748e58', 'f64a8366-402a-4017-afe6-bdcd2febdf1b', 14.11, 1),
           (DEFAULT, '3d36ed0b-7763-4fc7-b7df-760736748e58', '66c32759-5403-46d3-9dd2-6ce25bdd6894', 1.44, 5);
   
    INSERT INTO invoices (person_id) VALUES ('3ad620df-5273-4f97-97fd-04e6e490609b') RETURNING id;
    INSERT INTO invoice_items
    VALUES (DEFAULT, '8ea50813-ce35-4510-9b22-b6abc5f03721', '66c32759-5403-46d3-9dd2-6ce25bdd6894', 2, 5);

    INSERT INTO invoices (person_id) VALUES ('39cbe6ce-9858-4d5f-9d91-e81f63bc31c9') RETURNING id;
    INSERT INTO invoice_items
    VALUES (DEFAULT, '36ecba43-0669-4b53-97ec-33edb56e9c32', 'f64a8366-402a-4017-afe6-bdcd2febdf1b', 14.11, 1),
            (DEFAULT, '36ecba43-0669-4b53-97ec-33edb56e9c32', '66c32759-5403-46d3-9dd2-6ce25bdd6894', 1.44, 12);

-- 2. Groupings query

-- 2.1. DISTINCT query the information distinguishing the projection

SELECT DISTINCT last_name, first_name FROM persons;

--2.2 GROUP BY
-- Must contain the projected fields except for the functions 
SELECT last_name, first_name
FROM persons
GROUP BY last_name,first_name;

-- Queries with FUNCTIONS
SELECT last_name, COUNT(*) AS quantity -- Instead of * you can use 1
FROM persons
GROUP BY last_name;

SELECT last_name, COUNT(updated_at) AS quantity
FROM persons
GROUP BY last_name;

-- Answering questions with SQL

-- Total price of the first invoice

SELECT * FROM invoice_items 
WHERE invoice_id = '415e7128-f10e-41f3-9ae1-b768aa633015';

SELECT SUM(price * quantity) AS total_price
FROM invoice_items
WHERE invoice_id = '415e7128-f10e-41f3-9ae1-b768aa633015';

-- Ans: 92.66

-- Total price of all invoices, grouped by invoice_id

SELECT invoice_id, SUM(price * quantity) AS total_price
FROM invoice_items
GROUP BY invoice_id
ORDER BY total_price;

-- How much has the customer Roger Cot bought?
SELECT * FROM persons;
-- 95347e00-b76e-4f66-aecc-53a088b7dc96

SELECT * FROM invoices
WHERE person_id = '95347e00-b76e-4f66-aecc-53a088b7dc96';

SELECT SUM(price * quantity) AS whole_purcharse
FROM invoice_items
WHERE invoice_id IN (SELECT id FROM invoices
WHERE person_id = '95347e00-b76e-4f66-aecc-53a088b7dc96');

-- Ans: 92.66

-- How much has the customer Yeneth B bought?
-- 4a1dd58c-f92c-4f66-a1e3-5d2b4f106610

SELECT SUM(price * quantity) AS whole_purcharse
FROM invoice_items
WHERE invoice_id IN (SELECT id FROM invoices 
WHERE person_id = '4a1dd58c-f92c-4f66-a1e3-5d2b4f106610');

-- Ans: 256.32

-- Most selling product vs least selling product in quantity and value

SELECT product_id, SUM(quantity) AS total_quantity, SUM(price*quantity) sale
FROM invoice_items
GROUP BY product_id
ORDER BY sale;

-- HAVING
-- Is like WHERE but by register GROUPS:

-- Which customer has done more purcharses? 1 invoice = 1 purcharse

INSERT INTO invoices (person_id) VALUES ('95347e00-b76e-4f66-aecc-53a088b7dc96');

SELECT person_id, COUNT(*) AS quantity
FROM invoices
GROUP BY person_id
HAVING COUNT(*) >= 2;

-- LIMIT & OFFSET
-- Allows you limit the amount of returned registers, paginate the queries

-- Show the first 3 products

SELECT * FROM invoice_items ORDER BY id LIMIT 3;

-- Show the next 3 products, starting at the 3rd product

SELECT * FROM invoice_items ORDER BY id LIMIT 3 OFFSET 3;



