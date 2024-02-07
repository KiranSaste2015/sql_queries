--1]retrive name and salary of employees who have
--heighest salary in each departmentin include dept name,emp name salary.
SELECT e.department_id,d.department_name,e.salary,rnk
FROM(SELECT department_id,department_name 
FROM departments) d
JOIN (SELECT employee_id,department_id,salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
FROM employees) e
ON (d.department_id = e.department_id)
WHERE e.rnk <= 1;
--2]find employee longest tenure in company


--3]retrive emp name salary who have salary higher than 
--avg salaryin their respective dept
--4]waqd those employee who salary greater than his/her reporting manager
--5]waqd of those departments where more than 50 employees joinbut after 12 dec 2007
--6]waqd to delete duplicate records from table
--7]waqd those employees who has 6 digit salary and first name contain 
--letter p at 5 pos and joined company before year 2006
