-----------------dmv-------------------


select * from sys.sysprocesses where spid > 50 and blocked <> 0


select * from sys.dm_os_waiting_tasks where blocking_session_id is not null

select * from sys.dm_exec_requests  where blocking_session_id <> 0  
