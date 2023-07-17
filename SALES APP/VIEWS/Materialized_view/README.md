# MATERIALIZED VIEW

<sub> Check out [`Mat_view.pgsql`](Mat_view.pgsql) file to follow the code </sub>

## Materialized vs common
Main difference between materialized and common views, the 2 types of views on PostreSQL:

- Common view: This view is the standard for all realtional DB, this view doesn't store the data phsically, but build up the query every time the view is queried,namely, they are always updated. We will use it when we have a complex query structure to make it more simple or when the queries are not quite repetitive.

- Materialized view: This view is particular of PostgreSQL, and unlike the common view the materialized one stores phisically the data <sub> Like the tables</sub> , therefore the query is faster but we need to updated it frequently. The aim is freeze the information and use it's efficiency for repetitive queries.

To prove it we can use this command in your IDE:

```SQL
SELECT pg_relation_filepath(`table_/view_name`);
```
For materialized view or tables the path of their location will be shown in the ouput but for the common view the output will be `NULL`.

## 1. CREATE

### Exercise

**Who is the employee with more sales?**
Show the complete name and number of sales

foto(1ref)
1. First we need the `SELECT` part, it's the difficult one because it will define the view
- We need the ``sales`` and ``employees`` tables, both are linked by the `employee_id` field <sub>**Yellow**</sub>
- Indeed, the more the employee id appears in the `sales` table more sales that person have done, therefore we use the `COUNT` function in `sales` <sub> **Blue** </sub>
- We group the counting with ``GROUP BY`` and the new defined fild as `full_name` <sub> **Purple** </sub>
- Finally we order it descendently and we limit it to 1
The answer is: **Juan González** with **3** sales.

foto(2)
2. Secondly and to end up, we add the ``CREATE MATERIALIZED VIEW`` clause.

## 2. USE

### Common view

foto(3ref)
The usage is exactly like a table. 

### Materialized view

foto(4)
The same as the common view.

## 3. Drawback

foto(5ref)
1. First we update the table ``sales`` inserting more sales done by the employee with id 1, now we have 6 sales <sub> **Yellow** </sub>, but when we select the materializes view ``month_employee`` the field ``total_sales`` is not updated.

foto(6)
2. To update a materialized view we have to use the function,
```SQL
REFRESH MATERIALIZED VIEW view_name
```



