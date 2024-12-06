CREATE DATABASE DCLDB;

USE DCLDB;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
INSERT INTO Employees (EmployeeName, Department, Salary)
VALUES
('Alice', 'HR', 50000),
('Bob', 'IT', 70000),
('Charlie', 'Finance', 60000);

INSERT INTO Departments (DepartmentName)
VALUES ('HR'), ('IT'), ('Finance');

select * from Employees;

-- DCL - User - Multi-user environment
-- check current user
select user();

select current_user();
-- project 1 server -- database 
-- project 2 server 

-- other users in this server
select user, host from mysql.user;

-- creating new user 
-- create user username@host identified by 'pwd';
create user analyst@localhost identified by 'analyst123';
create user developer@localhost identified by 'developer123';
create user manager@localhost identified by 'manager123';

show grants for analyst@localhost;

-- Grant SELECT Privileges to a User
grant select on DCLDB.Employees to analyst@localhost;

-- Revoke Privileges for the user analyst
revoke select on DCLDB.Employees from analyst@localhost;

-- Grant ALL Privileges to a Manager
grant ALL Privileges on DCLDB.* to manager@localhost;

-- grant Multiple Privileges
grant select, insert on departments to developer@localhost;

-- revoking particular grant from user
revoke insert on DCLDB.departments from developer@localhost;

show grants for manager@localhost;

-- drop user
drop user developer@localhost;

-- Reset Password for a User
alter user analyst@localhost identified by 'analyst2024';







