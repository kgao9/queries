.read create-sales.sql

.mode column
.headers on

-- Part 2
CREATE VIEW deptTotal AS
SELECT store, dept, sum(weeklysales) as deptSales
FROM salesnew
GROUP BY store, dept;

SELECT dept, sum(normalizedSales) as normalizedTotalSales
FROM (SELECT dept, round(deptSales/size,2) as normalizedSales FROM deptTotal NATURAL JOIN stores)
GROUP BY dept
ORDER by normalizedTotalSales DESC
LIMIT 20;
