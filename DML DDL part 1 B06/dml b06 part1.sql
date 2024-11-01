create database if not exists cricketdb;
use cricketdb;

Create table players(
Player_ID int auto_increment primary key,
Player_Name varchar(50) Not NUll,
Email varchar(50) unique,
Team varchar(50) Not NUll,   -- Team varchar(50) Not NUll Check (Team IN('India','Aus','NZ','PAK'))
Player_Role varchar(50) default 'Batsman',
DateofBirth Date Not Null
);

Create table matches(
Match_ID int auto_increment primary key,
Player_ID int Not Null,  -- Player_ID int Not Null References players(Player_ID)
Opponent varchar(50) Not Null,
Runs int Default 0 Check(Runs>=0),
Match_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
-- I am declaring Player_ID in this table as the foreign key which is availble in the players table in the name Player_ID
Foreign key (Player_ID) References players(Player_ID) on delete cascade
);

INSERT INTO Players (Player_Name, Email, Team, Player_Role, DateOfBirth) VALUES 
('Virat Kohli', 'virat@cricket.com', 'India', 'Batsman', '1988-11-05'),
('Joe Root', 'joe@cricket.com', 'Aus', 'All-Rounder', '1990-12-30'),
('Babar Azam', 'babar@cricket.com', 'PAK', 'Batsman', '1994-10-15'),
('Steve Smith', 'steve@cricket.com', 'Aus', 'Batsman', '1989-06-02'),
('Kane Williamson', 'kane@cricket.com', 'NZ', 'Batsman', '1990-08-08'),
('David Warner', 'david@cricket.com', 'Aus', 'Batsman', '1986-10-27'),
('Rohit Sharma', 'rohit@cricket.com', 'India', 'Batsman', '1987-04-30'),
('Ben Stokes', 'ben@cricket.com', 'Aus', 'All-Rounder', '1991-06-04'),
('Jasprit Bumrah', 'jasprit@cricket.com', 'India', 'Bowler', '1993-12-06'),
('Pat Cummins', 'pat@cricket.com', 'Aus', 'Bowler', '1993-05-08');


select Player_ID, Player_Name, Team from Players;

INSERT INTO Matches (Player_ID, Opponent, Runs) VALUES 
(1, 'Australia', 85),
(2, 'New Zealand', 45),
(3, 'India', 120),
(4, 'England', 67),
(5, 'Pakistan', 92),
(6, 'India', 150),
(7, 'Australia', 56),
(8, 'New Zealand', 88),
(9, 'Pakistan', 3),
(10, 'England', 5);

select Match_ID, Player_ID, Opponent, Runs from Matches;

Insert into matches(Player_ID, Opponent, Runs)
values(1,'Pakistan',200);

select * from Players;

Insert into Players(Player_Name, Email, Team, Player_Role, DateOfBirth)
values
("Jadeja","jaddu@crickdb.com","India","All-Rounder","1988-10-10");

update Players 
set player_role = "all rounder"
where player_name ="jasprit bumrah";

select * from Matches;

-- when we use delete id 
-- delete
Delete from Matches
where Runs<50;

select * from players;

Delete from players
where Player_ID=3;

select * from Matches;