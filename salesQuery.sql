.mode column
.headers on

.read create-sales.sql

-- Part 1
CREATE VIEW StoreHolidaySales AS
SELECT store, sum(weeklysales) as overall
FROM sales, holidays
WHERE sales.weekdate = holidays.weekdate
AND holidays.IsHoliday = 'TRUE'
GROUP BY store;

SELECT store, overall
FROM StoreHolidaySales s
WHERE s.overall =
(SELECT min(overall) as val
FROM StoreHolidaySales s1)
OR s.overall = 
(SELECT max(overall) as val
FROM StoreHolidaySales s2);

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

-- Part 3
SELECT DISTINCT store FROM temporaldata WHERE unemploymentrate > 10
EXCEPT
SELECT DISTINCT store FROM temporaldata WHERE fuelprice > 200;

-- Part 4
CREATE VIEW holidayAvgSales AS
SELECT AVG(holidaytotal) as holidayAvg
FROM (SELECT sum(s.weeklysales) as holidaytotal
FROM sales s, holidays h
WHERE s.weekdate = h.weekdate AND h.isholiday = 'TRUE'
GROUP BY s.weekdate);

CREATE VIEW nonholidayWeeklySales AS
SELECT sum(s.weeklysales) as nonholidayweeklysales
FROM sales s, holidays h
WHERE s.weekdate = h.weekdate AND h.isholiday = 'FALSE'
GROUP BY s.weekdate;

SELECT count()
FROM nonholidayweeklysales n, holidayavgsales h
WHERE n.nonholidayweeklysales > h.holidayAvg;

-- Part 5



-- Part 7
CREATE VIEW salesnew2 AS
SELECT store, weekdate, sum(weeklysales) weeklysales
FROM salesnew
GROUP BY store, weekdate;

CREATE VIEW temporalAvg AS
SELECT AVG(temperature) atemperature, AVG(fuelprice) afuelprice, AVG(cpi) acpi, AVG(unemploymentrate) aunemploymentrate, AVG(weeklysales) aweeklysales
FROM temporaldata t, salesnew2 s
WHERE t.weekdate = s.weekdate AND t.store = s.store;

CREATE VIEW temporalNorm AS
SELECT temperature-(SELECT atemperature FROM temporalAvg) ntemperature, fuelprice-(SELECT afuelprice FROM temporalAvg) nfuelprice, cpi-(SELECT acpi FROM temporalAvg) ncpi, unemploymentrate-(SELECT aunemploymentrate FROM temporalAvg) nunemploymentrate, weeklysales-(SELECT aweeklysales FROM temporalAvg) nweeklysales
FROM temporaldata t, salesnew2 s
WHERE t.weekdate = s.weekdate AND t.store = s.store;

CREATE VIEW correlation AS
SELECT SUM(ntemperature*nweeklysales) rtemperature,
SUM(nfuelprice*nweeklysales) rfuelprice,
SUM(ncpi*nweeklysales) rcpi,
SUM(nunemploymentrate*nweeklysales) runemploymentunemployment
FROM temporalNorm;
