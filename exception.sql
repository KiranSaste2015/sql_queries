----------------
SET SERVEROUTPUT ON
DECLARE
FNAME VARCHAR2(20);
LNAME VARCHAR2(20);
BEGIN
SELECT FIRST_NAME,LAST_NAME INTO FNAME,LNAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = &DID ;
DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME);
EXCEPTION
WHEN NO_DATA_FOUND
THEN
DBMS_OUTPUT.PUT_LINE('PLEASE ENTE CORRECT DEPARTMENT ID ');
WHEN TOO_MANY_ROWS
THEN
DBMS_OUTPUT.PUT_LINE('SCLARE VARIABLES CANT HOLD MULTIPLE VARIABLES');
WHEN OTHERS 
THEN
DBMS_OUTPUT.PUT_LINE('OTHER EXCEPTION');
END ;
-----------------------------------------
SET SERVEROUTPUT ON
DECLARE
  lname VARCHAR2(15);
BEGIN
  SELECT last_name INTO lname FROM employees WHERE     
  first_name='John'; 
  DBMS_OUTPUT.PUT_LINE ('John''s last name is : ' ||lname);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN
  DBMS_OUTPUT.PUT_LINE (' multiple rows found use cursor');
END;

--------------------------------------------------
CREATE TABLE STUDENT_01(SID INT PRIMARY KEY,NAME VARCHAR(20) NOT NULL);
BEGIN
    INSERT INTO STUDENT_01 VALUES(10,NULL);
EXCEPTION

WHEN DUP_VAL_ON_INDEX          
THEN
    DBMS_OUTPUT.PUT_LINE('PRIMARY KEY VOILET');      
WHEN OTHERS 
THEN
      DBMS_OUTPUT.PUT_LINE('NOT NULL CONSTRAINT VOILET');
END;      


SELECT * FROM STUDENT_01;
--=============================================================
DECLARE
  numerator NUMBER := 10;
  denominator NUMBER := 0; 
  result NUMBER;
BEGIN
  result := numerator / denominator;
EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Error: Division by zero is not allowed.');
END;


-------------------------------------------------------
--08-01-24
create table Products(pid number,pname varchar2(20),stock number);
insert into Products values(1,'earphone',10);
insert into Products values(2,'mobile',23);
insert into Products values(3,'Speaker',56);
insert into Products values(4,'tablet',8);
insert into Products values(5,'laptop',35);

select * from products;
--user defined exception

--using simple block stucture
set serveroutput on
declare 
p_id number :=&pid;
stock_count number;
product_not_available exception;
begin
select stock into stock_count from products where pid=p_id;
IF stock_count < 50
Then
RAISE product_not_available;
ELSE
DBMS_OUTPUT.PUT_LINE('Product is available in stock.');
END IF;
EXCEPTION
  WHEN product_not_available 
  THEN
DBMS_OUTPUT.PUT_LINE('Product is not available in stock.');
END;
--call procedure
execute productavailability(2);
--using procedure
CREATE OR REPLACE PROCEDURE productAvailability(p_id IN NUMBER) IS
  product_not_available EXCEPTION;
  stock_count NUMBER;
BEGIN
SELECT stock INTO stock_count FROM products WHERE pid = p_id;
IF stock_count < 50
Then
RAISE product_not_available;
ELSE
DBMS_OUTPUT.PUT_LINE('Product is available in stock.');
END IF;
EXCEPTION
  WHEN product_not_available 
  THEN
DBMS_OUTPUT.PUT_LINE('Product is not available in stock.');
END;
---call 1 PROC USING BLOCK
set serveroutput on
DECLARE
  pid NUMBER := 3;
BEGIN
  productAvailability(pid);
END;
--Call 2 procedure
EXECUTE productAvailability(2);
------------------------------------------

create table PROD(prid number PRIMARY KEY,prname varchar2(20)UNIQUE,
pstock number,cid number,cname varchar2(20));
insert into PROD values(1,'mobile',10,1,'electronic');
insert into PROD values(2,'washing machine',23,2,'household');
insert into PROD values(3,'fridge',56,2,'household');
insert into PROD values(4,'tablet',8,1,'electronic');
insert into PROD values(5,'laptop',35,1,'electronic');
insert into PROD values(6,'sugar',35,3,'grocery');
insert into PROD values(7,'lemon juice',35,4,'drink');
insert into PROD values(8,'table',13,5,null);
 
select * from prod;
---2 user defined 2 implicite
CREATE OR REPLACE PROCEDURE procProduct(C_ID NUMBER) 
IS
  product_not_available exception;
  invalid_category exception;
  p_stock number;
  p_id number;
  pname varchar(20);
  c_name varchar2(20);
BEGIN
select prid,prname,pstock,cname into p_id,pname,p_stock,c_name from prod
where cid=c_id;

IF p_stock < 10 ---4    50 for exc1, 10 for exc2
Then
RAISE product_not_available;
ELSIF c_name IS NULL THEN  ---8
RAISE invalid_category;
ELSE
DBMS_OUTPUT.PUT_LINE('Product is available in stock.');
END IF;
exception
when NO_DATA_FOUND --10
Then
DBMS_OUTPUT.PUT_LINE('ENTER CORRECT CID.');
when TOO_MANY_ROWS ---1
Then
DBMS_OUTPUT.PUT_LINE('scalar variable not hold multiple rows');
WHEN product_not_available 
THEN
DBMS_OUTPUT.PUT_LINE('Product is not available in stock.');
WHEN invalid_category THEN
DBMS_OUTPUT.PUT_LINE('Invalid category name.');
WHEN OTHERS 
THEN
DBMS_OUTPUT.PUT_LINE('other error.');
END;



EXECUTE procProduct(4); 


---------------others exception
set serveroutput on
DECLARE
   num1 number;
   num2 number:=&num2;
BEGIN
    num1 := 10 / num2;
    num1:='kiran';
EXCEPTION
    WHEN ZERO_DIVIDE THEN
DBMS_OUTPUT.PUT_LINE('division by zero.');
WHEN OTHERS 
THEN
DBMS_OUTPUT.PUT_LINE('other error.');
END;




