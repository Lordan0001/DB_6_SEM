
CREATE TABLE PRODUCTS2
     (
		ID CHAR(5) NOT NULL,
		DESCRIPTION VARCHAR(20) NOT NULL,
		PRICE DECIMAL(9,2) NOT NULL,
		AVAIL INTEGER NOT NULL,
		PRIMARY KEY (ID));


CREATE TABLE OFFICES2
     (	
		ID INTEGER NOT NULL,
        CITY VARCHAR(15) NOT NULL,
		REGION VARCHAR(10) NOT NULL,
		SALES DECIMAL(9,2) NOT NULL,
		PRIMARY KEY (ID));


CREATE TABLE SALESREPRS2
   (	
		ID INTEGER NOT NULL,
        NAME VARCHAR(15) NOT NULL,
        AGE INTEGER,
		OFFICE INTEGER,
		POSITION VARCHAR(10) , 
		CHECK (POSITION IN('Sales Rep', 'Sales Mgr', 'Trainee')),
		HIRE_DATE DATE NOT NULL,
		MANAGER INTEGER,
		SALES DECIMAL(9,2) NOT NULL,
		PRIMARY KEY (ID),
		FOREIGN KEY (MANAGER) REFERENCES SALESREPRS2(ID),
		CONSTRAINT WORKSIN2 FOREIGN KEY (OFFICE) REFERENCES OFFICES2(ID) ON DELETE SET NULL);


CREATE TABLE CUSTOMERS2
   (
	CUST_NUM INTEGER    NOT NULL,
    COMPANY  VARCHAR(20) NOT NULL,
    CUST_REP INTEGER,
    CREDIT_LIMIT DECIMAL(9,2),
	PRIMARY KEY (CUST_NUM),
	CONSTRAINT HASREP2 FOREIGN KEY (CUST_REP)
	REFERENCES SALESREPRS2(ID) ON DELETE SET NULL);


CREATE TABLE ORDERS2
(
    ID NUMBER(10) NOT NULL,
    CUST NUMBER(10) NOT NULL,
    REPRES NUMBER(10),
    TOTAL_COST NUMBER(9,2) NOT NULL,
    ORDER_DATE DATE NOT NULL,
    PLANNED_D_DAY DATE NOT NULL,
    PAY_DATE DATE DEFAULT NULL,
    CUST_CONFIRM DATE DEFAULT NULL,
    SENDED DATE DEFAULT NULL,
    ENTER_COUNTR DATE DEFAULT NULL,
    POST_OFICE DATE DEFAULT NULL,
    DELIVERED DATE DEFAULT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PLACEDBY2 FOREIGN KEY (CUST) REFERENCES CUSTOMERS2(CUST_NUM) ON DELETE CASCADE,
    CONSTRAINT TAKENBY2 FOREIGN KEY (REPRES) REFERENCES SALESREPRS2(ID) ON DELETE SET NULL
);

CREATE SEQUENCE ORDERS2_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ORDERS2_TRIGGER
BEFORE INSERT ON ORDERS2
FOR EACH ROW
BEGIN
    :NEW.ID := ORDERS2_SEQ.NEXTVAL;
END;

CREATE TABLE ORDERS_CART2(
	ORD_ID int,
	PROD_ID CHAR(5) NOT NULL,
	PROD_COUNT INT,
	CONSTRAINT ISFOR2 FOREIGN KEY (PROD_ID) REFERENCES PRODUCTS2(ID),
	CONSTRAINT ORDER_FOR2 FOREIGN KEY (ORD_ID) REFERENCES ORDERS2(ID)
)

use  Exec_control;
alter session set NLS_DATE_FORMAT='YYYY-MM-DD';


select * from Products;
INSERT INTO PRODUCTS2 VALUES('2A45C','Ratchet Link',79.00,210);
INSERT INTO PRODUCTS2 VALUES('4100Y','Widget Remover',2750.00,25);
INSERT INTO PRODUCTS2 VALUES('XK47 ','Reducer',355.00,38);
INSERT INTO PRODUCTS2 VALUES('41627','Plate',180.00,0);
INSERT INTO PRODUCTS2 VALUES('779C ','900-LB Brace',1875.00,9);
INSERT INTO PRODUCTS2 VALUES('41003','Size 3 Widget',14.00,207);
INSERT INTO PRODUCTS2 VALUES('41004','Size 4 Widget',117.00,139);
INSERT INTO PRODUCTS2 VALUES('887P ','Brace Pin',250.00,24);
INSERT INTO PRODUCTS2 VALUES('XK48 ','Reducer',134.00,203);
INSERT INTO PRODUCTS2 VALUES('2A44L','Left Hinge',4500.00,12);
INSERT INTO PRODUCTS2 VALUES('112  ','Housing',148.00,115);
INSERT INTO PRODUCTS2 VALUES('887H ','Brace Holder',54.00,223);
INSERT INTO PRODUCTS2 VALUES('41089','Retainer',225.00,78);
INSERT INTO PRODUCTS2 VALUES('41001','Size 1 Wiget',55.00,277);
INSERT INTO PRODUCTS2 VALUES('775C ','500-lb Brace',1425.00,5);
INSERT INTO PRODUCTS2 VALUES('4100Z','Widget Installer',2500.00,28);
INSERT INTO PRODUCTS2 VALUES('XK48A','Reducer',177.00,37);
INSERT INTO PRODUCTS2 VALUES('41002','Size 2 Widget',76.00,167);
INSERT INTO PRODUCTS2 VALUES('2A44R','Right Hinge',4500.00,12);
INSERT INTO PRODUCTS2 VALUES('773C ','300-lb Brace',975.00,28);
INSERT INTO PRODUCTS2 VALUES('4100X','Widget Adjuster',25.00,37);
INSERT INTO PRODUCTS2 VALUES('114  ','Motor Mount',243.00,15);
INSERT INTO PRODUCTS2 VALUES('887X ','Brace Retainer',475.00,32);
INSERT INTO PRODUCTS2 VALUES('2A44G','Hinge Pin',350.00,14);

---
---  OFFICES
---
INSERT INTO OFFICES2 VALUES(22,'Denver','Western',186042.00);
INSERT INTO OFFICES2 VALUES(11,'New York','Eastern',692637.00);
INSERT INTO OFFICES2 VALUES(12,'Chicago','Eastern',735042.00);
INSERT INTO OFFICES2 VALUES(13,'Atlanta','Eastern',367911.00);
INSERT INTO OFFICES2 VALUES(21,'Los Angeles','Western',835915.00);

---
---  SALESREPS
---
INSERT INTO SALESREPRS2 VALUES (14,'Bob Smith',33,12,'Sales Mgr','2005-05-19',null,200000.00);
INSERT INTO SALESREPRS2 VALUES (18,'Larry Fitch',62,21,'Sales Mgr','2007-10-12',null,350000.00);
INSERT INTO SALESREPRS2 VALUES (10,'Sam Clark',52,11,'Sales Rep','2006-06-14',null,275000.00);
INSERT INTO SALESREPRS2 VALUES (15,'Mary Jones',31,11,'Sales Rep','2007-10-12',14,392725.00);
INSERT INTO SALESREPRS2 VALUES (105,'Bill Adams',37,13,'Sales Rep','2006-02-12',14,367911.00);
INSERT INTO SALESREPRS2 VALUES (200,'Sue Smith',48,21,'Trainee','2004-12-10',18,10.00);
INSERT INTO SALESREPRS2 VALUES (101,'Dan Roberts',45,12,'Sales Rep','2004-10-20',18,305673.00);
INSERT INTO SALESREPRS2 VALUES (67,'Tom Snyder',41,null,'Sales Rep','2008-01-13',18,75985.00);
INSERT INTO SALESREPRS2 VALUES (21,'Paul Cruz',29,12,'Trainee','2005-03-01',14,0);
INSERT INTO SALESREPRS2 VALUES (17,'Nancy Angelli',49,22,'Sales Rep','2006-11-14',null,186042.00);

---
---   CUSTOMERS
---
INSERT INTO CUSTOMERS2 VALUES(2111,'JCP Inc.',105,50000.00);
INSERT INTO CUSTOMERS2 VALUES(2102,'First Corp.',101,65000.00);
INSERT INTO CUSTOMERS2 VALUES(2103,'Acme Mfg.',105,50000.00);
INSERT INTO CUSTOMERS2 VALUES(2123,'Carter \& Sons',67,40000.00);
INSERT INTO CUSTOMERS2 VALUES(2107,'Ace International',17,35000.00);
INSERT INTO CUSTOMERS2 VALUES(2115,'Smithson Corp.',101,20000.00);
INSERT INTO CUSTOMERS2 VALUES(2101,'Jones Mfg.',14,65000.00);
INSERT INTO CUSTOMERS2 VALUES(2112,'Zetacorp',14,50000.00);
INSERT INTO CUSTOMERS2 VALUES(2121,'QMA Assoc.',15,45000.00);
INSERT INTO CUSTOMERS2 VALUES(2114,'Orion Corp.',67,20000.00);
INSERT INTO CUSTOMERS2 VALUES(2124,'Peter Brothers',14,40000.00);
INSERT INTO CUSTOMERS2 VALUES(2108,'Holm \& Landis',18,55000.00);
INSERT INTO CUSTOMERS2 VALUES(2117,'J.P. Sinclair',14,35000.00);
INSERT INTO CUSTOMERS2 VALUES(2122,'Three Way Lines',105,30000.00);
INSERT INTO CUSTOMERS2 VALUES(2120,'Rico Enterprises',67,50000.00);
INSERT INTO CUSTOMERS2 VALUES(2106,'Fred Lewis Corp.',67,65000.00);
INSERT INTO CUSTOMERS2 VALUES(2119,'Solomon Inc.',18,25000.00);
INSERT INTO CUSTOMERS2 VALUES(2118,'Midwest Systems',14,60000.00);
INSERT INTO CUSTOMERS2 VALUES(2113,'Ian \& Schmidt',10,20000.00);
INSERT INTO CUSTOMERS2 VALUES(2109,'Chen Associates',15,25000.00);
INSERT INTO CUSTOMERS2 VALUES(2105,'AAA Investments',101,45000.00);

---
---  ORDERS
---'2A44L',41003', 
INSERT into ORDERS(CUST, REPRES, TOTAL_COST, ORDER_DATE, PLANNED_D_DAY) VALUES ( 2117, 105, DEFAULT, '2022-03-08', '2022-03-09');
INSERT INTO ORDERS(CUST, REPRES, TOTAL_COST, ORDER_DATE, PLANNED_D_DAY) VALUES (2111,105,DEFAULT,'2022-03-08', '2022-03-09' );
update orders set DELIVERED = '2022-03-10' where id = 1;
INSERT INTO ORDERS2 VALUES ('112989',2101,14,'114' );
INSERT INTO ORDERS VALUES ('113051',2118,105,'XK47' );
INSERT INTO ORDERS VALUES ('112983',2103,105,'41004' );
INSERT INTO ORDERS VALUES ('112963',2103,105,'41004' );
INSERT INTO ORDERS VALUES ('112968',2102,101,'41004' );
INSERT INTO ORDERS VALUES ('113036',2107,101,'4100Z' );
INSERT INTO ORDERS VALUES ('113045',2112,14,'2A44R' );
INSERT INTO ORDERS VALUES ('113007',2112,18,'773C' );
INSERT INTO ORDERS VALUES ('113058',2108,67,'112' );
INSERT INTO ORDERS VALUES ('113024',2114,18,'XK47' );
INSERT INTO ORDERS VALUES ('113062',2124,67,'114' );
INSERT INTO ORDERS VALUES ('112979',2114,17,'4100Z' );
INSERT INTO ORDERS VALUES ('113027',2103,105,'41002' );
INSERT INTO ORDERS VALUES ('113069',2109,17,'775C' );
INSERT INTO ORDERS VALUES ('113034',2107,200,'2A45C' );
INSERT INTO ORDERS VALUES ('112992', 2118, 18, '41002');

---


---
---------
CREATE TABLE Report2
(
    id NUMBER(10) PRIMARY KEY,
    xml_ CLOB
);
CREATE SEQUENCE Report2_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Report2_TRIGGER
BEFORE INSERT ON Report2
FOR EACH ROW
BEGIN
    :NEW.id := Report2_SEQ.NEXTVAL;
END;
/

----------------
drop procedure gen_xml2

CREATE OR REPLACE PROCEDURE gen_xml2
AS
   x XMLTYPE;
BEGIN
   SELECT XMLELEMENT("Root",
                     XMLAGG(
                        XMLELEMENT("Customer2",
                                   XMLFOREST(cust_num AS "CustNum",
                                             company AS "Company",
                                             salesreprs2.name AS "SalesRepName",
                                             salesreprs2.hire_date AS "HireDate")
                                  )
                               )
                    )
     INTO x
     FROM customers2
     JOIN salesreprs2 ON salesreprs2.id = customers2.cust_rep
     JOIN offices2 ON offices2.id = salesreprs2.office;

   DBMS_OUTPUT.PUT_LINE(x.getStringVal());
END;
/
exec gen_xml2

------------------
CREATE OR REPLACE PROCEDURE add_report2
AS
   x CLOB;
BEGIN
   SELECT XMLSERIALIZE(CONTENT XMLELEMENT("newName",
                     XMLAGG(
                        XMLELEMENT("Customer",
                                   XMLFOREST(cust_num AS "CustNum",
                                             company AS "Company",
                                             salesreprs2.name AS "SalesRepName",
                                             salesreprs2.hire_date AS "HireDate")
                                  )
                               )
                    ) AS CLOB INDENT SIZE = 2)
     INTO x
     FROM customers2
     JOIN salesreprs2 ON salesreprs2.id = customers2.cust_rep
     JOIN offices2 ON offices2.id = salesreprs2.office;

   INSERT INTO Report2 (id, xml_)
   VALUES (Report2_SEQ.NEXTVAL, x);
   
   COMMIT;
END;


BEGIN
   add_report2;
   COMMIT;
END;

select * from REPORT2
/
/

/

select * from Report2;

------------
CREATE INDEX xml_ind ON Report2(XMLType(xml_)) INDEXTYPE IS XDB.XMLINDEX;



-----------
CREATE OR REPLACE PROCEDURE xml_search2
AS
   clob_result CLOB;
   xml_result XMLTYPE;
BEGIN
   SELECT XMLQuery('/newName/hire_date'
                  PASSING XMLTYPE(xml_) RETURNING CONTENT)
   INTO xml_result
   FROM Report2;

   IF xml_result IS NOT NULL THEN
      clob_result := xml_result.getClobVal();
      DBMS_OUTPUT.PUT_LINE(clob_result);
   END IF;
END;
/


BEGIN
   xml_search2;
END;
/


