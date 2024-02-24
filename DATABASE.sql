/* CAPSTONE PROJECT PHASE THREE*/
use capstone;
show GRANTS;
GRANT FILE ON *.* TO 'root'@'localhost';

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile=1;

/*CREATING THREE TABLES*/
SELECT * FROM table1;

ALTER TABLE table1
ADD COLUMN Sno INT AUTO_INCREMENT PRIMARY KEY FIRST;

/* 1 Write a SQL query to order records by a rental price column in ascending order*/
SELECT *
FROM table1
ORDER BY Rental_Price_INR ASC;

/* 2 Write a SQL query to select unique combinations of City and State with their average Rental Price*/
SELECT City, StateCode, AVG(Rental_Price_INR) AS AverageRentalPrice
FROM table1
GROUP BY City, StateCode;

/* 3 Write a SQL query to select the top 5 highest deposit amounts with corresponding Address and City*/
SELECT Address, City, Deposit_INR
FROM table1
ORDER BY Deposit_INR DESC
LIMIT 5;

/* 4 Write a SQL query to select the count of records for each Country along with the total deposit amount*/
SELECT Country, COUNT(*) AS RecordCount, SUM(CAST(Deposit_INR AS SIGNED)) AS TotalDeposit
FROM table1
GROUP BY Country;

/* 5 Write a SQL query to select records with a Rental Price higher than the average Rental Price across all records.*/
SELECT *
FROM table1
WHERE Rental_Price_INR > (SELECT AVG(Rental_Price_INR) FROM table1);

/* TABLE2 */

SELECT * FROM table2;

ALTER TABLE table2
ADD COLUMN Sno INT AUTO_INCREMENT PRIMARY KEY FIRST;

/* 1 Write a SQL query to select the average area for each number of bedrooms */
SELECT Bedrooms, AVG(Area) AS AverageArea
FROM table2
GROUP BY Bedrooms;

/* 2 Write a SQL query to select records with more than one bathroom and pets allowed. */
SELECT *
FROM table2
WHERE Bathrooms > 1 AND Pets_Allowed = 'YES';

/* 3 Write a SQL query to select the top 3 records with the highest total area (bedrooms + bathrooms) */
SELECT *
FROM table2
ORDER BY (Bedrooms + Bathrooms) DESC
LIMIT 3;


/* 4 Write a SQL query to select the count of records for each combination of bedrooms and bathrooms.*/
SELECT Bedrooms, Bathrooms, COUNT(*) AS RecordCount
FROM table2
GROUP BY Bedrooms, Bathrooms;


/* 5 Write a SQL query to select records with the largest area where pets are allowed */
SELECT *
FROM table2
WHERE Pets_Allowed = 'YES'
ORDER BY Area DESC
LIMIT 1;





/* TABLE 3 */


SELECT * FROM table3;
ALTER TABLE table3
ADD COLUMN Sno INT AUTO_INCREMENT PRIMARY KEY FIRST;

/* 1 Write a SQL query to Select records where both Washer/Dryer and AC are available, and order by Sno.*/
SELECT *
FROM table3
WHERE Washer_Dryer = 'YES' AND AC = 'YES'
ORDER BY Sno;


/* 2  Write a SQL query to Select records where Hardwood floors are available but neither Roofdeck nor Storage is present, and order by Sno in descending order.*/
SELECT *
FROM table3
WHERE Hardwood_Floors = 'YES' AND Roof_Deck = 'NO' AND Storage = 'NO'
ORDER BY Sno DESC;


/* 3 Write a SQL query to Select records where at least four amenities (AC, Parking, Dishwasher, Fireplace) are available, and order by Sno.*/
SELECT *
FROM table3
WHERE AC = 'YES' AND Parking = 'YES' AND Dishwasher = 'YES' AND Fireplace = 'YES'
ORDER BY Sno;


/* 4 Write a SQL query to Select records where neither Roofdeck nor Storage is available, and include the count of such records.*/
SELECT *, COUNT(*) OVER () AS RecordCount
FROM table3
WHERE Roof_Deck = 'NO' AND Storage = 'NO';


/* 5 Write a SQL query to Select records with Parking and either Fireplace or Dishwasher, and include the count of records for each condition.*/
SELECT *, COUNT(*) OVER () AS RecordCount
FROM table3
WHERE Parking = 'YES' AND (Fireplace = 'YES' OR Dishwasher = 'YES');


/* Joining SQL Queries using all 3 tables  */


/* 1 Write a SQL subquery to find records with more than the average area and related details using table 1 and table 2.*/
SELECT t1.*, t2.*
FROM table1 t1
JOIN table2 t2 ON t1.Sno = t2.Sno
WHERE t2.Area > (SELECT AVG(Area) FROM table2);


/* 2 Write a subquery to find records in table1 based on conditions pets allowed is ‘YES’ and no of bed is greater than 3 in table2.*/
SELECT *
FROM table1
WHERE Sno IN (SELECT Sno FROM table2 WHERE Pets_Allowed = 'YES' AND Bedrooms > 3);


/* 3 Write a SQL subquery using both tables (2 and 3) to find records in Table2 with more than 2 bedrooms and related details from Table3 where AC is present.*/
SELECT t2.*, t3.*
FROM table2 t2
JOIN table3 t3 ON t2.Sno = t3.Sno
WHERE t2.Bedrooms > 2 AND t3.AC = 'YES';


/* 4 Write a SQL subquery to find records in Table2 with pets allowed and a Dishwasher, and include related details from Table3.*/
SELECT t2.*, t3.*
FROM table2 t2
JOIN table3 t3 ON t2.Sno = t3.Sno
WHERE t2.Pets_Allowed = 'YES' AND t3.Dishwasher = 'YES';


/* 5 Write a subquery to find records in Table2 with the highest area and related details from Table3 where roofdeck is present.*/
SELECT t2.*, t3.*
FROM table2 t2
JOIN table3 t3 ON t2.Sno = t3.Sno
WHERE t2.Area = (SELECT MAX(Area) FROM table2) AND t3.Roof_Deck = 'YES';


/* 6 Write a SQL Inner Join to combine information from table1 and table 2*/
SELECT t1.*, t2.*
FROM table1 t1
JOIN table2 t2 ON t1.Sno = t2.Sno;


/* 7 Write SQL Subquery to find records in table1 with pets allowed and a Washer/Dryer, and include details from table2 and table3.*/
SELECT t1.*, t2.*, t3.*
FROM table1 t1
JOIN table2 t2 ON t1.Sno = t2.Sno
JOIN table3 t3 ON t1.Sno = t3.Sno
WHERE t2.Pets_Allowed = 'YES' AND t3.Washer_Dryer = 'YES';

/*                          END                                      */












