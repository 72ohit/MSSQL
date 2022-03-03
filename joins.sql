create database forjoin
use forjoin
go

create table A (depid  int , depname varchar(50))
insert into  A values(100, 'dev')
insert into  A values(101, 'dba')
insert into  A values(102, 'test')
insert into  A values(103, 'server')


create table c (depid  int , depname varchar(50))
insert into  c values(100, 'devC')
insert into  c values(101, 'dbaC')
insert into  c values(102, 'testC')
insert into  c values(103, 'serverC')
insert into  c values(103, 'serverC')


go 

create table B (depid  int , name varchar(50))
insert into  B values(100, 'rohit')
insert into  B values(101, 'mayur')
insert into  B values(102, 'amol')
insert into  B values(103, 'anil')
insert into  B values(104, 'vishal')

go 

--simple joine
select AA.* , BB.name from 
A AA
 join
B BB
on AA.depid = BB.depid

---left join

select AA.* , BB.name from 
A AA
 left join
B BB
on AA.depid = BB.depid

--right join

select AA.* , BB.name from 
A AA
 right join
B BB
on AA.depid = BB.depid where AA.depid  is null
----------#################
select CC.* , BB.name from 
C CC
 join
B BB
on CC.depid = BB.depid 
-------#######################

 --- ######### cross Join ------#####
select AA.* , BB.* from 
A AA
cross join
B BB
