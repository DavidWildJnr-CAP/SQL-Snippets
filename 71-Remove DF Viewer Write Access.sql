
--******* DO NOT JUST RUN THIS - THE RE-ADD SCRIPT IS AT THE END.

--LIVE SERVERS


--AD\CIC-RG-SQL_DF_Viewer
use AdhocJobs;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_droprolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

---------------------------------------------------------------------------------------------------------------------------

--ADHOC\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_droprolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

-----------------------------------------------------------------------------------------------------------------------------

--capita-ics\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_droprolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

-----------------------------------------------------------------------------------------------------------------------------

--CSS\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_droprolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TEST SERVER
--TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_droprolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

------------------------------------------------------------------------------------------------------------------------------------------------------------------


--*************************************************** RE ADD THEM ****************************************************************************************************

--LIVE SERVERS


--AD\CIC-RG-SQL_DF_Viewer
use AdhocJobs;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_addrolemember 'db_datawriter', 'AD\CIC-RG-SQL_DF_Viewer'; 

---------------------------------------------------------------------------------------------------------------------------

--ADHOC\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_addrolemember 'db_datawriter', 'ADHOC\CIC-RG-SQL_DF_Viewer'; 

-----------------------------------------------------------------------------------------------------------------------------

--capita-ics\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_addrolemember 'db_datawriter', 'capita-ics\CIC-RG-SQL_DF_Viewer'; 

-----------------------------------------------------------------------------------------------------------------------------

--CSS\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_addrolemember 'db_datawriter', 'CSS\CIC-RG-SQL_DF_Viewer'; 

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TEST SERVER
--TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer

use AdhocJobs;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Capita;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Capita_Automation_Email;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use CDIS_UserRights;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use DSIPostageMI;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

use Pluto;
GO
EXEC sp_addrolemember 'db_datawriter', 'TESTCAPITA-ICS\CIC-RG-SQL_DF_Viewer'; 

------------------------------------------------------------------------------------------------------------------------------------------------------------------