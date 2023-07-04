# Ordering 

<sub> Check out [`ordering.pgsql`](ordering.pgsql) file to follow the code </sub>

## 1. Order the output by number
![1](https://github.com/RogerCL24/pgSQL/assets/90930371/54a21039-e844-4cde-9d01-977b6ae53b99)

1.1. We use the command `ORDER BY` followed by the number of the column to indicate the column will be ordered <sub>**Yellow** color</sub> and in which form <sub> ASC or DESC </sub>, as the default mode is ASC the column has been ordered ascendently, notice the `<` operator at the table 

![2](https://github.com/RogerCL24/pgSQL/assets/90930371/a6aa4d8b-408a-4f95-abf8-d5e9b4c1b934)

1.2. Same statement that `1.1.` but now we define the order of the column 2 as descendent with `DESC` command <sub>**Blue** square</sub>, compare it with `1.1.` figure

![3](https://github.com/RogerCL24/pgSQL/assets/90930371/b7c83164-492c-4cf2-8b94-75e6e15b373e)

1.3. Now we use nested orders
- The first one orders the 3rd column descendently and the tuple which has the same value <sub>like `Yeneth` and `Carla`</sub> use the next column order stated to tiebreak, in this case the column 5 <sub>**Green** color</sub>

## 2. Order the output by name 
![4](https://github.com/RogerCL24/pgSQL/assets/90930371/3fc46c4c-8807-4b6d-99e5-fb95e11e343d)

2. The same as `1.1.` format but instead of the number of the column we use the name of the column <sub> **Yellow** color </sub>

