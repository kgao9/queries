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

CREATE TABLE baconID AS
SELECT id FROM actor WHERE fname = "Kevin" AND lname = "Bacon";

-- BaconId = 52435

-- bacon# 1
CREATE TABLE bacon1 AS
SELECT DISTINCT c1.pid pid
FROM casts c1 NATURAL JOIN (SELECT mid FROM casts c2 WHERE c2.pid = (SELECT * FROM baconID))
WHERE NOT c1.pid = (SELECT * FROM baconID);

-- bacon# > 1
CREATE TABLE bacon1p AS
SELECT *
FROM (SELECT DISTINCT pid FROM casts WHERE NOT pid = (SELECT * FROM baconID))
EXCEPT
SELECT * FROM bacon1;


SELECT COUNT(DISTINCT pid)
FROM (SELECT pid, mid FROM casts NATURAL JOIN bacon1p) c1 NATURAL JOIN (SELECT DISTINCT mid FROM casts c2 NATURAL JOIN bacon1);
