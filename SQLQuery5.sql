CREATE PROC usp_AddDatabase @Name varchar(100),
                        @FileName varchar(MAX),
                        @Size int,
                        @MaxSize int,
                        @FileGrowth int,
                        @LogName varchar(100),
                        @LogFileName varchar(MAX),
                        @LogSize int,
                        @LogMaxsize int,
                        @LogFileGrowth int
AS
    DECLARE @SQL nvarchar(MAX), @Params nvarchar(MAX);
    SET @SQL = N'
    CREATE DATABASE ' + QUOTENAME(@Name) + N' ON PRIMARY
        (NAME = @dName,
         FILENAME = @dFileName,
         SIZE = @dSize,
         MAXSIZE = @dMaxSize,
         FILEGROWTH = @dFileGrowth)
    LOG ON (NAME = @dLogName,
            FILENAME = @dLogFileName,
            SIZE = @dLogSize,
            MAXSIZE = @dLogMaxsize,
            FILEGROWTH = @dLogFileGrowth);';
    SET @Params = N'@dName varchar(100), @dFileName varchar(MAX), @dSize int, @dMaxSize int, @dFileGrowth int, @dLogName varchar(100), @dLogFileName varchar(MAX), @dLogSize int, @dLogMaxsize int, @dLogFileGrowth int';
    EXEC sp_executesql @SQL, @Params, @dName = @Name, @dFileName = @FileName, @dSize = @Size, @dMaxSize = @MaxSize, @dFileGrowth = @FileGrowth, @dLogName = @LogName, @dLogFileName = @LogFileName, @dLogSize = @LogSize, @dLogMaxsize = @LogMaxsize, @dLogFileGrowth = @LogFileGrowth;
GO
