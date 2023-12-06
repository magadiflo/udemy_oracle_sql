/* Sección 6: Conversión y funciones generales */

/* Data Type Conversion: Implicit Conversion */
SELECT last_name, salary, salary + '300' AS "Increased Sal"
FROM employees e
WHERE department_id = 90; 

SELECT last_name, department_id, hire_date
FROM employees e
WHERE hire_date >= '01-DEC-2005' AND hire_date <= '01 march 06';

SELECT sysdate
FROM dual;

/* Conversion Functions - TO_CHAR(date...) */
--fm, quita el espacio en blanco
SELECT 
	sysdate, 
	to_char(sysdate, 'dd/mm/yyyy HH24:MI:SS') AS "Format 1", 
	to_char(sysdate, 'fmDay/dd/Mon/yyyy HH:MI:SS AM') AS "Format 2",
	to_char(sysdate, 'fmDY-MONTH "de" YYYY HH24:MI:SS') AS "Format 3"
FROM dual;

/* Conversion Functions - TO_CHAR(number...)
 * 
 * 9, representa un número
 * 0, fuerza un cero a ser desplegado
 * $, coloca un signo de dólar flotante
 * L, Utiliza el símbolo de moneda local flotante
 * ., Imprime un punto decimal
 * , Imprime una coma como indiciador de miles
 * */
SELECT last_name, salary,
	to_char(salary, '$99,999.99') AS "Format 1",
	to_char(salary, 'L0099,999.99') "Format 2"
FROM employees e
WHERE department_id = 90;

-- Exercise
SELECT 
	last_name, 
	salary, 
	hire_date,
	to_char(hire_date, 'fmDay, Ddspth "de" Month,yyyy') AS "Format 1", 
	add_months(hire_date, 4),
	to_char(add_months(hire_date, 4), 'fmDay, "el" Ddspth "de" Month,yyyy') AS "Format 2",
	to_char(add_months(hire_date, 4), 'fmDay, Month"("Mmsp")",yyyy') AS "Format 3"
FROM employees e
WHERE department_id = 100;

--Podemos modificar el símbolo de la moneda:
ALTER SESSION SET nls_currency='S/';

--Una vez modificada el símbolo de la moneda podemos usarlo con la bandera L
SELECT last_name || ' gana ' || to_char(salary, 'fmL99,999.00') || ' mensual, pero quiere ' || to_char(salary * 3, 'fmL99,999.00') AS "Frase"
FROM employees e
WHERE department_id = 90;

/* Conversion Functions - TO_NUMBER, and TO_DATE */
SELECT to_number('$48,746.45', '$99,999.99') + 1000 "Format 1"
FROM dual;

SELECT last_name, department_id, to_char(hire_date, 'DD-MM-YYYY') AS "Format"
FROM employees e
WHERE hire_date >= to_date('17-02-2005', 'DD-MM-YYYY') 
	AND hire_date <= to_date('17-03-2005', 'DD-MM-YYYY');

SELECT last_name, department_id, to_char(hire_date, 'DD-MM-YYYY') AS "Format"
FROM employees e
WHERE hire_date >= '17-FEB-2005'
	AND hire_date <= '17-MAR-2005'

-- Exercise
SELECT to_number('$5,200.3', '$9,999.99') + 500 AS "Sum"
FROM dual;

SELECT last_name, salary, to_char(hire_date, 'dd-mm-yyyy') "FORMAT"
FROM employees e
WHERE hire_date BETWEEN to_date('01-02-2004', 'dd-mm-yyyy') AND to_date('31-03-2004', 'dd-mm-yyyy');

SELECT last_name, salary, to_char(hire_date, 'dd-mm-yyyy') "FORMAT"
FROM employees e
WHERE hire_date BETWEEN '01-FEB-2004' AND '31-MAR-2004';

/* General Functions - NVL, NVL2, NULLIF and COALESCE */
SELECT 
	nvl('No soy nulo', 'Valor por defecto') AS "NVL",
	nvl(NULL, 'Valor por defecto') AS "NVL", --Si la primera expresión es NULL, entonces retorna la segunda expresión
	nvl2('No soy nulo', 'segundo parámetro', 'tercer parámetro') AS "NVL2",
	nvl2(NULL, 'segundo parámetro', 'tercer parámetro') AS "NVL2", --Si la expresión es NULL, entonces retorna la tercera expresión
	nullif(2, 2) AS "NULLIF", --Si ambas expresiones son iguales, retorna NULL
	nullif(2, 10) AS "NULLIF", --Si NO son iguales, entonces retorna la primera expresión (2)
	coalesce(NULL, NULL, 'Tengo valor', NULL, 'Yo también tengo valor') AS "COALESCE" --Busca el primer valor NO NULL en una lista de expresiones
FROM dual;

SELECT last_name, salary, commission_pct, nvl(commission_pct, 0),
	salary * 12 + (salary * 12 * nvl(commission_pct, 0)) AS "Annual_Sal"
FROM employees e
ORDER BY salary;

SELECT last_name, salary, commission_pct, 
	nvl2(commission_pct, 'Con comisión', 'Sin comisión') AS "¿Comisión?",
	salary*12 + (salary*12*nvl2(commission_pct, commission_pct, 0)) AS "Annual_Sal"
FROM employees e
ORDER BY salary;

SELECT last_name, salary, commission_pct, nvl(to_char(commission_pct), 'Sin comisión')
FROM employees e
ORDER BY salary;

SELECT commission_pct, nvl2(commission_pct, 'Yes', 4)
FROM employees e;

SELECT last_name, salary, commission_pct,
	coalesce(12*salary + salary*12*commission_pct, 12*salary, 0) AS "Annual_sal"
FROM employees e
ORDER BY salary;

--Exercises
SELECT department_name, department_id, manager_id,
	nvl2(manager_id, 'Tiene manager', 'No tiene manager') AS "MANAGER"
FROM departments d
WHERE location_id = 1700;

SELECT last_name, salary, commission_pct, nvl(to_char(commission_pct), 'Sin commision') AS "Commission"
FROM employees e
WHERE department_id IN (110, 80);

/* General Functions - CASE and DECODE */
SELECT last_name, job_id, salary,
	CASE job_id 
		WHEN 'ST_MAN' THEN salary + 300
		WHEN 'FI_MGR' THEN salary + 500
		WHEN 'AD_VP' THEN salary + 1000
		ELSE salary		
	END AS "new_salary"	
FROM employees e
ORDER BY job_id;


SELECT last_name, job_id, salary,
	decode(job_id, 'ST_MAN', salary + 300, 'FI_MGR', salary + 500, 'AD_VP', salary + 1000, salary) AS "new_salary"	
FROM employees e
ORDER BY job_id;


SELECT last_name, job_id,
	CASE job_id
		WHEN 'AD_PRES' THEN 'A'
		WHEN 'IT_PROG' THEN 'B'
		WHEN 'SA_REP'  THEN 'C'
		ELSE '0'		
	END AS "GRADE"
FROM employees e
ORDER BY "GRADE";

SELECT last_name, job_id,
	decode(job_id, 'AD_PRES', 'A', 'IT_PROG', 'B', 'SA_REP', 'C', '0') AS "GRADE"
FROM employees e
ORDER BY "GRADE"

