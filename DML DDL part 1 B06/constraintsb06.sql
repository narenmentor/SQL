-- DDL and Constraints

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

-- DML -- CRUD
-- Insert --> Create -- Insert Into
-- View --> Read -- select from
-- Update
-- Delete 

-- syntax for inserting data
-- Insert into tablename(leave empty if you are entereing data for all the fields) values(values for all fields in the table)
--  Insert into tablename(specify columns) values(insert respective values )
insert into players(Player_Name,Email,Team, Player_Role,DateofBirth)
values
('Virat Kohli','virat@crickdb.com','India','Batsman','1988-11-05');

-- view the data from the database/table
-- syntaxt for viewing data or reading the data
-- select column_names from table_name
-- select * from table_name-- fetch all fields data
select Player_Name,DateofBirth from players;
select * from players;

insert into players(Player_Name,Email,Team,DateofBirth)
values
('CONWAY','conway@crickdb.com','NZ','1986-10-05');
select * from players;

insert into players(Player_Name,Email,DateofBirth)
values
('marsh','marsh@crickdb.com','1987-10-05');
select * from players;

-- Error Code: 1062. Duplicate entry 'conway@crickdb.com' for key 'players.Email'

insert into players(Player_Name,Email,Team,DateofBirth)
values
('Babar','conway@crickdb.com','Pak','1986-10-05');

insert into players(Player_Name,Email,Team,DateofBirth)
values
('Babar','Babar@crickdb.com','Pak','1986-10-05');

Insert into matches(Player_ID,Opponent,Runs,Match_Date)
values
(1,'NZ',78,'2024-10-26');

select * from matches;

-- foreign  key error 
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`cricketdb`.`matches`, CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`Player_ID`) REFERENCES `players` (`Player_ID`))

Insert into matches(Player_ID,Opponent,Runs,Match_Date)
values
(5,'NZ',78,'2024-10-26');

Insert into matches(Player_ID,Opponent,Runs)
values
(4,'Aus',60);

-- Error Code: 3819. Check constraint 'matches_chk_1' is violated.
Insert into matches(Player_ID,Opponent,Runs)
values
(4,'NZ',-60);

Insert into matches(Player_ID,Opponent)
values
(4,'India');

select * from matches;
select * from players;

-- update
/*
The cricket association wants to change the Player_Role of a player from "Batsman" to "Captain" due to
 recent performance improvements.
*/
-- update syntax
-- update tablename
-- set column --> values
-- where and condition

update players
set Player_Role="Captain"
where Player_Name="Virat Kohli";

select * from players;

update players
set Player_Role="Opponent Captain"
where Player_Name="Babar" AND Player_Role="Batsman";

set SQL_SAFE_UPDATES=0;
-- delete on cascade

-- truncate
SELECT * from Players;
-- Error Code: 1701. Cannot truncate a table referenced in a foreign key constraint (`cricketdb`.`matches`, CONSTRAINT `matches_ibfk_1`)


-- alter query to modify the constrain foregin key
Alter table matches
drop foreign key matches_ibfk_1;

-- delete all the records available in the table
truncate players;

-- drop 
drop database cricketdb;

-- delete
/*
Delete from Matches
where opponent="Pakistan" and Runs<50;
*/

