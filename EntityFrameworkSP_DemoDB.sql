USE [EntityFrameworkSP_DemoDB]
GO

/****** Object:  StoredProcedure [dbo].[GetPrductList]    Script Date: 10/16/2022 11:08:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[GetPrductList]
AS
BEGIN
	SELECT * FROM dbo.Product
END
GO

USE [EntityFrameworkSP_DemoDB]
GO

/****** Object:  StoredProcedure [dbo].[GetPrductByID]    Script Date: 10/16/2022 11:09:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[GetPrductByID]
@ProductId int
AS
BEGIN
	SELECT
		ProductId,
		ProductName,
		ProductDescription,
		ProductPrice,
		ProductStock
	FROM dbo.Product where ProductId = @ProductId
END
GO

USE [EntityFrameworkSP_DemoDB]
GO

/****** Object:  StoredProcedure [dbo].[AddNewProduct]    Script Date: 10/16/2022 11:09:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[AddNewProduct]
@ProductName [nvarchar](max),
@ProductDescription [nvarchar](max),
@ProductPrice int,
@ProductStock int
AS
BEGIN
	INSERT INTO dbo.Product
		(
			ProductName,
			ProductDescription,
			ProductPrice,
			ProductStock
		)
    VALUES
		(
			@ProductName,
			@ProductDescription,
			@ProductPrice,
			@ProductStock
		)
END
GO

USE [EntityFrameworkSP_DemoDB]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 10/16/2022 11:09:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[UpdateProduct]
@ProductId int,
@ProductName [nvarchar](max),
@ProductDescription [nvarchar](max),
@ProductPrice int,
@ProductStock int
AS
BEGIN
	UPDATE dbo.Product
    SET
		ProductName = @ProductName,
		ProductDescription = @ProductDescription,
		ProductPrice = @ProductPrice,
		ProductStock = @ProductStock
	WHERE ProductId = @ProductId
END
GO

