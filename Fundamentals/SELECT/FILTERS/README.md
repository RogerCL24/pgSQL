# Filter

<sub> Check out [`filters.pgsql`](filters.pgsql) file to follow the code </sub>

## 1. WHERE 
foto

1. Comparison between using the `WHERE` command and not using `WHERE`
    - The first one selects all the tuples of the table with any condition of restriction <sub>**Yellow** squares</sub> (there is no `WHERE`)
    - The second one also selects all the tuples of the table but the `WHERE` command restricts the selection with a condition <sub>**Purple** squares </sub>

## 2.Functions
foto
2. We can also use functions in the conditions, notice how `upper(...)` works,
changes all the letters of the string to capital letters, this way you do not need to know how is exactly written

## 3. Comparison operators
foto(0)
<sub> The table `persons` we are working on</sub>
<sub> **Recomendation**: for each of the following figures compare them with this one to better understanding</sub>
foto
3.1. `>` operator -> Select all the tuples with the string in `first_name` column bigger than **Carola** (integers and other type of data can be compared as well)

foto
3.2. `<` operator -> Select all the tuples with the string in `first_name` column smaller than **Carola**

foto
3.3. `>=` operator -> Select all the tuples with the string in `first_name` column bigger and equal to **Carola**

foto
3.4. `<=` operator -> Select all the tuples with the string in `first_name` column smaller and equal to **Carola**

foto
3.5. `<>` operator -> Select all the tuples with the string in `first_name` column **DIFFERENT** to **Carola**

## 4. Logical operators

foto
4.1. `AND` operator -> Select all the tuples with the string **Roger** in the `first_name` field <sub>**Purple** square</sub> **AND** with **NULL** in the `updated_at` field <sub> **Yellow** square </sub> 

foto
4.2. `OR` operator -> Select all the tuples with the string **Roger** in the `first_name`field <sub>**Purple** square</sub> **OR** with **NULL** in the `updated_at` field <sub> **Yellow** square </sub> 

## 5. LIKE & ILIKE

foto
`LIKE` command -> 
- **Place holder**: Select all the tuples with the string **B_NA_A** in the `first_name` field <sub>**Yellow** square</sub>, namely, is selecting all the strings equal to the letters written in the condition, the `_` spaces can be any letter, if there was a **Banala** value at `first_name` field would showed up alongside if there was a **BANALA** value at `first_name` field would showed up with alongside with **Binaia**! <sub>**OBS**: We have to know the length of the word for this one </sub>

foto(12)
<sub> We insert new tuples with `Ca` starting names to understand it better </sub>
- **Unkown length**: Same as the **Place holder** one, but now we do not know the length of the word we are looking for, therefore we use the `%` simbol, writting it means that we know perfectly a part of the name (Ca) but not the following letters, could be Carla, Cameron or whatever, so we select all the names starting with `Ca` <sub> **Yellow** square </sub> and we do not care the following letters <sub> **Purple** square</sub>

foto(13)
`ILIKE` command -> Same as the second type of `LIKE` but now we do not care about case sensitive situations, with `ILIKE` we select the words which has the same letters regardless if it`s capital letter or not

## 6. BETWEEN

foto(16.1c)
<sub> We updated the `birthday` field of the `persons` table to make the example</sub>
6. The `BETWEEN` commands works as a range limitator, therefore we use the `AND` operator, in this example we are looking for the persons with the range of the `birthday` field from 1980-01-01 to 2000-12-31

## 7. IN

foto(16.2c)
7.1. `IN` with value: `IN` determines what value is going to be selected, in the example only selects the persons with A and B values in the `last_name` field

foto(16.3c)
7.2. `IN` with sub-query: Now the values we are selecting are the ones from `persons_id` of the `jobs` table that are in the `id` field of the `persons` table, the second `SELECT` selects all the `id` field <sub> **Yellow** color</sub> and the `WHERE` + `IN` narrows the set of `persons_id` field to the values that are in the `id` field of the `persons` table <sub> **Purple** color </sub>

## 8. NOT

8. We can see `NOT` in several contexts here we see 2

foto(18)
- Simple `NOT`: Select all the tuples which do `NOT` have the value expressed next to it, in this case `NULL`, then we see all the tuples selected have no `NULL` value <sub> **Yellow** square </sub> in the `updated_at` field <sub> **Orange** square </sub> 
foto(16.2)
- `NOT` with sub-query: 
    - First, the second `SELECT` selects all the values from the the `persons_id` of the `jobs` table <sub> **Yellow** square </sub> 
    - Now we select the values from the `id` field of the `persons` table which are already in the `persons_id` field, because there a `IN` command <sub> **Orange** square</sub>
    -Finally with `NOT` we select the values that were not selected formerly from the `id` field <sub> **Purple** square</sub>