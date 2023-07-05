# Filter

<sub> Check out [`filters.pgsql`](filters.pgsql) file to follow the code </sub>

## 1. WHERE 
![1 - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/354f225f-34f1-4dd2-bb31-774b76b8a4ed)
1. Comparison between using the `WHERE` command and not using `WHERE`
    - The first one selects all the tuples of the table with any condition of restriction <sub>**Yellow** squares</sub> (there is no `WHERE`)
    - The second one also selects all the tuples of the table but the `WHERE` command restricts the selection with a condition <sub>**Purple** squares </sub>

## 2.Functions
![3](https://github.com/RogerCL24/pgSQL/assets/90930371/25894bbb-c2ca-4b4b-8e9e-f890ba8d693d)

2. We can also use functions in the conditions, notice how `upper(...)` works,
changes all the letters of the string to capital letters, this way you do not need to know how is exactly written

## 3. Comparison operators
![0](https://github.com/RogerCL24/pgSQL/assets/90930371/a15d20df-5445-4f12-93c9-3e22d5b0f094)


<sub> The table `persons` we are working on</sub>

<sub> **Recomendation**: for each of the following figures compare them with this one to better understanding</sub>


![4](https://github.com/RogerCL24/pgSQL/assets/90930371/23f0e76f-d2d5-43c6-8158-06bc45b09f77)

3.1. `>` operator -> Select all the tuples with the string in `first_name` column bigger than **Carola** (integers and other type of data can be compared as well)

![5](https://github.com/RogerCL24/pgSQL/assets/90930371/9e39b723-9c13-41dd-9fa5-34309a8a33f7)

3.2. `<` operator -> Select all the tuples with the string in `first_name` column smaller than **Carola**

![6](https://github.com/RogerCL24/pgSQL/assets/90930371/a5699ae9-cf27-497b-949a-4b608d023951)

3.3. `>=` operator -> Select all the tuples with the string in `first_name` column bigger and equal to **Carola**

![7](https://github.com/RogerCL24/pgSQL/assets/90930371/988d7a5e-cbe9-4a97-9fc7-856d9ee877eb)

3.4. `<=` operator -> Select all the tuples with the string in `first_name` column smaller and equal to **Carola**

![8](https://github.com/RogerCL24/pgSQL/assets/90930371/74989bf3-6588-4d68-920b-bf111b72cf6b)

3.5. `<>` operator -> Select all the tuples with the string in `first_name` column **DIFFERENT** to **Carola**

## 4. Logical operators

![9](https://github.com/RogerCL24/pgSQL/assets/90930371/89b673ae-a8fd-4f29-b38d-3f07c88558c9)

4.1. `AND` operator -> Select all the tuples with the string **Roger** in the `first_name` field <sub>**Purple** square</sub> **AND** with **NULL** in the `updated_at` field <sub> **Yellow** square </sub> 

![10](https://github.com/RogerCL24/pgSQL/assets/90930371/8199781b-1ae2-42f5-8584-b4b78404f472)

4.2. `OR` operator -> Select all the tuples with the string **Roger** in the `first_name`field <sub>**Purple** square</sub> **OR** with **NULL** in the `updated_at` field <sub> **Yellow** square </sub> 

## 5. LIKE & ILIKE

![11](https://github.com/RogerCL24/pgSQL/assets/90930371/4f2609a2-07d8-454a-a96e-da66aa4040bd)

`LIKE` command -> 
- **Place holder**: Select all the tuples with the string **B_NA_A** in the `first_name` field <sub>**Yellow** square</sub>, namely, is selecting all the strings equal to the letters written in the condition, the `_` spaces can be any letter, if there was a **Banala** value at `first_name` field would showed up alongside if there was a **BANALA** value at `first_name` field would showed up with alongside with **Binaia**! <sub>**OBS**: We have to know the length of the word for this one </sub>

![12](https://github.com/RogerCL24/pgSQL/assets/90930371/3dc4aecd-a286-4d04-9a4a-89000d8406c9)

<sub> We insert new tuples with `Ca` starting names to understand it better </sub>
- **Unkown length**: Same as the **Place holder** one, but now we do not know the length of the word we are looking for, therefore we use the `%` simbol, writting it means that we know perfectly a part of the name (Ca) but not the following letters, could be Carla, Cameron or whatever, so we select all the names starting with `Ca` <sub> **Yellow** square </sub> and we do not care the following letters <sub> **Purple** square</sub>

![13](https://github.com/RogerCL24/pgSQL/assets/90930371/015b6002-5a6b-4525-aa73-23aeac1a694c)

`ILIKE` command -> Same as the second type of `LIKE` but now we do not care about case sensitive situations, with `ILIKE` we select the words which has the same letters regardless if it`s capital letter or not

## 6. BETWEEN

![16(1) - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/bd56bad0-9419-4df1-8d07-d1c691febe5e)

<sub> We updated the `birthday` field of the `persons` table to make the example</sub>
6. The `BETWEEN` commands works as a range limitator, therefore we use the `AND` operator, in this example we are looking for the persons with the range of the `birthday` field from 1980-01-01 to 2000-12-31

## 7. IN

![16(2) - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/e657c32a-17ca-48bf-b6bc-622fda423c53)

7.1. `IN` with value: `IN` determines what value is going to be selected, in the example only selects the persons with A and B values in the `last_name` field

![16(3) - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/5f38be13-1c5c-461e-8aeb-617c415d214d)

7.2. `IN` with sub-query: Now the values we are selecting are the ones from `persons_id` of the `jobs` table that are in the `id` field of the `persons` table, the second `SELECT` selects all the `id` field <sub> **Yellow** color</sub> and the `WHERE` + `IN` narrows the set of `persons_id` field to the values that are in the `id` field of the `persons` table <sub> **Purple** color </sub>

## 8. NOT

8. We can see `NOT` in several contexts here we see 2

![18](https://github.com/RogerCL24/pgSQL/assets/90930371/d79d67bc-59a7-4aca-9a2c-aee37578b5ec)

- Simple `NOT`: Select all the tuples which do `NOT` have the value expressed next to it, in this case `NULL`, then we see all the tuples selected have no `NULL` value <sub> **Yellow** square </sub> in the `updated_at` field <sub> **Orange** square </sub> 
![16(2)](https://github.com/RogerCL24/pgSQL/assets/90930371/e497d258-8797-42c3-a0c6-ab2223546ee0)

- `NOT` with sub-query: 
    - First, the second `SELECT` selects all the values from the the `persons_id` of the `jobs` table <sub> **Yellow** square </sub> 
    - Now we select the values from the `id` field of the `persons` table which are already in the `persons_id` field, because there a `IN` command <sub> **Orange** square</sub>
    -Finally with `NOT` we select the values that were not selected formerly from the `id` field <sub> **Purple** square</sub>
