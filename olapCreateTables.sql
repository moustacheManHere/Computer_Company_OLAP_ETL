CREATE DATABASE CompAccInc_DWRam;

GO

USE CompAccInc_DWRam;

CREATE TABLE CUSTOMER_DIM (
	CUSTOMER_KEY INT IDENTITY(1,1) PRIMARY KEY,  
	CUSTOMER_ID INT NOT NULL,
	CUSTOMER_NAME VARCHAR(100) NOT NULL,
	CUSTOMER_ADDRESS VARCHAR(255) NOT NULL,
	WEBSITE TEXT,
	CREDIT_LIMIT INT NOT NULL
);

CREATE TABLE PRODUCT_DIM (
	PRODUCT_KEY INT IDENTITY(1,1) PRIMARY KEY, 
	PRODUCT_ID INT NOT NULL,
	PRODUCT_NAME VARCHAR(100) NOT NULL,
	PRODUCT_DESCRIPTION TEXT,
	STANDARD_COST DECIMAL(10,2),
	LIST_PRICE DECIMAL(10,2),
	CATEGORY_NAME VARCHAR(100),
	STOCK INT
);

CREATE TABLE ORDERS_DIM (
	ORDER_KEY INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ORDER_ID INT NOT NULL,
	ORDER_STATUS VARCHAR(20) NOT NULL,
	ORDER_DATE DATE NOT NULL,
	ITEM_ID INT NOT NULL
);

CREATE TABLE EMPLOYEE_DIM (
	EMPLOYEE_KEY INT IDENTITY(1,1) PRIMARY KEY, 
	EMPLOYEE_ID INT NOT NULL,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL,
	PHONE VARCHAR(20),
	HIRE_DATE DATE NOT NULL,
	MANAGER_ID INT,
	JOB_TITLE VARCHAR(50) NOT NULL
);


CREATE TABLE TIME_DIM (
    TIME_Key VARCHAR(20) PRIMARY KEY NOT NULL,
    TIME_YEAR INT NOT NULL,
    TIME_QUARTER SMALLINT NOT NULL,
    TIME_MONTH SMALLINT NOT NULL,
    TIME_WEEK SMALLINT NOT NULL,
    TIME_DATE INT NOT NULL,
    TIME_DAY SMALLINT NOT NULL
);

CREATE TABLE SALES_FACT(
	ORDER_KEY INT NOT NULL,
	CUSTOMER_KEY INT NOT NULL,
	PRODUCT_KEY INT NOT NULL,
	EMPLOYEE_KEY INT NOT NULL,
	TIME_KEY VARCHAR(20) NOT NULL,
	QUANTITY INT NOT NULL,
	UNIT_PRICE DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (ORDER_KEY, CUSTOMER_KEY, PRODUCT_KEY, EMPLOYEE_KEY, TIME_KEY),
	FOREIGN KEY (ORDER_KEY) REFERENCES ORDERS_DIM (ORDER_KEY),
	FOREIGN KEY (CUSTOMER_KEY) REFERENCES CUSTOMER_DIM (CUSTOMER_KEY),
	FOREIGN KEY (PRODUCT_KEY) REFERENCES PRODUCT_DIM (PRODUCT_KEY),
	FOREIGN KEY (EMPLOYEE_KEY) REFERENCES EMPLOYEE_DIM (EMPLOYEE_KEY),
	FOREIGN KEY (TIME_KEY) REFERENCES TIME_DIM (TIME_KEY)
);

