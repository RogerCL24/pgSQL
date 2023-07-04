# PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS
<sub> Check out [`constraints.pgsql`](constraints.pgsql) file to follow the code</sub>

## 1. PRIMARY AND UNIQUE KEY

1.1. First `INSERT` produces **no** errors

-

![4f - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/312cd7e3-762e-444a-a4b2-82b6476fd0eb)

1.2. Second `INSERT` breach the `UNIQUE KEY` constraintment because the attributes `first_name` and `last_name` are constrained to unique values in their domain <sub> **red** square </sub> 
, repeated values of these attributes  cannot exist <sub> **yellow** square </sub>

1.3. Third `INSERT` produces **no** errors <sub> It's not written in the `constraints.pgsql` file, instead we execute the query 2 times with the fourth INSERT</sub>

 -       

![4f - copia (2)](https://github.com/RogerCL24/pgSQL/assets/90930371/2bb29798-12f9-4cec-9915-11d8d7782341)
1.4. 
- Fourth `INSERT` breach the `PRIMARY KEY` constraintment because the attribute `id` is a `PRIMARY KEY` <sub> **Blue** square</sub>
- The value we are inserting in the `id` field is already at the table <sub> **Yellow** square</sub>,
- therefore the constraint defined as `persons_id_pk` restraint us from this alikeness <sub> **Purple** square</sub>

## 2. FOREIGN KEY
-
![4f - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/fbb93a02-638f-4fad-a4df-a8a18bb5e877)
2.1. First `INSERT` produces **no** errors, the field `persons_id` of `jobs` table is referenced by the field `id` of `persons` table <sub> **Yellow** and **Green** squares respectively (is a foreign key) </sub> ,therefore we need a value in `persons_id` that already exists in `id` field and the first `INSERT` meets it <sub>**Blue** square </sub>

2.2. Second `INSERT` breach the `FOREIGN KEY` constraint because the `persons_id` value we are trying to insert it is not at the `id` field of the `persons` table <sub>**Purple** square</sub> 

![1f](https://github.com/RogerCL24/pgSQL/assets/90930371/1b86fe50-a6d8-41ab-8c4e-c31d31a021f5)
2.3. The first `DELETE` produces error because we are trying to delete a tuple that has the value `id` from the `persons` table referencing a `persons_id` value from the `jobs` table <sub>**Blue** square </sub> and with the `ON DELETE RESTRICT` command <sub> line 42 on the code</sub> we constraint all delete actions to the values that are `FOREIGN KEY` and are being referenced

2.4. For that reason the second `DELETE` is correct, the value of the `id` field is not referencing any value of the `persons_id` field from the `jobs` table <sub> color **Yellow**</sub> 
- **IMPORTANT:** They are `FOREIGN KEY` even though the restriction does not affect them, the restriction only works for the values that are referenced <sub> They are in both tables</sub>
