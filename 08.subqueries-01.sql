/* Sección 09. Using Subqueries 01 */

/* Using Suqueries 
 * 
 * La subconsulta (consulta interna) se ejecuta primero, luego la consulta principal 
 * (consulta externa) utiliza el resultado devuelto de la subconsulta para devolver 
 * el resultado final.
 * */
SELECT last_name, salary
FROM employees e
WHERE salary > (SELECT salary 
				FROM employees e2
				WHERE last_name = 'Chen');

/* Single Row Subquery */
SELECT last_name, manager_id, department_id
FROM employees e
WHERE manager_id > (SELECT manager_id
				FROM employees e2
				WHERE last_name = 'Matos');
			
SELECT last_name, hire_date, department_id
FROM employees e
WHERE hire_date > (SELECT hire_date
				   FROM employees e2
				   WHERE last_name = 'Lee');
				  
SELECT e.last_name, e.salary, d.department_name
FROM employees e 
	INNER JOIN departments d ON(e.department_id = d.department_id)
WHERE salary >= (SELECT avg(salary)
				FROM employees e2);

/* Multi Row Subquery
 * 
 * - IN, igual a algún miembro de la lista
 * - ANY, debe ir precedido de =, !=, >, <, <=, >=. Devuelve VERDADERO si existe 
 *   al menos un elemento en el conjunto de resultados de la subconsulta cuya relación es VERDADERA.
 * - ALL, debe ir precedido de =, !=, >, <, <=, >=. Devuelve VERDADERO si la relación es VERDADERA 
 *   para todos los elementos del conjunto de resultados de la subconsulta
 * */
SELECT employee_id, last_name, salary, department_id
FROM employees e
WHERE salary IN (SELECT MIN(salary)
				FROM employees e2
				GROUP BY department_id);
			
SELECT e.employee_id, e.last_name, e.salary, e.department_id
FROM employees e
WHERE department_id IN(SELECT e2.department_id
						FROM employees e2
						WHERE e2.last_name LIKE 'J%');

SELECT e.employee_id, e.last_name, e.salary
FROM employees e
WHERE salary > ANY (SELECT e2.salary
					FROM employees e2
					WHERE department_id = 110);
			
/* Multi Column Subquery */
SELECT last_name, job_id, department_id, salary
FROM employees e
WHERE (salary, department_id) = (SELECT salary, department_id
									FROM employees e2
									WHERE last_name = 'Matos')
	AND last_name != 'Matos';
				

SELECT last_name, job_id, department_id
FROM employees e
WHERE (job_id, department_id) = (SELECT job_id, department_id
									FROM employees
									WHERE last_name = 'Lee');



				
				