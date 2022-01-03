-----------------disk io-------------------------------------------------------------
if exists (
	 select * from DBA_ROHIT.sys.tables
		where name = 'diskioinfo'
	 )

begin 
SELECT ----- step 1
		[ReadLatency] =
			CASE WHEN [num_of_reads] = 0
				THEN 0 ELSE ([io_stall_read_ms] / [num_of_reads]) END,
		[WriteLatency] =
			CASE WHEN [num_of_writes] = 0
				THEN 0 ELSE ([io_stall_write_ms] / [num_of_writes]) END,
		[Latency] =
			CASE WHEN ([num_of_reads] = 0 AND [num_of_writes] = 0)
				THEN 0 ELSE ([io_stall] / ([num_of_reads] + [num_of_writes])) END,
		[AvgBPerRead] =
			CASE WHEN [num_of_reads] = 0
				THEN 0 ELSE ([num_of_bytes_read] / [num_of_reads]) END,
		[AvgBPerWrite] =
			CASE WHEN [num_of_writes] = 0
				THEN 0 ELSE ([num_of_bytes_written] / [num_of_writes]) END,
		[AvgBPerTransfer] =
			CASE WHEN ([num_of_reads] = 0 AND [num_of_writes] = 0)
				THEN 0 ELSE
					(([num_of_bytes_read] + [num_of_bytes_written]) /
					([num_of_reads] + [num_of_writes])) END,
		LEFT ([mf].[physical_name], 2) AS [Drive],
		DB_NAME ([vfs].[database_id]) AS [DB],
		[mf].[physical_name]

		into #tempdiskio ----- temp data
		FROM
		sys.dm_io_virtual_file_stats (NULL,NULL) AS [vfs]
		JOIN sys.master_files AS [mf]
		ON [vfs].[database_id] = [mf].[database_id]
		AND [vfs].[file_id] = [mf].[file_id]
		-- WHERE [vfs].[file_id] = 2 -- log files
		-- ORDER BY [Latency] DESC
		-- ORDER BY [ReadLatency] DESC
		ORDER BY [WriteLatency] DESC;
		
--select * from #tempdiskio
	if exists ------step3
		( select * from #tempdiskio where ReadLatency > 20 or WriteLatency >20 
			)
		begin
			--email script ---- ste
			EXEC msdb.dbo.sp_send_dbmail
			  @profile_name = 'IBMdba',
			  @recipients = 'adnaik.rohit@gmail.com',
			  @body = 'DISKlatency_issue',
			  @subject = 'DISKlatency_issue'  
  
			  insert into DBA_ROHIT.dbo.diskioinfo select * from #tempdiskio 
			  drop table #tempdiskio --- step3

		END
	
	ELSE 
		begin
			insert into DBA_ROHIT.dbo.diskioinfo select * from #tempdiskio 
			drop table #tempdiskio 

	   END
END

ELSE

begin 
----script---------------
    
	SELECT ----- step 1
		[ReadLatency] =
			CASE WHEN [num_of_reads] = 0
				THEN 0 ELSE ([io_stall_read_ms] / [num_of_reads]) END,
		[WriteLatency] =
			CASE WHEN [num_of_writes] = 0
				THEN 0 ELSE ([io_stall_write_ms] / [num_of_writes]) END,
		[Latency] =
			CASE WHEN ([num_of_reads] = 0 AND [num_of_writes] = 0)
				THEN 0 ELSE ([io_stall] / ([num_of_reads] + [num_of_writes])) END,
		[AvgBPerRead] =
			CASE WHEN [num_of_reads] = 0
				THEN 0 ELSE ([num_of_bytes_read] / [num_of_reads]) END,
		[AvgBPerWrite] =
			CASE WHEN [num_of_writes] = 0
				THEN 0 ELSE ([num_of_bytes_written] / [num_of_writes]) END,
		[AvgBPerTransfer] =
			CASE WHEN ([num_of_reads] = 0 AND [num_of_writes] = 0)
				THEN 0 ELSE
					(([num_of_bytes_read] + [num_of_bytes_written]) /
					([num_of_reads] + [num_of_writes])) END,
		LEFT ([mf].[physical_name], 2) AS [Drive],
		DB_NAME ([vfs].[database_id]) AS [DB],
		[mf].[physical_name]
		into #tempdiskio2 
		FROM
		sys.dm_io_virtual_file_stats (NULL,NULL) AS [vfs]
		JOIN sys.master_files AS [mf]
		ON [vfs].[database_id] = [mf].[database_id]
		AND [vfs].[file_id] = [mf].[file_id]
		-- WHERE [vfs].[file_id] = 2 -- log files
		-- ORDER BY [Latency] DESC
		-- ORDER BY [ReadLatency] DESC
		ORDER BY [WriteLatency] DESC;
		
	if exists
		( select * from #tempdiskio2 where ReadLatency > 20 or WriteLatency >20 
			)
		begin
			--email script ----
			EXEC msdb.dbo.sp_send_dbmail
			  @profile_name = 'IBMdba',
			  @recipients = 'adnaik.rohit@gmail.com',
			  @body = 'DISKlatency_issue',
			  @subject = 'DISKlatency_issue'  
  
			  
			  select * into DBA_ROHIT.dbo.diskioinfo  from #tempdiskio2
			  drop table #tempdiskio2 

		end
	
	else 
		begin
			select * into DBA_ROHIT.dbo.diskioinfo  from #tempdiskio2 
			drop table #tempdiskio2 
		end
END
-------------------#rohit---------------------------------------------
