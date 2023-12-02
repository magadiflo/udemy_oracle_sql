/* Sección 2: Using SELECT statement to retrieve data */

/* 1. Write a query to display the employee last name, salary, department id, 
 * anual salary (which is salary multiplied by 12), commission pct, 
 * commission pct * salary for all employees
 * */
SELECT
    last_name,
    salary,
    department_id,
    salary * 12,
    commission_pct,
    commission_pct * salary
FROM
    employees e;

-- 2. Concatenación
SELECT last_name || ' ' || first_name AS "employee name"
FROM employees e;

-- 3. Literales: Se repiten en cada fila. En el select de abajo vemos dos literales
-- 1000 y This is test
SELECT last_name, 1000 AS "Col1", 'This is test' "Col2"
FROM employees e;

-- 4. DISTINCT keyworkd
SELECT DISTINCT job_id
FROM employees;

-- 5. Describe command
DESCRIBE regions;
