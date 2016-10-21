.read create-sales.sql

.headers on
.mode column

CREATE TABLE storeDept AS
SELECT store, count(DISTINCT dept) numDept FROM salesnew GROUP BY store;

CREATE VIEW salesYearMonth AS
SELECT *, substr(trim(weekdate), 1, 4) year, substr(trim(weekdate), 6, 2) month FROM salesnew;

CREATE TABLE y2010 AS
SELECT month, store, COUNT(DISTINCT dept) deptWithSales
FROM (salesYearMonth) s
WHERE s.year="2010"
GROUP BY s.month, s.store;

CREATE TABLE y2011 AS
SELECT month, store, COUNT(DISTINCT dept) deptWithSales
FROM (salesYearMonth) s
WHERE s.year="2011"
GROUP BY s.month, s.store;

CREATE TABLE y2012 AS
SELECT month, store, COUNT(DISTINCT dept) deptWithSales
FROM (salesYearMonth) s
WHERE s.year="2012"
GROUP BY s.month, s.store;

SELECT * FROM (
/* Compares, for each year and store, # of depts with sales with (total # dept * # months in that year)*/
SELECT store, (numDept2010 = (numMonths2010 * numDept)) y2010, (numDept2011 = (numMonths2011 * numDept)) y2011, (numDept2012 = (numMonths2012 * numDept)) y2012
FROM storeDept
NATURAL JOIN
(SELECT store, sum(deptWithSales) numDept2010, count(month) numMonths2010 FROM y2010 GROUP BY store)
NATURAL JOIN
(SELECT store, sum(deptWithSales) numDept2011, count(month) numMonths2011 FROM y2011 GROUP BY store)
NATURAL JOIN
(SELECT store, sum(deptWithSales) numDept2012, count(month) numMonths2012 FROM y2012 GROUP BY store)
)
WHERE y2010 > 0 OR y2011 > 0 OR y2012 > 0;
