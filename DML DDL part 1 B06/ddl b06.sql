-- Creating the database

-- syntax -- Grammer/ rules for writing a code or query

-- create object_type object_name
-- create query
create database b06; 
-- query or command to make b06 database as the current working database
use b06;

-- table creation based on the given schema

-- syntax for creating the table
/* 
create table table_name( mention your columns/fields and datatype); 
create table table_name(
column1 data_type,
column2 data_type,
.....
columnN data_type);
*/

create table products(
product_id int,
product_name varchar(30),
price decimal(10,2), -- max 10 digits 12345678.90
stock_quantity int
);

-- DML queries 

create table customers(
customer_id int,
first_name varchar(30),
last_name varchar(30),
gender enum("M","F")
);

create table orders(
order_id int,
customer_id int,
product_id int,
order_date date
);

-- Alter commands
-- add column

Alter table orders
add column total_amount decimal(10,2);

Alter table customers
add column ( email varchar(30) , phone_number varchar(30));

-- drop column in Alter
Alter table customers
drop column last_name;

-- modify in alter
alter table customers
modify column email varchar(50);

-- rename column in alter
alter table customers
rename column email to email_id;

alter table orders
rename to order_details;

-- rename
rename table order_details to orders;

-- truncate
-- all data get erased
truncate table orders;

-- drop
-- totally schema get erased
-- drop table orders;

-- drop database b06;







