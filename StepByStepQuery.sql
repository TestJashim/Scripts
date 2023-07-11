Use master
IF DB_ID('AISDB') IS NOT NULL
DROP DATABASE AISDB
CREATE DATABASE AISDB
ON (NAME = 'AISDB_dat',
    FILENAME = 'D:\Databases\AISDB.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON (NAME = 'AISDB_log',
       FILENAME = 'D:\Databases\AISDB_log.ldf',
       SIZE = 5MB,
       MAXSIZE = 25MB,
       FILEGROWTH = 5MB);
GO

Use AISDB
GO


CREATE TABLE chart_of_accounts (
  account_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  amount NUMERIC NOT NULL,
  account_id INTEGER NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE journals (
  journal_id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE ledger (
  transaction_id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  contact_info TEXT NOT NULL
);
CREATE TABLE vendors (
  vendor_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  contact_info TEXT NOT NULL
);
CREATE TABLE employees (
  employee_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  contact_info TEXT NOT NULL,
  department TEXT NOT NULL
);
CREATE TABLE balance_sheet (
  id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE income_statement (
  id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE owners_equity (
  id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE cash_flow (
  id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE notes (
  id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
CREATE TABLE vouchers (
  id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  account_id INTEGER NOT NULL,
  amount NUMERIC NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);
GO

INSERT INTO chart_of_accounts (account_id, name)
VALUES (1, 'Cash'), (2, 'Accounts Receivable'), (3, 'Inventory'), (4, 'Prepaid Expenses');
INSERT INTO transactions (transaction_id, date, amount, account_id)
VALUES (1, '2022-01-01', 1000, 1), (2, '2022-01-02', 500, 2), (3, '2022-01-03', 250, 3), (4, '2022-01-04', 100, 4);
INSERT INTO journals (journal_id, date, account_id, amount)
VALUES (1, '2022-01-01', 1, 1000), (2, '2022-01-02', 2, 500), (3, '2022-01-03', 3, 250), (4, '2022-01-04', 4, 100);
INSERT INTO ledger (transaction_id, date, account_id, amount)
VALUES (1, '2022-01-01', 1, 1000), (2, '2022-01-02', 2, 500), (3, '2022-01-03', 3, 250), (4, '2022-01-04', 4, 100);
INSERT INTO customers (customer_id, name, contact_info)
VALUES (1, 'John Smith', 'john@example.com'), (2, 'Jane Doe', 'jane@example.com'), (3, 'Bob Johnson', 'bob@example.com');
INSERT INTO vendors (vendor_id, name, contact_info)
VALUES (1, 'Acme Inc', 'info@acme.com'), (2, 'XYZ Corp', 'contact@xyz.com'), (3, 'ABC Company', 'abc@example.com');
INSERT INTO employees (employee_id, name, contact_info, department)
VALUES (1, 'Alice Smith', 'alice@example.com', 'sales'), (2, 'Bob Johnson', 'bob@example.com', 'marketing'), (3, 'Charlie Williams', 'charlie@example.com', 'operations');
INSERT INTO balance_sheet (id, date, account_id, amount)
VALUES (1, '2022-12-31', 1, 10000), (2, '2022-12-31', 2, 15000), (3, '2022-12-31', 3, 20000), (4, '2022-12-31', 4, 5000);
INSERT INTO income_statement (id, date, account_id, amount)
VALUES (1, '2022-12-31', 1, 2000), (2, '2022-12-31', 2, 1000), (3, '2022-12-31', 3, 500), (4, '2022-12-31', 4, 250);
INSERT INTO owners_equity (id, date, account_id, amount)
VALUES (1, '2022-12-31', 1, 10000), (2, '2022-12-31', 2, 15000);
INSERT INTO cash_flow (id, date, account_id, amount)
VALUES (1, '2022-12-31', 1, 1000), (2, '2022-12-31', 2, 500), (3, '2022-12-31', 3, 250), (4, '2022-12-31', 4, 100);
INSERT INTO notes (id, date, account_id, description)
VALUES (1, '2022-12-31', 1, 'Loan from XYZ Bank'), (2, '2022-12-31', 2, 'Notes payable to ABC Company');
INSERT INTO vouchers (id, date, account_id, amount, description)
VALUES (1, '2022-12-31', 1, 1000, 'Payment for invoice #123'), (2, '2022-12-31', 2, 500, 'Reimbursement for expenses');
GO

CREATE PROCEDURE usp_insert_sample_data
AS
BEGIN
  DECLARE @i INT = 0;

  WHILE @i < 100
  BEGIN
    INSERT INTO chart_of_accounts (account_id, name)
    VALUES (@i, 'Account ' + CAST(@i AS VARCHAR));

    INSERT INTO transactions (transaction_id, date, amount, account_id)
    VALUES (@i, '2022-01-01', @i, @i);

    INSERT INTO journals (journal_id, date, account_id, amount)
    VALUES (@i, '2022-01-01', @i, @i);

    INSERT INTO ledger (transaction_id, date, account_id, amount)
    VALUES (@i, '2022-01-01', @i, @i);

    INSERT INTO customers (customer_id, name, contact_info)
    VALUES (@i, 'Customer ' + CAST(@i AS VARCHAR), 'customer' + CAST(@i AS VARCHAR) + '@example.com');

    INSERT INTO vendors (vendor_id, name, contact_info)
    VALUES (@i, 'Vendor ' + CAST(@i AS VARCHAR), 'vendor' + CAST(@i AS VARCHAR) + '@example.com');

    INSERT INTO employees (employee_id, name, contact_info, department)
    VALUES (@i, 'Employee ' + CAST(@i AS VARCHAR), 'employee' + CAST(@i AS VARCHAR) + '@example.com', 'Department ' + CAST(@i AS VARCHAR));

    INSERT INTO balance_sheet (id, date, account_id, amount)
    VALUES (@i, '2022-12-31', @i, @i);

    INSERT INTO income_statement (id, date, account_id, amount)
    VALUES (@i, '2022-12-31', @i, @i);

    INSERT INTO owners_equity (id, date, account_id, amount)
    VALUES (@i, '2022-12-31', @i, @i);

    INSERT INTO cash_flow (id, date, account_id, amount)
    VALUES (@i, '2022-12-31', @i, @i);

    INSERT INTO notes (id, date, account_id, description)
    VALUES (@i, '2022-12-31', @i, 'Note ' + CAST(@i AS VARCHAR));

    INSERT INTO vouchers (id, date, account_id, amount, description)
    VALUES (@i, '2022-12-31', @i, @i, 'Voucher ' + CAST(@i AS VARCHAR));

    SET @i = @i + 1;
  END
END
GO

EXEC usp_insert_sample_data
GO


CREATE TRIGGER tr_insert_sample_data
ON transactions
AFTER INSERT
AS
BEGIN
  EXEC usp_insert_sample_data;
END
GO
