select * from sys.dm_os_process_memory




--Memory used by SQL Server

select

(physical_memory_in_use_kb/1024)Memory_usedby_Sqlserver_MB,

(locked_page_allocations_kb/1024 )Locked_pages_used_Sqlserver_MB,

(total_virtual_address_space_kb/1024 )Total_VAS_in_MB,

process_physical_memory_low,

process_virtual_memory_low

from sys. dm_os_process_memory


 

-- Total OS Memory and used percentage

--Script: Captures System Memory Usage

--Works On: 2008, 2008 R2, 2012, 2014, 2016

 

select

      total_physical_memory_kb/1024 AS Total_physical_memory_mb,

      available_physical_memory_kb/1024 AS available_physical_memory_mb,

      total_page_file_kb/1024 AS total_page_file_mb,

      available_page_file_kb/1024 AS available_page_file_mb,

      100 - (100 * CAST(available_physical_memory_kb AS DECIMAL(18,3))/CAST(total_physical_memory_kb AS DECIMAL(18,3)))

      AS 'Percentage_Used',

      system_memory_state_desc

from  sys.dm_os_sys_memory;





--DAtbale level

DECLARE @total_buffer INT;

SELECT @total_buffer = cntr_value   FROM sys.dm_os_performance_counters

WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Total Pages';

;WITH src AS(   SELECT        database_id, db_buffer_pages = COUNT_BIG(*)

FROM sys.dm_os_buffer_descriptors       --WHERE database_id BETWEEN 5 AND 32766      

GROUP BY database_id)SELECT   [db_name] = CASE [database_id] WHEN 32767        THEN 'Resource DB'        ELSE DB_NAME([database_id]) END,   db_buffer_pages,   db_buffer_MB = db_buffer_pages / 128,   db_buffer_percent = CONVERT(DECIMAL(6,3),        db_buffer_pages * 100.0 / @total_buffer)

FROM src

ORDER BY db_buffer_MB DESC;




--then drill down into memory used by objects in database of your choice

 

USE Master;

 

WITH src AS(   SELECT       [Object] = o.name,       [Type] = o.type_desc,       [Index] = COALESCE(i.name, ''),       [Index_Type] = i.type_desc,       p.[object_id],       p.index_id,       au.allocation_unit_id  

FROM       sys.partitions AS p   INNER JOIN       sys.allocation_units AS au       ON p.hobt_id = au.container_id   INNER JOIN       sys.objects AS o       ON p.[object_id] = o.[object_id]   INNER JOIN       sys.indexes AS i       ON o.[object_id] = i.[object_id]       AND p.index_id = i.index_id   WHERE       au.[type] IN (1,2,3)       AND o.is_ms_shipped = 0)

SELECT   src.[Object],   src.[Type],   src.[Index],   src.Index_Type,   buffer_pages = COUNT_BIG(b.page_id),   buffer_mb = COUNT_BIG(b.page_id) / 128

FROM   src

INNER JOIN   sys.dm_os_buffer_descriptors AS b 

 ON src.allocation_unit_id = b.allocation_unit_id

WHERE   b.database_id = DB_ID()

GROUP BY   src.[Object],   src.[Type],   src.[Index],   src.Index_Type

ORDER BY   buffer_pages DESC;
