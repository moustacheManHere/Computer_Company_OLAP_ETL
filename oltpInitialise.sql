Create Database CompAccInc_OLTPRam;

GO

Use CompAccInc_OLTPRam;

CREATE TABLE REGIONS (
	REGION_ID INT PRIMARY KEY,
	REGION_NAME VARCHAR(255)
);

CREATE TABLE COUNTRIES (
	COUNTRY_ID CHAR(2) PRIMARY KEY,
	COUNTRY_NAME VARCHAR(100),
	REGION_ID INT,
	FOREIGN KEY (REGION_ID) REFERENCES REGIONS (REGION_ID)
	);

CREATE TABLE LOCATIONS (
	LOCATION_ID INT PRIMARY KEY,
	LOCATION_ADDRESS VARCHAR(255),
	POSTAL_CODE VARCHAR(20),
	CITY VARCHAR(100),
	LOCATION_STATE VARCHAR(100),
	COUNTRY_ID CHAR(2),
	FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID)
	);

CREATE TABLE WAREHOUSES (
	WAREHOUSE_ID INT PRIMARY KEY,
	WAREHOUSE_NAME VARCHAR(100),
	LOCATION_ID INT,
	FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID)
	);

CREATE TABLE PRODUCT_CATEGORIES (
	CATEGORY_ID INT PRIMARY KEY,
	CATEGORY_NAME VARCHAR(100)
	);

CREATE TABLE PRODUCTS (
	PRODUCT_ID INT PRIMARY KEY,
	PRODUCT_NAME VARCHAR(100),
	PRODUCT_DESCRIPTION TEXT,
	STANDARD_COST DECIMAL(10,2),
	LIST_PRICE DECIMAL(10,2),
	CATEGORY_ID INT,
	FOREIGN KEY (CATEGORY_ID) REFERENCES PRODUCT_CATEGORIES (CATEGORY_ID)
	);

CREATE TABLE INVENTORIES (
	PRODUCT_ID INT,
	WAREHOUSE_ID INT,
	QUANTITY INT,
	PRIMARY KEY (PRODUCT_ID, WAREHOUSE_ID),
	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS (PRODUCT_ID),
	FOREIGN KEY (WAREHOUSE_ID) REFERENCES WAREHOUSES (WAREHOUSE_ID)
	);

CREATE TABLE CUSTOMERS (
	CUSTOMER_ID INT PRIMARY KEY,
	CUSTOMER_NAME VARCHAR(100),
	CUSTOMER_ADDRESS VARCHAR(255),
	WEBSITE TEXT,
	CREDIT_LIMIT INT,
	);

CREATE TABLE CONTACTS (
	CONTACT_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	EMAIL TEXT,
	PHONE VARCHAR(100),
	CUSTOMER_ID INT,
	FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID)
	);

CREATE TABLE EMPLOYEES (
	EMPLOYEE_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	EMAIL TEXT,
	PHONE VARCHAR(100),
	HIRE_DATE DATE,
	MANAGER_ID INT,
	JOB_TITLE VARCHAR(50),
	);

CREATE TABLE ORDERS (
	ORDER_ID INT PRIMARY KEY,
	CUSTOMER_ID INT,
	ORDER_STATUS VARCHAR(20),
	SALESMAN_ID INT,
	ORDER_DATE DATE,
	FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID),
	FOREIGN KEY (SALESMAN_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID),
	);

CREATE TABLE ORDER_ITEMS (
	ORDER_ID INT,
	ITEM_ID INT,
	PRODUCT_ID INT,
	QUANTITY INT,
	UNIT_PRICE DECIMAL(10,2),
	PRIMARY KEY (ORDER_ID, ITEM_ID),
	FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS (PRODUCT_ID)
	);

Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (107,'Summer','Payne','summer.payne@example.com','515.123.8181',cast('07-JUN-16' as date),106,'Public Accountant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (106,'Rose','Stephens','rose.stephens@example.com','515.123.8080',cast('07-JUN-16' as date),2,'Accounting Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (101,'Annabelle','Dunn','annabelle.dunn@example.com','515.123.4444',cast('17-SEP-16' as date),2,'Administration Assistant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (1,'Tommy','Bailey','tommy.bailey@example.com','515.123.4567',cast('17-JUN-16' as date),null,'President');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (3,'Blake','Cooper','blake.cooper@example.com','515.123.4569',cast('13-JAN-16' as date),1,'Administration Vice President');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (2,'Jude','Rivera','jude.rivera@example.com','515.123.4568',cast('21-SEP-16' as date),1,'Administration Vice President');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (11,'Tyler','Ramirez','tyler.ramirez@example.com','515.124.4269',cast('28-SEP-16' as date),9,'Accountant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (10,'Ryan','Gray','ryan.gray@example.com','515.124.4169',cast('16-AUG-16' as date),9,'Accountant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (14,'Elliot','Brooks','elli brooks@example.com','515.124.4567',cast('07-DEC-16' as date),9,'Accountant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (12,'Elliott','James','elliott.james@example.com','515.124.4369',cast('30-SEP-16' as date),9,'Accountant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (13,'Albert','Watson','albert.watson@example.com','515.124.4469',cast('07-MAR-16' as date),9,'Accountant');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (9,'Mohammad','Peterson','mohammad.peterson@example.com','515.124.4569',cast('17-AUG-16' as date),2,'Finance Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (104,'Harper','Spencer','harper.spencer@example.com','515.123.7777',cast('07-JUN-16' as date),2,'Human Resources Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (4,'Louie','Richardson','louie.richardson@example.com','590.423.4567',cast('03-JAN-16' as date),3,'Programmer');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (5,'Nathan','Cox','nathan.cox@example.com','590.423.4568',cast('21-MAY-16' as date),4,'Programmer');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (8,'Bobby','Torres','bobby.torres@example.com','590.423.5567',cast('07-FEB-16' as date),4,'Programmer');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (7,'Charles','Ward','charles.ward@example.com','590.423.4560',cast('05-FEB-16' as date),4,'Programmer');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (6,'Gabriel','Howard','gabriel.howard@example.com','590.423.4569',cast('25-JUN-16' as date),4,'Programmer');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (102,'Emma','Perkins','emma.perkins@example.com','515.123.5555',cast('17-FEB-16' as date),1,'Marketing Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (103,'Amelie','Hudson','amelie.hudson@example.com','603.123.6666',cast('17-AUG-16' as date),102,'Marketing Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (105,'Gracie','Gardner','gracie.gardner@example.com','515.123.8888',cast('07-JUN-16' as date),2,'Public Relations Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (17,'Frederick','Price','frederick.price@example.com','515.127.4563',cast('24-DEC-16' as date),15,'Purchasing Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (16,'Alex','Sanders','alex.sanders@example.com','515.127.4562',cast('18-MAY-16' as date),15,'Purchasing Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (18,'Ollie','Bennett','ollie.bennett@example.com','515.127.4564',cast('24-JUL-16' as date),15,'Purchasing Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (19,'Louis','Wood','louis.wood@example.com','515.127.4565',cast('15-NOV-16' as date),15,'Purchasing Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (20,'Dexter','Barnes','dexter.barnes@example.com','515.127.4566',cast('10-AUG-16' as date),15,'Purchasing Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (15,'Rory','Kelly','rory.kelly@example.com','515.127.4561',cast('07-DEC-16' as date),1,'Purchasing Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (49,'Isabella','Cole','isabella.cole@example.com','011.44.1344.619268',cast('15-OCT-16' as date),1,'Sales Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (48,'Jessica','Woods','jessica.woods@example.com','011.44.1344.429278',cast('10-MAR-16' as date),1,'Sales Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (47,'Ella','Wallace','ella.wallace@example.com','011.44.1344.467268',cast('05-JAN-16' as date),1,'Sales Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (46,'Ava','Sullivan','ava.sullivan@example.com','011.44.1344.429268',cast('01-OCT-16' as date),1,'Sales Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (50,'Mia','West','mia.west@example.com','011.44.1344.429018',cast('29-JAN-16' as date),1,'Sales Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (56,'Evie','Harrison','evie.harrison@example.com','011.44.1344.486508',cast('23-NOV-16' as date),46,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (57,'Scarlett','Gibson','scarlett.gibson@example.com','011.44.1345.429268',cast('30-JAN-16' as date),47,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (58,'Ruby','Mcdonald','ruby.mcdonald@example.com','011.44.1345.929268',cast('04-MAR-16' as date),47,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (59,'Chloe','Cruz','chloe.cruz@example.com','011.44.1345.829268',cast('01-AUG-16' as date),47,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (60,'Isabelle','Marshall','isabelle.marshall@example.com','011.44.1345.729268',cast('10-MAR-16' as date),47,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (61,'Daisy','Ortiz','daisy.ortiz@example.com','011.44.1345.629268',cast('15-DEC-16' as date),47,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (62,'Freya','Gomez','freya.gomez@example.com','011.44.1345.529268',cast('03-NOV-16' as date),47,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (80,'Elizabeth','Dixon','elizabeth.dixon@example.com','011.44.1644.429262',cast('04-JAN-16' as date),50,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (64,'Florence','Freeman','florence.freeman@example.com','011.44.1346.229268',cast('19-MAR-16' as date),48,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (65,'Alice','Wells','alice.wells@example.com','011.44.1346.329268',cast('24-JAN-16' as date),48,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (66,'Charlotte','Webb','charlotte.webb@example.com','011.44.1346.529268',cast('23-FEB-16' as date),48,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (67,'Sienna','Simpson','sienna.simpson@example.com','011.44.1346.629268',cast('24-MAR-16' as date),48,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (68,'Matilda','Stevens','matilda.stevens@example.com','011.44.1346.729268',cast('21-APR-16' as date),48,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (69,'Evelyn','Tucker','evelyn.tucker@example.com','011.44.1343.929268',cast('11-MAR-16' as date),49,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (70,'Eva','Porter','eva.porter@example.com','011.44.1343.829268',cast('23-MAR-16' as date),49,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (71,'Millie','Hunter','millie.hunter@example.com','011.44.1343.729268',cast('24-JAN-16' as date),49,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (72,'Sofia','Hicks','sofia.hicks@example.com','011.44.1343.629268',cast('23-FEB-16' as date),49,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (73,'Lucy','Crawford','lucy.crawford@example.com','011.44.1343.529268',cast('24-MAR-16' as date),49,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (74,'Elsie','Henry','elsie.henry@example.com','011.44.1343.329268',cast('21-APR-16' as date),49,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (75,'Imogen','Boyd','imogen.boyd@example.com','011.44.1644.429267',cast('11-MAY-16' as date),50,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (76,'Layla','Mason','layla.mason@example.com','011.44.1644.429266',cast('19-MAR-16' as date),50,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (77,'Rosie','Morales','rosie.morales@example.com','011.44.1644.429265',cast('24-MAR-16' as date),50,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (78,'Maya','Kennedy','maya.kennedy@example.com','011.44.1644.429264',cast('23-APR-16' as date),50,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (79,'Esme','Warren','esme.warren@example.com','011.44.1644.429263',cast('24-MAY-16' as date),50,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (55,'Grace','Ellis','grace.ellis@example.com','011.44.1344.987668',cast('09-DEC-16' as date),46,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (54,'Lily','Fisher','lily.fisher@example.com','011.44.1344.498718',cast('30-MAR-16' as date),46,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (53,'Sophia','Reynolds','sophia.reynolds@example.com','011.44.1344.478968',cast('20-AUG-16' as date),46,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (52,'Sophie','Owens','sophie.owens@example.com','011.44.1344.345268',cast('24-MAR-16' as date),46,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (51,'Poppy','Jordan','poppy.jordan@example.com','011.44.1344.129268',cast('30-JAN-16' as date),46,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (63,'Phoebe','Murray','phoebe.murray@example.com','011.44.1346.129268',cast('11-NOV-16' as date),48,'Sales Representative');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (85,'Holly','Shaw','holly.shaw@example.com','650.509.1876',cast('27-JAN-16' as date),22,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (86,'Emilia','Holmes','emilia.holmes@example.com','650.509.2876',cast('20-FEB-16' as date),22,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (87,'Molly','Rice','molly.rice@example.com','650.509.3876',cast('24-JUN-16' as date),22,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (88,'Ellie','Robertson','ellie.robertson@example.com','650.509.4876',cast('07-FEB-16' as date),22,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (89,'Jasmine','Hunt','jasmine.hunt@example.com','650.505.1876',cast('14-JUN-16' as date),23,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (90,'Eliza','Black','eliza.black@example.com','650.505.2876',cast('13-AUG-16' as date),23,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (91,'Lilly','Daniels','lilly.daniels@example.com','650.505.3876',cast('11-JUL-16' as date),23,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (92,'Abigail','Palmer','abigail.palmer@example.com','650.505.4876',cast('19-DEC-16' as date),23,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (93,'Georgia','Mills','georgia.mills@example.com','650.501.1876',cast('04-FEB-16' as date),24,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (94,'Maisie','Nichols','maisie.nichols@example.com','650.501.2876',cast('03-MAR-16' as date),24,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (95,'Eleanor','Grant','eleanor.grant@example.com','650.501.3876',cast('01-JUL-16' as date),24,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (96,'Hannah','Knight','hannah.knight@example.com','650.501.4876',cast('17-MAR-16' as date),24,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (97,'Harriet','Ferguson','harriet.ferguson@example.com','650.507.9811',cast('24-APR-16' as date),25,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (98,'Amber','Rose','amber.rose@example.com','650.507.9822',cast('23-MAY-16' as date),25,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (99,'Bella','Stone','bella.stone@example.com','650.507.9833',cast('21-JUN-16' as date),25,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (100,'Thea','Hawkins','thea.hawkins@example.com','650.507.9844',cast('13-JAN-16' as date),25,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (81,'Lola','Ramos','lola.ramos@example.com','650.507.9876',cast('24-JAN-16' as date),21,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (82,'Willow','Reyes','willow.reyes@example.com','650.507.9877',cast('23-FEB-16' as date),21,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (83,'Ivy','Burns','ivy.burns@example.com','650.507.9878',cast('21-JUN-16' as date),21,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (84,'Erin','Gordon','erin.gordon@example.com','650.507.9879',cast('03-FEB-16' as date),21,'Shipping Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (33,'Reggie','Simmons','reggie.simmons@example.com','650.124.8234',cast('10-APR-16' as date),22,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (44,'Emily','Hamilton','emily.hamilton@example.com','650.121.2874',cast('15-MAR-16' as date),25,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (43,'Olivia','Ford','olivia.ford@example.com','650.121.2994',cast('29-JAN-16' as date),25,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (42,'Amelia','Myers','amelia.myers@example.com','650.121.8009',cast('17-OCT-16' as date),25,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (41,'Connor','Hayes','connor.hayes@example.com','650.121.1834',cast('06-APR-16' as date),24,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (26,'Leon','Powell','leon.powell@example.com','650.124.1214',cast('16-JUL-16' as date),21,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (27,'Kai','Long','kai.long@example.com','650.124.1224',cast('28-SEP-16' as date),21,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (28,'Aaron','Patterson','aaron.patterson@example.com','650.124.1334',cast('14-JAN-16' as date),21,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (29,'Roman','Hughes','roman.hughes@example.com','650.124.1434',cast('08-MAR-16' as date),21,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (30,'Austin','Flores','austin.flores@example.com','650.124.5234',cast('20-AUG-16' as date),22,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (31,'Ellis','Washington','ellis.washington@example.com','650.124.6234',cast('30-OCT-16' as date),22,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (32,'Jamie','Butler','jamie.butler@example.com','650.124.7234',cast('16-FEB-16' as date),22,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (45,'Isla','Graham','isla.graham@example.com','650.121.2004',cast('09-JUL-16' as date),25,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (34,'Seth','Foster','seth.foster@example.com','650.127.1934',cast('14-JUN-16' as date),23,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (35,'Carter','Gonzales','carter.gonzales@example.com','650.127.1834',cast('26-AUG-16' as date),23,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (36,'Felix','Bryant','felix.bryant@example.com','650.127.1734',cast('12-DEC-16' as date),23,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (37,'Ibrahim','Alexander','ibrahim.alexander@example.com','650.127.1634',cast('06-FEB-16' as date),23,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (38,'Sonny','Russell','sonny.russell@example.com','650.121.1234',cast('14-JUL-16' as date),24,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (39,'Kian','Griffin','kian.griffin@example.com','650.121.2034',cast('26-OCT-16' as date),24,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (40,'Caleb','Diaz','caleb.diaz@example.com','650.121.2019',cast('12-FEB-16' as date),24,'Stock Clerk');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (25,'Ronnie','Perry','ronnie.perry@example.com','650.123.5234',cast('16-NOV-16' as date),1,'Stock Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (24,'Callum','Jenkins','callum.jenkins@example.com','650.123.4234',cast('10-OCT-16' as date),1,'Stock Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (23,'Jackson','Coleman','jackson.coleman@example.com','650.123.3234',cast('01-MAY-16' as date),1,'Stock Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (22,'Liam','Henderson','liam.henderson@example.com','650.123.2234',cast('10-APR-16' as date),1,'Stock Manager');
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE) values (21,'Jaxon','Ross','jaxon.ross@example.com','650.123.1234',cast('18-JUL-16' as date),1,'Stock Manager');

BULK INSERT CUSTOMERS
FROM 'C:/dengSources/Customers.csv'
WITH (
   FORMAT = 'CSV', -- Skip the header row if applicable
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n'
);

BULK INSERT CONTACTS
FROM 'C:/dengSources/Contacts.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

BULK INSERT REGIONS
FROM 'C:/dengSources/Regions.txt'
WITH
(
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '\n',
	Firstrow = 2
);

BULK INSERT COUNTRIES
FROM 'C:/dengSources/Countries.csv'
WITH (
   FORMAT = 'CSV',
   FIRSTROW = 2,  -- Skip the header row if applicable
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n'
);

BULK INSERT LOCATIONS
	FROM 'C:/dengSources/Locations.csv'
	WITH (
	   FORMAT = 'CSV',
	   FIRSTROW = 2,  -- Skip the header row if applicable
	   FIELDTERMINATOR = ',',
	   ROWTERMINATOR = '\n'
);

BULK INSERT WAREHOUSES
FROM 'C:/dengSources/Warehouses.txt'
WITH
(
    FIELDTERMINATOR = '\t\t',
    ROWTERMINATOR = '\n',
	Firstrow = 2
);
BULK INSERT PRODUCT_CATEGORIES
FROM 'C:/dengSources/Product_Categories.csv'
WITH (
    DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

BULK INSERT PRODUCTS
FROM 'C:/dengSources/Products.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

BULK INSERT INVENTORIES
FROM 'C:/dengSources/Inventories.csv'
WITH (
   FORMAT = 'CSV',
   FIRSTROW = 2,  -- Skip the header row if applicable
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n'
);

DECLARE @Orders VARCHAR(MAX);
SELECT @Orders = BulkColumn
FROM OPENROWSET(BULK 'C:/dengSources/Orders.txt', SINGLE_BLOB) JSON;
SET @Orders = SUBSTRING(@Orders, 4, LEN(@Orders) - 3);

INSERT INTO ORDERS
SELECT *
FROM OPENJSON(@Orders, '$')
WITH (
  ORDER_ID INT '$.order_id',
  CUSTOMER_ID INT '$.customer_id',
  ORDER_STATUS VARCHAR(20) '$.status',
  SALESMAN_ID INT '$.salesman_id',
  ORDER_DATE DATE '$.order_date'
);


DECLARE @OrdersItems VARCHAR(MAX);
SELECT @OrdersItems = BulkColumn
FROM OPENROWSET(BULK 'C:\dengSources\Order_items.txt', SINGLE_BLOB) JSON;
SET @OrdersItems = SUBSTRING(@OrdersItems, 4, LEN(@OrdersItems) - 3);
Insert into ORDER_ITEMS
SELECT *
FROM OPENJSON(@OrdersItems, '$')
WITH (
ORDER_ID INT '$.order_id',
	ITEM_ID INT'$.item_id',
	PRODUCT_ID INT'$.product_id',
	QUANTITY INT'$.quantity',
	UNIT_PRICE DECIMAL(10,2) '$.unit_price'

);