--Script Used in Demo:
--Step i) Disable the two publication options; 'allow_anonymous' and 'immediate_sync' :
EXEC sp_changepublication 
 @publication = 'AdventureTrans', 
 @property = 'allow_anonymous' , 
 @value = 'false'
 GO 
EXEC sp_changepublication 
 @publication = 'AdventureTrans', 
 @property = 'immediate_sync', 
 @value = 'false'

--Step v)   Finally re-enable the publication options; 'immediate_sync' and 'allow_anonymous':
EXEC sp_changepublication 
 @publication = 'AdventureTrans', 
 @property = 'allow_anonymous' , 
 @value = 'True'
 GO 
EXEC sp_changepublication 
 @publication = 'AdventureTrans', 
 @property = 'immediate_sync', 
 @value = 'True'