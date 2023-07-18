# RAISE
<sub> Check out [RAISE.pgsql](RAISE.pgsql) file to follow the code </sub>

## INFO, NOTICE, DEBUG & LOG

### Exercise

Determine the quantity of suppliers
- Print the result in console

foto(1ref)
1. First we create a function called `suppliers_quantity()`, with the variable `ans` and we give a value in the code part (`BEGIN...END;`) with the clause `INTO`, as we see it works <sub> **Yellow** </sub>

2. Finally we add the `RAISE` functions `INFO`, `NOTICE`, `LOG` & `DEBUG`

```sql
CREATE OR REPLACE FUNCTION suppliers_quantity()
    RETURNS INTEGER
    LANGUAGE plpgsql AS
    $$
        DECLARE ans int;
        BEGIN
            SELECT COUNT(supp.supplier_id) INTO ans
            FROM suppliers AS supp;

            RAISE INFO 'Suppliers quantity INFO: %', ans;
            RAISE NOTICE 'Suppliers quantity NOTICE: %', ans;
            RAISE LOG 'Suppliers quantity LOG: %', ans;
            RAISE DEBUG 'Suppliers quantity DEBUG: %', ans;

            RETURN ans;
        END;
    $$;
```
 <sub> The `%` indicates where the var goes </sub>

If we execute the function with
```sql
SELECT suppliers_quantity();
```
the output by console will be the following one

foto(3)
As you can see `INFO` and `NOTICE` display the text in console <sub> **Red**</sub>, they are only informative.

`Log` and `Debug` do not display on the console, `Log` creates a log message in the PostgreSQL log directory and `Debug` display the message when you depure the code


- To check the logs of postgreSQL we have to go to the log directory
> IMPORTANT: ``postgresql.conf`` has to be formerly configured, specifically at the **logging_collector** line if you have it in off turn in to on

foto(4)
- We use the next command in VSCODE or postgreSQL CLI to find the path
```SQL
SHOW data_directory;
```
<sub>**Yellow** </sub>

- Once there we will see a log directory <sub> **Blue**
- Inside of the directory we have a .log file <sub> **Purple**</sub>, which it can only be written and read by the root user <sub> **Orange** </sub>

foto(6)
Finally we can see our log message, this is important to handle auditories

## WARNING & EXCEPTION

