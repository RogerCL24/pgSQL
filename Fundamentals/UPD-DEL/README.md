# UPDATE & DELETE DATA

<sub> Check out `UPD-DEL.pgsql` file  to follow the code</sub>

## 1. UPDATE, SET, WHERE
![first](https://github.com/RogerCL24/pgSQL/assets/90930371/00c6be9c-d82b-4737-8949-e4e574a0f02b)
<sub>before / after </sub>

1.1. `SET` set the attribute (column) value by Gouda (in **first_name** column) and Lada (in **last_name** column) of all the tuples with the `WHERE` condition, `UPDATE` deletes the tuple and creates another one, for that reason is the last one after the query.

![second](https://github.com/RogerCL24/pgSQL/assets/90930371/a4d9a8a7-e839-4325-bb1c-5bb50c158e85)
<sub>before / after </sub>

1.2. Now there is no `WHERE` condition, therefore all the tuples will suffer the update in the column named at the `SET` statement

## 2. DELETE TABLE'S DATA
![third](https://github.com/RogerCL24/pgSQL/assets/90930371/0c7eb9e7-f2a0-4f2a-9f74-2690967fa3ab)
<sub>before / after </sub>

2.1. `DELETE` deletes the tuples which meets the condition stated in `WHERE` <sub>OBS: we use `IS` command **NOT** `=` because null is not a value</sub>

![5](https://github.com/RogerCL24/pgSQL/assets/90930371/86c9a4df-1d49-40b0-af16-5afce37f6071)
<sub>before / after </sub>

2.2. `DELETE` deletes all the tuples with the `WHERE` condition even those which should be a `PRIMARY KEY` (**CONSTRAINTS** folder)

![6](https://github.com/RogerCL24/pgSQL/assets/90930371/6e1e0caf-a4bc-43ab-b87b-58d90558a870)
<sub>before / after </sub>

2.3. `TRUNCATE` deletes the extension scheme from de table (all the tuple), **not the table**
