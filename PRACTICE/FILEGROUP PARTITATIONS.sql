USE [TCS]
GO
BEGIN TRANSACTION
CREATE PARTITION FUNCTION [CITY](nchar(10)) AS RANGE LEFT FOR VALUES (N'MUMBAI', N'PUNE')


CREATE PARTITION SCHEME [CITY] AS PARTITION [CITY] TO ([MUMBAI], [PUNE], [PRIMARY])




SET ANSI_PADDING ON

CREATE CLUSTERED INDEX [ClusteredIndex_on_CITY_637852585897532526] ON [dbo].[employee]
(
	[CITY]
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [CITY]([CITY])


DROP INDEX [ClusteredIndex_on_CITY_637852585897532526] ON [dbo].[employee]






COMMIT TRANSACTION




--right click on database ------> properties ------->click on filegroups------>
add file groups ---->add memory optimize data ----> DONE ------click on files
 ----->add database files
 
--right click on your table -----> storage ------>create partitation ----> select column name---> 
--ceate partitation function ---> create partitation schema ----> Assign the partitions to 
filegroups and set the boundaries. --->select Run immediately and then click Next. ---> DONE
