CREATE PROCEDURE InsertRandomData (@num INT)
AS
BEGIN
DECLARE @i INT = 1
DECLARE @Name NVARCHAR(100), @Gender NVARCHAR(10), @Department NVARCHAR(50), @Age INT, @IsFullTime BIT
DECLARE @HireDate DATE

WHILE @i <= @num
BEGIN
    SET @Name = (SELECT CONCAT(LEFT(NEWID(), 8), ' ', LEFT(NEWID(), 8)))
	SET @Gender = (SELECT CASE WHEN RAND() > 0.5 THEN 'Male' ELSE 'Female' END)
    SET @Department = (SELECT CONCAT(LEFT(NEWID(), 8), ' ', LEFT(NEWID(), 8)))
    SET @Age = (SELECT FLOOR(RAND() * (65 - 18 + 1) + 18))
    SET @IsFullTime = (SELECT CAST(RAND() as INT) % 2)
    SET @HireDate = (SELECT DATEADD(day, CAST(RAND()*365 as INT), CONVERT(DATE,'2021-01-01')))
    INSERT INTO Employees (Name, Gender, Department, Age, IsFullTime, HireDate)
    VALUES (@Name, @Gender, @Department, @Age, @IsFullTime, @HireDate)
    SET @i = @i + 1
END
END
