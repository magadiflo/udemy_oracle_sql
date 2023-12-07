/* Sección 07: Gropu Functions */

/* Using Group Functions 
 * 
 * - Retorna un resultado por un grupo o conjunto de filas
 * - Todos los group functions ignoran los valores nulos
 * - Para incluir valores nulos podemos usar la función NVL con funciones de grupo
 * */
SELECT min(salary) "MIN", max(salary) "MAX", sum(salary) "SUM", round(avg(salary), 2) AS "AVG", count(*) "COUNT"
FROM employees e
WHERE department_id = '100';

SELECT count(department_id) AS "TOTAL"
FROM departments d
WHERE location_id = 1700;

/* Distinct and null values in group functions */
SELECT count(distinct job_id) 
FROM employees e;

SELECT avg(commission_pct)
FROM employees e;

SELECT sum(commission_pct), count(commission_pct), sum(commission_pct)/ count(commission_pct), avg(commission_pct)
FROM employees e;

SELECT avg(nvl(commission_pct, 0)), count(employee_id)
FROM employees e;

SELECT distinct(department_id) 
FROM employees e;


/* Using the GROUP BY clause */
SELECT department_id, max(salary) "Salario_maximo", count(employee_id) "Total_por_departamento"
FROM employees e
GROUP BY department_id
ORDER BY department_id;

SELECT job_id, avg(salary) 
FROM employees e
GROUP BY job_id;

SELECT department_id, job_id, count(employee_id) AS "TOTAL EMPLOYEES"
FROM employees e
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT job_id, count(employee_id) "total"
FROM employees e
GROUP BY job_id
ORDER BY "total" DESC;

SELECT location_id, count(department_id)
FROM departments d
GROUP BY location_id;

SELECT department_id, job_id, sum(salary) "SUM", round(avg(salary), 0) "AVG", min(salary) "MIN", max(salary) "MAX"
FROM employees e
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

SELECT department_id, max(last_name), sum(salary)
FROM employees e
GROUP BY department_id;

/* Using the HAVING clause */
SELECT department_id, max(salary) "MAX"
FROM employees e
GROUP BY department_id
HAVING max(salary) > 10000
ORDER BY department_id;

SELECT department_id, sum(salary) SAL
FROM employees e
WHERE department_id IN (80, 90, 110)
GROUP BY department_id
HAVING sum(salary) > 25000
ORDER BY department_id;

SELECT region_id, count(country_id) TOTAL
FROM countries c
GROUP BY region_id
HAVING count(country_id) > 5
ORDER BY TOTAL;

SELECT job_id, sum(salary) "SUM"
FROM employees e
WHERE department_id IN(50, 80)
GROUP BY job_id
HAVING sum(salary) >= 60000;
