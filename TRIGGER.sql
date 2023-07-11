-- Create a new database with a custom path and file size
Use master
IF DB_ID('MyDB_20230102') IS NOT NULL
DROP DATABASE MyDB_20230102
CREATE DATABASE MyDB_20230102
ON (NAME = 'MyDB_20230102_dat',
    FILENAME = 'D:\Databases\MyDB_20230102.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON (NAME = 'MyDB_20230102_log',
       FILENAME = 'D:\Databases\MyDB_20230102_log.ldf',
       SIZE = 5MB,
       MAXSIZE = 25MB,
       FILEGROWTH = 5MB);
GO

Use MyDB_20230102
GO

-- Create the orders table
CREATE TABLE orders (
  order_id INT PRIMARY KEY IDENTITY,
  product_name VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL
);
GO

SELECT product_name, SUM(quantity) AS total_quantity
FROM orders
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY product_name
HAVING SUM(quantity) > 100
ORDER BY total_quantity DESC;
GO


-- Create the customers table
CREATE TABLE customers (
  customer_id INT PRIMARY KEY IDENTITY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(255) NOT NULL
);
GO

-- Create the addresses table
CREATE TABLE addresses (
  address_id INT PRIMARY KEY IDENTITY,
  customer_id INT NOT NULL,
  street_address VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  zip_code VARCHAR(255) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
GO


-- Create the orders_audit table
CREATE TABLE orders_audit (
  audit_id INT PRIMARY KEY IDENTITY,
  order_id INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL,
  operation VARCHAR(10) NOT NULL,
  audit_timestamp DATETIME DEFAULT GETDATE()
);
GO

/*
One key difference between INSTEAD OF triggers and AFTER triggers is that INSTEAD OF triggers can be used on views, whereas AFTER triggers can only be used on tables. This is because INSTEAD OF triggers are executed in place of the triggering action, whereas AFTER triggers are executed after the triggering action has occurred on the table.
*/

-- Create a trigger to track changes to the orders table
CREATE TRIGGER OrderAudit ON orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  -- Insert the affected rows into the audit table
  INSERT INTO orders_audit (order_id, product_name, quantity, order_date, operation)
  SELECT i.order_id, i.product_name, i.quantity, i.order_date, 'INSERT'
  FROM inserted i;

  INSERT INTO orders_audit (order_id, product_name, quantity, order_date, operation)
  SELECT d.order_id, d.product_name, d.quantity, d.order_date, 'DELETE'
  FROM deleted d;

  INSERT INTO orders_audit (order_id, product_name, quantity, order_date, operation)
  SELECT i.order_id, i.product_name, i.quantity, i.order_date, 'UPDATE'
  FROM inserted i
  INNER JOIN deleted d ON i.order_id = d.order_id
  WHERE i.product_name <> d.product_name OR i.quantity <> d.quantity OR i.order_date <> d.order_date;
END;
GO

--CREATE TRIGGER OrderAudit ON orders
--INSTEAD OF INSERT, UPDATE, DELETE
--AS
--BEGIN
--  SET NOCOUNT ON;

--  -- Insert the affected rows into the audit table
--  INSERT INTO orders_audit (order_id, product_name, quantity, order_date, operation)
--  SELECT i.order_id, i.product_name, i.quantity, i.order_date, 'INSERT'
--  FROM inserted i;

--  INSERT INTO orders_audit (order_id, product_name, quantity, order_date, operation)
--  SELECT d.order_id, d.product_name, d.quantity, d.order_date, 'DELETE'
--  FROM deleted d;

--  INSERT INTO orders_audit (order_id, product_name, quantity, order_date, operation)
--  SELECT i.order_id, i.product_name, i.quantity, i.order_date, 'UPDATE'
--  FROM inserted i
--  INNER JOIN deleted d ON i.order_id = d.order_id
--  WHERE i.product_name <> d.product_name OR i.quantity <> d.quantity OR i.order_date <> d.order_date;
--END;
--GO


-- Create a stored procedure to insert 1000 rows of data into the orders table
CREATE PROCEDURE InsertOrders
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @i INT = 1;
  WHILE @i <= 1000
  BEGIN
    INSERT INTO orders (product_name, quantity, order_date)
    VALUES ('Product ' + CAST(@i AS VARCHAR), @i, GETDATE());
    SET @i = @i + 1;
  END;
END;
GO

-- Create a stored procedure to insert 1000 rows of data into the customers table
CREATE PROCEDURE InsertCustomers
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @i INT = 1;
  WHILE @i <= 1000
  BEGIN
    INSERT INTO customers (first_name, last_name, email, phone)
    VALUES ('FirstName ' + CAST(@i AS VARCHAR), 'LastName ' + CAST(@i AS VARCHAR), 'email' + CAST(@i AS VARCHAR) + '@example.com', '123-456-' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
  END;
END;
GO

-- Create a stored procedure to insert 1000 rows of data into the addresses table
CREATE PROCEDURE InsertAddresses
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @i INT = 1;
  WHILE @i <= 1000
  BEGIN
    INSERT INTO addresses (customer_id, street_address, city, state, zip_code)
    VALUES (@i, 'Street Address ' + CAST(@i AS VARCHAR), 'City ' + CAST(@i AS VARCHAR), 'State ' + CAST(@i AS VARCHAR), 'ZipCode ' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
  END;
END;
GO

EXEC InsertOrders;
GO
EXEC InsertCustomers;
GO
EXEC InsertAddresses;
GO

SELECT * FROM orders_audit
GO