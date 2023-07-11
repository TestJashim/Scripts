Use master
If DB_ID('MvcApiWithSPDB') IS NOT NULL
DROP Database MvcApiWithSPDB
CREATE Database MvcApiWithSPDB
GO

Use MvcApiWithSPDB
GO

CREATE Table TestEmployee(ID int IDENTITY(1,1) PRIMARY KEY, Name varchar(100), Age int, Active int);
GO

SELECT * FROM TestEmployee
GO


--INSERT New Record
CREATE PROC usp_AddEmployee(@Name varchar(100), @Age int, @Active int)
AS
BEGIN
		INSERT INTO TestEmployee(Name, Age, Active)
		VALUES(@Name, @Age, @Active);
END
GO

--SELECT All
CREATE PROC usp_GetAllEmployees
AS
BEGIN
	SELECT * FROM TestEmployee;
END
GO

--SELECT By Id
CREATE PROC usp_GetEmployeeByID(@Id int)
AS
BEGIN
		SELECT * FROM TestEmployee
		WHERE ID = @Id;
END
GO

--UPDATE Existing Record
CREATE PROC usp_UpdateEmployee(@Id int, @Name varchar(100), @Age int, @Active int)
AS
BEGIN
		UPDATE TestEmployee SET Name = @Name, Age = @Age, Active = @Active
		WHERE ID = @Id; 

END
GO

--DELETE Existing Record
CREATE PROC usp_DeleteEmployee(@Id int)
AS
BEGIN
		DELETE FROM TestEmployee
		WHERE ID = @Id;
END
GO