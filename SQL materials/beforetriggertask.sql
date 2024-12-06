-- Trigger internal task

-- Customers
INSERT INTO Customers (CustomerName, Email, RegistrationDate)
VALUES 
('Alice', 'alice@example.com', '2023-01-10'),
('Bob', 'bob@example.com', '2023-02-15');

-- Products
INSERT INTO Products (ProductName, Price, Stock)
VALUES 
('Laptop', 1000.00, 10),
('Phone', 500.00, 20);

-- Orders
INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, orderstatus)
VALUES 
(1, 1, 2, '2023-03-01', 'Pending'),
(1, 2, 1, '2023-03-02', 'Delivered'),
(2, 1, 5, '2023-03-05', 'Processing');

-- format customer name to uppercase while Inserting
-- Prevent Deletion of Customers with Active Orders
-- Prevent Deletion of Orders Marked as Delivered
