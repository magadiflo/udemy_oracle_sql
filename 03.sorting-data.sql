/* Sección 4: Sorting Data */

-- 1. Sorting Data
-- -------------------------------------------------------------------------
SELECT employee_id, last_name, department_id, salary
FROM employees
WHERE department_id IN (10, 40, 90)
ORDER BY department_id DESC, salary, employee_id DESC;

-- 2. Row Limiting Clause
-- -------------------------------------------------------------------------
SELECT employee_id, last_name, salary
FROM employees e
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY; -- mostrará¡ solo las 5 primeras filas

SELECT employee_id, last_name, salary
FROM employees e
ORDER BY employee_id
OFFSET 4 ROWS FETCH NEXT 2 ROWS ONLY; -- de los resultados totales que nos dará, que omita los 4 primeros y muestre recién las 2 filas siguientes

SELECT department_id, department_name
FROM departments d
WHERE location_id = 1700
ORDER BY department_id
OFFSET 3 ROWS FETCH NEXT 4 ROWS ONLY; -- Retornar 4 filas después de saltarse las 3 primeras

-- 3. Substitution Variables (&)
-- -------------------------------------------------------------------------
/**
 * - &variable, una variable inicia con & y si ejecutamos la consulta con SQL Developer
 *   nos mostrará¡ una ventana para ingresar el valor a la variable. Si dicha variable la 
 *   reutilizamos en la consulta más de una vez, SQL Developer nos mostrará la ventana por 
 *   cada repetición.
 * - &&variable, una variable con dos &&, hará que las demás variables con un & que se llamen
 *   igual que dicha variable, el SQL Developer ya no vuelva a pedir sus valores, sino más
 *   bien que la reutilice. Incluso si vuelve a ejecutar la consulta por segunda vez, SQL Developer
 *   ya no le volverá a pedir ingresar el valor.
 */
SELECT last_name, job_id, salary, department_id
FROM employees e
WHERE department_id = &depid;

SELECT last_name, hire_date, &col
FROM employees e
WHERE &col = 24000
ORDER BY &col;

SELECT last_name, hire_date, &&col
FROM employees e
WHERE &col = 24000
ORDER BY &col;

-- 4. Define and Verify Commands
-- -------------------------------------------------------------------------
/**
 * DEFINE, command used to create and assign value to a variable in Oracle SQL
 * UNDEFINE, command used to remove the variable Oracle SQL
 * SET VERIFY ON, is used to force SQL Developer to display the text of a command
 * before and after it replaces substitution variables with values
 */

DEFINE v_employee_id = 100
SET VERIFY ON

SELECT employee_id, last_name, job_id, salary, department_id
FROM employees e
WHERE employee_id = &v_employee_id;

UNDEFINE v_employee_id;

-- Práctica
-- ----------------------------------------------------------------------------
SELECT employee_id, last_name, salary, department_id, manager_id
FROM employees
WHERE department_id = &v_department_id;

SELECT employee_id, last_name, salary, department_id, manager_id
FROM employees
WHERE department_id = &v_department_id
ORDER BY &column;

SET VERIFY ON
SELECT employee_id, last_name, salary, department_id, manager_id
FROM employees
WHERE department_id = &v_department_id
ORDER BY &column;


