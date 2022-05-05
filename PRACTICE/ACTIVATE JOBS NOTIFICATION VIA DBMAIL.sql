
use msdb
if exists
(SELECT * FROM sysjobs
where enabled<>0)
begin
EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = 'EMPLOYEE_DATA_INSERT',  --Your DB mail Profile name
    @recipients = 'ajaymane1050@gmail.com', --recipient email id 
    @body = '<b>CHECK DATABASE STATUS</b>', --body message  
    @subject = 'Automated Success Message', -- subject name
	@body_format = 'HTML'
end