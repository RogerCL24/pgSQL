# SELECT

<sub> Check out [`select.pgsql`](select.pgsql) file to follow the code </sub>

## 1. Constants
foto
1. The query returns a constant value (`string`, `int`, `numeric`...)

## 2. Expressions
foto
2. The query returns the result of an expression 

## 3. Cast
foto
3. The query returns the result of an expression, notice that we change the type `int` to `numeric`, we can also `change` string to `data` and a bunch more of conversions

## 4. Functions

4. We can use functions in our `SELECT` queries
- now() show us the date in `date` format just the time is executed
- upper(...) convert the sentence inside the (...) to capital letters
- lower(...) the opposite of `upper()`

# 5. Select columns from a table
foto
- 5.1. `SELECT *` is selecting all <sub> color **Yellow** </sub> the columns from the table `students` with the `FROM` command
foto
- 5.2. Now `SELECT` is narrowing the set of columns to only 3 <sub> each field with his own color at the ouput of the query</sub>

# 6. Naming columns
foto
- 6.1. The output of the query is correct but the last 2 columns <sub> **Blue** and **Purple**</sub> are nameless 

foto
- 6.2. Now we named the columns we are selecting with `SELECT`, this columns are called **projection** and you can see that with `AS` we name them <sub> each field with a color</sub>