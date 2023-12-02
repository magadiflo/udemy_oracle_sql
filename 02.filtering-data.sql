/* Sección 3: Filtering Data */


-- 1. Filtrado de datos
/**
 * Nota: Character strings are enclosed within single quotation marks.
 * Nota: Character values are case-sensitive.
 */

SELECT last_name, job_id, department_id 
FROM employees e
WHERE department_id = 80;

SELECT * 
FROM regions r
WHERE region_name = 'Europe';

SELECT * 
FROM regions r
WHERE region_name = 'europe';

SELECT last_name, job_id, department_id, hire_date 
FROM employees e
WHERE hire_date = '21-jun-2007';

SELECT last_name, department_id
FROM employees e
WHERE employee_id = 176;

SELECT *
FROM countries c
WHERE country_name = 'India';

SELECT location_id, street_address, city
FROM locations l
WHERE location_id = 1000;

SELECT department_id, department_name, manager_id 
FROM departments d
WHERE department_name = 'Marketing';

-- 2. Operadores de comparación
/**
 * %, representa cero o más caracteres
 * _, represente un caracter
 */

SELECT *
FROM departments d
WHERE department_id BETWEEN 30 AND 100;


-- Diferente: <> ó !=
SELECT *
FROM departments d
WHERE department_id != 10;

SELECT *
FROM departments d
WHERE location_id IN (1800, 2700);

SELECT * 
FROM employees e
WHERE last_name LIKE 'M%';

SELECT last_name, salary, department_id 
FROM employees e
WHERE last_name LIKE '_i%';

SELECT last_name, job_id, department_id
FROM employees e
WHERE job_id LIKE 'IT%';

SELECT last_name, salary, commission_pct
FROM employees e
WHERE commission_pct IS NULL;

-- Práctica de los operadores de comparación
SELECT last_name, salary
FROM employees e
WHERE salary > 16000;

SELECT last_name, salary
FROM employees e
WHERE salary BETWEEN 11000 AND 14000;

SELECT last_name, salary
FROM employees e
WHERE commission_pct IS NOT NULL;

SELECT department_name, manager_id, location_id
FROM departments d
WHERE department_id IN(10, 20, 50);

SELECT first_name, last_name, department_id
FROM employees e
WHERE first_name LIKE '__s%';


-- 3. Operadores lógicos
SELECT last_name, job_id, salary, department_id
FROM employees e
WHERE department_id = 100 AND salary >= 12000;

SELECT last_name, job_id, salary, department_id
FROM employees e
WHERE department_id = 100 OR salary >= 12000;

SELECT *
FROM employees e
WHERE job_id = 'SA_REP' AND commission_pct IS NOT NULL;

-- Práctica de los operadores lógicos
SELECT last_name || ' ' || first_name AS "Full Name", hire_date, department_id
FROM employees e
WHERE hire_date >= to_date('2008-01-01', 'YYYY-MM-DD') 
	AND hire_date <= to_date('2008-12-31', 'YYYY-MM-DD');

SELECT last_name || ' ' || first_name AS "Full Name", hire_date, department_id
FROM employees e
WHERE extract(YEAR FROM hire_date) = 2008;