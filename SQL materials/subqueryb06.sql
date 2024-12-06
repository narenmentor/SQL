create database if not exists newcrickdb;
use newcrickdb;

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(100) NOT NULL,
    Team VARCHAR(50) NOT NULL,
    Role VARCHAR(20) CHECK (Role IN ('Batsman', 'Bowler', 'All-Rounder')),
    Age INT NOT NULL
);

-- Create the Matches Table
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    MatchDate DATE NOT NULL,
    Team1 VARCHAR(50) NOT NULL,
    Team2 VARCHAR(50) NOT NULL,
    Venue VARCHAR(100) NOT NULL
);

-- Create the Performances Table
CREATE TABLE Performances (
    PerformanceID INT PRIMARY KEY,
    PlayerID INT NOT NULL,
    MatchID INT NOT NULL,
    Runs INT NOT NULL,
    Wickets INT NOT NULL,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

-- Insert Data into Players Table
INSERT INTO Players (PlayerID, PlayerName, Team, Role, Age) VALUES
(1, 'Virat Kohli', 'India', 'Batsman', 34),
(2, 'Steve Smith', 'Australia', 'Batsman', 34),
(3, 'Pat Cummins', 'Australia', 'Bowler', 30),
(4, 'Ravindra Jadeja', 'India', 'All-Rounder', 35);

INSERT INTO Players (PlayerID, PlayerName, Team, Role, Age) VALUES
(5, 'Babar', 'PAK', 'Batsman', 33),
(6, 'Shami', 'India', 'Bowler', 34);


-- Insert Data into Matches Table
INSERT INTO Matches (MatchID, MatchDate, Team1, Team2, Venue) VALUES
(101, '2023-05-20', 'India', 'Australia', 'Mumbai'),
(102, '2023-05-21', 'India', 'England', 'Chennai');

INSERT INTO Matches (MatchID, MatchDate, Team1, Team2, Venue) VALUES
(103, '2023-05-21', 'India', 'PAK', 'Chennai');

-- Insert Data into Performances Table
INSERT INTO Performances (PerformanceID, PlayerID, MatchID, Runs, Wickets) VALUES
(1, 1, 101, 85, 0),
(2, 2, 101, 45, 0),
(3, 3, 101, 10, 3),
(4, 4, 101, 20, 2),
(5, 1, 102, 43, 0),
(6, 2, 102, 99, 0),
(7, 3, 102, 0, 5),
(8, 4, 102, 10, 3)
;
INSERT INTO Performances (PerformanceID, PlayerID, MatchID, Runs, Wickets) VALUES
(9, 1, 103, 110, 0),
(10, 4, 103, 80, 3);

INSERT INTO Performances (PerformanceID, PlayerID, MatchID, Runs, Wickets) VALUES
(11, 5, 103, 90, 0),
(12, 6, 103, 0, 4);

select * from players;
select * from matches;
select * from performances;

-- Subquery - Query within another query


--  Find the player with the highest score in a particular match id =101
select PlayerID, max(runs) as maxruns
from performances
where matchid=101
group by PlayerID
order by maxruns desc
limit 1;

-- by using subquery
select playerid,runs
from performances
where runs = (select max(runs) 
from performances 
where matchid=101);

-- Retrieve the details of the player with the maximum runs scored in the dataset.
-- player details id, name, team, runs--> maximum runs 
-- players , performances
select pl.playerid, pl.playername, pl.team, pr.runs
from players pl
join performances pr
on pl.playerid=pr.playerid
where pr.runs = (select max(runs) from performances);

-- Retrieve the name of the youngest player in the database.
select Playerid, playername, team, age 
from players
where age = ( select min(age) from players);

-- Multi-row subquery In ,Not IN
-- List the players who participated in matches played at the venue "Chennai".
-- make sure to use distinct 

select distinct pl.playerid, pl.playername, pl.team, pr.matchid
from players pl
join performances pr
on pl.playerid = pr.playerid
where pr.matchid in (select m.matchid
from matches m
where m.venue="Chennai") ;

-- Error Code: 1242. Subquery returns more than 1 row
-- we can use = for the above query if one one match is played in that specific venue
select m.matchid
from matches m
where m.venue="Chennai";

-- Find the matches where at least one player scored more than 100 runs.
select matchid, matchdate, team1,team2,venue
from matches
where matchid in (
select matchid
from performances
where runs>100);

-- views

-- Create a view to show basic player details (Name, Team, Role)
create view playerdetails as
select playername, team, role as player_role
from players;

select * from playerdetails;

-- Create a view to show the total runs and wickets for each player across all matches.
create view playerperformace as 
select pl.playername, 
sum(pr.runs) as total_runs, 
sum(pr.wickets) as total_wickets
from players pl
join performances pr
on pl.playerid = pr.playerid
group by playername;

select * from playerperformace;



