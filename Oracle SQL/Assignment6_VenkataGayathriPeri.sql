-- BUS-ADM 749 Data and Information Management
-- Venkata Gayathri Peri
-- CPHC OLAP

SET ECHO ON

-- drop existing tables
DROP TABLE Product 		CASCADE CONSTRAINTS PURGE;
DROP TABLE Sales 		CASCADE CONSTRAINTS PURGE;
DROP TABLE Store 	CASCADE CONSTRAINTS PURGE;


-- create new tables as per star schema
CREATE TABLE Product (
    UPC         NUMBER(12)   PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL,
    unitPrice   DECIMAL(10, 2) -- Adjusts decimals upto 2 as per the price
);

CREATE TABLE Sales (
    storeNo     CHAR(4)    NOT NULL,
    UPC         NUMBER(12)   NOT NULL,
   yearMonth   VARCHAR2(7)  NOT NULL,
    quantity    NUMBER       NOT NULL,
    CONSTRAINT Sales_PK PRIMARY KEY (storeNo, UPC, yearMonth)
);

CREATE TABLE Store (
    storeNo     CHAR(4)    PRIMARY KEY,
    street      VARCHAR2(255) NOT NULL,
    city        VARCHAR2(50)  NOT NULL,
    state       VARCHAR2(50)  NOT NULL,
    zip         VARCHAR2(10)  NOT NULL,
    CONSTRAINT Store_zip_check CHECK (LENGTH(zip) = 5) -- Optional: Check for ZIP code length
);
-- list all tables
SELECT * from tab;
DESC Product
DESC Sales
DESC Store
---inserting data into tables----
INSERT INTO Store (storeNo, street, city, state, zip) VALUES('WI01', '100 E Capital Dr', 'Milwaukee', 'WI', 53201);
INSERT INTO Store (storeNo, street, city, state, zip) VALUES('WI04', '199 N Appletree Ave', 'Fox Point', 'WI', 53217);
INSERT INTO Store (storeNo, street, city, state, zip) VALUES('IL01', '844 E Milwaukee Ave', 'Chicago', 'IL', 60601);
INSERT INTO Store (storeNo, street, city, state, zip) VALUES('IL03', '712 W Lincoln St', 'Rockford', 'IL', 60619);
select * from Store;

INSERT INTO Product (UPC, name, manufacturer, unitPrice) VALUES(234569, '4-in-1 Pocket Screwdriver', 'Stanley', 4.29);
INSERT INTO Product (UPC, name, manufacturer, unitPrice) VALUES(236569, 'Hot Melt Glue Gun Kit', 'Stanley', 14.99);
INSERT INTO Product (UPC, name, manufacturer, unitPrice) VALUES(338569, 'Jig Saw with Smart Select Dial', 'Black Decker', 38.99);
INSERT INTO Product (UPC, name, manufacturer, unitPrice) VALUES(340569, '10-Piece Drill Bit Set', 'Black Decker', 5.88);

select * from Product;

INSERT INTO Sales VALUES ('WI01', 234569, '2022-11', 20);
INSERT INTO Sales VALUES ('WI04', 234569, '2022-11', 19);
INSERT INTO Sales VALUES ('IL01', 234569, '2022-11', 18);
INSERT INTO Sales VALUES ('IL03', 234569, '2022-11', 11);
INSERT INTO Sales VALUES ('WI01', 236569, '2022-11', 21);
INSERT INTO Sales VALUES ('WI04', 236569, '2022-11', 20);
INSERT INTO Sales VALUES ('IL01', 236569, '2022-11', 19);
INSERT INTO Sales VALUES ('IL03', 236569, '2022-11', 17);
INSERT INTO Sales VALUES ('WI01', 338569, '2022-11', 22);
INSERT INTO Sales VALUES ('WI04', 338569, '2022-11', 21);
INSERT INTO Sales VALUES ('IL01', 338569, '2022-11', 20);
INSERT INTO Sales VALUES ('IL03', 338569, '2022-11', 24);
INSERT INTO Sales VALUES ('WI01', 340569, '2022-11', 19);
INSERT INTO Sales VALUES ('WI04', 340569, '2022-11', 17);
INSERT INTO Sales VALUES ('IL01', 340569, '2022-11', 19);
INSERT INTO Sales VALUES ('IL03', 340569, '2022-11', 20);
INSERT INTO Sales VALUES ('WI01', 234569, '2022-12', 21);
INSERT INTO Sales VALUES ('WI04', 234569, '2022-12', 21);
INSERT INTO Sales VALUES ('IL01', 234569, '2022-12', 23);
INSERT INTO Sales VALUES ('IL03', 234569, '2022-12', 27);
INSERT INTO Sales VALUES ('WI01', 236569, '2022-12', 21);
INSERT INTO Sales VALUES ('WI04', 236569, '2022-12', 22);
INSERT INTO Sales VALUES ('IL01', 236569, '2022-12', 17);
INSERT INTO Sales VALUES ('IL03', 236569, '2022-12', 19);
INSERT INTO Sales VALUES ('WI01', 338569, '2022-12', 21);
INSERT INTO Sales VALUES ('WI04', 338569, '2022-12', 26);
INSERT INTO Sales VALUES ('IL01', 338569, '2022-12', 22);
INSERT INTO Sales VALUES ('IL03', 338569, '2022-12', 19);
INSERT INTO Sales VALUES ('WI01', 340569, '2022-12', 20);
INSERT INTO Sales VALUES ('WI04', 340569, '2022-12', 21);
INSERT INTO Sales VALUES ('IL01', 340569, '2022-12', 21);
INSERT INTO Sales VALUES ('IL03', 340569, '2022-12', 23);
INSERT INTO Sales VALUES ('WI01', 234569, '2023-01', 27);
INSERT INTO Sales VALUES ('WI04', 234569, '2023-01', 21);
INSERT INTO Sales VALUES ('IL01', 234569, '2023-01', 22);
INSERT INTO Sales VALUES ('IL03', 234569, '2023-01', 17);
INSERT INTO Sales VALUES ('WI01', 236569, '2023-01', 19);
INSERT INTO Sales VALUES ('WI04', 236569, '2023-01', 21);
INSERT INTO Sales VALUES ('IL01', 236569, '2023-01', 20);
INSERT INTO Sales VALUES ('IL03', 236569, '2023-01', 21);
INSERT INTO Sales VALUES ('WI01', 338569, '2023-01', 21);
INSERT INTO Sales VALUES ('WI04', 338569, '2023-01', 23);
INSERT INTO Sales VALUES ('IL01', 338569, '2023-01', 27);
INSERT INTO Sales VALUES ('IL03', 338569, '2023-01', 21);
INSERT INTO Sales VALUES ('WI01', 340569, '2023-01', 22);
INSERT INTO Sales VALUES ('WI04', 340569, '2023-01', 17);
INSERT INTO Sales VALUES ('IL01', 340569, '2023-01', 20);
INSERT INTO Sales VALUES ('IL03', 340569, '2023-01', 21);
INSERT INTO Sales VALUES ('WI01', 234569, '2023-02', 21);
INSERT INTO Sales VALUES ('WI04', 234569, '2023-02', 23);
INSERT INTO Sales VALUES ('IL01', 234569, '2023-02', 27);
INSERT INTO Sales VALUES ('IL03', 234569, '2023-02', 21);
INSERT INTO Sales VALUES ('WI01', 236569, '2023-02', 22);
INSERT INTO Sales VALUES ('WI04', 236569, '2023-02', 17);
INSERT INTO Sales VALUES ('IL01', 236569, '2023-02', 19);
INSERT INTO Sales VALUES ('IL03', 236569, '2023-02', 21);
INSERT INTO Sales VALUES ('WI01', 338569, '2023-02', 20);
INSERT INTO Sales VALUES ('WI04', 338569, '2023-02', 21);
INSERT INTO Sales VALUES ('IL01', 338569, '2023-02', 21);
INSERT INTO Sales VALUES ('IL03', 338569, '2023-02', 23);
INSERT INTO Sales VALUES ('WI01', 340569, '2023-02', 27);
INSERT INTO Sales VALUES ('WI04', 340569, '2023-02', 21);
INSERT INTO Sales VALUES ('IL01', 340569, '2023-02', 22);
INSERT INTO Sales VALUES ('IL03', 340569, '2023-02', 17);

select * from Sales;

-- OLAP queries by Venkata Gayathri Peri
--Q1: Show the grand total of sales revenue from all stores between 2022 and 2023.
SELECT SUM(s.quantity * p.unitPrice) AS "Revenue"
FROM Sales s
JOIN Product p ON s.UPC = p.UPC
WHERE TO_NUMBER(SUBSTR(s.yearMonth, 1, 4)) BETWEEN 2022 AND 2023;
--Q2: Show the total sales revenue in Wisconsin in 2023.

SELECT SUM(s.quantity * p.unitPrice) AS "Revenue"
FROM Sales s
JOIN Product p ON s.UPC = p.UPC
JOIN Store st ON s.storeNo = st.storeNo
WHERE TO_NUMBER(SUBSTR(s.yearMonth, 1, 4)) = 2023
  AND st.state = 'WI';
--Q3: Show the total sales revenue by city, manufacturer, and month.
SELECT 
    st.state AS "St",
    st.city AS "City",
    p.manufacturer AS "Manufacturer",
    s.yearMonth AS "YearMon",
    SUM(s.quantity * p.unitPrice) AS "Revenue"
FROM  Sales s
JOIN Product p ON s.UPC = p.UPC
JOIN Store st ON s.storeNo = st.storeNo
GROUP BY st.state, st.city, p.manufacturer, s.yearMonth
ORDER BY st.state, st.city, p.manufacturer, s.yearMonth;

--Q4: Show the total sales revenue by state, manufacturer, and year.
SELECT st.state AS "St",
    p.manufacturer AS "Manufacturer",
    SUBSTR(s.yearMonth, 1, 4) AS "Year",
    SUM(s.quantity * p.unitPrice) AS "Revenue"
FROM Sales s
JOIN  Product p ON s.UPC = p.UPC
JOIN Store st ON s.storeNo = st.storeNo
GROUP BY st.state, p.manufacturer, SUBSTR(s.yearMonth, 1, 4)
ORDER BY st.state, p.manufacturer, SUBSTR(s.yearMonth, 1, 4);

--Q5: Show the total sales revenue by state and year.
SELECT  st.state AS "St",
    SUBSTR(s.yearMonth, 1, 4) AS "Year",
    SUM(s.quantity * p.unitPrice) AS "TotalRevenue"
FROM  Sales s
JOIN Product p ON s.UPC = p.UPC
JOIN Store st ON s.storeNo = st.storeNo
GROUP BY st.state, SUBSTR(s.yearMonth, 1, 4)
ORDER BY st.state, SUBSTR(s.yearMonth, 1, 4);
--Q6: Show the total sales revenue by state
SELECT  st.state AS "St",SUM(s.quantity * p.unitPrice) AS "TotalRevenue"
FROM Sales s
JOIN  Product p ON s.UPC = p.UPC
JOIN  Store st ON s.storeNo = st.storeNo
GROUP BY st.state
ORDER BY  st.state;
--Q7: Show the totals, subtotals, and grand total (i.e., rollup) of sales revenue by state, manufacturer, and year.
SELECT 
    st.state AS "St",
    p.manufacturer AS "Manufacturer",
    SUBSTR(s.yearMonth, 1, 4) AS "Year",
    SUM(s.quantity * p.unitPrice) AS "TotalRevenue"
FROM Sales s
JOIN  Product p ON s.UPC = p.UPC
JOIN  Store st ON s.storeNo = st.storeNo
GROUP BY ROLLUP (st.state, p.manufacturer, SUBSTR(s.yearMonth, 1, 4))
ORDER BY st.state, p.manufacturer, SUBSTR(s.yearMonth, 1, 4);
    
--Q8: Show all possible subtotals (i.e., cube) of sales revenue by state, manufacturer, and year.
SELECT 
    st.state AS "State",
    p.manufacturer AS "Manufacturer",
    SUBSTR(s.yearMonth, 1, 4) AS "Year",
    SUM(s.quantity * p.unitPrice) AS "TotalRevenue"
FROM Sales s
JOIN Product p ON s.UPC = p.UPC
JOIN Store st ON s.storeNo = st.storeNo
GROUP BY CUBE (st.state, p.manufacturer, SUBSTR(s.yearMonth, 1, 4))
ORDER BY st.state, p.manufacturer, SUBSTR(s.yearMonth, 1, 4);
-- Q9: Rank the cities by their total sales revenue in 2023.
SELECT 
    st.state AS "St",
    st.city AS "City",
    SUM(s.quantity * p.unitPrice) AS "Revenue",
    RANK() OVER (ORDER BY SUM(s.quantity * p.unitPrice) DESC) AS "Ranking",
    DENSE_RANK() OVER (ORDER BY SUM(s.quantity * p.unitPrice) DESC) AS "DenseRanking"
FROM 
    Sales s
JOIN 
    Product p ON s.UPC = p.UPC
JOIN 
    Store st ON s.storeNo = st.storeNo
WHERE 
    SUBSTR(s.yearMonth, 1, 4) = '2023'
GROUP BY 
    st.state, st.city
ORDER BY 
    "Revenue" DESC, "St", "City";
-- Q10: Show the monthly total rentals and bimonthly moving total sales revenue in Wisconsin.
SELECT 
    "YearMonth",
    "Revenue",
    SUM("Revenue") OVER (ORDER BY "YearMonth" ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS "Bimonthly"
FROM (
    SELECT 
        s.yearMonth AS "YearMonth",
        SUM(s.quantity * p.unitPrice) AS "Revenue"
    FROM 
        Sales s
    JOIN 
        Product p ON s.UPC = p.UPC
    JOIN 
        Store st ON s.storeNo = st.storeNo
    WHERE 
        st.state = 'WI'
    GROUP BY 
        s.yearMonth
) MonthlySales
ORDER BY 
    "YearMonth";
