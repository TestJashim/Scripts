USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [jashim]    Script Date: 1/2/2023 10:20:29 PM ******/
CREATE LOGIN [jashim] WITH PASSWORD=N'[Enter Password Here]', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

ALTER LOGIN [jashim] DISABLE
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [jashim]
GO


