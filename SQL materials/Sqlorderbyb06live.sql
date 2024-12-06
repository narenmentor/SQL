use cricketdb;

-- SQL Clauses - Orderby, limit,aggregation function - Sum, Count, Min, Max, Average, groupby, having - filtering

select * from matches;
select * from players;

-- Orderby
-- Q1: List players ordered by their date of birth in ascending order

select Player_Name, Date_of_Birth
from Players
Order By Date_of_Birth ASC;

-- display in decending order
select Player_Name, Date_of_Birth
from Players
Order By Date_of_Birth DESC;

-- Q2: Find matches sorted by opponent in ascending order and by runs scored in descending order.

-- sorting out the opponent asceding
select opponent, runs from matches
order by opponent ASC;

-- sorting out the opponent ascending runs in deceding order
select opponent, runs from matches
order by opponent ASC, runs desc;


-- Q3: Retrieve all players from team 'India' ordered by their role and then by Player_ID in descending order.
-- display all players
Select Player_Name, Player_Role, player_id
from players;

-- -- display indian players
Select Player_Name, Player_Role, player_id
from players
where Team="India";

-- sorting 

Select Player_Name, Player_Role, player_id
from players
where Team="India"
order by Player_Role ASC, player_id desc;

-- 2. LIMIT
-- Q1: Retrieve the top 5 players with the highest scores from the Matches table
select Player_ID, Runs from matches
order by runs desc
limit 5;

-- Q2: Display the first 3 players added to the Players table
select Player_Name, Team 
from players
order by Player_ID
Limit 3;

-- 3. Aggregate Functions - Sum, Count, Min, Max, Average

-- Q1. Calculate the Total Runs Scored by All Players
select runs from Matches;

select sum(runs) as Total_runs from Matches;

-- Q2: Find the highest score recorded by any player.
select max(runs) as highest_score 
from Matches;

-- Q3 Calculate the Average Runs Scored Against ‘AUS’
select avg(runs) as average_runs_vs_aus 
from Matches
where Opponent="AUS";

-- Q4 Find the Minimum Runs Scored by Any Player Against ‘PAK’
Select Min(runs) as minimum_runs_vs_Pak from matches where opponent="PAK";

-- groupby
-- Q1: Find the average runs scored against each opponent

select opponent, avg(runs) as avg_runs 
from Matches;

-- Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'cricketdb.Matches.Opponent'; this is incompatible with sql_mode=only_full_group_by

-- similar to averageif in excel
select opponent, avg(runs) as avg_runs 
from Matches
group by opponent;

-- Q2: Get the top 2 opponents with the highest average scores
select opponent, avg(runs) as avg_runs 
from Matches
group by opponent
order by avg_runs desc
limit 2;

-- Q3.Total Runs Scored by Each Player
-- sumif
select Player_ID, sum(runs) as total_runs
from Matches
group by Player_ID
order by total_runs desc;

-- Question 4: Total Matches Played by Each Player
-- countif 
select player_id, count(match_id) as matches_played
from matches
group by player_id;

-- 5. HAVING -- similar to where which is used filtering but only when group by 
-- Q1: Find the total number of matches played by each player 
-- where the total runs scored by the player in all matches exceed 200.

select player_id, count(match_id) as matches_played, sum(runs) as total_runs
from matches
group by player_id
having total_runs>200;

-- with order by and limit

select player_id, count(match_id) as matches_played, sum(runs) as total_runs
from matches
group by player_id
having total_runs>200
order by total_runs desc
limit 3;

-- Q2: Retrieve opponents against whom players have scored an average of more than 50 runs.
select opponent, avg(runs) as avg_runs
from matches
group by opponent
having avg_runs>50;

-- Q3: Find the players with a minimum score of 30 runs in any of their matches.
select player_id, min(runs) as min_runs
from matches
group by player_id
having min_runs>=30;

-- Q4 : Q4. using where in groupby clauses
-- Retrieve players who scored a total of over 100 runs against ‘NZ’.

select player_id, sum(runs) as total_runs
from matches
where opponent="NZ"
group by player_id
having total_runs>100;

-- combined questions
-- List the top 3 opponents where players have scored the highest average runs, 
-- but only include opponents where the total runs scored are above 200. 
-- Order the result by average runs in descending order.

select opponent, avg(runs) as avg_runs, sum(runs) as total_runs
from matches
group by opponent
having total_runs>200
order by avg_runs desc
limit 3;

/*
Find the top 5 players with the highest total runs across all matches, 
but only include players who have played in more than 3 matches. 
Display the results ordered by total runs in descending order.
*/

select player_id, sum(runs) as total_runs, count(match_id) as matches_played
from matches
group by player_id
having matches_played>3
order by total_runs desc
limit 5;

/*
Identify the top 5 players with the highest average runs in matches against 'NZ' or 'AUS', 
where they scored at least 20 runs on average.
Order the list by average runs in descending order.
*/

select player_id, opponent, avg(runs) as avg_runs
from matches
where Opponent in ('NZ', 'AUS')
group by player_id
having avg_runs>=20
order by avg_runs desc
limit 5;

-- Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'cricketdb.matches.Opponent' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- solution group by opponent also!

select player_id, opponent, avg(runs) as avg_runs
from matches
where Opponent in ('NZ', 'AUS')
group by player_id, opponent
having avg_runs>=20
order by avg_runs desc
limit 5;












