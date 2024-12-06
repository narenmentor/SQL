create database if not exists cricketdb;
use cricketdb;

-- Create Players Table
CREATE TABLE Players (
    Player_ID INT AUTO_INCREMENT PRIMARY KEY,
    Player_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(50),
    Team VARCHAR(50) NOT NULL,
    Player_Role VARCHAR(50) DEFAULT 'Batsman',
    Date_of_Birth DATE NOT NULL
);


-- Create Matches Table
CREATE TABLE Matches (
    Match_ID INT AUTO_INCREMENT PRIMARY KEY,
    Player_ID INT NOT NULL,
    Opponent VARCHAR(50) NOT NULL,
    Runs INT DEFAULT 0 CHECK (Runs >= 0),
    Match_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Player_ID) REFERENCES Players(Player_ID)
);


-- Insert data points into Players table
INSERT INTO Players (Player_Name, Email, Team, Player_Role, Date_of_Birth) VALUES
('Virat Kohli', 'virat@example.com', 'India', 'Batsman', '1988-11-05'),
('Rohit Sharma', 'rohit@example.com', 'India', 'Batsman', '1987-04-30'),
('KL Rahul', 'klrahul@example.com', 'India', 'Batsman', '1992-04-18'),
('Jasprit Bumrah', 'bumrah@example.com', 'India', 'Bowler', '1993-12-06'),
('Shreyas Iyer', 'iyer@example.com', 'India', 'Batsman', '1994-12-06'),
('Hardik Pandya', 'pandya@example.com', 'India', 'All-rounder', '1993-10-11'),
('Steve Smith', 'smith@example.com', 'Aus', 'Batsman', '1989-06-02'),
('David Warner', 'warner@example.com', 'Aus', 'Batsman', '1986-10-27'),
('Mitchell Starc', 'starc@example.com', 'Aus', 'Bowler', '1990-01-30'),
('Pat Cummins', 'cummins@example.com', 'Aus', 'Bowler', '1993-05-08'),
('Aaron Finch', 'finch@example.com', 'Aus', 'Batsman', '1986-11-17'),
('Glenn Maxwell', 'maxwell@example.com', 'Aus', 'All-rounder', '1988-10-14'),
('Kane Williamson', NULL, 'NZ', 'Batsman', '1990-08-08'),
('Trent Boult', 'boult@example.com', 'NZ', 'Bowler', '1989-07-22'),
('Tim Southee', 'southee@example.com', 'NZ', 'Bowler', '1988-12-11'),
('Martin Guptill', 'guptill@example.com', 'NZ', 'Batsman', '1986-09-30'),
('Tom Latham', 'latham@example.com', 'NZ', 'Batsman', '1992-04-02'),
('Jimmy Neesham', 'neesham@example.com', 'NZ', 'All-rounder', '1990-09-17'),
('Babar Azam', 'babar@example.com', 'PAK', 'Batsman', '1994-10-15'),
('Shaheen Afridi', 'afridi@example.com', 'PAK', 'Bowler', '2000-04-06'),
('Mohammad Rizwan', 'rizwan@example.com', 'PAK', 'Batsman', '1992-06-01'),
('Fakhar Zaman', 'zaman@example.com', 'PAK', 'Batsman', '1990-04-10'),
('Shadab Khan', 'shadab@example.com', 'PAK', 'All-rounder', '1998-10-04'),
('Imam-ul-Haq', 'imam@example.com', 'PAK', 'Batsman', '1995-12-12'),
('Shakib Al Hasan', NULL, 'PAK', 'All-rounder', '1987-03-24'),
('Ben Stokes', 'stokes@example.com', 'Eng', 'All-rounder', '1991-06-04'),
('Joe Root', 'root@example.com', 'Eng', 'Batsman', '1990-12-30'),
('Jofra Archer', 'archer@example.com', 'Eng', 'Bowler', '1995-04-01'),
('Jos Buttler', 'buttler@example.com', 'Eng', 'Batsman', '1990-09-08'),
('Adil Rashid', 'rashid@example.com', 'Eng', 'Bowler', '1988-02-17');


select * from matches;


-- Insert sample data with more matches, including several for Virat Kohli against NZ
INSERT INTO Matches (Player_ID, Opponent, Runs, Match_Date) VALUES
-- Matches for Virat Kohli (Player_ID = 1) against NZ
(1, 'NZ', 74, '2023-05-10'),
(1, 'PAK', 110, '2023-06-12'),
(1, 'Aus', 45, '2023-08-24'),
(1, 'Eng', 89, '2023-10-01'),
(1, 'NZ', 62, '2023-12-15'),

-- Additional matches for other players
(2, 'Aus', 120, '2023-06-21'),
(2, 'PAK', 65, '2023-07-11'),
(3, 'Aus', 102, '2023-07-18'),
(4, 'NZ', 5, '2023-09-12'),
(5, 'Eng', 35, '2023-10-05'),
(6, 'NZ', 58, '2023-10-20'),
(7, 'Aus', 42, '2023-11-11'),
(8, 'India', 55, '2023-12-01'),
(9, 'India', 4, '2024-01-15'),
(10, 'NZ', 79, '2024-02-02'),
(11, 'PAK', 34, '2024-02-25'),
(12, 'Eng', 75, '2024-03-15'),
(13, 'PAK', 88, '2024-03-30'),
(14, 'India', 112, '2024-04-22'),
(15, 'Aus', 44, '2024-05-09'),
(16, 'NZ', 91, '2024-06-15'),
(17, 'Eng', 33, '2024-06-30'),
(18, 'India', 99, '2024-07-10'),
(19, 'Aus', 45, '2024-08-01'),
(20, 'NZ', 66, '2024-09-18'),
(21, 'Eng', 18, '2024-10-02'),
(22, 'PAK', 57, '2024-10-20'),
(23, 'Eng', 75, '2024-11-04'),
(24, 'India', 22, '2024-11-20'),
(25, 'NZ', 82, '2024-12-12'),
(26, 'India', 40, '2024-12-25'),
(27, 'NZ', 60, '2025-01-10'),
(28, 'PAK', 102, '2025-02-15'),
(29, 'India', 15, '2025-03-01'),
(30, 'NZ', 75, '2025-03-20');

-- 1. Distinct -- Unique values
-- Q1: Retrieve distinct teams from the Players table
-- Displaying the entire table
select * from players;
-- diplsay only team col
select Team from players;
-- diplsay only unique teams
select distinct Team from players;
-- diplay only unique teams with column renamed to Teams In
select distinct Team as TeamsIN  from players;

-- Q2: Find distinct opponents that player Virat Kohli have faced in matches
select * from players;
select * from matches;

select * from matches where player_id=1;

-- select distinct opponent as OppTeam from matches where player_id=1;
select distinct opponent as OppTeam 
from matches 
where player_id=1;

-- Q3: List all unique player roles available in the team  (e.g., Batsman, Bowler) 
select distinct player_role from players;

-- 2. alias as
-- Q1: Display player names and their respective teams with aliases Player_Name and Player_Team.

select Player_Name, Team as Player_Team from players;

-- Q2: Show Opponent and Match_Date from the Matches table with aliases Opponent_Team and Date_Of_Match
select opponent as Opponent_Team, match_date as Date_Of_Match from matches;

-- Q3: List each player's ID and Date of Birth as ID_Number and Birth_Date
select Player_ID as ID_Number, Date_of_Birth Birth_Date from players;

-- 3. Where
-- Q1.Retrieve match data where Virat Kohli’s runs are 80 or more
select * from matches
where player_id=1;

select * from matches
where player_id=1 or runs>=80;


select * from matches;

-- Q2: Retrieve players whose team is India and who are Batsmen

select * from players
where Team='India' and player_role='Batsman';

-- Q3: Find matches where the opponent team is NZ or Aus and runs scored are greater than 50
select * from matches
where (opponent = 'NZ' or 'Aus') and runs>50;

-- 4. IS NULL / IS NOT NULL
-- Q1: Find all players who don’t have an email address listed.
select * from players
where email is null;

-- Q2: Find all players who don’t have an email address listed and set the email to data missing
-- safe updates 0 set
SET SQL_SAFE_UPDATES =0;

Update players
SET email='data missing'
where email is null;


select * from players;

-- Q3: Retrieve players who have a role assigned (not null values)

select * from players
where player_role is not null;

-- 5. IN / NOT IN:
-- Q1: List players from teams "India" or "Aus"

select * from players 
where Team in ('India','Aus');

-- Q2: Retrieve matches where the opponent team is not PAK or NZ

select * from players 
where Team not in ('PAK','NZ');

-- Q3: List players who have a role as Batsman or All-Rounder
select * from players 
where player_role in ('Batsman','All-Rounder');

-- 6. BETWEEN / NOT BETWEEN:
-- Q1: Players born between 1985 and 1995.
select * from players 
where Date_of_Birth BETWEEN '1990-01-01' and '1995-12-31';

-- Q2: Find matches where runs scored are between 50 and 100
select * from matches
where runs between 50 and 100; 

-- 7.LIKE / NOT LIKE: Pattern matching using wildcard operators % or _
-- Q1: Find players whose names start with 'S'
select * from players 
where player_name LIKE 'S%';

select * from players;
-- Q2: Retrive players whose Player_name contains virat
select * from players 
where Player_name LIKE '%virat%';

-- Q3: List players whose names do not end with 'a'
select * from players 
where Player_name not like '%a';

-- Q4: name contains sh

select * from players 
where Player_name  like '%sh%';

select * from players 
where Player_name  like 'sh%';

-- Q5: any name where third character is s

select * from players 
where Player_name  like '__S%';

-- Q6: Name starts with a,s,m
select * from players 
where Player_name regexp '^[AM]';



-- Price * 5 units --> total cost
-- select product_name, Price * 5 as total_cost from products;
-- select salesperson_name, sales_amount*0.1 as commission from sales;
select * from matches;

select *, runs*2 from matches;


