
--Q1 . Write a query to display manager name & no of employees 
--working under him or her.
SELECT m.first_name AS mgr_name,COUNT(e.employee_id) AS num_employees
FROM employees e JOIN employees m
ON(e.manager_id = m.employee_id)
GROUP BY m.first_name;
--2]Write a query to display department_name wise no of employees & total salary.
SELECT
    d.department_name,
    COUNT(e.employee_id) AS num_employees,
    SUM(e.salary) AS total_salary
FROM
    employees e
JOIN
    departments d
ON
    e.department_id = d.department_id
GROUP BY
    d.department_name;

--3]Write a query to display details of those employees whose record is present 
--in JOB_HISTORY table as well
SELECT *
FROM employees e
JOIN JOB_HISTORY jh
ON e.employee_id = jh.employee_id;


SELECT e.*
FROM employees e
WHERE e.employee_id IN (
    SELECT DISTINCT jh.employee_id
    FROM JOB_HISTORY jh);
    
--4]Write a query to display city & department name wise 
--employee’s count. In output sort data count wise.
SELECT d.department_name, l.city, COUNT(e.employee_id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
GROUP BY d.department_name, l.city
ORDER BY employee_count DESC;

--Q6. Write a query to display manager details only ( without self join ).
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE e.employee_id IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL);
--7
--Q7. Write a query to display details of those departments where total 
--salary is more than 50000 and minimum salary is 5000.
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 50000
   AND MIN(e.salary) >= 5000;
   
--8]. Write a query to display details of those employees who are living in city Oxford and 
--having phone_number more than 15 digits.

SELECT *
FROM employees
WHERE city = 'Oxford' AND LENGTH(phone_number) > 15;

select * from locations where city='Oxford';


select l.city,e.phone_number
from employees e join DEPARTMENTS d
on(e.department_id=d.department_id)
join locations l
on(d.location_id=l.location_id)
where l.city = 'Oxford' AND LENGTH(e.phone_number) > 15;


--5]
CREATE TABLE A1
(ID VARCHAR(20));
INSERT INTO A1(ID) VALUES('AA');
INSERT INTO A1(ID) VALUES('AB');
INSERT INTO A1(ID) VALUES('AA');
INSERT INTO A1(ID) VALUES('AB');
INSERT INTO A1(ID) VALUES('AC');
INSERT INTO A1(ID) VALUES('NULL');
INSERT INTO A1(ID) VALUES('AC');
INSERT INTO A1(ID) VALUES('AB');

CREATE TABLE B1
(ID VARCHAR(20));
INSERT INTO B1(ID) VALUES('AC');
INSERT INTO B1(ID) VALUES('AB');
INSERT INTO B1(ID) VALUES('NULL');
INSERT INTO B1(ID) VALUES('AD');
INSERT INTO B1(ID) VALUES('DD');
INSERT INTO B1(ID) VALUES('NULL');
SELECT * FROM A1;
SELECT * FROM B1;
 
 SELECT a.Id FROM 
 A1 a LEFT OUTER JOIN B1 b
 ON(a.ID=b.Id);
 
 
 SELECT b.ID FROM 
 A1 a RIGHT OUTER JOIN B1 b
 ON(a.ID=b.Id);
 
 SELECT * FROM 
 A1 a FULL OUTER JOIN B1 b
 ON(a.ID=b.Id);
 
 
 SELECT * FROM 
 A1 a INNER JOIN B1 b
 ON(a.ID=b.Id);
 
 
 
 
 
 
 --test
--1] 
SELECT INSTR(LPAD(initcap(substr('INDIANS ARE VERY BRAVE PEOPLE',1,8)),15,'#'),'i') 
FROM DUAL ; ----OP:11

--2]
SELECT ROUND(87888.6546,-2) FROM DUAL ;----OP:87900
--3]
SELECT ROUND(MONTHS_BETWEEN(SYSDATE,ROUND(ADD_MONTHS('25-Dec-2021',-3),'Year')),0)
FROM DUAL ;
SELECT ROUND(22.63390793010752688172043010752688172043,0) FROM DUAL;
--0P:23


--test 2
--q1
SELECT ADDR, COUNT(S_ID) AS STUDENT_COUNT
FROM STUDENT
GROUP BY ADDR
HAVING COUNT(S_ID) < 3;


--Q2
SELECT *
FROM STUDENT
WHERE S_ID IN (SELECT S_ID
               FROM MARKS
               WHERE UPPER(SUBJECT) = 'CHEMISTRY'
               AND MARKS = (SELECT MAX(MARKS) 
                            FROM MARKS
                            WHERE UPPER(SUBJECT) = 'CHEMISTRY'
                            GROUP BY SUBJECT));
                            
--Q3
SELECT s.*, m.MARKS, g.GRADE
FROM STUDENT s LEFT OUTER JOIN MARKS m
ON (s.S_ID = m.S_ID)
LEFT OUTER JOIN GRADE g
ON (m.MARKS BETWEEN g.MIN_MARKS AND g.MAX_MARKS);

--Q4
SELECT ADDR, COUNT(*) AS STUDENT_COUNT
FROM STUDENT 
WHERE ADDR IN (SELECT ADDR
                  FROM STUDENT 
                  WHERE S_NAME = 'J')
GROUP BY ADDR;
                  
--Q5
SELECT m.SUBJECT, g.GRADE, COUNT(S_ID) AS STUDENT_COUNT
FROM MARKS m LEFT OUTER JOIN GRADE g
ON (m.MARKS BETWEEN g.MIN_MARKS AND g.MAX_MARKS)
WHERE m.SUBJECT = 'Mathematics' 
AND g.GRADE = 'Fail'
GROUP BY m.SUBJECT, g.GRADE;

--Q6-1
SELECT s.*
FROM STUDENT s LEFT OUTER JOIN MARKS m
ON (s.S_ID = m.S_ID)
WHERE m.S_ID IS NULL;

--Q6-2
SELECT *
FROM STUDENT 
WHERE S_ID IN (SELECT S_ID FROM STUDENT
               MINUS
               SELECT S_ID FROM MARKS);
SELECT * FROM STUDENT;             
--Q7
SELECT S_ID, S_NAME, ADDR, DOB, GENDER, S_CLASS,
(MONTHS_BETWEEN(SYSDATE, DOB)/12) AS AGE
FROM STUDENT;


--Q8
SELECT ADDR, COUNT(S_ID) AS STUDENT_COUNT
FROM STUDENT
GROUP BY ADDRESS
HAVING COUNT(S_ID) > 10;

--Q9-1
SELECT A.ID, B.ID
FROM A INNER JOIN B
ON (A.ID = B.ID);

--Q9-2
SELECT A.ID, B.ID
FROM A LEFT OUTER JOIN B
ON (A.ID = B.ID);

--Q9-3
SELECT A.ID, B.ID
FROM A RIGHT OUTER JOIN B
ON (A.ID = B.ID);

--Q9-4
SELECT A.ID, B.ID
FROM A FULL OUTER JOIN B
ON (A.ID = B.ID);


--Q11
SELECT g.GRADE, s.GENDER, COUNT(s.S_ID) AS STUDENT_COUNT
FROM STUDENT s LEFT OUTER JOIN MARKS m
ON (s.S_ID = m.S_ID)
LEFT OUTER JOIN GRADE g
ON (m.MARKS BETWEEN g.MIN_MARKS AND g.MAX_MARKS)
GROUP BY g.GRADE, s.GENDER;
              
--Q12
SELECT *
FROM STUDENT
WHERE S_ID IN (SELECT m.S_ID 
               FROM MARKS m JOIN GRADE g
               ON(m.MARKS BETWEEN g.MIN_MARKS AND g.MAX_MARKS )
               WHERE UPPER(m.SUBJECT) = 'CHEMISTRY'
               AND UPPER(g.GRADE) <> 'FAIL')
 AND S_ID  IN (SELECT m.S_ID 
               FROM MARKS m JOIN GRADE g
               ON(m.marks BETWEEN g.MIN_MARKS AND g.MAX_MARKS )
               WHERE UPPER(m.SUBJECT)='MATHEMATICS'
               AND UPPER(g.GRADE) = 'FAIL');
               
               
--test4
--1
SELECT * FROM 
EMPLOYEES 
WHERE DEPARTMENT_ID=50
AND SALARY=(SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID=50);

--2            
SELECT E.LAST_NAME,E.JOB_ID,E.DEPARTMENT_ID,D.DEPARTMENT_NAME           
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
JOIN 
LOCATIONS L
ON D.LOCATION_ID=L.LOCATION_ID
WHERE 
UPPER(L.CITY)='TORONTO';


--3
SELECT FIRST_NAME,LAST_NAME,HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE>ANY(SELECT HIRE_DATE 
                    FROM EMPLOYEES
                    WHERE UPPER(lAST_NAME)='JONES');

--4                    
SELECT J.JOB_TITLE,D.DEPARTMENT_NAME,E.LAST_NAME,E.HIRE_DATE
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
JOIN
JOBS J 
ON(E.JOB_ID=J.JOB_ID)
WHERE E.HIRE_DATE BETWEEN TO_DATE('01-JAN-2000','DD-MON-YYYY')
                    AND   TO_DATE('31-DEC-2005','DD-MON-YYYY') ;
                    
  
--5
SELECT * FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN(
                        SELECT  DEPARTMENT_ID
                        FROM EMPLOYEES
                        GROUP BY DEPARTMENT_ID
                        HAVING MAX(SALARY)>10000 );


--6
SELECT D.DEPARTMENT_NAME,L.CITY ,COUNT(*)         
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
JOIN 
LOCATIONS L
ON D.LOCATION_ID=L.LOCATION_ID
WHERE L.CITY IN(SELECT L.CITY
                FROM EMPLOYEES E JOIN DEPARTMENTS D
                ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
                JOIN 
                LOCATIONS L
                ON D.LOCATION_ID=L.LOCATION_ID  
                GROUP BY L.CITY HAVING COUNT(*)>10)
GROUP BY D.DEPARTMENT_NAME,L.CITY;


--7                  
SELECT CONCAT(CONCAT(M.FIRST_NAME,' '),M.LAST_NAME) AS MANAGER_NAME,COUNT(*) AS EMPLOYEE_COUNT
FROM EMPLOYEES E JOIN EMPLOYEES M
ON M.EMPLOYEE_ID=E.MANAGER_ID
GROUP BY CONCAT(CONCAT(M.FIRST_NAME,' '),M.LAST_NAME);

---8
SELECT * FROM  EMPLOYEES 
WHERE DEPARTMENT_ID=50
UNION All
SELECT * FROM  EMPLOYEES 
WHERE DEPARTMENT_ID=80;
















--correlated subqueries
SELECT employee_id, last_name, job_id, department_id
FROM employees outer
WHERE EXISTS ( SELECT *
FROM employees
WHERE manager_id =
outer.employee_id);


--9
SELECT E.EMPLOYEE_ID,TO_CHAR(J.START_DATE,'YYYY')AS YEAR,COUNT(*) AS JOB_SWITCH_COUNT
FROM EMPLOYEES E JOIN JOB_HISTORY J
ON(E.EMPLOYEE_ID=J.EMPLOYEE_ID)
GROUP BY E.EMPLOYEE_ID,TO_CHAR(J.START_DATE,'YYYY');




SELECT LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES S
WHERE EXISTS 
(SELECT DEPARTMENT_NAME FROM DEPARTMENTS D 
WHERE D.DEPARTMENT_ID = S.DEPARTMENT_ID AND D.LOCATION_ID IN (1700,1800));

SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products 
WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

