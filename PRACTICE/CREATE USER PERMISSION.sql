create database classmate

backup database classmate to disk = 'E:\backup\full_classmate.bak'

backup database classmate to disk = 'E:\backup\Diff_classmate.bak'

backup log classmate to disk = 'E:\backup\tlig_classmate1.trn'
backup log classmate to disk = 'E:\backup\tlig_classmate2.trn'
backup log classmate to disk = 'E:\backup\tlig_classmate3.trn'
backup log classmate to disk = 'E:\backup\tlig_classmate4.trn'
backup log classmate to disk = 'E:\backup\tlig_classmate5.trn'
backup log classmate to disk = 'E:\backup\tlig_classmate6.trn'
backup log classmate to disk = 'E:\backup\tlig_classmate7.trn'






--Restore full backup 
restore database classmate from disk = 'E:\backup\full_classmate.bak' with replace,norecovery

--restore diff backup

restore database classmate from disk = 'E:\backup\Diff_classmate.bak' with norecovery

--restore Tlog backup

restore log classmate from disk = 'E:\backup\tlig_classmate.trn' with recovery

--Create Login in security using CLI

Use [master]
go
create login [aniket] with password = N'123'
go



--Create local / windows authontication 
USE [master]
GO
CREATE LOGIN [DESKTOP-GKIPOD8\Demo] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO

---Create Database and Create Login with authntication,and Role access,permissions 
CREATE DATABASE [NewDatabase]
GO
CREATE LOGIN [NewLogin] WITH PASSWORD=N'test', DEFAULT_DATABASE=[NewDatabase]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NewLogin]
GO
USE [NewDatabase]
GO
CREATE USER [NewUser] FOR LOGIN [NewLogin]
GO
ALTER USER [NewUser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NewUser]
GO
-- Clean up database and login
USE master
GO
DROP DATABASE [NewDatabase]
GO
DROP LOGIN [NewLogin]
GO
