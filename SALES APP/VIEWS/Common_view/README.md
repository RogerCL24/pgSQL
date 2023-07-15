# Standard VIEW

<sub> Check out [`Std_view.pgsql`](Std_view.pgsql) file to follow the code </sub>

# Exercise
Apply a discount to the products depending on the category they are, if it's:

- Electronics -> 8 %
- Home -> 5 %
- The rest -> 1 %

Furthermore, create a report with:

- Product name, base price and the new price applying the discount
- Moreover, the supplier name and their email
- Finally, the categories and discounts

For this exercise we only need 3 tables, `products`, `categories` and `suppliers`.

The purpose of the view is give an easy and fast structure to query with information already queried by the view, this is useful for complex and repetitives queries where the information we query always is the same.

![MOTHER](https://github.com/RogerCL24/pgSQL/assets/90930371/cc8d5732-6d49-4af5-9dc1-600e59b83659)

1. To create a view we use the `CREATE VIEW` clause and `SELECT` with the columns we want to show in the view of each table, is like a table but reduced and it's not phisically in the disk (is a virtual table), to bind the table we use the `INNER JOIN` clause with the resembled columns (`ON` ...).

Summing up, the columns we select in order to answer the exercise are:

- From ``products`` the names and the price <sub> **Yellow** </sub>
- From ``categories`` the names <sub> **Green** </sub>
- From ``suppliers`` the names and the email <sub> **Purple** </sub>


2. Using the former query structure, we just need to add the discount and the new price to complete the exercise.

![3](https://github.com/RogerCL24/pgSQL/assets/90930371/13346e0e-356b-4442-8d07-6a9c8d7beb7d)
At the `SELECT` clause we add 2 new columns:
- `discounts`: We use the CASE function <sub> Same usage as the `switch` command in other PL like pyhton </sub>
- `discounted_price`: We use the same method as before 

