.read create-sales.sql

.mode column
.headers on

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
