select * from emp
order by employee_id asc;
--CREATE VIEW
CREATE OR REPLACE VIEW EMP_CITY
AS
SELECT EMPLOYEE_ID,ENAME,CITY 
FROM EMP
WHERE UPPER(CITY)='PUNE';
--DISPLAY VIEW
SELECT *
FROM EMP_CITY
ORDER BY EMPLOYEE_ID;

INSERT INTO EMP_CITY (EMPLOYEE_ID,ENAME,CITY)
VALUES (11,'Khushi','Mumbai');

INSERT INTO EMP_CITY (EMPLOYEE_ID,ENAME,CITY)
VALUES (12,'Prakash','Nashik');

select * from emp;


UPDATE EMP_CITY
SET ENAME = 'Shreenu'
WHERE employee_id = 2;

SELECT *
FROM EMP_CITY
ORDER BY EMPLOYEE_ID;


DELETE FROM EMP
WHERE EMP.EMPLOYEE_ID IN (
    SELECT EID
    FROM EMP_SAL
    WHERE EID =2
);--NO DELETE ROW
---simple view using constraint table
select * from employee;

CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT EID,ENAME,SALARY
FROM EMPLOYEE
WHERE SALARY>=20000;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL (EID,ENAME,SALARY)
VALUES (6,'Khushi','50000');

INSERT INTO EMP_SAL (EID,ENAME,SALARY)
VALUES (7,'Jyoti','11000');

UPDATE EMP_sal
SET ENAME = 'Radha'
WHERE eid = 2;

DELETE FROM EMPLOYEE
WHERE EMPLOYEE.EID IN (
    SELECT EID
    FROM EMP_SAL
    WHERE EID =2
);
SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_SAL;

select * from  add_02;
select * from  add_02;

CREATE OR REPLACE VIEW add_03
AS
SELECT s_id,addr 
FROM student;
select * from  add_03;
--join view
select a.s_id,b.s_id
from add_02 a join add_03 b
on(a.s_id=b.s_id);
--join base table and view
select a.s_id,b.s_id
from student a join add_03 b
on(a.s_id=b.s_id);