-- Creating a sample database
create database if not exists ecom;
use ecom;
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    RegistrationDate DATE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    OrderStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert data into Customers
INSERT INTO Customers (CustomerName, Email, RegistrationDate) 
VALUES ('Alice', 'alice@example.com', '2023-01-01'),
       ('Bob', 'bob@example.com', '2023-02-01');

-- Insert data into Products
INSERT INTO Products (ProductName, Price, Stock) 
VALUES ('Laptop', 50000.00, 20),
       ('Smartphone', 30000.00, 50);

-- Insert data into Orders
INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, OrderStatus) 
VALUES (1, 1, 5, '2023-03-01', 'Shipped'),
       (2, 2, 10, '2023-03-05', 'Delivered');

select * from customers;
select * from Products;
select * from Orders;


-- After trigger for Insert
-- Log New Customer Registration
-- create a registration log table
create table CustomerLog(
LogID INT auto_increment primary key,
CustomerID INT,
LogMessage varchar(255),
LogDate timestamp default current_timestamp
);

-- creating after trigger

DELIMITER //
CREATE trigger aftercustomerinsert
after insert on customers
for each row
Begin
 -- trigger logic
	insert into CustomerLog(CustomerID,LogMessage)
    values(new.CustomerID,concat('New Customer Registered: ',new.CustomerName));
End //
DELIMITER ;

INSERT INTO Customers (CustomerName, Email, RegistrationDate) 
VALUES ('Jack', 'jack@example.com', '2024-02-01');

INSERT INTO Customers (CustomerName, Email, RegistrationDate) 
VALUES ('elon', 'elon@example.com', '2024-02-01');
select * from customers;
select * from CustomerLog;

-- Test question here
-- Auto-Update Stock Alert After Product Addition ( if less then 10 stocks)
-- Insert data into Products
INSERT INTO Products (ProductName, Price, Stock) 
VALUES ('Laptop', 50000.00, 9);
/*
StockAlert
AlertID
productid
alertmessage
alertdate

logic - trigger - if less then 10 stocks log into stockalert table
*/
create table StockAlert(
AlertID INT auto_increment primary key,
productid INT,
alertmessage varchar(255),
alertdate timestamp default current_timestamp
);


DELIMITER //
CREATE trigger afternewproduct
after insert on products
for each row
Begin
 -- trigger logic
 if new.Stock<10 then
	insert into StockAlert(productid,alertmessage)
    values(new.productid,concat('Low stock left for the newly added product: ',new.ProductName));
 end if;
End //
DELIMITER ;


INSERT INTO Products (ProductName, Price, Stock) 
VALUES ('Laptop', 50000.00, 9);

select * from StockAlert;




-- after trigger update
-- Log Price Changes of Products
create table pricechangelog(
LogID INT auto_increment primary key,
productid int,
oldprice decimal(10,2),
newprice decimal(10,2),
ChangeDate timestamp default current_timestamp
);

-- create after update trigger


DELIMITER //
CREATE trigger afterpricechange
after update on Products
for each row
Begin
 -- trigger logic
	if new.price  <> old.price then
		insert into pricechangelog(productid,oldprice,newprice)
        values(new.productid,old.price,new.price);
	end if;
End //
DELIMITER ;
-- Error Code: 1363. There is no OLD row in on INSERT trigger

-- update query

set sql_safe_updates=0;
update products
set price='54000'
where productname="laptop";

select * from pricechangelog;
select * from products;

-- test 2 -- update
select * from orders;
-- Notify Customers of Order Status Change
-- orderstatuschangelog




