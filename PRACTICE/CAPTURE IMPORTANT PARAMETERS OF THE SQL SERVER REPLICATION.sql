----Run this query on the Publisher Server
--------------------------------------------*/
--USE --<Select Publisher Database>


--http://www.dharmendrakeshari.com/capture-important-parameters-sql-server-replication/

use [philips]
SELECT
@@ServerName as publisherserver,
DB_NAME() publisherdb,
sp.name as publicationname,
sp.immediate_sync,
sp.allow_anonymous,
OBJECT_SCHEMA_NAME(sa.objid, db_id()) as articleSchema,
sa.name as articlename,
s.status subscription_status,
CASE s.status
       WHEN 0  THEN 'Inactive'
       WHEN 1  THEN  'Subscribed (Not Published)'
       ELSE 'Active (Published)'
END AS subscription_status_desc,
sa.pre_creation_cmd,
CASE sa.pre_creation_cmd
       WHEN 0  THEN 'none'
       WHEN 1  THEN 'drop'
       WHEN 2  THEN 'delete'
       ELSE 'truncate'
END AS pre_creation_cmd_desc,
UPPER (srv.srvname) AS subscriberservername,
s.dest_db as subscriberdb,
case s.sync_type
             when 2 then
                           case s.nosync_type
                                  WHEN 3 THEN 5
                                  WHEN 2 THEN 4
                                  WHEN 1 THEN 3
                                  else 2
                END
                     ELSE s.sync_type
END as sync_type,
 
case s.sync_type
              when 2 then
                 case s.nosync_type
                    WHEN 3 THEN 'initialize with lsn'
                    WHEN 2 THEN 'initialize with backup'
                    WHEN 1 THEN 'replication support only'
                    else CAST (2 AS VARCHAR (2)) +'none'
                 END
                       when 1 THEN 'automatic'
              ELSE CAST (s.sync_type AS VARCHAR)
END as sync_type_desc
FROM dbo.syspublications sp
JOIN dbo.sysarticles sa ON sp.pubid = sa.pubid
JOIN dbo.syssubscriptions s ON sa.artid = s.artid
JOIN master.dbo.sysservers srv ON s.srvid = srv.srvid
go