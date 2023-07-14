# Multiple JSON objects

![1](https://github.com/RogerCL24/pgSQL/assets/90930371/c62de506-d1e1-4851-aa20-bec9c92afdfa)
The aim of this section is the substitution, we use JSON objects instead of more tables in order to compact the information, this way we take advantatge of JSONB data type.

In the example we only need to access the `description` column with the operators and if it's an array we use the `jsonb_array_elements()` function, in this case is the array of the `opts` column.

We could used the table ``description`` with columns ``name``, ``price`` and `category` and another table `opts` with a column `size`,`color`... But instead we used only 1 table with 2 JSON objects.

