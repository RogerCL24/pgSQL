# Ordering 

<sub> Check out [`ordering.pgsql`](ordering.pgsql) file to follow the code </sub>

## 1. Order the output by number
foto 
1.1. We use the command `ORDER BY` followed by the number of the column to indicate the column will be ordered <sub>**Yellow** color</sub> and in which form <sub> ASC or DESC </sub>. as the default mode is ASC the column has been ordered ascendently, notice the `<` operator at the table 

foto
1.2. Same statement that `1.1.` but now we define the order of the column 2 as descendent with `DESC` command <sub>**Blue** square</sub>, compare it with `1.1.` figure

foto
1.3. Now we use nested orders
- The first one orders the 3rd column descendently and the tuple which has the same value <sub>like `Yeneth` and `Carla`</sub> use the next column order stated to tiebreak, in this case the column 5 <sub>**Green** color</sub>

## 2. Order the output by name 
foto
2. The same as `1.1.` format but instead of the number of the column we use the name of the column <sub> **Yellow** color </sub>

