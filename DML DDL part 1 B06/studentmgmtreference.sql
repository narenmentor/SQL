/* 
Table student:
Student_ID 	INT	PK	AI
First_Name 	VARCHAR(50)	NOT NULL	
Last_Name	VARCHAR(50)	NOT NULL	
DOB	Date		
Gender	Enum	('M','F','Other')	Default --> Other
Contact_Number	VARCHAR(50)		
Email	VARCHAR(50)	Unique	
Department_ID	INT	FK	on Delete Cascade
*/

create database if not exists studentmgmtdb;

use studentmgmtdb;

-- Error Code: 1824. Failed to open the referenced table 'departments'
create table student(
Student_ID INT auto_increment primary key,
First_Name VARCHAR(50)	NOT NULL,
Last_Name	VARCHAR(50)	NOT NULL,
DOB datetime,
Gender enum("M","F","Other"),
Department_ID INT,
foreign key (Department_ID) references Departments(Department_ID) on Delete Cascade
);

/*
Department_ID	INT	PK	AI
Department_Name	VARCHAR(50)	UNIQUE NOT NULL	
*/

create table Departments(
Department_ID INT auto_increment primary key,
Department_Name	VARCHAR(50)	UNIQUE NOT NULL	
);

/*
Course_ID	INT	PK	AI
Course_Name	VARCHAR(50)	NOT NULL	
Department_ID	INT	FK	on Delete Cascade
Credits	INT	between 1 and 6	
*/

create table courses(
Course_ID INT auto_increment primary key,
Course_Name	VARCHAR(50)	NOT NULL,
Credits	INT Check (Credits between 1 and 6),
Department_ID	INT,
foreign key (Department_ID) references Departments(Department_ID) on Delete Cascade
);

insert into Departments(Department_Name)
values
("Mechanical");

select * from Departments;

insert into Departments(Department_Name)
values
("CSE");



