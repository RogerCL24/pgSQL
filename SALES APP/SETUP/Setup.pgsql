CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY NOT NULL, -- You can use UUID as well
    names VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_num VARCHAR(20),
    e_mail VARCHAR(50)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY NOT NULL,
    _names VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_num VARCHAR(20),
    email VARCHAR(50),
    wage NUMERIC(10,2),
    hire_date DATE  
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY NOT NULL,
    _names VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_num VARCHAR(20),
    email VARCHAR(50)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY NOT NULL,
    _names VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY NOT NULL,
    _names VARCHAR(50) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL,
    inventory_quantity INTEGER NOT NULL,
    supplier_id INTEGER REFERENCES suppliers (supplier_id),
    category_id INTEGER REFERENCES categories (category_id)
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY NOT NULL,
    date DATE NOT NULL,
    employee_id INTEGER REFERENCES employees (employee_id),
    customer_id INTEGER REFERENCES customers (customer_id)
);

CREATE TABLE sale_detail (
    sale_id INTEGER REFERENCES sales (sale_id),
    product_id INTEGER REFERENCES products (product_id),
    quantity INTEGER NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (sale_id, product_id)
);

CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY NOT NULL,
    date DATE NOT NULL,
    employee_id INTEGER REFERENCES employees (employee_id),
    customer_id INTEGER REFERENCES customers (customer_id),
    sale_id INTEGER REFERENCES sales (sale_id)
);

CREATE TABLE shipping (
    shipping_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    state VARCHAR(100) NOT NULL,
    employee_id INTEGER REFERENCES employees (employee_id),
    customer_id INTEGER REFERENCES customers (customer_id)
);

CREATE TABLE shipping_detail (
    shipping_id INTEGER REFERENCES shipping (shipping_id),
    product_id INTEGER REFERENCES products (product_id),
    quantity INTEGER NOT NULL,
    shipping_adress VARCHAR(100) NOT NULL,
    shipping_charge NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (shipping_id, product_id)
);

INSERT INTO customers (names, last_name, address, phone_num, e_mail)
VALUES ('Jason','Philips', '123 street, X city ','555-1234','jason.philips@example.com'),
       ('Marilyn','García', 'Principal avenue, Y city ','555-5678','marilyn.garcia@example.com'),
       ('Charles','González', '456 street, Z city ','555-9012','charles.gonzalez@example.com'),
       ('Lavender','Hernández', 'Central avenue, A city ','555-3456','lavender.hernandez@example.com'),
       ('Loyd','Martínez', '789 street, B city ','555-7890','loyd.martinez@example.com');


INSERT INTO employees (_names, last_name, address, phone_num, email, wage, hire_date)
VALUES ('Juan', 'González', '123 street, City', '555-1234', 'juan.gonzalez@example.com', 3000.00, '2020-01-15'),
       ('María', 'Rodríguez', 'Principal av., Neighbourhood', '555-5678', 'maria.rodriguez@example.com', 3500.00,
        '2019-05-22'),
       ('Pedro', 'López', '45 street, Sector', '555-9012', 'pedro.lopez@example.com', 2800.00, '2021-02-28'),
       ('Ana', 'Martínez', 'Central av., Urbanitzation', '555-3456', 'ana.martinez@example.com', 3200.00, '2018-11-10'),
       ('Luis', 'Sánchez', '67 street, Set', '555-7890', 'luis.sanchez@example.com', 4000.00, '2022-01-01');

INSERT INTO suppliers (_names, address, phone_num, email)
VALUES ('Electronic products supplier', '123 Technologic Av., Col. Center, Mexico City', '55-1234-5678',
        'sales@supplier.com'),
       ('Food distributor', '456 5th of May street, Col. Juárez, Guadalajara', '33-9876-5432',
        'sales@supplier.com'),
       ('Textile manufacturer', 'Road to Toluca Km. 17, Toluca', '722-234-5678', 'contact@manufacturer.com'),
       ('Sporting goods wholesaler', '789 Constitution Av., Col. Center Zone, Monterrey', '81-3456-7890',
        'sales@wholesaler.com'),
       ('Industrial supply company', '321 Reform street, Col. Center, Puebla', '222-876-5432',
        'sales@supplies.com');

INSERT INTO categories (_names)
VALUES ('Electronic'),
       ('Clothes'),
       ('Home'),
       ('Food'),
       ('Jewelry');

INSERT INTO products(_names, description, price, inventory_quantity, supplier_id, category_id)
VALUES ('Laptop HP', 'High end laptop with i7 processor and 16GB RAM', 1200.00, 10, 2, 1),
       ('Epson printer', 'Multifunctional printer with Wi-Fi', 400.00, 20, 1, 2),
       ('Wireless mouse', 'Wireless mouse with ergonomic design', 20.00, 50, 3, 3),
       ('USB keyboard', 'Waterproof USB keyboard', 15.00, 30, 4, 3),
       ('Samsung monitor', '27 inches LED Monitor', 350.00, 15, 2, 1);

INSERT INTO sales (date, employee_id, customer_id)
VALUES ('2022-01-15', 1, 3),
       ('2022-02-01', 2, 4),
       ('2022-02-10', 1, 2),
       ('2022-03-05', 3, 1),
       ('2022-03-12', 2, 5);

INSERT INTO sale_detail (sale_id, product_id, quantity, price)
VALUES (1, 1, 1, 1200.00),
       (1, 2, 2, 400.00),
       (2, 3, 1, 20.00),
       (2, 4, 1, 15.00),
       (3, 5, 1, 350.00),
       (4, 1, 2, 1200.00),
       (4, 2, 1, 400.00),
       (5, 3, 3, 20.00),
       (5, 4, 2, 15.00),
       (5, 5, 1, 350.00);

INSERT INTO invoices(date, employee_id, customer_id, sale_id)
VALUES ('2022-01-15', 1, 3, 1),
       ('2022-02-01', 2, 4, 2),
       ('2022-02-10', 1, 2, 3),
       ('2022-03-05', 3, 1, 4),
       ('2022-03-12', 2, 5, 5);

INSERT INTO shipping (date, state, employee_id, customer_id)
VALUES ('2022-01-10', 'pending delivery', 2, 3),
       ('2022-02-05', 'on the way', 1, 5),
       ('2022-02-25', 'on the way', 3, 4),
       ('2022-03-10', 'on the way', 2, 2),
       ('2022-03-20', 'pending delivery', 4, 1),
       ('2022-04-05', 'pending delivery', 1, 3),
       ('2022-04-15', 'pending delivery', 3, 5),
       ('2022-05-01', 'delivered', 4, 2),
       ('2022-05-20', 'delivered', 2, 1),
       ('2022-06-05', 'delivered', 1, 4);

INSERT INTO shipping_detail (shipping_id, product_id, quantity, shipping_adress, shipping_charge)
VALUES (1, 1, 1, '123 Principal av.', 20.00),
       (1, 2, 2, '456 North street', 30.00),
       (2, 4, 1, '789 south av.', 80.00),
       (3, 3, 3, '321 East street', 15.00),
       (3, 5, 2, '654 West av.', 40.00);

