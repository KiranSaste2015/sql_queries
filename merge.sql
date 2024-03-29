--Merge table

CREATE TABLE EMP_SRC
(EID NUMBER,ENAME VARCHAR(20),START_DATE DATE,END_DATE DATE);

INSERT INTO EMP_SRC(EID,ENAME,START_DATE,END_DATE)
VALUES
(1,'KOMAL','12-04-2019','11-03-2023');
INSERT INTO EMP_SRC VALUES(2,'KAJAL','09-06-2018','01-06-2023');
INSERT INTO EMP_SRC VALUES(3,'SONALI','07-04-2020','01-08-2023');
INSERT INTO EMP_SRC VALUES(4,'SHEETAL','12-04-2019','');
INSERT INTO EMP_SRC VALUES(5,'PAYAL','12-04-2019','');

SELECT * FROM EMP_SRC;
COMMIT;
CREATE TABLE EMP_JOIN_REG_DETAILS
(EID NUMBER,ENAME VARCHAR(20),START_DATE DATE,END_DATE DATE,
ETL_CREATE_DATE DATE,ETL_UPDATE_DATE DATE);

SELECT * FROM EMP_JOIN_REG_DETAILS;

MERGE INTO EMP_JOIN_REG_DETAILS TRG -- TARGET TABLE
USING EMP_SRC SRC -- SRC TABLE
ON( TRG.EID = SRC.EID )

WHEN MATCHED 
THEN UPDATE
SET 
TRG.ENAME = SRC.ENAME,
TRG.START_DATE =SRC.START_DATE,
TRG.END_DATE =SRC.END_DATE,
TRG.ETL_UPDATE_DATE=SRC.END_DATE

WHEN NOT MATCHED
THEN
INSERT (TRG.EID,TRG.ENAME,TRG.START_DATE,TRG.END_DATE,TRG.ETL_CREATE_DATE)
VALUES (SRC.EID,SRC.ENAME,SRC.START_DATE,SRC.END_DATE,SRC.START_DATE) ;

TRUNCATE TABLE EMP_SRC;
SELECT * FROM EMP_JOIN_REG_DETAILS TRG;


