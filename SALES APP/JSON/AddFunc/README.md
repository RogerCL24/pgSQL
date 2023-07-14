# Functions

![1e](https://github.com/RogerCL24/pgSQL/assets/90930371/900d22a6-e3fa-42bf-a094-7b0f3fca32e3)
We only use the `SUM` function but the procedure is the same for `AVG`,`MIN`,`MAX` and `COUNT`

## Exercise 1
### Get the total price of all products

![x - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/aee4a05a-f96e-4fb8-a043-29e8f00b5086)
The `total` key contains the total price of the products the person/tuple has bought, we only need to execute a sum with the values of that key with the `->>` operator

## Exercise 2
### Get the max value from total OBJECT

![x - copia (2)](https://github.com/RogerCL24/pgSQL/assets/90930371/bbb1a989-9a1c-4732-b541-9424c5a144f8)
Same as the last one but using the `MAX` funciton

## Exercise 3
### Sum of the real object price

![x](https://github.com/RogerCL24/pgSQL/assets/90930371/6edc69b3-c97c-4252-8fc0-c2e79529f668)
To get the real price of each product we have to access to the `products` array with the `json_array_elements` in the `FROM` clause, then in the `SELECT` clause use the defined array as `product_detail` (in this case) and sum all the values of the `price` key<sub> **Purple**</sub>
