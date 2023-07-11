Use master
IF DB_ID('AccountingDB ') IS NOT NULL
DROP Database AccountingDB 
CREATE Database AccountingDB 
GO

Use AccountingDB 
GO

CREATE TABLE accounts (
  account_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  contact_info TEXT,
  payment_terms TEXT
);

CREATE TABLE vendors (
  vendor_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  contact_info TEXT,
  payment_terms TEXT
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  price NUMERIC NOT NULL,
  tax_rate NUMERIC NOT NULL
);

CREATE TABLE employees (
  employee_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  pay_rate NUMERIC NOT NULL,
  deductions NUMERIC NOT NULL,
  benefits NUMERIC NOT NULL
);

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  date DATE NOT NULL,
  amount NUMERIC NOT NULL,
  description TEXT,
  category TEXT,
  account_id INTEGER REFERENCES accounts (account_id),
  customer_id INTEGER REFERENCES customers (customer_id),
  vendor_id INTEGER REFERENCES vendors (vendor_id),
  product_id INTEGER REFERENCES products (product_id),
  employee_id INTEGER REFERENCES employees (employee_id)
);
