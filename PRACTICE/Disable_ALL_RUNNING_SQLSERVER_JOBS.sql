

 --- Check Current Staus of SQL Agent Jobs

SELECT job_id, name, enabled 
FROM msdb.dbo.sysjobs

-- or this version
SELECT SJ.job_id, SJ.name, SJ.enabled, SC.name as category
FROM msdb.dbo.sysjobs SJ
INNER JOIN msdb.dbo.syscategories SC on SJ.category_id = SC.category_id


---Disable All SQL Server Agent Jobs

USE MSDB;
GO

DECLARE @job_id uniqueidentifier

DECLARE job_cursor CURSOR READ_ONLY FOR  
SELECT job_id
FROM msdb.dbo.sysjobs
WHERE enabled = 1

OPEN job_cursor   
FETCH NEXT FROM job_cursor INTO @job_id  

WHILE @@FETCH_STATUS = 0
BEGIN
   EXEC msdb.dbo.sp_update_job @job_id = @job_id, @enabled = 0
   FETCH NEXT FROM job_cursor INTO @job_id  
END

CLOSE job_cursor   
DEALLOCATE job_cursor



---Enable All SQL Server Agent Jobs

USE MSDB;
GO

DECLARE @job_id uniqueidentifier

DECLARE job_cursor CURSOR READ_ONLY FOR  
SELECT job_id
FROM msdb.dbo.sysjobs
WHERE enabled = 0

OPEN job_cursor   
FETCH NEXT FROM job_cursor INTO @job_id  

WHILE @@FETCH_STATUS = 0
BEGIN
   EXEC msdb.dbo.sp_update_job @job_id = @job_id, @enabled = 1
   FETCH NEXT FROM job_cursor INTO @job_id  
END

CLOSE job_cursor   
DEALLOCATE job_cursor


---Disable Jobs By Job Category
--This code will disable any job that is currenlty enabled and the job category is 'Database Maintenance'.

USE MSDB;
GO

DECLARE @job_id uniqueidentifier

DECLARE job_cursor CURSOR READ_ONLY FOR  
SELECT SJ.job_id
FROM msdb.dbo.sysjobs SJ
INNER JOIN msdb.dbo.syscategories SC on SJ.category_id = SC.category_id
WHERE SJ.enabled = 1
  AND SC.[name] = N'Database Maintenance'

OPEN job_cursor   
FETCH NEXT FROM job_cursor INTO @job_id  

WHILE @@FETCH_STATUS = 0
BEGIN
   EXEC msdb.dbo.sp_update_job @job_id = @job_id, @enabled = 0
   FETCH NEXT FROM job_cursor INTO @job_id  
END

CLOSE job_cursor   
DEALLOCATE job_cursor