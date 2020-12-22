

--**BOTH SERVERS**

--Get Rid of Creds IF REQUIRED

drop CREDENTIAL [https://cwtmisqlstagingarea.blob.core.windows.net/cognosdbmigration]

-------------------------------------------------------------------------------------------------------------


--CHECK SECRET LOOKS LIKE BELOW, 
--IS DATE VALID,  
--REMOVE  Question Mark at the start !!!!!


CREATE CREDENTIAL [https://cwtmisqlstagingarea.blob.core.windows.net/cognosdbmigration] 
WITH IDENTITY = 'SHARED ACCESS SIGNATURE', -- MANDATORY
SECRET = 'sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacupx&se=2020-06-30T17:09:28Z&st=2020-06-30T09:09:28Z&spr=https&sig=3i5hW%2F8MxSX1X5wl2XK3wgshFdhKtkp88H8zjTL0Yjg%3D';  
GO



-----------------------------------------------------------------------------------------------------------------------------------------------------

--ON 'FROM' SERVER

BACKUP DATABASE OneStopMPS 
TO URL = 'https://cwtmisqlstagingarea.blob.core.windows.net/cognosdbmigration/OneStopMPS_AddDateOrSomething.bak' with COMPRESSION, STATS = 5;



--ON 'TO' SERVER

RESTORE DATABASE OneStopMPS   
FROM URL = 'https://cwtmisqlstagingarea.blob.core.windows.net/cognosdbmigration/OneStopMPS_AddDateOrSomething.bak' with STATS = 5;


