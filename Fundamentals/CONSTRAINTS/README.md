# PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS
<sub> Check out `constraints.pgsql` file  to follow the code</sub>

## 1. PRIMARY AND UNIQUE KEY

1.1. First INSERT produces **no** errors

![4f - copia](https://github.com/RogerCL24/pgSQL/assets/90930371/312cd7e3-762e-444a-a4b2-82b6476fd0eb)

1.2. Second INSERT breach the UNIQUE KEY because the attributes `first_name` and `last_name` are constrained to unique values in their domain 
