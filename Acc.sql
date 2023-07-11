Use master
IF DB_ID('AccDB ') IS NOT NULL
DROP Database AccDB 
CREATE Database AccDB 
GO

Use AccDB 
GO

CREATE TABLE accounts (
  account_id INTEGER PRIMARY KEY,
  account_name VARCHAR(255),
  account_type VARCHAR(255),
  balance DECIMAL(10,2)
);
CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  date DATE,
  description VARCHAR(255),
  amount DECIMAL(10,2),
  account_id INTEGER,
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  phone VARCHAR(255)
);
CREATE TABLE vendors (
  vendor_id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  phone VARCHAR(255)
);
CREATE TABLE employees (
  employee_id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  job_title VARCHAR(255),
  salary DECIMAL(10,2)
);
CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  code VARCHAR(255),
  inventory INTEGER
);
CREATE TABLE invoices (
  invoice_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  date DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
GO

---- Trigger
--CREATE TRIGGER update_account_balance
--AFTER INSERT ON transactions
--FOR EACH ROW
--BEGIN
--  UPDATE accounts
--  SET balance = balance + NEW.amount
--  WHERE account_id = NEW.account_id;
--END;
--GO

--CREATE TRIGGER update_inventory
--AFTER INSERT ON invoice_items
--FOR EACH ROW
--BEGIN
--  UPDATE products
--  SET inventory = inventory - NEW.quantity
--  WHERE product_id = NEW.product_id;
--END;
--GO

--CREATE TRIGGER update_customer_balance
--AFTER INSERT ON invoices
--FOR EACH ROW
--BEGIN
--  UPDATE customers
--  SET balance = balance + NEW.total
--  WHERE customer_id = NEW.customer_id;
--END;
--GO


---- Trigger for user login and activity

--CREATE TABLE user_activity_logs (
--  log_id INTEGER PRIMARY KEY,
--  user_id INTEGER,
--  timestamp TIMESTAMP,
--  action_type VARCHAR(255),
--  details VARCHAR(255)
--);
--GO
--CREATE TRIGGER log_login_activity
--AFTER UPDATE ON users
--FOR EACH ROW
--BEGIN
--  IF NEW.logged_in = 1 THEN
--    INSERT INTO user_activity_logs (user_id, timestamp, action_type, details)
--    VALUES (NEW.user_id, CURRENT_TIMESTAMP, 'login', 'User logged in');
--  ELSE
--    INSERT INTO user_activity_logs (user_id, timestamp, action_type, details)
--    VALUES (OLD.user_id, CURRENT_TIMESTAMP, 'logout', 'User logged out');
--  END IF;
--END;
--GO
--CREATE TRIGGER log_update_activity
--AFTER UPDATE ON customers
--FOR EACH ROW
--BEGIN
--  INSERT INTO user_activity_logs (user_id, timestamp, action_type, details)
--  VALUES (USER, CURRENT_TIMESTAMP, 'update', 'User updated customer record');
--END;
--GO
--CREATE TRIGGER log_delete_activity
--AFTER DELETE ON products
--FOR EACH ROW
--BEGIN
--  INSERT INTO user_activity_logs (user_id, timestamp, action_type, details)
--  VALUES (USER, CURRENT_TIMESTAMP, 'delete', 'User deleted product record');
--END;
--GO


--Other Tables
CREATE TABLE chart_of_accounts (
  account_id INTEGER PRIMARY KEY,
  account_number VARCHAR(255),
  account_name VARCHAR(255),
  account_type VARCHAR(255)
);

--CREATE TABLE financial_statements (
--  id INTEGER PRIMARY KEY,
--  statement_type VARCHAR(255),
--  period_start DATE,
--  period_end DATE,
--  data JSON
--);
CREATE TABLE cash_flow_statements (
  id INTEGER PRIMARY KEY,
  period_start DATE,
  period_end DATE,
  net_cash_flow_from_operating_activities DECIMAL(10,2),
  net_cash_flow_from_investing_activities DECIMAL(10,2),
  net_cash_flow_from_financing_activities DECIMAL(10,2),
  net_change_in_cash_and_cash_equivalents DECIMAL(10,2)
);
CREATE TABLE income_statements (
  id INTEGER PRIMARY KEY,
  period_start DATE,
  period_end DATE,
  revenue DECIMAL(10,2),
  expenses DECIMAL(10,2),
  net_income DECIMAL(10,2),
  notes TEXT
);

CREATE TABLE balance_sheets (
  id INTEGER PRIMARY KEY,
  period_start DATE,
  period_end DATE,
  assets DECIMAL(10,2),
  liabilities DECIMAL(10,2),
  equity DECIMAL(10,2),
  notes TEXT
);

--CREATE TABLE owner_equity_statements (
--  id INTEGER PRIMARY KEY,
--  period_start DATE,
--  period_end DATE,
--  capital_contributions DECIM

GO

--Store Procedure

CREATE PROCEDURE add_customer (
  @name VARCHAR(255),
  @address VARCHAR(255),
  @phone VARCHAR(255)
)
AS
BEGIN
  INSERT INTO customers (name, address, phone)
  VALUES ('Jashim', 'Dhaka', '007');
END 
GO

CREATE PROCEDURE update_customer (
  @customer_id INTEGER,
  @name VARCHAR(255),
  @address VARCHAR(255),
  @phone VARCHAR(255)
)
AS 
BEGIN
  UPDATE customers
  SET name = name, address = address, phone = phone
  WHERE customer_id = customer_id;
END 
GO

CREATE PROCEDURE delete_customer (
  @customer_id INTEGER
)
AS
BEGIN
  DELETE FROM customers
  WHERE customer_id = customer_id;
END 
GO

CREATE PROCEDURE add_product (
  @name VARCHAR(255),
  @code VARCHAR(255),
  @inventory INTEGER
)
AS
BEGIN
  INSERT INTO products (name, code, inventory)
  VALUES ('JJJ', '009', '7');
END 
GO

CREATE PROCEDURE update_product (
  @product_id INTEGER,
  @name VARCHAR(255),
  @code VARCHAR(255),
  @inventory INTEGER
)
AS
BEGIN
  UPDATE products
  SET name = name, code = code, inventory = inventory
  WHERE product_id = product_id;
END 
GO

CREATE PROCEDURE delete_product (
  @product_id INTEGER
)
AS
BEGIN
  DELETE FROM products
  WHERE product_id = product_id;
END;
GO