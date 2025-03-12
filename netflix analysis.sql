CREATE DATABASE netflix_db;
USE netflix_db;

CREATE TABLE netflix_shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    show_type ENUM('Movie', 'TV Show'),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(50),
    genre VARCHAR(100),
    country VARCHAR(100),
    director VARCHAR(255),
    description TEXT
);

INSERT INTO netflix_shows (title, show_type, release_year, rating, duration, genre, country, director, description) VALUES
('Stranger Things', 'TV Show', 2016, 'TV-14', '4 Seasons', 'Sci-Fi', 'USA', 'The Duffer Brothers', 'A group of kids uncover secret experiments.'),
('Money Heist', 'TV Show', 2017, 'TV-MA', '5 Seasons', 'Crime', 'Spain', 'Álex Pina', 'A criminal mastermind plans heists.'),
('Breaking Bad', 'TV Show', 2008, 'TV-MA', '5 Seasons', 'Drama', 'USA', 'Vince Gilligan', 'A chemistry teacher turns to crime.'),
('Inception', 'Movie', 2010, 'PG-13', '148 min', 'Sci-Fi', 'USA', 'Christopher Nolan', 'A thief enters dreams to steal secrets.'),
('The Godfather', 'Movie', 1972, 'R', '175 min', 'Crime', 'USA', 'Francis Ford Coppola', 'A powerful crime family story.'),
('Parasite', 'Movie', 2019, 'R', '132 min', 'Thriller', 'South Korea', 'Bong Joon Ho', 'A poor family infiltrates a rich household.'),
('The Dark Knight', 'Movie', 2008, 'PG-13', '152 min', 'Action', 'USA', 'Christopher Nolan', 'Batman faces the Joker.'),
('Narcos', 'TV Show', 2015, 'TV-MA', '3 Seasons', 'Crime', 'Colombia', 'José Padilha', 'The story of drug cartels.'),
('Black Mirror', 'TV Show', 2011, 'TV-MA', '5 Seasons', 'Sci-Fi', 'UK', 'Charlie Brooker', 'Dystopian tech-based stories.'),
('Squid Game', 'TV Show', 2021, 'TV-MA', '1 Season', 'Thriller', 'South Korea', 'Hwang Dong-hyuk', 'A deadly survival game.')
;

select * from netflix_shows;

-- 1. Retrieve all unique genres available in the Netflix dataset.
select distinct genre from netflix_shows;
-- 2. Retrieve all shows that were released in or after 2015.
select * from netflix_shows
where release_year>=2015;
-- 3. Find all TV Shows released after 2010 that are either Sci-Fi or Crime
select * from netflix_shows
where release_year>=2010 and genre in ('sci-fi','crime');

-- Retrieve all records where the description contains the word "crime".
select * from netflix_shows
where description like '%crime%';

-- Retrieve all movies and TV shows that were NOT released between 2010 and 2020.

select * from netflix_shows
where release_year not between 2010 and 2020;