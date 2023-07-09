# JOIN

<sub>Check out [`JOIN.pgsql`](JOIN.pgsql) file to follow the code</sub>

## 1. CROSS JOIN

foto(2)
1. The clause ` CROSS JOIN` works as cartesian product, each tuple of the table A connects with all the tuples of table B, the next tuple of A does the same and so on <sub> OBS: It's not necessary to write the clause, it's implicit</sub>

## 2. NATURAL JOIN

2.1. Firstly, we create 2 tables, `alpha` and `beta`, for the example and we insert the values into them.

foto(3)
2.2. The clause `NATURAL JOIN` only show the tuples where the name of a field of the table A (`alpha`) match with the name of a field of the table B (`beta`) and the domain type and value is thes same, both tables the field named `id` with domain type `INT` and the matches are the id 1, 2 and 3

## 3. INNER JOIN 

foto(4ref2)
3.1. First we select the fields are going to be projected, as there are fields with the same name we have to specify what table are from <sub>**Yellow** color for `persons` table and **Purple** color for `invoices` table </sub>, secondly we have to state what tables will join (`FROM` ... `INNER JOIN`...) and finally we use the clause `ON` to indicate what fields set the join <sub> **Blue** color </sub>

foto(4ref2c2)
3.2. At the former example (3.1) we searched for the customers that have bought something, now we want to know what they purcharsed, therefore we need the same sentence as before (3.1.) <sub>**Yellow** color</sub> , once we got the person with a invoice we searche for the deatils of the invoice at the `invoice_items` table, we need the `invoice_id` that match with the `id` of the `invoices` table <sub>**Orange** table </sub> with another `INNER JOIN` with `invoice_items`, finally with the `product_id` we can figure out what's the product name at the `products` table <sub>**Purple** and **Blue** color </sub> using the third `INNER JOIN` on the `products` table 

## 4. LEFT, RIGHT & FULL JOIN

foto(4ref2)
4.1. `LEFT JOIN`: This clause show the the matching relations <sub>**Yellow** and **Orange** color </sub> and all the values from the 'left' table ,whether they have a match or not, in this case `persons` <sub>**Purple** color </sub>

4.2. `RIGHT JOIN`: The same as `LEFT JOIN` but exchanging the tables postions at the code

foto(9ref)
4.3. `FULL JOIN` match all the tuples with the same value at the `ON` clause, in this case the `id`, if some `id` it's not matched in the other table the output of that tuple on that field will be **NULL**