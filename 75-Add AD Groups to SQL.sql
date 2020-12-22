/*

Ctrl-Shift-M to populate 

Remove the -RO/-RW/-DBO when entering the AD group.

*/

-----------------------------------------------------------------------------------------------------------------------------------------------
-- <DatabaseName, sysname, >
-----------------------------------------------------------------------------------------------------------------------------------------------
USE [master] -- Do Not Change
GO


CREATE LOGIN  [<AD_Group, sysname, >-RO] FROM WINDOWS WITH DEFAULT_DATABASE=[<DatabaseName, sysname, >], DEFAULT_LANGUAGE=[British]
GO
CREATE LOGIN  [<AD_Group, sysname, >-RW] FROM WINDOWS WITH DEFAULT_DATABASE=[<DatabaseName, sysname, >], DEFAULT_LANGUAGE=[British]
GO
CREATE LOGIN  [<AD_Group, sysname, >-DBO] FROM WINDOWS WITH DEFAULT_DATABASE=[<DatabaseName, sysname, >], DEFAULT_LANGUAGE=[British]
GO

USE [<DatabaseName, sysname, >];

GO

-- Create a db_executor role
CREATE ROLE db_executor

-- Grant execute rights to the new role
GRANT EXECUTE TO db_executor

GO

CREATE USER [<AD_Group, sysname, >-RO] FOR LOGIN [<AD_Group, sysname, >-RO] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [<AD_Group, sysname, >-RW] FOR LOGIN [<AD_Group, sysname, >-RW] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [<AD_Group, sysname, >-DBO] FOR LOGIN [<AD_Group, sysname, >-DBO] WITH DEFAULT_SCHEMA=[dbo]

Grant CONNECT TO [<AD_Group, sysname, >-RO]  AS [dbo]
Grant CONNECT TO [<AD_Group, sysname, >-RW]  AS [dbo]
Grant CONNECT TO [<AD_Group, sysname, >-DBO]  AS [dbo]

EXEC sp_addrolemember 'db_datareader', '<AD_Group, sysname, >-RO';  

EXEC sp_addrolemember 'db_datawriter', '<AD_Group, sysname, >-RW'; 
EXEC sp_addrolemember 'db_datareader', '<AD_Group, sysname, >-RW'; 

EXEC sp_addrolemember 'db_owner', '<AD_Group, sysname, >-DBO'; 


------------------------------------------------------------------------------------------------------------------------------------------------

