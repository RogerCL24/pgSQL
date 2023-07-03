-- Create person table
-- ID, first name, last, name, age, birthday, available  
CREATE TABLE persons (
    id UUID,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    age SMALLINT,
    birthday DATE,
    available BOOL
);

-- Create work table
-- ID, person ID, initial date, final date, current
CREATE TABLE jobs (
    id UUID,
    persons_id UUID,
    init_date DATE,
    final_date DATE,
    currently bool
);

-- Delete the age attribute from persons table
 ALTER TABLE persons DROP COLUMN age;

 -- Add the attribute "job name" to the jobs table 
 ALTER TABLE jobs ADD COLUMN job_name VARCHAR(40);

 -- Create a table that we are going to DELETE
 CREATE TABLE to_delete (
    id serial,
    budget BIGINT
 );

 DROP TABLE to_delete;
