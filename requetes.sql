-- 1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle. */
SELECT * FROM HumanResources.Employee ORDER BY jobtitle;

-- 2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname.
SELECT * FROM Person.Person AS employe ORDER BY LastName;

-- 3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.
SELECT firstname, lastname, businessentityid as employee_id FROM Person.person ORDER BY lastname;

-- 4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.
SELECT ProductID, ProductNumber, Name FROM Production.Product WHERE SellStartDate IS NOT NULL AND ProductLine='T'ORDER BY Name;

-- 5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.
SELECT salesorderid, customerid, orderdate, subtotal,(taxamt/subtotal*100) as tax_percent FROM sales.salesorderheader ORDER BY subtotal DESC ;

-- 6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.
SELECT DISTINCT jobtitle FROM HumanResources.Employee ORDER BY jobtitle ASC;

-- 7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.
SELECT customerid, SUM(freight) FROM sales.salesorderheader GROUP BY customerid ORDER BY customerid;

-- 8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
SELECT customerid, salespersonid, AVG(subtotal) AS avg_subtotal, SUM(subtotal) AS sum_subtotal FROM sales.salesorderheader GROUP BY customerid, salespersonid ORDER BY customerid DESC;

-- 9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order.
SELECT productid, SUM(quantity) AS total_quantity FROM production.productinventory WHERE shelf IN ('A','C','H')GROUP BY productid HAVING SUM(quantity) > 500 ;

-- 10. From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.
SELECT SUM(quantity) as total_quantity FROM production.productinventory GROUP BY (locationid*10);

-- 11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.
SELECT Person.PersonPhone.BusinessEntityID,FirstName, LastName, PhoneNumber FROM Person.PersonPhone INNER JOIN Person.Person ON Person.PersonPhone.businessentityid = Person.Person.businessentityid WHERE LastName LIKE 'L%' ORDER BY LastName, FirstName;

-- 12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
-- PROBLEME REQUETE, MEME AVEC LA SOLUTION 

-- 13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.
SELECT locationid, shelf, SUM(quantity) AS total_quantity FROM production.productinventory GROUP BY CUBE (locationid, shelf);

-- 14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.
SELECT locationid, shelf, SUM(quantity) AS total_quantity FROM production.productinventory GROUP BY GROUPING SETS (ROLLUP (locationid, shelf), CUBE (locationid, shelf));

-- 15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.
SELECT locationid, sum(quantity) as totalquantity FROM production.productinventory GROUP BY ROLLUP (locationid) ORDER BY totalquantity DESC;

-- 16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.
SELECT city, count(businessentityid) as employee_count FROM Person.BusinessEntityAddress as p JOIN Person.Address as ps ON p.addressid = ps.addressid GROUP BY city ORDER BY city ASC;

-- 17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.
SELECT YEAR(orderdate) as year, SUM(totaldue) as total FROM Sales.salesorderheader GROUP BY YEAR(orderdate) ORDER BY year(orderdate) ASC;

-- 18. From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.
SELECT YEAR(orderdate) AS year, SUM(totaldue) as total FROM Sales.salesorderheader WHERE year(orderdate) <= 2016 GROUP BY year(orderdate) ORDER BY year ASC;

-- 19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.
SELECT contacttypeid, name FROM Person.ContactType WHERE name LIKE '% Manager' ORDER BY name DESC;

-- 20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.
SELECT p.businessentityid,lastname, firstname FROM Person.person as p JOIN Person.BusinessEntityContact as c ON p.businessentityid = c.personid JOIN Person.ContactType as T ON c.contacttypeid = t.contacttypeid WHERE T.name = 'Purchasing Manager' ORDER BY lastname, firstname;

-- 21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
SELECT ROW_NUMBER() OVER (PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS "Row Number",
pp.LastName, sp.SalesYTD, pa.PostalCode
FROM Sales.SalesPerson AS sp
    INNER JOIN Person.Person AS pp
        ON sp.BusinessEntityID = pp.BusinessEntityID
    INNER JOIN Person.Address AS pa
        ON pa.AddressID = pp.BusinessEntityID
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0
ORDER BY PostalCode;

-- 22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.
SELECT pc.contacttypeid, pc.name, count(pb.personid) as nocontacts FROM Person.BusinessEntityContact as pb INNER JOIN Person.ContactType as pc ON pb.contacttypeid = pc.contacttypeid GROUP BY pc.contacttypeid,pc.name HAVING count(pb.personid) >= 100 ORDER BY nocontacts DESC; 

-- 23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
SELECT CAST(e.RateChangeDate AS DATE) as ratechangedate, CONCAT(p.lastname,', ',p.firstname, ' ',p.middlename) AS fullname, (e.rate*40) AS weeklysalary FROM Person.person as p JOIN HumanResources.employeepayhistory as e ON p.businessentityid = e.businessentityid ORDER BY fullname;

-- 24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.
SELECT CAST(e.RateChangeDate AS DATE) as ratechangedate, CONCAT(p.lastname,', ',p.firstname, ' ',p.middlename) AS fullname, (e.rate*40) AS weeklysalary FROM Person.person as p JOIN HumanResources.employeepayhistory as e ON p.businessentityid = e.businessentityid ORDER BY fullname;

-- 25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.
SELECT SalesOrderID, ProductID, OrderQty
    ,SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Total Quantity"
    ,AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Avg Quantity"
    ,COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS "No of Orders"
    ,MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Min Quantity"
    ,MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Max Quantity"
    FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664);

-- 26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.
SELECT SalesOrderID AS OrderNumber, ProductID,
    OrderQty AS Quantity,
    SUM(OrderQty) OVER (ORDER BY SalesOrderID, ProductID) AS Total,
    AVG(OrderQty) OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderID, ProductID) AS Avg,
    COUNT(OrderQty) OVER(ORDER BY SalesOrderID, ProductID ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS Count
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664) and ProductID LIKE '71%';
-- PAS COMPRIS 

-- 27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.
SELECT salesorderid, sum(orderqty * unitprice) AS orderidcost FROM sales.salesorderdetail GROUP BY salesorderid HAVING sum(orderqty * unitprice) > 100000;

-- 28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on product ID column.
SELECT productid, name FROM Production.product WHERE name LIKE 'Lock Washer%' ORDER BY productid;

-- 29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product.
SELECT productid, name, color FROM production.product ORDER BY listprice;

-- 30. From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.
SELECT businessentityid, jobtitle, hiredate FROM HumanResources.Employee ORDER BY DATEPART(year,hiredate);

-- 31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.
SELECT lastname, firstname FROM Person.person WHERE lastname LIKE 'R%' ORDER BY firstname ASC, lastname DESC;

-- 32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.
SELECT businessentityid, salariedflag FROM HumanResources.employee ORDER BY CASE salariedflag WHEN 'True' THEN businessentityid END DESC, CASE salariedflag WHEN 'False' THEN businessentityid END;

-- 33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.
SELECT p.businessentityid, p.lastname, t.name AS TerritoryName, c.name AS CountryRegionName
FROM sales.salesperson as s 
JOIN person.person as p ON s.businessentityid = p.businessentityid 
JOIN sales.salesterritory as t ON s.territoryid = t.territoryid 
JOIN person.countryregion as c ON t.countryregioncode =  c.countryregioncode
ORDER BY c.name,
    CASE
        WHEN c.name = 'United States' THEN t.name
    END;

-- 34. From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.
SELECT p.FirstName, p.LastName  
    ,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"  
    ,RANK() OVER (ORDER BY a.PostalCode) AS "Rank"  
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS "Quartile"  
    ,s.SalesYTD, a.PostalCode  
FROM Sales.SalesPerson AS s   
    INNER JOIN Person.Person AS p   
        ON s.BusinessEntityID = p.BusinessEntityID  
    INNER JOIN Person.Address AS a   
        ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;

-- 35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.
SELECT * FROM HumanResources.Department ORDER BY departmentid OFFSET 10 ROWS;

-- 36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.
SELECT * FROM HumanResources.department ORDER BY Departmentid OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- 37. From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice
SELECT name, color, listprice FROM Production.product WHERE color = 'Red' OR color = 'Blue' ORDER BY listprice;


-- 38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column.
SELECT p.name, s.salesorderid FROM Production.product as p FULL JOIN Sales.salesorderdetail as s ON p.productid = s.productid ORDER BY p.name;


-- 39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.
SELECT p.name, s.salesorderid FROM Production.product as p LEFT OUTER JOIN sales.salesorderdetail as s ON p.productid = s.productid ORDER BY p.name;

-- 40. From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column.
SELECT p.name, s.salesorderid FROM Production.product as p INNER JOIN sales.salesorderdetail as s ON p.productid = s.productid ORDER BY p.name;

-- 41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether or not they are assigned a territory.
SELECT t.name, s.businessentityid FROM Sales.SalesTerritory as t RIGHT JOIN sales.salesPerson as s ON t.territoryid = s.territoryid ;

-- 42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname.
SELECT CONCAT_WS(' ',p.firstname, p.lastname) as fullname, a.city 
from person.person as p 
JOIN Person.BusinessEntityAddress as b ON p.businessentityid = b.businessentityid
JOIN Person.Address as a ON b.addressid = a.addressid 
ORDER BY lastname, firstname;

-- 43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table.
SELECT businessentityid, firstname, lastname FROM Person.person WHERE persontype = 'IN' AND lastname = 'Adams' ORDER BY firstname;
SELECT businessentityid, firstname, lastname FROM (SELECT * FROM Person.Person WHERE persontype = 'IN') AS derivedtable WHERE lastname = 'Adams' ORDER BY firstname;

-- 44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.
SELECT businessentityid, firstname, lastname FROM Person.Person WHERE businessentityid < 1500 AND lastname LIKE 'Al%' AND firstname LIKE 'M%';

-- 45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.
SELECT Productid, name, color FROM Production.product WHERE name = 'Blade' OR name = 'Crown Race' OR name = 'AWC Logo Cap' ;

SELECT ProductID, a.Name, Color  
FROM Production.Product AS a  
INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS b(Name)   
ON a.Name = b.Name;

-- 46. Create a SQL query to display the total number of sales orders each sales representative receives annually. Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.
SELECT salespersonid, count(salesorderid) as totalsales, YEAR(orderdate) as salesyear FROM sales.salesorderheader WHERE salespersonid IS NOT NULL GROUP BY salespersonid,YEAR(orderdate) ORDER BY salespersonid, year(orderdate); 

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
(
    SELECT SalesPersonID, SalesOrderID, DATEPART(year,OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;

-- 47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.
WITH Sales_CTE (Salespersonid, totalsales)
AS
    (
        SELECT salespersonid, count(salesorderid) as totalsales FROM sales.salesorderheader WHERE salespersonid IS NOT NULL GROUP BY salespersonid 
    )
SELECT AVG(totalsales) AS avgsalesorder 
FROM sales_cte;

-- 48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table's columns must all be returned.
SELECT * FROM Production.productphoto WHERE LargePhotoFileName LIKE '%greena_%' ESCAPE 'a'; -- permet de prendre en compte le _, le escape a indique qu'il faut prendre en compte le caractère _ et ne pas l'utiliser comme un caractère spécial
SELECT * FROM Production.productphoto WHERE LargePhotoFileName LIKE '%green_%';

-- 49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.
SELECT a.addressline1, a.addressline2, a.city, a.postalcode, s.countryregioncode FROM person.address as a JOIN Person.stateprovince as s ON a.stateprovinceid = s.stateprovinceid WHERE s.countryregioncode <> 'US' AND a.city LIKE 'Pa%';

-- 50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.
SELECT TOP 20 jobtitle, hiredate FROM humanresources.employee ORDER BY hiredate DESC ;

-- 51. From the following tables write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100. Return all the columns from the tables.
SELECT *  
FROM Sales.SalesOrderHeader AS h  
INNER JOIN Sales.SalesOrderDetail AS d 
    ON h.SalesOrderID = d.SalesOrderID   
WHERE h.TotalDue > 100  
AND (d.OrderQty > 5 OR d.unitpricediscount < 1000.00);

-- 52. From the following table write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table.
SELECT name, color FROM production.product WHERE name LIKE '%red%';

-- 53. From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain. Return name, and listprice columns from the table.
SELECT name, listprice from production.product WHERE listprice = 80.99 AND name LIKE '%mountain%';

-- 54. From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. Return name, and color columns.
SELECT name, color FROM production.product WHERE name LIKE '%mountain%' OR name LIKE '%road%';

-- 55. From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. Return Name and color.
SELECT name, color FROM production.product WHERE name LIKE '%mountain%' AND name LIKE '%black%';

-- 56. From the following table write a query in SQL to return all the product names with at least one word starting with the prefix chain in the Name column.
SELECT name from production.product WHERE name LIKE 'chain%';

-- 57. From the following table write a query in SQL to return all category descriptions containing strings with prefixes of either chain or full.
SELECT name, color FROM production.product WHERE name LIKE '%chain%' OR NAME LIKE '%FULL%';

-- 58. From the following table write a SQL query to output an employee's name and email address, separated by a new line character.
SELECT CONCAT(p.firstname, ' ',p.lastname, ' ¶', e.emailaddress) FROM person.person as p JOIN person.emailaddress as e ON p.BusinessEntityID = e.BusinessEntityID WHERE P.BusinessEntityID = 1;

-- 59. From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.
SELECT name, CHARINDEX('yellow', name) AS positionyellow FROM production.product WHERE name LIKE '%yellow%';

-- 60 From the following table write a query in SQL to concatenate the name, color, and productnumber columns.
SELECT CONCAT_WS(' ', name, ' color:', color,' number:',productnumber) AS result,color FROM production.product ;

-- 61 Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following table, each separated by a specified character.
SELECT CONCAT_WS(',',name, productnumber,CHAR(10)) as databasinfo FROM production.product;

-- 62 From the following table write a query in SQL to return the five leftmost characters of each product name.
SELECT LEFT(name,5) as result FROM Production.product;

-- 63 From the following table write a query in SQL to select the number of characters and the data in FirstName for people located in Australia.
SELECT LEN(firstname) as length, firstname, lastname from Sales.vindividualcustomer WHERE countryregionname = 'Australia'

-- 64 From the following tables write a query in SQL to return the number of characters in the column FirstName and the first and last name of contacts located in Australia.
SELECT LEN(firstname) as length, firstname, lastname FROM Sales.vstorewithcontacts as v JOIN sales.vstorewithaddresses as a ON v.BusinessEntityID = a.BusinessEntityID WHERE a.CountryRegionName = 'Australia';

-- 65 From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00. Return product name as Lower, Upper, and also LowerUpper.
SELECT LOWER(name) AS lower, UPPER(name) AS upper FROM production.product WHERE StandardCost between 1000 and 1220;

-- 66 Write a query in SQL to remove the spaces from the beginning of a string.
SELECT  '     five space then the text' as "Original Text", LTRIM('     five space then the text') as "Trimmed Text(space removed)";

-- 67 From the following table write a query in SQL to remove the substring 'HN' from the start of the column productnumber. Filter the results to only show those productnumbers that start with "HN". Return original productnumber column and 'TrimmedProductnumber'.
SELECT SUBSTRING(productnumber,3,5) as subproductnumber, productnumber FROM production.product WHERE LEFT(ProductNumber,2) = 'HN';

SELECT SUBSTRING(productnumber,3,5) as subproductnumber, productnumber FROM production.product WHERE productnumber LIKE 'HN%';

-- 68 From the following table write a query in SQL to repeat a 0 character four times in front of a production line for production line 'T'.
SELECT name, CONCAT(REPLICATE('0',4), productline) FROM production.product WHERE productline = 'T' ORDER BY name;

-- 69 From the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6.
SELECT firstname, REVERSE(firstname) as reverse FROM Person.person WHERE BusinessEntityID < 6;

-- 70 From the following table write a query in SQL to return the eight rightmost characters of each name of the product. Also return name, productnumber column. Sort the result set in ascending order on productnumber.
SELECT name, productnumber, RIGHT(name,8) as productname FROM production.product ORDER BY ProductNumber;

-- 71 Write a query in SQL to remove the spaces at the end of a string.
SELECT 'space after text       ' as text, RTRIM('space after text       ') as spaceremoved;

-- 72 From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. Return productnumber and name.
SELECT productnumber, name FROM production.product WHERE RIGHT(name,1) IN ('S','M','L');

-- 73 From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row.
SELECT STRING_AGG(coalesce(firstname,'N/A'),', ') AS test FROM person.person WHERE firstname LIKE 'Ab%' ;
-- pour mieux voir ce que fait coalesce (remplacer les valeurs nulles par ce qu'on veut)
SELECT name, COALESCE(color,'N/A') AS color FROM Production.product;

-- 74 From the following table write a query in SQL to return the names and modified date separated by commas in a single row.
-- ajout filtre sur le prénom car résultat trop important pour être affiché
SELECT STRING_AGG(CONCAT_WS(' ',firstname, lastname, CAST(modifieddate AS date)),', ') FROM Person.person WHERE firstname LIKE 'Ab%';

-- 75 From the following table write a query in SQL to find the email addresses of employees and groups them by city. Return top ten rows.
SELECT city, STRING_AGG(emailaddress, ',') 
FROM person.EmailAddress as p 
JOIN person.BusinessEntityAddress as b ON p.BusinessEntityID = b.BusinessEntityID
JOIN person.Address as a ON b.BusinessEntityID = a.AddressID
WHERE city LIKE 'B%'
GROUP BY city;

-- 76 From the following table write a query in SQL to create a new job title called "Production Assistant" in place of "Production Supervisor".
SELECT jobtitle, REPLACE(jobtitle,'Production Supervisor','Production Assistant') as newjobtitle FROM HumanResources.employee WHERE JobTitle LIKE 'Production Supervisor%';

SELECT jobtitle, STUFF(jobtitle,12,10, 'Assistant') as "New Jobtitle"
FROM humanresources.employee e 
WHERE SUBSTRING(jobtitle,12,10)='Supervisor';

-- 77 From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales". Return firstname, middlename, lastname and jobtitle column.
SELECT firstname, middlename, lastname, jobtitle from person.person as p JOIN HumanResources.Employee as e ON p.BusinessEntityID = e.BusinessEntityID WHERE jobtitle LIKE 'Sales%';

-- 78 From the following table write a query in SQL to return the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.
SELECT CONCAT(UPPER(TRIM(lastname)), ', ', firstname) as name FROM Person.person;

-- 79 From the following table write a query in SQL to show a resulting expression that is too small to display. Return FirstName, LastName, Title, and SickLeaveHours. The SickLeaveHours will be shown as a small expression in text format.
SELECT p.FirstName, p.LastName, SUBSTRING(p.Title, 1, 25) AS Title,
    CAST(e.SickLeaveHours AS char(1)) AS "Sick Leave"  
FROM HumanResources.Employee e JOIN Person.Person p 
    ON e.BusinessEntityID = p.BusinessEntityID  
WHERE NOT e.BusinessEntityID > 5;

-- 80 From the following table write a query in SQL to retrieve the name of the products. Product, that have 33 as the first two digits of listprice.
SELECT name, listprice FROM production.product WHERE listprice LIKE '33%';

--81 From the following table write a query in SQL to calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT). Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number. 
SELECT salesytd, commissionpct, CAST((salesytd/commissionpct) AS INT) AS computed FROM sales.Salesperson WHERE commissionpct != 0;

SELECT salesytd, commissionpct, ROUND((salesytd/commissionpct),0) AS computed FROM sales.Salesperson WHERE commissionpct != 0;

SELECT salesytd, commissionpct, CONVERT(INT,(salesytd/commissionpct)) AS computed FROM sales.Salesperson WHERE commissionpct != 0;

SELECT salesytd, commissionpct, FLOOR((salesytd/commissionpct)) AS entier_inferieur, CEILING((salesytd/commissionpct)) AS entier_superieur FROM sales.Salesperson WHERE commissionpct != 0;

-- 82 From the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID. 
SELECT firstname, lastname, salesytd FROM person.person as p JOIN sales.salesperson as s ON p.BusinessEntityID = s.BusinessEntityID WHERE SalesYTD LIKE '2%';

SELECT firstname, lastname, salesytd FROM person.person as p JOIN sales.salesperson as s ON p.BusinessEntityID = s.BusinessEntityID WHERE CAST(CAST(SalesYTD AS INT) AS char(20)) LIKE '2%';

-- 83 From the following table write a query in SQL to convert the Name column to a char(16) column. Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.
SELECT CAST(name AS char(16)) AS name, listprice FROM production.product WHERE name LIKE 'Long-Sleeve Logo Jersey%';

-- 84 From the following table write a SQL query to determine the discount price for the salesorderid 46672. Calculate only those orders with discounts of more than.02 percent. Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).
SELECT productid, unitprice, unitpricediscount, CAST(unitprice*unitpricediscount AS INT) as discountprice FROM sales.salesorderdetail WHERE salesorderid = 46672 AND UnitPriceDiscount > 0.02;

-- 85 From the following table write a query in SQL to calculate the average vacation hours, and the sum of sick leave hours, that the vice presidents have used.
SELECT AVG(vacationhours)AS AVGvacationshours, SUM(sickleavehours) AS SUMsickleavehours  FROM HumanResources.Employee WHERE JobTitle LIKE 'Vice president%';

-- 86 From the following table write a query in SQL to calculate the average bonus received and the sum of year-to-date sales for each territory. Return territoryid, Average bonus, and YTD sales.
SELECT territoryid, AVG(bonus) as AVGbonus, SUM(salesytd) as SUMsalesytd FROM sales.salesperson GROUP BY TerritoryID;

-- 87 From the following table write a query in SQL to return the average list price of products. Consider the calculation only on unique values.
SELECT AVG(DISTINCT listprice) AS AVGlistprice FROM production.product ;

-- 88 From the following table write a query in SQL to return a moving average of yearly sales for each territory. Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.
SELECT businessentityid, territoryid, YEAR(modifieddate) as salesyear, salesytd, AVG(salesytd) OVER (PARTITION BY territoryid ORDER BY YEAR(modifieddate)) as movingavg, SUM(salesytd) OVER (PARTITION BY territoryid ORDER BY YEAR(modifieddate)) as cumulativetotal FROM sales.salesperson;

-- 89 From the following table write a query in SQL to return a moving average of sales, by year, for all sales territories. Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.
SELECT businessentityid, territoryid, YEAR(modifieddate) as salesyear, salesytd, AVG(salesytd) OVER (ORDER BY YEAR(modifieddate)) as movingavg, SUM(salesytd) OVER (ORDER BY YEAR(modifieddate)) as cumulativetotal FROM sales.salesperson;

SELECT BusinessEntityID, TerritoryID   
   ,YEAR(ModifiedDate) AS SalesYear  
   ,cast(SalesYTD as VARCHAR(20)) AS  SalesYTD  
   ,AVG(SalesYTD) OVER (ORDER BY YEAR(ModifiedDate)) AS MovingAvg  
   ,SUM(SalesYTD) OVER (ORDER BY YEAR(ModifiedDate)) AS CumulativeTotal  
FROM Sales.SalesPerson  
WHERE TerritoryID IS NULL OR TerritoryID < 5  
ORDER BY SalesYear;

-- 90 From the following table write a query in SQL to return the number of different titles that employees can hold.
SELECT COUNT(DISTINCT jobtitle) AS numberofjobtitles FROM HumanResources.employee;

-- 91 From the following table write a query in SQL to find the total number of employees.
SELECT COUNT(businessentityid) as numberofemployee FROM HumanResources.Employee;

-- 92 From the following table write a query in SQL to find the average bonus for the salespersons who achieved the sales quota above 25000. Return number of salespersons, and average bonus.
SELECT COUNT(businessentityid) as count, AVG(bonus) as average FROM sales.salesperson WHERE salesquota > 25000;

-- 93 From the following tables wirte a query in SQL to return aggregated values for each department. Return name, minimum salary, maximum salary, average salary, and number of employees in each department.
SELECT name, MIN(rate), max(rate), AVG(rate), Count(p.businessentityid) FROM HumanResources.EmployeePayHistory as p JOIN HumanResources.EmployeeDepartmentHistory as h ON p.BusinessEntityID = h.BusinessEntityID JOIN HumanResources.department as d ON h.DepartmentID = d.DepartmentID WHERE h.EndDate IS NULL GROUP BY d.name;

SELECT DISTINCT Name  
       , MIN(Rate) OVER (PARTITION BY edh.DepartmentID) AS MinSalary  
       , MAX(Rate) OVER (PARTITION BY edh.DepartmentID) AS MaxSalary  
       , AVG(Rate) OVER (PARTITION BY edh.DepartmentID) AS AvgSalary  
       ,COUNT(edh.BusinessEntityID) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept  
FROM HumanResources.EmployeePayHistory AS eph  
JOIN HumanResources.EmployeeDepartmentHistory AS edh  
     ON eph.BusinessEntityID = edh.BusinessEntityID  
JOIN HumanResources.Department AS d  
ON d.DepartmentID = edh.DepartmentID
WHERE edh.EndDate IS NULL  
ORDER BY Name;

-- 94 From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.
SELECT d.name, count(h.businessentityid) as count FROM HumanResources.Department as d JOIN HumanResources.EmployeeDepartmentHistory as h ON d.DepartmentID = h.departmentid WHERE h.EndDate IS NULL GROUP BY D.name HAVING count(h.BusinessEntityID) > 15 ;

-- 95 From the following table write a query in SQL to find the number of products that ordered in each of the specified sales orders.
SELECT COUNT(salesorderdetailid) as count, salesorderid FROM sales.SalesOrderDetail WHERE SalesOrderID in (43855,43661) GROUP BY SalesOrderID;

-- 96 From the following table write a query in SQL to compute the statistical variance of the sales quota values for each quarter in a calendar year for a sales person. Return year, quarter, salesquota and variance of salesquota.
SELECT quotadate AS Year, DATEPART(quarter,quotadate) AS Quarter, SalesQuota AS SalesQuota,  
       VAR(SalesQuota) OVER (ORDER BY DATEPART(quarter,quotadate)) AS Variance  
FROM sales.salespersonquotahistory  
WHERE businessentityid = 277 AND YEAR(quotadate) = 2012  
ORDER BY DATEPART(quarter,quotadate);

-- 97 From the following table write a query in SQL to populate the variance of all unique values as well as all values, including any duplicates values of SalesQuota column.
SELECT varp(DISTINCT SalesQuota) AS Distinct_Values, varp(SalesQuota) AS All_Values  
FROM sales.salespersonquotahistory;

-- 98 From the following table write a query in SQL to return the total ListPrice and StandardCost of products for each color. Products that name starts with 'Mountain' and ListPrice is more than zero. Return Color, total list price, total standardcode. Sort the result set on color in ascending order.
SELECT color, sum(listprice) as sumlistprice, SUM(standardcost) as sumstandardcost FROM production.product WHERE name LIKE 'Mountain%' AND ListPrice >0 AND color IS NOT NULL GROUP BY color;

-- 99 From the following table write a query in SQL to find the TotalSalesYTD of each SalesQuota. Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.
SELECT salesquota, SUM(salesytd) as totalsalesytd, GROUPING(SalesQuota) as "Grouping" FROM sales.salesperson GROUP BY rollup(salesquota);

-- 100 From the following table write a query in SQL to calculate the sum of the ListPrice and StandardCost for each color. Return color, sum of ListPrice.
SELECT color, SUM(listprice) as totallist, SUM(standardcost) as totalcost FROM production.product GROUP BY color;




