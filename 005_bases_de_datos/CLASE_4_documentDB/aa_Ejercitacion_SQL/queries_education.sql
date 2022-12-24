select * 
from employee
limit  4;

-- 1)
SELECT last_name, 
	   first_name, 
	   salary_amount
FROM employee
WHERE manager_employee_number = 1019
ORDER BY last_name;

-- 2)
SELECT first_name
FROM employee
WHERE last_name = 'Brown';

--3)
SELECT COUNT (*) AS how_many
FROM employee
WHERE job_code >= 510001;

--4)
SELECT last_name, department_number
FROM employee
WHERE department_number = 301 or 
	  department_number = 401 or 
	  department_number = 501;
	  
--5)
SELECT last_name
FROM employee
WHERE employee.salary_amount > 28078
ORDER BY last_name;

--6)
SELECT 
	last_name
	,first_name
FROM employee
WHERE department_number is null;

--7)
SELECT 
	last_name
	,first_name
	,department_number
FROM employee
WHERE department_number IN (301, 401, 501) 
or job_code in (512102, 432101);
	
-- 8)
SELECT 
	last_name
	,first_name
	,department_number
	,salary_amount
FROM employee
WHERE (department_number in (301, 401, 501) 
or job_code in (512102, 432101))
and salary_amount between 50000 and 60000;

--9)
SELECT 
	DISTINCT(job_code)
FROM employee
WHERE job_code > 510000;

--10)List all employees by name, the name of their department, 
-- their original salary, and salary again with a ten percent increase, 
-- for those working in departments with budgets > $400,000.00. 
SELECT 
	emp.last_name
	,emp.first_name
	,emp.salary_amount
	,dep.department_name
	,emp.salary_amount * 1.1 new_salary
FROM employee emp
INNER JOIN 	department dep
ON emp.department_number = dep.department_number
WHERE dep.budget_amount > 400000

-- 11)Find the department names and employee names 
-- for employees that have both an “i” and an “e” in their last name.
SELECT 
	d.department_name
	,e.first_name
	,e.last_name
FROM employee as e
INNER JOIN department as d
ON d.department_number = e.department_number
WHERE e.last_name LIKE '%i%' 
AND	e.last_name LIKE '%e%'

-- 12) List department names that have people working in them whose job 
-- description has the word “manager” in it. List the employee names as well.
SELECT 
	dep.department_name
	,emp.last_name
	,emp.first_name
FROM
	employee as emp
INNER JOIN department as dep
ON emp.department_number = dep.department_number
INNER JOIN job as j
ON j.job_code = emp.job_code
WHERE j.description ILIKE '%manager%'

-- 13)	Write a cross join that lists all possible combinations of first 
-- names and last names from employee.
SELECT count(*) 
FROM (SELECT 
	 	e.last_name
	 	,e.first_name
	 	,e2.last_name
	 	,e2.first_name
	  FROM
	 	employee e
	 	CROSS JOIN
	 	employee e2)  as SUBQUERY

-- 14) Find and list employees first and last names for employees where their
-- last name begins with either “R”, “S” or “T”. (Do this without regard 
-- to case sensitivity).
SELECT e.first_name
	,e.last_name
FROM employee e
WHERE (e.last_name ILIKE 'r%'
	or e.last_name ILIKE 's%' 
	or e.last_name ILIKE 't%')

-- 15) Write a request that will show the salary amount for the people 
-- identified in #14 if they were given a 10% increase in salary.
SELECT last_name
	,first_name
	,salary_amount as old_salary
	,salary_amount * 1.1 as new_salary
FROM employee
WHERE (last_name ILIKE 'r%'
	or last_name ILIKE 's%' 
	or last_name ILIKE 't%')
