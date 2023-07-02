
# INSERT command

## 1, 2, 3
![persons](https://github.com/RogerCL24/pgSQL/assets/90930371/a2e56bf4-c0ec-4e7a-9b3b-9077e314500c)
1. Insert into specific fields (_attributes_) the `values` of each field -> **first tuple of the sample**
2. Insert into all the fields of the table <sub>OBS: `values` order are not important</sub> -> **second tuple of the sample**
3. Insert into all the fields of the table, but with default `values` -> **third tuple of the sample**
## 3.1
![student1](https://github.com/RogerCL24/pgSQL/assets/90930371/723f4502-a6b1-4823-9d6c-53f03d1aaa4d)

3.1. Same as **3** but we define the default `values` formerly.

## 4
![student2](https://github.com/RogerCL24/pgSQL/assets/90930371/7f78375c-9bd3-4dcd-bbaa-af695d9ce5bd)

4. Insert several tuples at the same time -> **Last 4 tuples of the table**

## 5
![tmp_students](https://github.com/RogerCL24/pgSQL/assets/90930371/06296308-ca16-460e-a8c1-2447762f143b)

5. Insert the foreign key of `tmp_students` table into `students` table referenced attributes
   
## 6
![null](https://github.com/RogerCL24/pgSQL/assets/90930371/0f1a261d-3961-46db-8311-5a26f5a93204)

6. The first insert is feasible but wrong, `id` attribute is a primary key, therefore cannot be **NULL**
  - We define the default `value` of `id` as NOT NULL in order to restraint a fraudulent use
