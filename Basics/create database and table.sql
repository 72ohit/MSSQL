 use master
 create database snapshotrelication
 use snapshotrelication

 create table snapshotrelicationtable(id  int, name varchar(50) , dep varchar(50)
              primary key(id))

			  insert into snapshotrelicationtable values(1,'rohit', 'comp'),(2,'mayur','comp'),(3,'akshay','mech')

select * from snapshotrelicationtable


create table snapshotrelicationtable2(id  int, name varchar(50) , admissionyear int
              primary key(id))

			  insert into snapshotrelicationtable2 values(1,'rohit', 2019),(2,'mayur',2017),(3,'akshay',2018)


select * from snapshotrelicationtable
select * from snapshotrelicationtable2


update snapshotrelicationtable2 
set admissionyear = 2000
where id = 2
