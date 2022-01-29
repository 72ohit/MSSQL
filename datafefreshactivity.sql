-------------------on source database


---take full backup database in shared folder 

backup database school to disk = 'D:\datarefresh\schoolfull.bak'


--scriptout all users for that perticular database (on destination /testin enviroment )and save that output in notepad file

---then set database into single user mode on destination database

alter database schoolrefresh 
set single_user
with rollback immediate


-----restore database on destination server

---set database in multi_user mode

alter database schoolrefresh 
set  multi_user

----execute  all users wich are scripted out on destination table


