# Functions
<sub> Check out [`Functions.pgsql`](Functions.pgsql) file to follow the code </sub>

> We are going to use the view created at [VIEWS](../../VIEWS/Common_view/Std_view.pgsql)

## Single row function (SRF)
 SRFs operates in single rows, they execute in each row of the query, therefore return one result for row.

 There are different types of functions:

 - **Mathematics**: _ABS_, _ROUND_, _TRUNC_, _CEIL_ and _FLOOR_
 - **String**: _CONCAT_, _SUBSTRING_, _LENGTH_, _LOWER_, _UPPER_, _INITCAP_ and _TRIM_
 - **Date and hour**: _CURRENT_DATE_, _DATE_PART_, _TO_DATE_, _TO_CHAR_ and _AGE_
 - **Conversion**: _CAST_
> Check out the use of each function [https://www.tutorialspoint.com/sql_certificate/using_single_row_functions.htm](https://www.tutorialspoint.com/sql_certificate/using_single_row_functions.htm)

### EXERCISE
Given the product_discounts VIEW:
- Convert in uppercase the CATEGORY field
- Add 2 decimals to the DISCOUNTED_PRICE field

![1](https://github.com/RogerCL24/pgSQL/assets/90930371/9ee36bcb-6265-4799-bf10-c1d7a781bcc5)
We will use the `UPPER` function in the category field defining what field we want to convert in capital 
letters inside the `()` <sub>**Yellow**</sub> and the `CAST` function at the `discounted_price` field, we can use `CAST` 
in 2 ways, the one showed at the figure `::NUMERIC(d,r)`<sub>**Purple**</sub>, where d is the total digits nº and r is the range of
decimals, and the other way is `CAST(field, NUMERIC(d,r))`, both are equal.

## User defined function (UDF)
UDFs are created and implemented by the DBA or a user with privileges

### EXERCISE 
Create a function that allows you validate the product price
- Prices under 10.00 are not allowed (company policies)

![2](https://github.com/RogerCL24/pgSQL/assets/90930371/b262a289-d3fa-4c3a-8529-ae8e0844f8dc)
1. First we will show you a super basic function:

- Initially, we use `CREATE FUNCTION`
- Following that, the name of the function <sub> **Purple** </sub>
- Now it would come the parameters, but this function is so simple that it has not parametres
- Next, we define the data type we will return (all the UDFs return a value) <sub>Otherwise we use `VOID`</sub> with the clause 
`RETURNS` <sub> **Orange** </sub>
- Then we define the language we are using to implement the function <sub> **Green**</sub> in our case is 
postgreSQL but you can use Pyhton, Tcl or Perl, if you want to use another PL you can 
search for it in the PostgreSQL extensions
- After that we open and close the function implementation space with this keys`$$...$$;`
- Inside of that keys first we declare the variables <sub> Here we have not stated anyone </sub> and then
we start coding the logical part of the function, indeed between the `BEGIN...END;` clauses

![3](https://github.com/RogerCL24/pgSQL/assets/90930371/b0c1ab6d-3650-45b6-ad88-7fb1a92c4a78)
2. Now we can implement the function in order to complete the exercise

Differences with the former function:
- Firstly we added a ``NUMERIC`` parameter <sub> **Yellow** </sub> stated as price, so
```SQL
CREATE FUNCTION function_name (parameter_name DATA_TYPE, ...)
```
- Secondly, before the ``BEGIN`` we stated a local variable ``answer`` with the clause ``DECLARE`` and 
also we initialized it with the _false_ value <sub> **Green**</sub>
- Finally we added the necessary code to achieve the exercise ended up with a `RETURN` clause 
<sub> **Orange**</sub>

As you can see it works, _12.00_ is greater than _10.00_ so the output of the query is true <sub> **Purple** </sub>

## USE 

For the use example we are going to create a function with the same funcionality as the 
``discounted_price`` field in the `product_discounts` view to make it more clean.

![5](https://github.com/RogerCL24/pgSQL/assets/90930371/056fd42f-07f4-4380-a880-7474ed67cee9)
- First we create the function using the same pattern as the former functions we created and then 
we add the code 

![6](https://github.com/RogerCL24/pgSQL/assets/90930371/35bf417a-b9a5-4a15-8fcf-8dfa73917764)
- Finally we only need to substitute the former field definition by the created function 
`calc_discount` <sub> **Yellow** </sub>, giving the proper fields as parameters

> **Observation**: you can use this clause to delete a function
```SQL
DROP FUNCTION function_name();
```




