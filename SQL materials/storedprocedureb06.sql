 -- Step 1: Create the database
CREATE DATABASE company_db;
USE company_db;

-- Step 2: Create the employees table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE
);

-- Insert data into employees table
INSERT INTO employees (first_name, last_name, department_id, hire_date)
VALUES
('John', 'Doe', 1, '2019-05-10'),
('Jane', 'Smith', 2, '2020-03-15'),
('Alice', 'Johnson', 3, '2018-07-19'),
('Bob', 'Brown', 1, '2017-01-12'),
('Charlie', 'Davis', 2, '2021-10-25'),
('Eve', 'Wilson', 3, '2019-11-30'),
('Grace', 'Hall', 1, '2020-06-22'),
('Frank', 'Lee', 2, '2022-04-01'),
('Helen', 'Clark', 3, '2018-08-18'),
('Ivy', 'Turner', 1, '2019-09-14'),
-- Add more records as needed
('Max', 'Payne', 3, '2021-12-20');

-- Step 3: Create the departments table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Insert data into departments table
INSERT INTO departments (dept_name)
VALUES
('Human Resources'),
('Engineering'),
('Finance');

-- Step 4: Create the salaries table
CREATE TABLE salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    salary_amount DECIMAL(10, 2),
    payment_date DATE
);

-- Insert data into salaries table
INSERT INTO salaries (emp_id, salary_amount, payment_date)
VALUES
(1, 55000, '2023-01-15'),
(2, 75000, '2023-01-20'),
(3, 67000, '2023-02-15'),
(4, 48000, '2023-02-20'),
(5, 82000, '2023-03-15'),
(6, 59000, '2023-03-20'),
(7, 52000, '2023-04-15'),
(8, 72000, '2023-04-20'),
(9, 61000, '2023-05-15'),
(10, 53000, '2023-05-20'),
-- Add more records as needed
(11, 70000, '2023-06-15');


select * from employees;
select * from departments;
select * from salaries;

-- Stored Procedure
-- 1. Simple Stored Procedure
-- Create a stored procedure GetAllEmployees to retrieve all employees' details from the employees table.

Delimiter //
create procedure GetAllEmployees()
BEGIN
select * from employees;
END //
Delimiter ;

call GetAllEmployees();

--  Create a stored procedure GetDepartments to retrieve all department names.
-- drop Procedure GetDepartments;
Delimiter //

Create Procedure GetDepartments()
begin 
select dept_name from departments;
end //
delimiter ;

call GetDepartments();

-- task
-- Create a stored procedure GetTotalSalary to calculate the total salary expense of the company.
-- avereage salary
-- maximum salary


-- 2.IN parameter 
-- Create a stored procedure GetEmployeesByDepartment to retrieve employees based on a given department name.

Delimiter //
create procedure GetEmployeesByDepartment(IN department_name varchar(20))
BEGIN
	select e.emp_id, concat(e.first_name," ",e.last_name) as employee_name, d.dept_name
    from employees e
    join departments d
    on e.department_id=d.dept_id
    where d.dept_name=department_name;
END //
Delimiter ;

call GetEmployeesByDepartment("Engineering");
-- Create a stored procedure GetEmployeesHiredAfter to retrieve employees hired after a specific date.
-- 2020-03-15

drop procedure GetEmployeesHiredAfter;
DELIMITER // 

create procedure GetEmployeesHiredAfter(IN hire_date date)  
BEGIN 
select * from employees e
where e.hire_date>hire_date; 
END // 
delimiter ;     

call GetEmployeesHiredAfter("2020-03-15");

-- Create a stored procedure GetHighSalaries to retrieve employees earning more than a specified salary.


-- out
-- Create a stored procedure GetEmployeeCount to return the total number of employees.
DELIMITER // 
create procedure GetEmployeeCount(OUT totalcount INT)
BEGIN
	select count(*) into totalcount from employees;
END //
DELIMITER ;

-- call with output variable
set @empcount=0;
call GetEmployeeCount(@empcount);
select @empcount as totalcount;

-- in, out
-- Retrieves and returns the employee's current department (as an OUT parameter).
DELIMITER // 
create procedure getdeptbyid(IN empid INT, OUT deptname varchar(20))
BEGIN
	select d.dept_name INTO deptname
    from employees e
    join departments d
    on e.department_id=d.dept_id
    where e.emp_id = empid;
END //
DELIMITER ;
set @deptname="";
call getdeptbyid(9,@deptname);
select @deptname as department_name;


-- inout
-- salary --> Increment --> updatedsalary

Delimiter //

create procedure incrementsalary(IN empid INT, IN percentage decimal(10,2), INOUT salary decimal(10,2))
BEGIN
	set salary = salary + (salary*percentage/100);
    update salaries set salary_amount = salary 
    where emp_id = empid;
END //

set sql_safe_updates=0;

Delimiter ;
set @currentsalary =70000;
call incrementsalary(11, 10,@currentsalary);

select * from salaries;




 