-- 1. Update information

-- UPDATE table
-- SET field1 = value1, field2 = value2, ..., fieldN = valueN
-- WHERE fieldM = valueM;
UPDATE persons
SET first_name = 'Gouda', last_name = 'Lada'
WHERE id = '6a8ea745-0ca2-4fa6-af5f-cbe47870c29b';

UPDATE persons
SET available = FALSE;

-- 2. Delete information

-- DELETE FROM table WHERE fieldM = valueM
DELETE FROM persons
WHERE id IS null; -- DO NOT USE =

DELETE FROM persons WHERE id = '64ce24ff-24d7-4e48-8f48-4ac62c1ed4f6';

-- TRUNCATE TABLE table
TRUNCATE TABLE persons;