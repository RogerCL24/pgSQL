# PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS
<sub> Check out `constraints.pgsql` file  to follow the code</sub>

## 1. PRIMARY AND UNIQUE KEY

1.1. First INSERT produces **no** errors

-

![4f - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/312cd7e3-762e-444a-a4b2-82b6476fd0eb)

1.2. Second INSERT breach the `UNIQUE KEY` constraintment because the attributes `first_name` and `last_name` are constrained to unique values in their domain <sub> **red** square </sub> 
, repeated values of these attributes  cannot exist <sub> **yellow** square </sub>

1.3. Third INSERT produces **no** errors <sub> It's not written in the `constraints.pgsql` file, instead we execute the query 2 times with the fourth INSERT</sub>

 -       

![4f - copia (2)](https://github.com/RogerCL24/pgSQL/assets/90930371/2bb29798-12f9-4cec-9915-11d8d7782341)
1.4. 
- Fourth INSERT breach the `PRIMARY KEY` constraintment because the attribute `id` is a `PRIMARY KEY` <sub> **Blue** square</sub>
- The value we are inserting in the `id` field is already at the table <sub> **Yellow** square</sub>,
- therefore the constraint defined as `persons_id_pk` restraint us from this alikeness <sub> **Purple** square</sub>

