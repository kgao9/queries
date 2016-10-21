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

CREATE VIEW tenMovies AS
SELECT a.id as actorID, a.fname as actorFname, a.lname as actorlname, count(distinct movie.id) as numMovies
FROM actor a
Inner Join casts  
on a.id = casts.pid
Inner Join movie 
on movie.id = casts.mid
WHERE movie.year = '2010' 
GROUP BY actorID
Having numMovies >= 10

SELECT DISTINCT t.actorFname, t.actorlname 
FROM tenMovies t;
