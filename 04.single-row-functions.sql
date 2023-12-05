/* Sección 5: Single Row Functions */

/* Character Functions - Case Conversion Functions */
SELECT lower(first_name), upper(last_name), initcap('this is test string')
FROM employees e
WHERE department_id >= 90;

SELECT region_id, region_name
FROM regions r
WHERE upper(region_name) = 'EUROPE';

SELECT upper(last_name) AS name, department_id
FROM employees e
WHERE last_name LIKE 'A%'
ORDER BY name;

/* Character Functions - Manipulation Functions */
SELECT last_name, first_name, concat(concat(last_name, ' '), first_name) AS "Full Name"
FROM employees e
WHERE department_id >= 110;

SELECT last_name, substr(last_name, 3), substr(last_name, 1, 4) "Partial", substr(last_name,-3, 2) "Last two char", instr(last_name, 's') "Contain's S", length(last_name) "Name length"
FROM employees e
WHERE department_id >= 110;

SELECT last_name, lpad(last_name, 10, '*') AS "LPAD", rpad(last_name, 10, '*') AS "RPAD",
	trim('   Test String    ') AS "TRIM", replace(last_name, 'gg', 'ff') AS "REPLACE"
FROM employees e
WHERE department_id >= 110;

SELECT department_id, department_name, length(department_name) AS "length", substr(department_name, -4, 4) AS "Last four characteres"
FROM departments d
WHERE location_id = 1700
ORDER BY "length" DESC;

SELECT country_id, country_name, replace(country_name, substr(country_name, 1,2), '**') AS "replacing"
FROM countries c;


/* Numeric Functions */
SELECT floor(76.878), ceil(76.878)
FROM dual;

--trunc(76.878, -1), el -1 trunca el dígito entero desde derecha a izq 1 unidad, en este caso el 6 
--y todos los digitos siguientes (decimales), por lo que al truncar con -1 quedaría el 7 de las decenas + el 0
--es decir, quedaría 70
SELECT trunc(76.878, 2), trunc(76.878), trunc(76.878, -1)
FROM dual;

SELECT round(76.878, 2), round(76.878), round(76.878, -1), round(35.55, 1)
FROM dual;

SELECT employee_id, last_name, salary, round(salary * 1.1) AS "New Salary"
FROM employees e
WHERE department_id = 100
ORDER BY salary;


SELECT mod(30, 7), ceil(79.3), floor(34.7)
FROM dual;

/* Date Functions */
/*
 * - sysdate, returns the current date of the operating system on which the database resides.
 * - current_date, returns the current date from the user session.
 * - current_timestamp, returns the current timestamp from the user session.
 */

SELECT sysdate, current_date, current_timestamp
FROM dual;

SELECT sysdate, round(sysdate, 'MONTH'), trunc(sysdate, 'MONTH')
FROM dual;

SELECT sysdate, round(sysdate, 'YEAR'), trunc(sysdate, 'YEAR')
FROM dual;

SELECT sysdate, add_months(sysdate, 5), last_day(sysdate), next_day(sysdate, 'FRIDAY'),
months_between(sysdate, '01-JUN-23')
FROM dual;

SELECT last_name, department_id, (sysdate - hire_date) AS days
FROM employees e
WHERE department_id = 90;

-- sysdate - 1, estamos restando 1 día a la fecha dada por sysdate
SELECT sysdate, sysdate - 1 AS yesterday, sysdate + 1 AS tomorrow
FROM dual;

SELECT last_name, hire_date, add_months(hire_date, 3)
FROM employees e
WHERE department_id = 30;