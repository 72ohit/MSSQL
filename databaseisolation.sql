DECLARE @command varchar(1000) 

SELECT @command = 'use ?
SELECT DB_NAME() AS [Current Database]
 
DBCC USEROPTIONS
' 

EXEC sp_MSforeachdb @command 
