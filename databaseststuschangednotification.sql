declare @state varchar(10)
declare @Database_Name varchar(100)
declare @email varchar(100)
set @state = ''
set @email = ''
set @Database_Name = 'Model'

select @state = 
case 
When a.state = 0 then 'Online'
when a.state = 1 then 'Restoring'
when a.state = 2 then 'Recovery_Pending'
when a.state = 4 then 'Suspect'
when a.state = 5 then 'Emergency'
when a.state = 6 then 'Offline'
when a.state = 7 then 'Copying - SQL Azure'
when a.state = 10 then 'Ofline_Secondary - SQL Azure'
end
from sys.databases a where name = @Database_Name

if @state <> 'Online'
begin
set @email = 'The database ' + @Database_Name + ' is currently : ' + @state

EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'Profile_name_of_DBMAIL',
    @recipients = 'Recipient EmailID',
        @body = @email,
    @subject = 'Database Status' ;
end
