---- fragmentaion 

select * from sys.databases 
select * from sys.tables
select * from sys.objects where object_id = 37223533
select * from sys.indexes where object_id = 37223533

select * from sys.dm_db_index_physical_stats(35, 37223533, null , null,null) 
dbcc show_statistics (REPORTMASTER_MST, PK_REPORTMASTER_MST ) 


--rebuild
select * from sys.dm_db_index_physical_stats(null,null, null , null,null) where avg_fragmentation_in_percent > 30 and database_id >5
--reorgnize
select * from sys.dm_db_index_physical_stats(null,null, null , null,null) where avg_fragmentation_in_percent >5 and avg_fragmentation_in_percent <30  and database_id >5
