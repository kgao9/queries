.read create-sales.sql

.mode column
.headers on


-- Part 7
CREATE VIEW salesnew2 AS
SELECT store, weekdate, sum(weeklysales) weeklysales
FROM salesnew
GROUP BY store, weekdate;

CREATE VIEW temporalAvg AS
SELECT AVG(temperature) atemperature, AVG(fuelprice) afuelprice, AVG(cpi) acpi, AVG(unemploymentrate) aunemploymentrate, AVG(weeklysales) aweeklysales
FROM temporaldata NATURAL JOIN salesnew2;

CREATE VIEW temporalNorm AS
SELECT temperature-(SELECT atemperature FROM temporalAvg) ntemperature, fuelprice-(SELECT afuelprice FROM temporalAvg) nfuelprice, cpi-(SELECT acpi FROM temporalAvg) ncpi, unemploymentrate-(SELECT aunemploymentrate FROM temporalAvg) nunemploymentrate, weeklysales-(SELECT aweeklysales FROM temporalAvg) nweeklysales
FROM temporaldata NATURAL JOIN salesnew2;

CREATE TABLE correlation AS
SELECT SUM(ntemperature*nweeklysales) rhotemperature,
SUM(nfuelprice*nweeklysales) rhofuelprice,
SUM(ncpi*nweeklysales) rhocpi,
SUM(nunemploymentrate*nweeklysales) rhounemployment
FROM temporalNorm;

SELECT "temperature", 2*(rhotemperature > 0) -1 CorrelationSign FROM correlation
UNION ALL
SELECT "fuelprice", 2*(rhofuelprice > 0) -1 CorrelationSign FROM correlation
UNION ALL
SELECT "cpi", 2*(rhocpi > 0) -1 CorrelationSign FROM correlation
UNION ALL
SELECT "unemploymentrate", 2*(rhounemployment > 0) -1 CorrelationSign FROM correlation;
