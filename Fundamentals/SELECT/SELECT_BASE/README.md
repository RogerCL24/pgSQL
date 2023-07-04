# SELECT

<sub> Check out [`select.pgsql`](select.pgsql) file to follow the code </sub>

## 1. Constants
![1](https://github.com/RogerCL24/pgSQL/assets/90930371/0feb724b-8eea-4d12-b13f-1a6bc4809c6d)

1. The query returns a constant value (`string`, `int`, `numeric`...)

## 2. Expressions
![2](https://github.com/RogerCL24/pgSQL/assets/90930371/719306fc-5cc0-4624-885f-dd8e2f271f16)

2. The query returns the result of an expression 

## 3. Cast
![3](https://github.com/RogerCL24/pgSQL/assets/90930371/d581c110-c179-46d9-ac7a-94d8ea504fb3)

3. The query returns the result of an expression, notice that we change the type `int` to `numeric`, we can also `change` string to `date` and a bunch more of conversions

## 4. Functions

4. We can use functions in our `SELECT` queries
- now() show us the date in `date` format just the time is executed
- upper(...) convert the sentence inside the (...) to capital letters
- lower(...) the opposite of `upper()`

## 5. Select columns from a table
![4](https://github.com/RogerCL24/pgSQL/assets/90930371/d5588282-7bd5-46ab-9bf6-118bf310f751)

- 5.1. `SELECT *` is selecting all <sub> color **Yellow** </sub> the columns from the table `students` with the `FROM` command
- 
![5](https://github.com/RogerCL24/pgSQL/assets/90930371/7bb78cea-773a-4c6d-acfa-7eb0d4e149c8)

- 5.2. Now `SELECT` is narrowing the set of columns to only 3 <sub> each field with his own color at the ouput of the query</sub>

## 6. Naming columns
![6](https://github.com/RogerCL24/pgSQL/assets/90930371/6341332f-1556-4edb-abfd-a6e6c78018ff)

- 6.1. The output of the query is correct but the last 2 columns <sub> **Blue** and **Purple**</sub> are nameless
- 
![7](https://github.com/RogerCL24/pgSQL/assets/90930371/e1ca0eef-28b8-4290-aa2c-8cda77869f52)

- 6.2. Now we are naming the columns we are selecting with `SELECT`, this columns are called **projection** and you can see that with `AS` command we name them <sub> each field with a color</sub>
