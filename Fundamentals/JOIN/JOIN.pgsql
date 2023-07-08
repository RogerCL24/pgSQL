-- Register counter of our tables

SELECT COUNT(*) FROM invoices;
SELECT COUNT(*) FROM invoice_items;

-- CROSS JOIN without using the JOIN clause
SELECT *
FROM invoice_items, invoices; -- The order is not important

-- CROSS JOIN using the JOIN clause
SELECT *
FROM invoice_items CROSS JOIN invoices; -- Same result as BEFORE

-- NATURAL JOIN
-- Filter the table A with the table B relation with the same field name
CREATE TABLE alpha (
    id INT NOT NULL,
    description VARCHAR(50) NOT NULL,
    CONSTRAINT alpha_id_pk PRIMARY KEY (id)
);

CREATE TABLE beta (
    id INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    CONSTRAINT beta_id_fk FOREIGN KEY (id)
    REFERENCES alpha (id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
);



-- Information poblation
INSERT INTO alpha VALUES (1,'UNO'), (2,'DOS'),(3,'TRES'), (4,'CUATRO');
INSERT INTO beta VALUES (1, 'ONE'), (2, 'TWO'), (3, 'THREE');

SELECT * FROM alpha NATURAL JOIN beta; --Same name and domain type (uuid, bool...)

-- INNER  JOIN
    -- Invoice headers
SELECT persons.id, persons.first_name, persons.last_name, 
persons.birthday, invoices.invoice_date
FROM persons
INNER JOIN invoices
ON persons.id = invoices.person_id;

    -- Invoice detail
    SELECT persons.id, persons.first_name, persons.last_name, 
    persons.birthday, invoices.invoice_date,
    products.product_name, invoice_items.price,
    invoice_items.quantity, 
    (invoice_items.price * invoice_items.quantity) AS total
    FROM persons
    INNER JOIN invoices
    ON persons.id = invoices.person_id
    INNER JOIN invoice_items
    ON invoices.id = invoice_items.invoice_id
INNER JOIN products
ON products.id = invoice_items.product_id;

-- Show all the users even though they have not bought yet
-- LEFT JOIN
SELECT first_name, last_name, invoice_date
FROM persons LEFT JOIN invoices 
ON persons.id = invoices.person_id;

-- RIGHT JOIN
SELECT first_name, last_name, invoice_date
FROM invoices RIGHT JOIN persons 
ON persons.id = invoices.person_id;

-- FULL JOIN 
CREATE TABLE gama (
    id INT NOT NULL,
    description VARCHAR(50) NOT NULL,
    CONSTRAINT gama_id_pk PRIMARY KEY (id)
);

INSERT INTO gama VALUES (1, 'ONE'), (2, 'TWO'), (3, 'THREE'), (5,'FIVE'), (6, 'SIX');

SELECT * FROM alpha
FULL JOIN gama
ON alpha.id = gama.id;



