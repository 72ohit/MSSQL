
if exists (
select * from sys.sysprocesses where blocked <>0 and spid > 50
)
begin 

select * into #blocking  from sys.sysprocesses where blocked <>0 and spid > 50
insert into DBA_ROHIT.dbo.blocking select * from #blocking 
drop table #blocking --- step3

end 

go 


declare @spid int
declare cursor_blocking cursor
for
SELECT [spid] from  sys.sysprocesses WHERE blocked <>0 and spid >50
open cursor_blocking;
fetch next from cursor_blocking into @spid
while @@FETCH_STATUS = 0
      begin
 declare @session_id varchar (10)
 declare @kill nvarchar (1000)

 select @session_id = spid from  sys.sysprocesses WHERE blocked <>0 and spid >50

 select @kill= 'kill '+@session_id
 exec (@kill)
 fetch next from cursor_blocking into @spid
 
 end;

close cursor_blocking;
deallocate cursor_blocking
