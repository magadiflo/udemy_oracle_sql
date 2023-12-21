/* Sección 10: SET Operators
 * 
 * 
 * Los operadores de conjuntos combinan los resultados de dos consultas de componentes en un solo resultado.
 * Las consultas que contienen operadores de conjuntos se denominan consultas compuestas.
 *  */

/* Set Operators: UNION / UNION ALL 
 * 
 * UNION, retorna la unión de ambas consultas, pero elimina duplicados.
 * UNION ALL, retorna la unión de ambas consultas incluyendo los duplicados.
 * */

CREATE TABLE retired_employees(
	id NUMBER(6) NOT NULL PRIMARY KEY,
	last_name VARCHAR2(25) NOT NULL
);

INSERT INTO retired_employees(id, last_name)
VALUES(1, 'Martín');
INSERT INTO retired_employees(id, last_name)
VALUES(2, 'Abel');

SELECT last_name
FROM employees
UNION
SELECT last_name
FROM retired_employees;

SELECT last_name
FROM employees
UNION ALL
SELECT last_name
FROM retired_employees;

SELECT job_id, department_id
FROM employees e
WHERE department_id = 10
UNION ALL
SELECT job_id, department_id
FROM employees e
WHERE department_id = 20
UNION ALL
SELECT job_id, department_id
FROM employees e
WHERE department_id = 90;

SELECT job_id, department_id
FROM employees e
WHERE department_id IN (10, 20, 90);



/* Set Operators: INTERSECT / MINUS 
 * 
 * 
 * INTERSECT, retorna datos comunes entre dos consultas.
 * MINUS, retorna datos que existen en la primera consulta pero que no existen 
 * en la segunda consulta.
 */

SELECT e.employee_id, e.job_id
FROM employees e
INTERSECT
SELECT jh.employee_id, jh.job_id
FROM job_history jh;

SELECT department_id
FROM departments d
MINUS
SELECT department_id
FROM employees e
ORDER BY department_id;

SELECT last_name, job_id, to_date(hire_date) AS "hiredate"
FROM employees e
UNION
SELECT last_name, to_char(null) AS "job_id", to_date(null) AS "hiredate"
FROM retired_employees re;


SELECT l.location_id, l.city, l.street_address
FROM locations l
MINUS
SELECT d.location_id, l2.city, l2.street_address
FROM departments d 
	INNER JOIN locations l2 ON(d.location_id = l2.location_id);

SELECT e.employee_id, e.job_id
FROM employees e
INTERSECT
SELECT employee_id, job_id
FROM job_history jh

