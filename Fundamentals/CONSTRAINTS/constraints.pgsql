-- Primary key, unique key and foreign key constraints 
DROP TABLE IF EXISTS persons;
DROP TABLE IF EXISTS jobs;

-- 1. Primary and unique KEY

-- Create the table with constraints 
CREATE TABLE persons (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    birthday DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT persons_id_pk PRIMARY KEY (id),
    CONSTRAINT persons_first_name_last_name_uk UNIQUE (first_name, last_name)
);

-- Insert data
INSERT INTO persons 
VALUES (DEFAULT, 'Roger', 'Cot', now(), DEFAULT, NULL);

-- Breach the UK constraint
INSERT INTO persons 
VALUES (DEFAULT, 'Roger', 'Cot', now(), DEFAULT, NULL);

-- Breach the PK constraint
INSERT INTO persons 
VALUES ('4ab73685-fd9c-4955-a115-71a868aa17cf', 'Jose', 'Chavez', now(), DEFAULT, NULL);

-- 2. foreign key

CREATE TABLE jobs (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    persons_id UUID NOT NULL,
    job_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT jobs_id_pk PRIMARY KEY (id),
    CONSTRAINT jobs_persons_id_fk FOREIGN KEY (persons_id) REFERENCES persons (id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT 
);

INSERT INTO jobs 
VALUES (DEFAULT ,'95347e00-b76e-4f66-aecc-53a088b7dc96', 'Professor',DEFAULT, DEFAULT);

-- Error
INSERT INTO jobs 
VALUES (DEFAULT ,'12357e00-b76e-4f66-aecc-53a088b7dc96', 'Professor',DEFAULT, DEFAULT);

-- Attempt to delete 'persons' table information
DELETE FROM persons
WHERE id = '95347e00-b76e-4f66-aecc-53a088b7dc96'; --Roger

DELETE FROM persons
WHERE id = '4ab73685-fd9c-4955-a115-71a868aa17cf'; --Jose


