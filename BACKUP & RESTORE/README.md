# BACKUP & RESTORE

## BACKUP
Create a directory or use the directory `/var/backups` of your local computer

```
pg_dump -d tddinc -f bkup-20230709.sql -O -v -h 127.0.0.1 -p 5432 -U postgres -W 

```
- -d dbname -> Name of the data base we are going to backup, in my case `tddinc`

- -f file -> Name the file that takes the output of the backup, we use `.sql` because is a plain text and we can read it with a text editor

- -O -> Set the backup in no-owner mode, in order to restore the DB with no need of the user owner (because you might backup the DB with another user)

- -v -> Verbose mode give us feedback of the proces of dumping the file specified before

- -h -> Specifies the host giving the host name if you want to do the backup on a server or your local net 

- -p -> Specifies TCP port the server is listening for connections

- -U -> Name the user which will do the backup 

- -W -> Force `pg_dump` to prompt for a password before connecting to a database (must configure pg_hba.conf)

Once you execute the command in the prompt of your CLI,it will generate a `file_name`.sql file which you can read with nano, vim or any text editor.
This file contains, overall, a title, which version of PostgreSQL was used, start date of the backup, required variables to generate the backup, the code with the clauses used to generate the DB backup like `CREATE TABLE ...`       <sub>**Without constraints**</sub> and instead of `INSERT` the command `pg_dump` use by default the clause `COPY` which is faster than `INSERT`,
then with the `ALTER TABLE ONLY` starts to add the constraintments to the tables 

**IMPORTANT**: This is only an example, therefore depending on your needs you will need different flags in the command

## RESTORE

There are few ways to restore the DB, here we will explain only one:

- First, you have to connect to your DB server through your CLI in the same directory you have de .sql file

```
psql postgres postgres
```

- Second, create a user

```
CREATE USER user_name PASSWORD user_password;
```

- Third,  create a DB with `user_name` as owner

```
CREATE DATABASE db_name OWNER user_name;
```

- Connect to `db_name` with the user `user_name`

```
\c db_name user_name
```
- Restore the DB 

```
\i $PATH/file_name.sql
```

To check the updates in the DB you have to leave with `\q` and enter again, then list the relations with `\d` metacommand
