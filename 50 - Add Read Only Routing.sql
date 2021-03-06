--Ensure that replica allows read only on secondary
ALTER AVAILABILITY GROUP [CICS-LIVE-SQL-2]  
 MODIFY REPLICA ON  
N'CICSAZVM030' WITH   
(SECONDARY_ROLE (ALLOW_CONNECTIONS = READ_ONLY));  
--Add Route
ALTER AVAILABILITY GROUP [CICS-LIVE-SQL-2]  
 MODIFY REPLICA ON  
N'CICSAZVM030' WITH   
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://cicsazvm030.capita-ics.co.uk:1433'));  


--Ensure that replica allows read only on secondary
ALTER AVAILABILITY GROUP [CICS-LIVE-SQL-2]  
 MODIFY REPLICA ON  
N'CICSAZVM031' WITH   
(SECONDARY_ROLE (ALLOW_CONNECTIONS = READ_ONLY));  
--Add Route
ALTER AVAILABILITY GROUP [CICS-LIVE-SQL-2]  
 MODIFY REPLICA ON  
N'CICSAZVM031' WITH   
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://cicsazvm031.capita-ics.co.uk:1433'));  


--Add Prioritys
ALTER AVAILABILITY GROUP [CICS-LIVE-SQL-2]   
MODIFY REPLICA ON  
N'CICSAZVM030' WITH   
(PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('CICSAZVM031','CICSAZVM030')));  

ALTER AVAILABILITY GROUP [CICS-LIVE-SQL-2]   
MODIFY REPLICA ON  
N'CICSAZVM031' WITH   
(PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('CICSAZVM030','CICSAZVM031')));  
GO  