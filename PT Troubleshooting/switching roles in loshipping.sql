-- Statement to execute on the new primary server  
USE msdb  
GO  
EXEC master.dbo.sp_change_log_shipping_secondary_database @secondary_database = N'database_name', @threshold_alert_enabled = 1;  
GO


-- Statement to execute on the new secondary server  
USE msdb  
GO  
EXEC master.dbo.sp_change_log_shipping_primary_database @database=N'database_name', @threshold_alert_enabled = 1;  
GO
