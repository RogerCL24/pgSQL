
CREATE VIEW product_discounts AS
SELECT prod._names AS product, 
       prod.price AS price, 
       supp._names AS supplier,
       supp.email AS email,
       cat._names AS category
FROM products AS prod
INNER JOIN suppliers AS supp 
ON supp.supplier_id = prod.supplier_id
INNER JOIN categories AS cat
ON cat.category_id = prod.category_id;

CREATE OR REPLACE VIEW product_discounts AS
SELECT prod._names AS product, 
       prod.price AS price, 
       supp._names AS supplier,
       supp.email AS email,
       cat._names AS category,
       (
        CASE cat._names
            WHEN 'Electronic' THEN '8%'
            WHEN 'Home' THEN '5%'
            ELSE '1%'
        END
       ) AS discounts,
       (
        CASE cat._names
            WHEN 'Electronic' THEN price * 0.92
            WHEN 'Home' THEN price * 0.95
            ELSE price * 0.99
        END
       ) AS discounted_price
FROM products AS prod
INNER JOIN suppliers AS supp 
ON supp.supplier_id = prod.supplier_id
INNER JOIN categories AS cat
ON cat.category_id = prod.category_id;



