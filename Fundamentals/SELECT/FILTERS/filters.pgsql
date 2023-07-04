-- Filters
-- WHERE (field, operator, value), example: WHERE first_name = 'Roger'

SELECT * FROM persons
WHERE first_name = 'Roger';

-- Functions
SELECT * FROM persons 
WHERE upper(first_name) = 'YENETH';

-- Comparison operators
-- = 

-- >
SELECT * FROM persons 
WHERE upper(first_name) > 'CAROLA';

-- <
SELECT * FROM persons 
WHERE upper(first_name) < 'CAROLA';

-- >=
SELECT * FROM persons 
WHERE upper(first_name) >= 'CAROLA';

-- <=
SELECT * FROM persons 
WHERE upper(first_name) <= 'CAROLA';

-- <>
SELECT * FROM persons 
WHERE upper(first_name) <> 'CAROLA';

-- AND & OR
SELECT * FROM persons 
WHERE updated_at IS NULL and first_name = 'Roger';

SELECT * FROM persons
WHERE updated_at IS NULL OR first_name = 'Roger';

-- LIKE with place holder (we know the length)
SELECT * FROM persons
WHERE upper(first_name) LIKE 'B_NA_A';

INSERT INTO persons VALUES 
(gen_random_uuid(), 'Carlos', 'A', now(), now(), DEFAULT),
(gen_random_uuid(), 'Carla', 'B', now(), now(), DEFAULT),
(gen_random_uuid(), 'Carmen', 'U', now(), now(), DEFAULT),
(gen_random_uuid(), 'Calopio', 'L', now(), now(), DEFAULT);

-- We do no know the length
SELECT * FROM persons
WHERE first_name LIKE 'Ca%';

-- ILIKE
SELECT * FROM persons
WHERE first_name ILIKE 'ca%';


-- BETWEEN 
SELECT * FROM persons 
WHERE birthday 
BETWEEN '1980-01-01' AND '2000-12-31';

-- IN VALUE
SELECT * FROM persons
WHERE last_name IN ('B','A');

-- IN SELECT
SELECT * FROM jobs
WHERE persons_id IN (SELECT id FROM persons); 

SELECT * FROM persons
WHERE id IN (SELECT persons_id FROM jobs);

-- NOT
SELECT * FROM jobs WHERE updated_at IS NOT NULL;

SELECT * FROM persons
WHERE id NOT IN (SELECT persons_id FROM jobs);