# GROUPING

<sub> Check out [`setout.pgsql`](setout.pgsql) file to follow the code </sub>

##  1. SETOUT

1.1. Firstly we create the `products`, `invoices` and `invoice_items` tables in order to prepare the environment for the examples

1.2. Finally, we just insert the data into the proper tables

## 2. DISTINCT & GROUP BY

2.1. `DISTINCT` commmand -> 

![1 - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/dd62f411-4a11-4d3e-b893-6d195ed7d40f)
- This command selects all the tuples that has no repeated value in the field we are projecting, in this case is `last_name` <sub> **Yellow** color </sub> and as you can see there are 2 B's in this field at the `persons` table <sub> **Purple** color</sub> and only selects 1 of those

![1 - copia (2)](https://github.com/RogerCL24/pgSQL/assets/90930371/b9decd66-2a00-4ba4-9170-c0206deaaf83)
- Now we are selecting 2 fields `first_name` and `last_name` <sub> **Yellow** square</sub>, and now the 2 B's tuples are different because of the `first_name` field <sub> **Purple** color</sub> 

2.2. `GROUP BY` commmand -> 

![4](https://github.com/RogerCL24/pgSQL/assets/90930371/1ee20a30-885e-4eb5-9bd1-648459b881be)
- In this case `GROUP BY` works alike as `DISTINCT`, we are grouping the tuples depending on `last_name` and `first_name` fields, as you can see any tuple is repeated, therefore the query show all the registers

- Functions:
  
    ![1 - copia (3)](https://github.com/RogerCL24/pgSQL/assets/90930371/2af7feef-4ce0-483a-b158-3b7514198503)
    - `COUNT(*)`: This command count the amount of tuples with the same value at the `last_name` field <sub>**Blue** square</sub>, due to the `GROUP BY` command 

   ![1 - copia (4)](https://github.com/RogerCL24/pgSQL/assets/90930371/bd5940ba-6f34-4337-8a3a-d448e41854df)
    - `COUNT(field_name)`: In this case we the field `updated_at` to count <sub>**Yellow** color</sub>, but all the values are **NULL**, therefore equals to 0, if one of the     B's had some non-null value we could see a 1 at the `quantity` field of the B tuple at the output

## 3. Answering questions w/ new commands

3.1. Total price of the first invoice ->

![8ref - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/4fbff878-3416-42c0-b666-b645ffcbfa91)
- First we select the details of the **first invoice** <sub>**Yellow** color</sub> (because they contain the price), with `WHERE` we are specifying the `invoice_id` we are looking for <sub>**Orange** color</sub>

![8ref2 - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/3bcb94b9-f830-4763-88d0-3cf05420ac52)
- Finally we execute the same statement but selecting the **sum** of the **prodcut** between the field `price` and `quantity` with the function `SUM` <sub> **Purple** color </sub> (there are `MIN`, `MAX` and `AVG` functions as well)

So the answer is: **92.66**

3.2. Total price of all invoices, grouped by invoice_id -> 

![8ref2 - copia (2)](https://github.com/RogerCL24/pgSQL/assets/90930371/6bf1312e-f72c-4ce4-83ff-96b89745a6b9)
- We only need to select the `invoice_id` field cause the grouping has to be with this field according to the statement <sub>**Yellow** color</sub>, after that we sum the total price of each invoice <sub> every invoice equals to another one has the same color and I forgot to write the green one, sorry for that</sub>

3.3. How much has the customer Roger Cot bought? -> 

- Firstly, we need the id from the customer in order to have the `person_id` value for the `WHERE` condition, we can do that executing a `SELECT *` query to the persons table

![8ref](https://github.com/RogerCL24/pgSQL/assets/90930371/e60ae633-bc03-4a86-8a29-828751c5ce01)
-  For the next step we will do a sub-query selecting the id value from the `id` field of the `invoices` table <sub>**Orange** color </sub>, obviously with the `person_id` equals to the customer <sub>**Yellow** color </sub>, following the main query the `invoice_id` has to be **IN** the `id` selected of the former sub-query <sub>**Purple** color</sub>, the last step is sum the product of the price and quantity values of that tuples <sub>**Blue** color</sub>

So the answer is: **92.66**

<sub>We do the same question for Yeneth the sol. is: **256.32**</sub>

![8ref2 - copia (4)](https://github.com/RogerCL24/pgSQL/assets/90930371/112e729b-d403-444f-9461-16ea6021450a)
3.4. Most selling product vs least selling product in quantity and value -> 

- Seems complicated but it is not that hard, first of all, we need to select the important fields to answer the question, namely, `product_id` to identificate the most/least selled product <sub>**Yellow** square</sub>, the sum of the quantity of each product and the total value/price of that product using the `SUM` on both, as you can see for each color there is a product and their respective quantity and value, therefore

- The most selled in quantity is the **Purple** product
- The least selled in quantity is the **Blue** product
- The most selled in value is the **Orange** product
- The least selled in value is the **Purple** product


3.5. Which customer has done more purcharses? If 1 invoice = 1 purcharse

![14ref](https://github.com/RogerCL24/pgSQL/assets/90930371/3d51066d-5940-4a67-9576-eb12666129be)
As we want to know what customer is, we select the `person_id` field <sub> **Yellow** color</sub> and we group by it<sub>**Orange** color</sub>. The table we are selecting the information is `invoices`, so the more times your id (`person_id` field) appears in the table more purcharse you have done, therefore we use the COUNT(*) function, but we do not want to show the customers who has only 1 purcharse, for that reason we limit the ``COUNT`` for at least 2 times with the ``HAVING`` command, if you only appear 1 time in the ``invoices`` table you are not going to be showed at the query output<sub>**Purple** color </sub>

## 4. LIMIT & OFFSET

4.1. Basically now we can paginate the registers (tuples) -> 

![15ref - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/8dd66e39-edab-400b-945c-8ab6adf8d30c)
- LIMIT: As you can see ``LIMIT`` limits the number of registers to the first 3 <sub>**Yellow** color </sub>

![15ref](https://github.com/RogerCL24/pgSQL/assets/90930371/5ff05342-f81c-4459-b409-513c54a1fb18)
- LIMIT + OFFSET: Now if we combine `OFFSET` with ``LIMIT`` the query output starts on the following register indicated at the ``LIMIT`` command, in this case number 3 <sub>**Yellow** color </sub> so the next one is number 4 and the next 2 <sub> **Green** color</sub> because the page is of 3 registers, indicated at the ``OFFSET`` command 



