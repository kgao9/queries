.read create-sales.sql

.mode column
.headers on

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
