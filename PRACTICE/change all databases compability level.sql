
-- Find Compatibility Level for all databases on the server
SELECT name, compatibility_level  
FROM sys.databases;


-- Change all database compability level 140 to 150
BEGIN
    SET NOCOUNT ON;

    DECLARE @rc INT = 0, @i INT = 1, @v_cmd NVARCHAR(MAX);

    DECLARE @cmds TABLE(RowNum INT NOT NULL IDENTITY(1,1) PRIMARY KEY, Cmd NVARCHAR(MAX) NOT NULL);

    INSERT INTO @cmds
    SELECT 'ALTER DATABASE ' + name + ' SET COMPATIBILITY_LEVEL = 150' FROM sys.databases 
    WHERE compatibility_level < 150

    SET @rc = @@ROWCOUNT;
    RAISERROR('The COMPATIBILITY_LEVEL of %d databases will be changed to 150', 10, 1, @rc) WITH NOWAIT;

    WHILE @i <= @rc
    BEGIN
        SELECT @v_cmd = cmd FROM @cmds WHERE RowNum = @i;

        PRINT @v_cmd;
        EXEC(@v_cmd);

        SET @i += 1;
    END;
END