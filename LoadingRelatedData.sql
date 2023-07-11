SELECT c.CustomerID, o.* from Customers c
INNER JOIN Orders o on o.CustomerID = c.CustomerID
where c.CustomerID = 'ALFKI'
GO

-- Order Id - 10248