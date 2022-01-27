--This statement creates a stored procedure in each user database that will return a listing of all users in a database, sorted by their modification date 

DECLARE @command varchar(1000) 

SELECT @command = 'ALTER DATABASE ? SET COMPATIBILITY_LEVEL = 150' 

EXEC sp_MSforeachdb @command 



------https://www.mssqltips.com/sqlservertip/1414/run-same-command-on-all-sql-server-databases-without-cursors/
