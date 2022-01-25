
select * from sys.sysprocesses where spid > 50 and status <> 'sleeling' 
order by waittime desc

