declare @DBID varchar (100)
---declare @DBname varchar (100)

--declare cursor
declare cursor_DBLIST cursor
for

select [database_id] from sys.databases where database_id > 17

open cursor_DBLIST;

fetch next from cursor_DBLIST into @DBID 
while @@FETCH_STATUS = 0
      begin 
	  declare @DBname nvarchar (100)
	  declare @backupscript nvarchar (1000)

	  select @DBname = name from sys.databases where database_id = @DBID
	  select @backupscript= 
	  'backup database '+@DBname +' to disk = ''F:\SQLdatabasebacup\'+ @DBname +'_full.bak'''
	  exec (@backupscript)
	  fetch next from cursor_DBLIST into @DBID
	  
	  end;



close cursor_DBLIST;

deallocate cursor_DBLIST

