SET NOCOUNT ON

DECLARE @Job TABLE (JobName SYSNAME)
DECLARE @JobName AS SYSNAME
DECLARE @Sql AS VARCHAR(MAX)

SET @JobName = ''

INSERT INTO @Job (JobName)
SELECT j.Name
FROM msdb.dbo.sysjobs AS j
LEFT JOIN msdb.dbo.sysmaintplan_subplans AS p ON j.job_id = p.job_id
WHERE p.subplan_id IS NULL
ORDER BY j.Name ASC

WHILE @JobName IS NOT NULL
BEGIN
	SET @JobName = (
			SELECT MIN(JobName)
			FROM @Job
			WHERE JobName > @JobName
			)
	SET @Sql = '
EXEC msdb.dbo.sp_delete_job @job_name = ' + '''' + @JobName + '''' + '; 
'
	PRINT @Sql
END


