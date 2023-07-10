CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY NOT NULL, -- You can use UUID as well
    _names VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_num VARCHAR(20),
    email VARCHAR(50)
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