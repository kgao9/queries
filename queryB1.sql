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

SELECT fname, lname
FROM actor NATURAL JOIN (SELECT pid id, count(mid) count FROM (SELECT DISTINCT pid, mid FROM casts) NATURAL JOIN (SELECT id mid FROM movie WHERE year=2010) GROUP BY pid) WHERE count >= 10
ORDER BY id ASC;
