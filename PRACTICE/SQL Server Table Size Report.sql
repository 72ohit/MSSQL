USE AdventureWorks;
GO

--Create a Temporary Table to store report
DECLARE @StorageRepTable TABLE
(
	Table_Name VARCHAR(80),
	RowCnt INT,
	TableSize VARCHAR(80),
	DataSpaceUsed VARCHAR(80),
	IndexSpaceUsed VARCHAR(80),
	Unused_Space VARCHAR(80)
);

--Populate Temporary Report Table
INSERT INTO @StorageRepTable
EXEC ('sp_msforeachtable ''sp_spaceused "?"''');

-- Sorting the report result 
SELECT *
FROM @StorageRepTable
ORDER BY Table_Name;