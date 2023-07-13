# Basic clauses

<sub> Check out [`CreInUpDeSe.pgsql`](CreInUpDeSe.pgsql) file to follow the code</sub>

## CREATE
We create the table as we always do and we specify the new data type on the domain like `JSONB`

## INSERT

![1](https://github.com/RogerCL24/pgSQL/assets/90930371/db99b89c-61fd-49f4-99f0-36d24ce2aa73)
To insert a JSON object into the table we use the common way of `INSERT INTO` ... `VALUES` ...  and in the JSON data type column we specify the keys and values inside the `{}`, you can create an other JSON object inside like the `address` key or an array like `products` key

## UPDATE

![1 - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/949604ad-49a9-464e-9fd5-a5acfd4a085b)
- Simple key: At the `SET` clause we use the function `jsonb_set` followed by a `()` where we specify first the location of the key into the `'{}'` and next to it the new value casted by `::jsonb`

![2](https://github.com/RogerCL24/pgSQL/assets/90930371/e57c607e-410c-4bab-89f1-a52e7be705a2)
- Nested key: Same as the first one but add a new key at the `'{first key, nested key}'`

![3](https://github.com/RogerCL24/pgSQL/assets/90930371/c6c30e0b-6965-491d-b96d-973501ceb30c)
- Array key: Same as the former one but instead of a key we use the index of the array and then the key 

## DELETE 

![9ref](https://github.com/RogerCL24/pgSQL/assets/90930371/103acd76-c66b-40f1-8a3f-4a167bd50ce4)
There are two ways to delete a tuple where is a JSON object inside, the traditional way with `WHERE` and an specific value like the id, or using the operator `->>` which access to the value of that key in text format

## SELECT

![5](https://github.com/RogerCL24/pgSQL/assets/90930371/4dbce3e9-f406-4653-b1ff-4a0f621cbef7)
- This first way is correct but difficult to interpret

![7](https://github.com/RogerCL24/pgSQL/assets/90930371/268afd88-8204-41cd-953b-4126d63f3c8f)
- Now we use the operators `->>` and `->` to access to specific keys of the JSON object, notice that if it's an array we point to the index and then the key we want to show

![8](https://github.com/RogerCL24/pgSQL/assets/90930371/5b8abdba-45a3-48dd-8078-4aad0428fa52)
- Finally to access to a nested key, `city` in this case, is important to access to the father key with the `->` operator, because unlike the `->>` operator, `->` give us the real value and with `->>` we change that value to a text format that is more legible


