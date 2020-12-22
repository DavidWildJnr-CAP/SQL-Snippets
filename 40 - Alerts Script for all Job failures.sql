--CHANGE THE OPERATOR NAME TO THE ONE CREATED FOR THIS DATABASE
--[SQL Server Agent] -> [Operators]

--RUN THE RESULTS OF THIS QUERY

use msdb
GO

DECLARE @operator varchar(50)
SET @operator = 'KCNS_LP_Alerts'

SELECT 'EXEC msdb.dbo.sp_update_job @job_ID = ''' + convert(varchar(50),job_id) + ''' ,@notify_level_email = 2, @notify_email_operator_name = ''' + @operator + '''' FROM sysjobs 


