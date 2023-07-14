# Multiple JSON objects

foto(1)
The aim of this section is the substitution, we use JSON objects instead of more tables in order to compact the information, this way we take advantatge of JSONB data type.

In the example we only need to access the `description` column with the operators and if it's an array we use the `jsonb_array_elements()` function, in this case is the array of the other column `opts`.

We could used the table ``description`` with columns ``name``, ``price`` and `category` and another table `opts` with a column `size`,`color`... But instead we used only 1 table with 2 JSON objects

