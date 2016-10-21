/*
CREATE TABLE actor(
  id int PRIMARY KEY,
  fname varchar(30),
  lname varchar(30),
  gender char(1));
CREATE TABLE movie(
  id int PRIMARY KEY,
  name varchar(150),
  year int);
CREATE TABLE directors(
  id int PRIMARY KEY,
  fname varchar(30),
  lname varchar(30));
CREATE TABLE genre(
  mid int,
  genre varchar(50));
CREATE TABLE casts(
  pid int REFERENCES actor,
  mid int REFERENCES movie,
  role varchar(50));
CREATE TABLE movie_directors(
  did int REFERENCES directors,
  mid int REFERENCES movie);
*/

.headers on
.mode column
.read create-imdb.sql

CREATE UNIQUE INDEX movieid ON movie(id);
CREATE UNIQUE INDEX actorid ON actor(id);
CREATE UNIQUE INDEX directorsid ON directors(id);

CREATE INDEX castsmid ON casts(mid);
CREATE INDEX castspid ON casts(pid);

CREATE INDEX movieyear ON movie(year);

CREATE INDEX moviedirectorsmid ON movie_directors(mid);
CREATE INDEX moviedirectordid ON movie_directors(did);

CREATE VIEW y1 AS
SELECT year, count(id) count FROM movie GROUP BY year;

CREATE TABLE decade AS
SELECT y1.year year, y1.count + IFNULL(y2.count,0) + IFNULL(y3.count,0) + IFNULL(y4.count,0) + IFNULL(y5.count,0) + IFNULL(y6.count,0) + IFNULL(y7.count,0) + IFNULL(y8.count,0) + IFNULL(y9.count,0) decadeCount
FROM y1 y1
LEFT OUTER JOIN y1 y2 ON y1.year + 1 = y2.year
LEFT OUTER JOIN y1 y3 ON y1.year + 2 = y3.year
LEFT OUTER JOIN y1 y4 ON y1.year + 3 = y4.year
LEFT OUTER JOIN y1 y5 ON y1.year + 4 = y5.year
LEFT OUTER JOIN y1 y6 ON y1.year + 5 = y6.year
LEFT OUTER JOIN y1 y7 ON y1.year + 6 = y7.year
LEFT OUTER JOIN y1 y8 ON y1.year + 7 = y8.year
LEFT OUTER JOIN y1 y9 ON y1.year + 8 = y9.year;

SELECT year
FROM decade
ORDER BY decadeCount DESC
LIMIT 1;
