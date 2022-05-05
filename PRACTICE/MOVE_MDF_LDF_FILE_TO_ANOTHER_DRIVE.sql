--first use database you want move mdf and ldf
use pune

--get mdf and ldf file location path
select * from sys.sysfiles

--set master databse 
use master
--set databse in offline state
alter database pune set offline

ALTER DATABASE pune 
MODIFY FILE (NAME = pune, FILENAME = 'E:\new\pune.mdf')

ALTER DATABASE pune 
MODIFY FILE (NAME = pune_log, FILENAME = 'E:\new\pune_log.ldf')

--set databse on online state
alter database pune set online 



pune	C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\pune.mdf
pune_log	C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\pune_log.ldf