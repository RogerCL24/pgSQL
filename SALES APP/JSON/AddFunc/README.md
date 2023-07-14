# Functions

foto(1e)
We only use the `SUM` function but the procedure is the same for `AVG`,`MIN`,`MAX` and `COUNT`

## Exercise 1
### Get the total price of all products

foto(xc)
The `total` key contains the total price of the products the person/tuple has bought, we only need to execute a sum with the values of that key with the `->>` operator

## Exercise 2
### Get the max value from total OBJECT

foto(xc2)
Same as the last one but using the `MAX` funciton

## Exercise 3
### Sum of the real object price

foto(x)
To get the real price of each product we have to access to the `products` array with the `json_array_elements` in the `FROM` clause, then in the `SELECT` clause use the defined array as `product_detail` (in this case) and sum all the values of the `price` key<sub> **Purple**</sub>
