/* Sección 08: Joins */

/* Join - Overview
 * 
 * JOINS son usadas para recuperar datos de múltiples tablas
 * O cuando usamos datos de más de una tabla.
 * Para producir el informe, debe vincular dos o más tablas utilizando una columna de datos común.
 *  */

-- ---------------------------------------------------------
-- 1° Tipo de join: Inner Join (equijoin)
-- ---------------------------------------------------------
/* Natural Join 
 *
 * - El Natural Join utilizará "AUTOMÁTICAMENTE" todas las columnas que tengan lo mismo en dos tablas para recuperar los datos. 
 * - Si usamos Natural Join, no podemos especificar las columnas por las que se unirán las tablas, sino más bien dejamos a Oracle
 *   detecte automáticamente todas las columnas que tengan el mismo nombre por el cual serán unidos.
 * - Selecciona filas de ambas tablas que tienen valores iguales en todas las columnas coincidentes (columnas con el mismo nombre)
 * - Si las columnas que tienen el mismo nombre tienen diferentes tipos de datos, Oracle generará un error.
 * */
SELECT department_id, department_name, city
FROM departments d
	NATURAL JOIN locations l
ORDER BY department_id;

SELECT department_name, city, street_address, country_name 
FROM departments d
	NATURAL JOIN locations l
	NATURAL JOIN countries c;

SELECT last_name, department_id, job_id, job_title
FROM employees e 
	NATURAL JOIN jobs j
WHERE department_id IN (10, 90, 20);

/* Using Clause 
 * 
 * - Si las tablas unidas contienen más de una columna coincidente y desea hacer coincidir solo 
 *   una columna específica, use la cláusula USING en lugar de la NATURAL JOIN.
 * - La columna utilizada en la cláusula USING debe tener el mismo nombre en ambas tablas.
 * */ 

SELECT department_id, department_name, city
FROM departments d
	JOIN locations l USING(location_id)
ORDER BY department_id;

SELECT last_name, salary, department_name
FROM employees e
	JOIN departments d USING(department_id)
ORDER BY department_id;

SELECT department_name, city, street_address, country_name
FROM departments d
	JOIN locations l USING(location_id)
	JOIN countries c USING(country_id);

SELECT last_name, department_id, job_id, job_title
FROM employees e
	JOIN departments d USING(department_id)
	JOIN jobs j USING(job_id)
WHERE department_id IN(10, 90, 20);

SELECT country_id, country_name, region_name
FROM countries c
	JOIN regions r USING(region_id);

/* ON clause 
 *
 * - La cláusula de unión ON se puede utilizar para unir tablas usando 
 * columnas que tienen nombres diferentes en las tablas unidas. 
 * */
SELECT d.department_id, d.department_name, l.city
FROM departments d
	JOIN locations l ON(d.location_id = l.location_id)
ORDER BY d.department_id;

SELECT e.last_name, j.job_id, j.job_title
FROM employees e
	JOIN jobs j ON(e.job_id = j.job_id)
ORDER BY j.job_id;

SELECT e.last_name, j.job_id, j.job_title
FROM employees e
	JOIN jobs j ON(e.job_id = j.job_id) AND e.department_id = 90
ORDER BY j.job_id;


SELECT e.last_name, d.department_id, d.department_name, l.city
FROM employees e
	JOIN departments d ON (e.department_id = d.department_id)
	JOIN locations l ON (d.location_id = l.location_id)
WHERE lower(l.city) = 'london';

/* Self Join 
 * 
 * - Es una unión en la que una tabla se une consigo misma.
 * */
SELECT employee.employee_id "ID-EMPLOYEE", employee.first_name || ' ' || employee.last_name "EMPLOYEE",
	manager.employee_id "ID-MANAGER", manager.first_name || ' ' || manager.last_name "MANAGER"
FROM employees manager
	JOIN employees employee ON(manager.employee_id = employee.manager_id)

-- ---------------------------------------------------------
-- 2° Tipo de join: Non equijoin
-- ---------------------------------------------------------
/**
 * Es una unión cuyas condiciones de unión utilizan operadores condicionales distintos de igual
 */

-- Para realizar el ejemplo crearemos una tabla donde estableceremos ciertos intervalos. 
-- ¡OJO! Esta tabla no está relacionada con la tabla empleados, pero la usaremos para ver
-- la categoría que tiene el sueldo de cada empleado.
CREATE TABLE job_grades(
	job_grades_id NUMBER(6,0) NOT NULL PRIMARY KEY,
	grade_level VARCHAR2(1) NOT NULL,
	lowest_sal NUMBER(6,0) NOT NULL,
	highest_sal NUMBER(6,0) NOT NULL
);

INSERT INTO job_grades(job_grades_id, grade_level, lowest_sal, highest_sal)
VALUES(1, 'A', 1000, 2999);
INSERT INTO job_grades(job_grades_id, grade_level, lowest_sal, highest_sal)
values(2, 'B', 3000, 5999);
INSERT INTO job_grades(job_grades_id, grade_level, lowest_sal, highest_sal)
values(3, 'C', 6000, 9999);
INSERT INTO job_grades(job_grades_id, grade_level, lowest_sal, highest_sal)
values(4, 'D', 10000, 14999);
INSERT INTO job_grades(job_grades_id, grade_level, lowest_sal, highest_sal)
values(5, 'E', 15000, 24999);
INSERT INTO job_grades(job_grades_id, grade_level, lowest_sal, highest_sal)
values(6, 'F', 25000, 40000);

-- Realizamos el Non equijoin, es decir vamos a unir las tablas empleados y job_grades
-- pero no usando la = ya que ambas tablas no están relacionadas, no existe entre
-- ambas una clave foránea que las una. Por lo tanto, usaremos otros campos, 
-- como por ejemplo el 'salary' a partir del cual veremos en qué intervalo se encuentra:
SELECT e.last_name, e.department_id, e.salary, jg.grade_level
FROM employees e
	JOIN job_grades jg ON(e.salary BETWEEN jg.lowest_sal AND jg.highest_sal)


-- ---------------------------------------------------------
-- 3° Tipo de join: Outer Join
-- ---------------------------------------------------------
/* Left outer join */
SELECT e.first_name, d.department_id, d.department_name
FROM employees e
	LEFT OUTER JOIN departments d ON(e.department_id = d.department_id)

/* Right outer join */
SELECT e.first_name, d.department_id, d.department_name
FROM employees e
	RIGHT OUTER JOIN departments d ON(e.department_id = d.department_id)

/* Full outer join */
SELECT e.first_name, d.department_id, d.department_name
FROM employees e
	FULL OUTER JOIN departments d ON(e.department_id = d.department_id)


-- ---------------------------------------------------------
-- 4° Tipo de join: Cross (Cartesian) Join
-- ---------------------------------------------------------
/*
 * Es una unión de cada fila de la primera tabla con cada fila de la segunda tabla.
 * */
SELECT e.last_name, e.department_id, d.department_name
FROM employees e
	CROSS JOIN departments d
ORDER BY e.department_id;