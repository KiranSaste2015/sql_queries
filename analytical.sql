--Analytical function

--1]
SELECT EMPLOYEE_ID,DEPARTMENT_ID,FIRST_NAME,
AVG(SALARY) OVER (PARTITION BY DEPARTMENT_ID)
FROM EMPLOYEES;
--2]
SELECT DEPARTMENT_ID,AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
--3]
SELECT EMPLOYEE_ID,FIRST_NAME,MANAGER_ID,SUM(SALARY),
AVG(SALARY)OVER (PARTITION BY MANAGER_ID) AS AVG_SAL FROM EMPLOYEES
,SUM(SALARY)OVER (PARTITION BY MANAGER_ID) AS SUM_SAL ,
MAX(SALARY) OVER (PARTITION BY MANAGER_ID) AS MAX_SAL,
MIN(SALARY) OVER (PARTITION BY MANAGER_ID) AS MIN_SAL,
COUNT(EMPLOYEE_ID)OVER (PARTITION BY MANAGER_ID)AS COUNT_EMP
FROM EMPLOYEES;

SELECT FIRST_NAME FROM EMPLOYEES;
--Like
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE  REGEXP_LIKE(FIRST_NAME, '^[BCDFGHJKLMNPQRSTVWXYZ].*[bcdfghjklmnpqrstvwxyz]$', '');
--EXISTS
SELECT employee_id,first_name
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Departments d
    WHERE d.department_id = e.department_id
);
--Analytical function-----
--Q1.. Write a query to display top 3 salaries 
SELECT *
FROM (
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY,
DENSE_RANK() OVER (ORDER BY SALARY DESC ) AS RNK
FROM EMPLOYEES) TEMP_01
WHERE TEMP_01.RNK <= 3;

-- Q2. Write a query to display department wise top 3 salaries
SELECT *
FROM(
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID,
DENSE_RANK()OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RNK FROM EMPLOYEES)
TEMP 
WHERE TEMP.RNK<4;




-- Q3  Write a query to display bottom 3 salaries 
SELECT *
FROM (
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY,
DENSE_RANK() OVER (ORDER BY SALARY ASC ) AS RNK
FROM EMPLOYEES) TEMP_01
WHERE TEMP_01.RNK < 4;


-- q4 Write a query to display department wise bottom 3 salaries
SELECT *
FROM(
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID,
DENSE_RANK()OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC) AS RNK FROM EMPLOYEES)
TEMP 
WHERE TEMP.RNK<4;

--Q5. Write a query to display top 3rd salaries
SELECT *
FROM (
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY,
DENSE_RANK() OVER (ORDER BY SALARY DESC ) AS RNK
FROM EMPLOYEES) TEMP_01
WHERE TEMP_01.RNK =3;
--Q6. Write a query to display department wise top 3rd salaries
SELECT *
FROM (
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY,DEPARTMENT_ID,
DENSE_RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC ) AS RNK
FROM EMPLOYEES) TEMP_01
WHERE TEMP_01.RNK =3;
--Q7. Write a query to display bottom 3rd salaries
SELECT *
FROM (
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY,
DENSE_RANK() OVER (ORDER BY SALARY ASC ) AS RNK
FROM EMPLOYEES) TEMP_01
WHERE TEMP_01.RNK =3;
--Q8. Write a query to display department wise bottom 3rd salaries
SELECT *
FROM (
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY,DEPARTMENT_ID,
DENSE_RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY ASC ) AS RNK
FROM EMPLOYEES) TEMP_01
WHERE TEMP_01.RNK =3;

--9]WAQD department name wise top 3 salary 
SELECT e.department_id,d.department_name,e.salary,rnk
FROM(SELECT department_id,department_name 
FROM departments) d
JOIN (SELECT employee_id,department_id,salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
FROM employees) e
ON (d.department_id = e.department_id)
WHERE e.rnk <= 3;


--row number
SELECT salary,ROW_NUMBER() OVER (ORDER BY salary) AS RowNumber
FROM employees;
--rank
SELECT salary,Rank() OVER (ORDER BY salary) AS RowNumber
FROM employees;
--dense_rank
SELECT salary,dense_rank() OVER (ORDER BY salary) AS RowNumber
FROM employees;

-- Q3  Write a query to display bottom 3 salaries 

Select * from employees where salary < 
(Select max(salary) from employees) order by salary;

select *
    FROM  (select * from employees order by salary desc )
where rownum < 4;
---without using dense rsnk fing deptwise top 3 salary

select department_id,max(salary)as top_salary
from employees e1
where 3 >=(select count( distinct salary) from employees e2
where e2.salary>e1.salary and e1.department_id=e2.department_id)
group by department_id;


select * from departments;
--lead
select employee_id,salary,lead(salary) over (order by salary)as  new_sal
from employees;
--lead with offset default value
select employee_id,salary,lead(salary,1,0) over (order by salary)as  new_sal
from employees;
