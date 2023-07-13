# Basic clauses

<sub> Check out [`CreInUpDeSe.pgsql`](CreInUpDeSe.pgsql) file to follow the code</sub>

## CREATE
We create the table as we always do and we specify the new data type on the domain like `JSONB`

## INSERT

foto(1)
To insert a JSON object into the table we use the common way of `INSERT INTO` ... `VALUES` ...  and in the JSON data type column we specify the keys and values inside the `{}`, you can create an other JSON object inside like the `address` key or an array like `products` key

## UPDATE

foto(1c)
- Simple key: At the `SET` clause we use the function `jsonb_set` followed by a `()` where we specify first the location of the key into the `'{}'` and next to it the new value casted by `::jsonb`

foto(2)
- Nested key: Same as the first one but add a new key at the `'{first key, nested key}'`

foto(3)
- Array key: Same as the former one but instead of a key we use the index of the array and then the key 

## DELETE 

foto(9ref)
There are two ways to delete a tuple where is a JSON object inside, the traditional way with `WHERE` and an specific value like the id, or using the operator `->>` which access to the value of that key in text format

## SELECT

foto(5)
- This first way is correct but difficult to interpret

foto(7)
- Now we use the operators `->>` and `->` to access to scpecific keys of the JSON object, notice that if it's an array we point to the index and then the key we want to show

foto(8)
- Finally to access to a nested key, `city` in this case, is important to access to the father key with the `->` operator, because unlike the `->>` operator, `->` give us the real value and with `->>` we change that value to a text format more legible


