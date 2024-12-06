create database tcldb;
use tcldb;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductName, Price, Stock)
VALUES
('Laptop', 50000.00, 10),
('Mobile', 15000.00, 20),
('Tablet', 20000.00, 15),
('Headphones', 2000.00, 50);

set sql_safe_updates=0;

-- update price of laptop 
begin;
update Products set Price="58000" where ProductName="Laptop";
update Products set Price="18000" where ProductName="Tablet";
commit;

select * from Products;

-- rollback
begin;
update Products set Stock="8" where ProductName="Laptop";
update Products set Stock="15" where ProductName="Mobile";
rollback; -- it will take you to the latest commit statement

-- savepoint
begin;
update Products set Price="1500" where ProductName="Headphones";
savepoint sp1;
-- release savepoint sp1;
update Products set Price="22000" where ProductName="Tablet";
rollback to sp1;
update Products set Price="25000" where ProductName="Tablet";
savepoint sp2;

commit;

release savepoint sp1;
-- Error Code: 1305. SAVEPOINT sp1 does not exist

select * from Products;




