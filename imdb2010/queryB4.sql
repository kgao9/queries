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

SELECT year, COUNT(DISTINCT mid)
FROM casts c, actor a, (SELECT id, year FROM movie) m
WHERE c.pid = a.id AND c.mid = m.id AND NOT EXISTS (SELECT * FROM (SELECT id FROM actor WHERE gender='M') amale WHERE amale.id = c.pid)
GROUP BY year
;

