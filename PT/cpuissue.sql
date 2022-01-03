--SQL Server instance CPU usage from last 10 minutes

DECLARE @ts BIGINT

SELECT @ts =(SELECT cpu_ticks/(cpu_ticks/ms_ticks)

FROM sys.dm_os_sys_info);

SELECT TOP(10)SQLProcessUtilization AS [SQLServer_Process_CPU_Utilization],

SystemIdle AS [System_Idle_Process],

100 - SystemIdle - SQLProcessUtilization AS [Other_Process_CPU_Utilization],

DATEADD(ms,-1 *(@ts - [timestamp]),GETDATE())AS [Event_Time]

FROM (SELECT record.value('(./Record/@id)[1]','int')AS record_id,

record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]','int')AS [SystemIdle],

record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]','int')AS [SQLProcessUtilization],

[timestamp]

     FROM (SELECT[timestamp],

convert(xml, record) AS [record]

            FROM sys.dm_os_ring_buffers

            WHERE ring_buffer_type =N'RING_BUFFER_SCHEDULER_MONITOR'

AND record LIKE'%%')AS x

)AS y

ORDER BY record_id DESC;  
