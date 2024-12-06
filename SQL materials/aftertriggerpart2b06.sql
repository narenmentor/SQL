create database newecomdb;
use newecomdb;
-- Create Tables
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    RegistrationDate DATE
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

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

-- Insert Sample Data
INSERT INTO Customers (CustomerName, Email, RegistrationDate)
VALUES ('John Doe', 'john@example.com', '2024-01-01'),
       ('Jane Smith', 'jane@example.com', '2024-02-15');

INSERT INTO Products (ProductName, Price, Stock)
VALUES ('Laptop', 1000.00, 10),
       ('Phone', 500.00, 20);

INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, OrderStatus)
VALUES (1, 1, 2, '2024-10-01', 'Shipped'),
       (2, 2, 1, '2024-10-05', 'Pending');
       
select * from customers;
select * from Products;
select * from Orders;


-- after trigger on delete
DELIMITER //
CREATE trigger afterdeleteorder
after delete on orders
for each row
Begin
 -- trigger logic
	update products
	set stock=stock+old.Quantity
	where ProductID=old.ProductID;
End //
DELIMITER ;


delete from orders where OrderID=1;

/*
sample logic for updating a value in already existing field/variable
number=10;
newnumber=2;
number=number+newnumber

number=12
*/
-- test 
-- HINT
-- prevent the deletion of customer who joined in the most recent year.
-- first which is recent year store it in a variable
-- trigger stored date year --> set message --> recent year joined customer cannot be deleted



