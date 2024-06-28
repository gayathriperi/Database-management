-- 1Q create new tables
--1
DROP TABLE Employee		CASCADE CONSTRAINTS PURGE; --- drop in case of any issues and create table again

CREATE TABLE Office (
  officeNo NUMBER(5) PRIMARY KEY,
  fax VARCHAR2(20), 
  officeSize NUMBER(10, 2), 
 capacity NUMBER(1, 0) CHECK (capacity BETWEEN 1 AND 5)--since at beginning of conceptual design we assumed not more than 5 people can work in office
  
);

--2
CREATE TABLE Employee (
  ID NUMBER(5) PRIMARY KEY,
  firstName VARCHAR2(50), 
  lastName VARCHAR2(50), 
  title VARCHAR2(50), 
  gender CHAR(1) CHECK (gender IN ('M', 'F')),
  homePhone VARCHAR2(15), 
  workPhone VARCHAR2(15), 
  birthdate DATE,
  hireDate DATE,
  officeNo NUMBER(5) NOT NULL,
  CONSTRAINT fk_officeNo FOREIGN KEY (officeNo) REFERENCES Office(officeNo),
  CONSTRAINT check_age CHECK ((MONTHS_BETWEEN(hireDate, birthdate) / 12 > 18)) 
);

--3
CREATE TABLE Salesperson (
  ID NUMBER(5) PRIMARY KEY,
  cellPhone VARCHAR2(15) UNIQUE,
  commission NUMBER(5, 2) CHECK (commission BETWEEN 0 AND 25),
  manager NUMBER(5),
  CONSTRAINT fk_employee_id FOREIGN KEY (ID) REFERENCES Employee(ID),
  CONSTRAINT fk_manager_id FOREIGN KEY (manager) REFERENCES Salesperson(ID)
); --Constraint: “The supervision relationship between salespersons is hierarchical up to three levels.” this cannot be shown in table as its an integrity constraint

--4
CREATE TABLE Backup (
  salesperson NUMBER(5),
  backup NUMBER(5),
  PRIMARY KEY (salesperson, backup),
  CONSTRAINT fk_salesperson_id FOREIGN KEY (salesperson) REFERENCES Salesperson(ID),
  CONSTRAINT fk_backup_id FOREIGN KEY (backup) REFERENCES Salesperson(ID),
  CONSTRAINT ifbackup CHECK (salesperson <> backup)
); 

--5
CREATE TABLE Client (
  clientNo NUMBER(5) PRIMARY KEY,
  name VARCHAR2(50), 
  streetAddress VARCHAR2(100),
  city VARCHAR2(50), 
  state VARCHAR2(2), 
  zip VARCHAR2(10), 
  salesperson NUMBER(5) NOT NULL,
  CONSTRAINT fk_salesman_id FOREIGN KEY (salesperson) REFERENCES Salesperson(ID)
);

--6
CREATE TABLE ClientPhone (
  clientNo NUMBER(5),
  phone VARCHAR2(15), 
  PRIMARY KEY (clientNo, phone),
  CONSTRAINT fk_clientNo FOREIGN KEY (clientNo) REFERENCES Client(clientNo)
  --Constraint: “Each client has one to three phones.”
);

--7
CREATE TABLE ClientEmployee (
  clientNo NUMBER(5),
  employeeID NUMBER(5),
  firstName VARCHAR2(50), -- Adjust the length as needed
  lastName VARCHAR2(50), -- Adjust the length as needed
  title VARCHAR2(50), -- Adjust the length as needed
  PRIMARY KEY (clientNo, employeeID),
  CONSTRAINT fk_clientNo_clientEmployee FOREIGN KEY (clientNo) REFERENCES Client(clientNo)
);

-- 8
CREATE TABLE ClientEmployeePhone (
  clientNo NUMBER(5),
  employeeID NUMBER(5),
  phone VARCHAR2(15), -- Adjust the length as needed
  PRIMARY KEY (clientNo, employeeID, phone),
  CONSTRAINT fk_clientEmployee_clientEmployeePhone FOREIGN KEY (clientNo, employeeID) REFERENCES ClientEmployee(clientNo, employeeID)
);

--9
CREATE TABLE Product (
  UPC NUMBER(13), -- Assuming 13 digits for UPC
  name VARCHAR2(100), -- Adjust the length as needed
  manufacturer VARCHAR2(50), -- Adjust the length as needed
  unitPrice NUMBER(10, 2), -- Adjust precision and scale as needed
  PRIMARY KEY (UPC)
);

--10
CREATE TABLE Contains (
  wholeProduct NUMBER(13), -- Assuming 13 digits for UPC
  part NUMBER(13), -- Assuming 13 digits for UPC
  quantity NUMBER(5), -- Adjust as needed
  PRIMARY KEY (wholeProduct, part),
  CONSTRAINT fk_wholeProduct FOREIGN KEY (wholeProduct) REFERENCES Product(UPC),
  CONSTRAINT fk_part FOREIGN KEY (part) REFERENCES Product(UPC),
  CONSTRAINT check_quantity CHECK (quantity >= 1),
  CONSTRAINT check_wholeProduct_not_equal_part CHECK (wholeProduct <> part)
);

--11
CREATE TABLE Sells (
  salesperson NUMBER(5),
  UPC NUMBER(13), -- Assuming 13 digits for UPC
  PRIMARY KEY (salesperson, UPC),
  CONSTRAINT fk_sellingsalesman FOREIGN KEY (salesperson) REFERENCES Salesperson(ID),
  CONSTRAINT fk_UPC_code FOREIGN KEY (UPC) REFERENCES Product(UPC)
);

--12
CREATE TABLE Sale (
  invoiceNo NUMBER(10), -- Adjust the length as needed
  invoiceDate DATE,
  salesperson NUMBER(5),
  client NUMBER(5),
  PRIMARY KEY (invoiceNo),
  CONSTRAINT fk_salemaker FOREIGN KEY (salesperson) REFERENCES Salesperson(ID),
  CONSTRAINT fk_client_sale FOREIGN KEY (client) REFERENCES Client(clientNo),
  CONSTRAINT check_salesperson_not_null CHECK (salesperson IS NOT NULL),
  CONSTRAINT check_client_not_null CHECK (client IS NOT NULL)
);

--13
CREATE TABLE SaleItem (
  invoiceNo NUMBER(10), -- Adjust the length as needed
  UPC NUMBER(13), -- Assuming 13 digits for UPC
  quantity NUMBER(5), -- Adjust as needed
  PRIMARY KEY (invoiceNo, UPC),
  CONSTRAINT fk_invoiceNo_saleItem FOREIGN KEY (invoiceNo) REFERENCES Sale(invoiceNo),
  CONSTRAINT fk_UPC_saleItem FOREIGN KEY (UPC) REFERENCES Product(UPC),
  CONSTRAINT checkquantity CHECK (quantity >= 1)
);

--14
CREATE TABLE Payment (
  paymentNo NUMBER(10), -- Adjust the length as needed
  invoiceNo NUMBER(10), -- Adjust the length as needed
  receivingEmployee NUMBER(5), -- Adjust as needed
  clientNo NUMBER(5), -- Adjust as needed
  authorizingEmployee NUMBER(5), -- Adjust as needed
  paymentDate DATE,
  method VARCHAR2(50), -- Adjust the length as needed
  amount NUMBER(10, 2), -- Adjust precision and scale as needed
  PRIMARY KEY (paymentNo),
  CONSTRAINT fk_invoiceNo_payment FOREIGN KEY (invoiceNo) REFERENCES Sale(invoiceNo),
  CONSTRAINT fk_receivingEmployee_payment FOREIGN KEY (receivingEmployee) REFERENCES Employee(ID),
  CONSTRAINT fk_clientNo_authorizingEmployee_payment FOREIGN KEY (clientNo, authorizingEmployee) REFERENCES ClientEmployee(clientNo, employeeID),
  CONSTRAINT check_invoiceNo_not_null CHECK (invoiceNo IS NOT NULL),
  CONSTRAINT check_receivingEmployee_not_null CHECK (receivingEmployee IS NOT NULL),
  CONSTRAINT check_clientNo_not_null CHECK (clientNo IS NOT NULL),
  CONSTRAINT check_authorizingEmployee_not_null CHECK (authorizingEmployee IS NOT NULL)
);
--------------TABLE CREATION COMPLETED-------------

-------2Q data insertion--------
---office table----
-- Insert data into the Office table
INSERT INTO Office (OFFICENO, FAX, OFFICESIZE, CAPACITY)
VALUES (101, '4142295999', 500, 1);

INSERT INTO Office (OFFICENO, FAX, OFFICESIZE, CAPACITY)
VALUES (102, '4142295998', 1000, 5);

INSERT INTO Office (OFFICENO, FAX, OFFICESIZE, CAPACITY)
VALUES (103, '4142295998', 1000, 5);

INSERT INTO Office (OFFICENO, FAX, OFFICESIZE, CAPACITY)
VALUES (104, '4142295997', 1000, 5);

INSERT INTO Office (OFFICENO, FAX, OFFICESIZE, CAPACITY)
VALUES (105, '4142295997', 1000, 5);
----------------- insert into employee------------

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (101, 'Anette', 'Larreau', 'CEO', 'F', 101, '25-JAN-52');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (102, 'Michel', 'Dolan', 'Sales Manager', 'F', 102, '13-MAY-62');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (103, 'Brian', 'Wiggins', 'Sales Representative', 'M', 102,'03-JUL-72');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (104, 'Wendell', 'Thomas', 'Sales Representative', 'F', 102, '14-FEB-85');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (105, 'Salena', 'Dimas', 'Sales Representative', 'F', 102, '15-MAR-57');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (106, 'Terri', 'Smith', 'Sales Representative', 'F', 102, '18-JUL-55');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (107, 'Larry', 'Moxly', 'Sales Manager', 'M', 103,'15-AUG-63');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (108, 'Jim', 'Jones', 'Sales Representative', 'M', 103, '31-AUG-58');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (109, 'Chris', 'Bailey', 'Sales Representative', 'F', 103, '16-JAN-94');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (110, 'Romila', 'Sprangler', 'Sales Representative', 'F', 103, '05-FEB-80');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (111, 'Coco', 'Bronson', 'Sales Representative', 'F', 103, '30-APR-74');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (112, 'Rita', 'Freeman', 'Sales Manager', 'F', 104, '26-AUG-67');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (113, 'Anita', 'Grost', 'Sales Representative', 'F', 104, '25-NOV-81');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (114, 'Joanne', 'Danger', 'Sales Representative', 'F', 104, '24-JAN-72');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (115, 'Steven', 'Nickolsen', 'Sales Representative', 'M', 104,'08-JUN-78');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (116, 'Joy', 'Yun', 'Sales Representative', 'F', 104, '18-MAY-52');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (117, 'Rachel', 'Hamilton', 'Sales Manager', 'F', 105,'15-MAY-54');

INSERT INTO Employee (ID, FIRSTNAME, LASTNAME, TITLE, GENDER, OFFICENO, BIRTHDATE)
VALUES (118, 'Nathanael', 'Tyre', 'Sales Representative', 'F', 105,'07-JUL-82');
--------sales person----------
INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (102, '4142296540', 25, NULL);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (103, '4142296539', 20, 102);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (104, '4142296538', 20, 102);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (105, '4142296537', 10, 104);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (106, '4142296536', 10, 103);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (107, '4142296535', 25, NULL);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (108, '4142296534', 20, 107);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (109, '4142296533', 20, 107);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (110, '4142296532', 20, 107);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (111, '4142296531', 20, 107);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (112, '4142296530', 25, NULL);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (113, '4142296529', 20, 112);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (114, '4142296528', 20, 112);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (115, '4142296527', 10, 113);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (116, '4142296526', 10, 114);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (117, '4142296525', 25, NULL);

INSERT INTO Salesperson (ID, CELLPHONE, COMMISSION, MANAGER)
VALUES (118, '4142296524', 20, 117);
------------- product table data insertion-------

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (234569, '4-in-1 Pocket Screwdriver', 'Stanley', 4.29);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (235569, 'Powerlock Measuring Tape', 'Stanley', 4.29);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (236569, 'Hot Melt Glue Gun Kit', 'Stanley', 14.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (237569, 'Retractable Utility Knife', 'Stanley', 3.29);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (238569, '6-piece Screwdriver Set', 'Stanley', 8.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (239569, 'Soft Sided Tool Bag', 'Stanley', 8.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (338569, 'Jig Saw with Smart Select Dial', 'Black Decker', 38.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (339569, 'Lithium Ion Dust Buster', 'Black Decker', 59.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (340569, '10-Piece Drill Bit Set', 'Black Decker', 5.88);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (438569, '7-1/4-Inch Circular Saw Kit', 'Skill', 42.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (439569, '10-Inch Drill Press', 'Skill', 119.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (440569, 'Lithium-Ion Drill/Driver', 'Skill', 35.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (541569, '10-Inch Compound Miter Saw', 'Hitachi', 134.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (542569, '1/2-Inch Drill/Driver', 'Hitachi', 129.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (543569, '5/8-Inch to 2-Inch Brad Nailer', 'Hitachi', 69.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (544569, 'Drill And Drive Bit Set', 'Hitachi', 28.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (545569, 'Gauge Micro Pin Nailer', 'Hitachi', 89.99);

INSERT INTO Product (UPC, NAME, MANUFACTURER, UNITPRICE)
VALUES (546569, 'Narrow Crown Finish Stapler', 'Hitachi', 79.99);
---------sells table data insertion-------------------
-- Insert data into the Sells table
INSERT INTO Sells (SALESPERSON, UPC) VALUES (102, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (103, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (103, '235569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (104, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (104, '235569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (104, '338569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (105, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (105, '235569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (105, '236569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (105, '237569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (105, '238569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (105, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (106, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (106, '339569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (107, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (107, '339569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (108, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (108, '235569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (108, '236569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (108, '237569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (108, '238569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (108, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (109, '339569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (109, '438569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (110, '541569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (110, '542569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (110, '543569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (110, '544569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (110, '545569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (110, '546569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '235569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '236569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '237569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '238569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (111, '541569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (112, '541569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (113, '338569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (113, '339569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (113, '340569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (113, '438569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (113, '439569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (113, '440569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (114, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '234569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '235569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '236569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '237569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '238569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (115, '541569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (116, '438569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (116, '542569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (117, '239569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (117, '541569');
INSERT INTO Sells (SALESPERSON, UPC) VALUES (118, '541569');
---------------DATA INSERTION INTO TABLES COMPLETED ------------
----3Q QUERIES----------------•	
--1. Get the ID, first name, last name, and birthdate of every employee of CPHC.
SELECT ID,FIRSTNAME,LASTNAME,BIRTHDATE FROM EMPLOYEE;
--2.Get the ID, name (first name plus last name), and age of every female employee of CPHC.
SELECT ID, firstName || ' ' || lastName AS Name , TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12) AS Age
FROM Employee WHERE GENDER='F';


--3. Get the ID, name, and age of every female salesperson.
SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
WHERE E.GENDER = 'F';

--4. Get the ID, name, and age of every female salesperson who sells some products manufactured by Stanley.
SELECT DISTINCT E.ID,   
-- Used disntict as it was giving same salesperson name for multiple products manufactured by stanley and we here 
-- just need salesperson who is female and sells stanley products
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
JOIN Sells SE ON E.ID = SE.SALESPERSON
JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F'  AND P.MANUFACTURER = 'Stanley';
--5.Get the following about every female salesperson who sells some products manufactured by Stanley: ID, name, age, and products (UPC and manufacturer) authorized to sell. Include products not manufactured by Stanley too.
SELECT DISTINCT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age,
       P.UPC,
       P.MANUFACTURER
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
LEFT JOIN Sells SE ON E.ID = SE.SALESPERSON
LEFT JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F' AND E.ID IN(SELECT E.ID FROM  Employee E
JOIN Salesperson S ON E.ID = S.ID
JOIN Sells SE ON E.ID = SE.SALESPERSON
JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F'  AND P.MANUFACTURER = 'Stanley'); -- WHO EVER SOLD STANLEY ARE AUTHORIZED, AND WE ARE CHECKING FROM THEM , WHAT OTHER MANUFACTERERS PRODUCTS THEY CAN SELL
--6.Get the following about every female salesperson who sells some products manufactured by Stanley: ID, name, age, number of products authorized to sell, and number of manufacturers of these products.
SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age,
       COUNT(P.UPC) AS PRODUCTS,
       COUNT(DISTINCT P.MANUFACTURER) AS MANUFACTURERS
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
LEFT JOIN Sells SE ON E.ID = SE.SALESPERSON
LEFT JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F' AND E.ID IN (
    SELECT E.ID
    FROM Employee E
    JOIN Salesperson S ON E.ID = S.ID
    JOIN Sells SE ON E.ID = SE.SALESPERSON
    JOIN Product P ON SE.UPC = P.UPC
    WHERE E.GENDER = 'F' AND P.MANUFACTURER = 'Stanley'
)
GROUP BY E.ID, E.FIRSTNAME, E.LASTNAME, E.BIRTHDATE
ORDER BY E.ID ASC;

--7.Get the following about every female salesperson who sells products from multiple manufactures or more than five products: ID, name, age, number of products authorized to sell, and number of manufacturers of these products.
SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age,
       COUNT(DISTINCT P.UPC) AS PRODUCTS,
       COUNT(DISTINCT P.MANUFACTURER) AS MANUFACTURES
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
LEFT JOIN Sells SE ON E.ID = SE.SALESPERSON
LEFT JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F' AND E.ID IN (
    SELECT E.ID
    FROM Employee E
    JOIN Salesperson S ON E.ID = S.ID
    JOIN Sells SE ON E.ID = SE.SALESPERSON
    JOIN Product P ON SE.UPC = P.UPC
    WHERE E.GENDER = 'F'
    GROUP BY E.ID
    HAVING COUNT(DISTINCT P.UPC) > 5 OR COUNT(DISTINCT P.MANUFACTURER) > 1
)
GROUP BY E.ID, E.FIRSTNAME, E.LASTNAME, E.BIRTHDATE
ORDER BY E.ID ASC;


--8.Get the following about every female salesperson who sells products from multiple manufactures or more than five products, but does not sell any product by Stanley: ID, name, age, number of products authorized to sell, and number of manufacturers of these products.
SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age,
       COUNT(P.UPC) AS PRODUCTS,
       COUNT(DISTINCT P.MANUFACTURER) AS MANUFACTURES
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
LEFT JOIN Sells SE ON E.ID = SE.SALESPERSON
LEFT JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F' AND E.ID IN (
    SELECT E.ID
    FROM Employee E
    JOIN Salesperson S ON E.ID = S.ID
    JOIN Sells SE ON E.ID = SE.SALESPERSON
    JOIN Product P ON SE.UPC = P.UPC
    WHERE E.GENDER = 'F' AND P.MANUFACTURER = 'Stanley'
)
GROUP BY E.ID, E.FIRSTNAME, E.LASTNAME, E.BIRTHDATE
ORDER BY E.ID ASC;

SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age,
       COUNT(DISTINCT P.UPC) AS PRODUCTS,
       COUNT(DISTINCT P.MANUFACTURER) AS MANUFACTURES
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
LEFT JOIN Sells SE ON E.ID = SE.SALESPERSON
LEFT JOIN Product P ON SE.UPC = P.UPC
WHERE E.GENDER = 'F' AND E.ID IN (
    SELECT E.ID
    FROM Employee E
    JOIN Salesperson S ON E.ID = S.ID
    JOIN Sells SE ON E.ID = SE.SALESPERSON
    JOIN Product P ON SE.UPC = P.UPC
    WHERE E.GENDER = 'F' AND P.MANUFACTURER <> 'Stanley'
    GROUP BY E.ID
    HAVING COUNT(DISTINCT P.UPC) > 5 OR COUNT(DISTINCT P.MANUFACTURER) > 1
)
GROUP BY E.ID, E.FIRSTNAME, E.LASTNAME, E.BIRTHDATE;

--9.Get the ID, name, age, and manager name (if any) of every female salesperson  
SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS Age,
       M.FIRSTNAME || ' ' || M.LASTNAME AS ManagerName
FROM Employee E
JOIN Salesperson S ON E.ID = S.ID
LEFT JOIN Employee M ON S.MANAGER = M.ID
WHERE E.GENDER = 'F'
ORDER BY E.ID ASC;


--10 •	Get the ID, name and age of every female salesperson who sells all of the products manufactured by Stanley. (Hint: This query involves the Division operation in relational algebra, but is notoriously difficult to write in SQL. Consider using sub-queries. Restate the query as “Find every female salesperson, such that there does NOT exist any product manufactured by Staley that the salesperson does NOT sell”).
SELECT E.ID,
       E.FIRSTNAME || ' ' || E.LASTNAME AS NAME,  TRUNC(MONTHS_BETWEEN(SYSDATE, E.BIRTHDATE) / 12) AS AGE
FROM Employee E
WHERE E.GENDER = 'F'
  AND NOT EXISTS (
    SELECT P.UPC
    FROM Product P
    WHERE P.MANUFACTURER = 'Stanley'
    MINUS
    SELECT S.UPC
    FROM Sells S
    WHERE S.SALESPERSON = E.ID
  );








