-- INSERT data

-- 1. INSERT INTO table (field1, ..., fieldN) VALUES (value1, ..., valueN)
INSERT INTO persons (id, first_name, last_name, birthday, available)  -- Can be unordered
VALUES (gen_random_uuid(), 'Roger', 'Cot', '2006-06-26', True); -- But values must have the same order that fields

-- 2. INSERT INTO table VALUES (value1, ..., valueN)
INSERT INTO persons VALUES (gen_random_uuid(), 'Yeneth', 'Gamiton', '2000-01-04', False);

-- 3. INSERT INTO table VALUES (default, valueN, ..., valueZ)
INSERT INTO persons VALUES (DEFAULT, 'Collie', DEFAULT, DEFAULT, False);

-- 3.1 Default values
CREATE TABLE students (
    id UUID DEFAULT gen_random_uuid(),
    first_name VARCHAR(50),
    is_active BOOL DEFAULT true,
    created_at TIMESTAMP DEFAULT now()
);

-- With 3rd option
INSERT INTO students VALUES (DEFAULT, 'Jessie', DEFAULT, DEFAULT);

-- With 1st option
INSERT INTO students (first_name) VALUES ('Bolfeigh');

-- 4. INSERT INTO table VALUES (valueA1, ...,valueAN),(valueB1, ..., valueBN)
INSERT INTO students VALUES 
(DEFAULT, 'Zayd', DEFAULT, DEFAULT),
(DEFAULT, 'Connor', DEFAULT, DEFAULT),
(DEFAULT, 'Gareth', DEFAULT, DEFAULT),
(DEFAULT, 'Leo', DEFAULT, DEFAULT);

-- 5. INSERT INTO table SELECT your-query

CREATE TABLE tmp_students (
    f_name VARCHAR(50),
    active BOOL
);

INSERT INTO tmp_students VALUES
('copper', True),
('silver', False),
('gold', True);

INSERT INTO students (first_name, is_active)
SELECT f_name, active FROM tmp_students;

-- 6. Null data
INSERT INTO students VALUES (NULL, NULL, NULL, NULL);

DROP TABLE students;

CREATE TABLE students (
    id UUID DEFAULT gen_random_uuid() NOT NULL,  -- primary key cannot be NULL
    first_name VARCHAR(50) NOT NULL,
    is_active BOOL NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP
);

INSERT INTO students VALUES (DEFAULT, 'Roger', TRUE, DEFAULT, DEFAULT)

-- Now it is not possible  
INSERT INTO students VALUES (NULL, NULL, NULL, NULL);
