create table tableA (id int identity ,name varchar(50))
declare @i int
set @i=0
while (@i<100)
begin
insert into tableA (name)
select name from master.dbo.spt_values
set @i=@i+1
end
--select COUNT(*) from dbo.tableA --250600
go
create table tableB (id int identity ,name varchar(50))
declare @i int
set @i=0
while (@i<100)
begin










create table tableC (id int identity,name varchar(50))

insert into tableC (name)

select name from master.dbo.spt_values

-- select COUNT(*) from dbo.tableC --2506

create table tableD (id int identity,name varchar(50))

insert into tableD (name)

select name from master.dbo.spt_values






create table tableE (id int identity,name varchar(50))

insert into tableE (name)

select top 10 name from master.dbo.spt_values

-- select COUNT(*) from dbo.tableE --10

create table tableF (id int identity,name varchar(50))

insert into tableF (name)

select top 10 name from master.dbo.spt_values

-- select COUNT(*) from dbo.tableF --10

insert into tableB (name)

select name from master.dbo.spt_values

set @i=@i+1

end



---------------------------------------------------------------------------
                 --WITHOUT INDEX   -- WITH CLUSTER INDEX  --- WITH UNIQE CLUSTER INDEX
--BIG A            HASH                   HASH MATCH 53                    MERGE JOINE 
--MID              HASH                   HASH   86                      MERGE  JOINE 46




select * from dbo.tableA  A join tableB B
on (a.id = b.id)
