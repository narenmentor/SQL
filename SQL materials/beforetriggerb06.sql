create database if not exists ecom;
use ecom;
-- Customers table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    RegistrationDate DATE
);

-- Products table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    orderstatus varchar(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data into Customers
INSERT INTO Customers (CustomerName, Email, RegistrationDate) VALUES
('John Doe', 'john@example.com', '2024-01-01'),
('Alice Smith', 'alice@example.com', '2024-02-15'),
('Daniel', 'Daniel@example.com', '2024-02-20');

-- Insert sample data into Products
INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 1200.00, 10),
('Smartphone', 800.00, 20),
('Tablet', 900.00, 30);

-- Insert sample data into Orders
INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, orderstatus) VALUES
(1, 1, 1, '2024-03-01',"Pending"),
(2, 2, 2, '2024-03-05',"Shipped"),
(3, 2, 4, '2024-03-10',"Shipped");


select * from customers;
select * from Products;
select * from Orders;


-- Trigger

-- Insert

-- Q1: Enforce Minimum Order Quantity

Delimiter //

create trigger EnforceMinimumOrderQuantity
-- before or after , insert/update/delete table name
Before Insert on orders
for each row
Begin
	-- trigger logic
    -- quantity <1 --> trigger logic --> custom error --> quantity must be at least 1
    if New.Quantity<1 then
		signal sqlstate '45000'
        Set message_text="quantity must be at least 1";
	End if;
    -- trigger logic
    
    
End //
Delimiter ;

INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, orderstatus) VALUES
(1, 1, 2, '2024-04-01',"Pending");

-- 
Delimiter //
create trigger checkstock
Before Insert on orders
for each row
Begin
	-- trigger logic
    -- create a variable for storing my current stocks where the newly inserted product id is matching
    Declare stock_left INT;
    select stock into stock_left 
    from products
    where ProductID = New.ProductID;
    -- logic stock_left<new.quantity (new.quantity < available stock in products)
    if stock_left<new.quantity then
    signal sqlstate '45000'
        Set message_text="not enough stock available";
	End if;
End //
Delimiter ;


INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, orderstatus) VALUES
(2, 2, 5, '2024-04-01',"Pending");


INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, orderstatus) VALUES
(2, 2, 0, '2024-04-01',"Pending");
-- update
-- Prevent Price Reduction Below Cost
-- i want to update price of a product 

Delimiter //
create trigger checkprice
Before update on products
for each row
Begin
	-- trigger logic
    -- price<100 
    if New.price<100 then
		signal sqlstate '45000'
        Set message_text="Price must be greater than 100";
	End if;
End // 
Delimiter ;



UPDATE products
SET price = 90
WHERE ProductID = 3;


-- task - create before trigger for this
-- while updaing product stock units check if it does not exceed more than 100 units


-- Trigger on before delete
-- Prevent Deletion of Products Linked to Orders
-- delete

Delimiter //
create trigger checkproductinorders
Before delete on products
for each row
Begin
	-- trigger logic
    -- the product id which i wanted to delete in products table is cross checked with the orders table
    -- product cannot be deleted
    -- if exists (select 'A' "here A or 1 is a dummy value that ensures that the product is available in the orders table" 
    if exists (select 1 from orders where ProductID=old.ProductID) then   -- if (true)
		signal sqlstate '45000'
        Set message_text="Product cannot be deleted because it is in orders table";
	End if;
    
End //

Delimiter ;

-- delete query
delete from products where ProductID =3;



