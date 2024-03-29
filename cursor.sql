SET SERVEROUTPUT ON
DECLARE
CURSOR EMP_DEPT_DETAILS
IS
SELECT FIRST_NAME, LAST_NAME,SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = &DID ;-- CREATED USER DEFINED CURSOR ( EXPLICITE)

--VARIABLE DEFINED

FNAME EMPLOYEES.FIRST_NAME%TYPE;
LNAME EMPLOYEES.LAST_NAME%TYPE;
SAL EMPLOYEES.SALARY%TYPE;

BEGIN
OPEN EMP_DEPT_DETAILS;-- open cur
LOOP
FETCH EMP_DEPT_DETAILS INTO FNAME,LNAME,SAL;--fetch record ( only 1 record is processing )
DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||SAL);--print

EXIT WHEN EMP_DEPT_DETAILS%NOTFOUND;-- check cursor is empty or not
END LOOP;

CLOSE EMP_DEPT_DETAILS;
END;



--******************
--1)
SET SERVEROUT ON
DECLARE 

CURSOR EMP_RECORD IS
SELECT FIRST_NAME ,LAST_NAME ,SALARY
FROM EMPLOYEES 
WHERE EMPLOYEE_ID = &EID;

FNAME VARCHAR2(20) ;
LNAME VARCHAR2(20);
SAL NUMBER ;

BEGIN
OPEN EMP_RECORD ;
FETCH EMP_RECORD INTO  FNAME,LNAME,SAL;
DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||SAL);
CLOSE EMP_RECORD ;
END;



--2)
SET SERVEROUT ON
DECLARE 

CURSOR EMP_RECORD IS
SELECT e.FIRST_NAME ,e.LAST_NAME ,e.SALARY ,e.DEPARTMENT_ID,d.DEPARTMENT_NAME 
FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE EMPLOYEE_ID = &EID;

FNAME VARCHAR2(20) ;
LNAME VARCHAR2(20);
SAL NUMBER ;
DID NUMBER ;
DNAME VARCHAR2(20);

BEGIN
OPEN EMP_RECORD ;
FETCH EMP_RECORD INTO  FNAME,LNAME,SAL,DID,DNAME;
DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||SAL||' '||DID||' '||DNAME);
CLOSE EMP_RECORD ;
END;

--3)

SET SERVEROUTPUT ON
DECLARE
TYPE EMP_REC IS RECORD 
(
FNAME VARCHAR2(20),
LNAME VARCHAR2(20),
SAL NUMBER 
);
EMP_RECORD EMP_REC;

BEGIN 

SELECT FIRST_NAME ,LAST_NAME ,SALARY INTO EMP_RECORD 
FROM EMPLOYEES 
WHERE EMPLOYEE_ID = &EID;
 DBMS_OUTPUT.PUT_LINE(EMP_RECORD.FNAME||' '||EMP_RECORD.LNAME||' '||EMP_RECORD.SAL);
END;

--4)

SET SERVEROUTPUT ON
DECLARE
TYPE EMP_REC IS RECORD 
(
FNAME VARCHAR2(20),
LNAME VARCHAR2(20),
SAL NUMBER ,
DID NUMBER ,
DNAME VARCHAR2(20),
CITY VARCHAR2(20)
);
EMP_RECORD EMP_REC;

BEGIN 

SELECT e.FIRST_NAME ,e.LAST_NAME ,e.SALARY,e.DEPARTMENT_ID,d.DEPARTMENT_NAME,l.CITY INTO EMP_RECORD 
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID
WHERE EMPLOYEE_ID = &EID;
 DBMS_OUTPUT.PUT_LINE(EMP_RECORD.FNAME||' '||EMP_RECORD.LNAME||' '||EMP_RECORD.SAL||' '||EMP_RECORD.DID||' '||EMP_RECORD.DNAME||' '||EMP_RECORD.CITY);
END;



--5)
SET SERVEROUTPUT ON
DECLARE
TYPE EMP_REC IS RECORD 
(
FNAME VARCHAR2(20),
LNAME VARCHAR2(20),
SAL NUMBER ,
DID NUMBER ,
DNAME VARCHAR2(20),
CITY VARCHAR2(20)
);
EMP_RECORD EMP_REC;

CURSOR EMP_DET IS
SELECT e.FIRST_NAME ,e.LAST_NAME ,e.SALARY,e.DEPARTMENT_ID,d.DEPARTMENT_NAME,l.CITY INTO EMP_RECORD 
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID
WHERE e.DEPARTMENT_ID = &DID;


BEGIN 
OPEN EMP_DET;
LOOP
FETCH EMP_DET INTO EMP_RECORD; 
EXIT WHEN EMP_DET%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(EMP_RECORD.FNAME||' '||EMP_RECORD.LNAME||' '||EMP_RECORD.SAL||' '||EMP_RECORD.DID||' '||EMP_RECORD.DNAME||' '||EMP_RECORD.CITY);
END LOOP ;
CLOSE EMP_DET;
END;