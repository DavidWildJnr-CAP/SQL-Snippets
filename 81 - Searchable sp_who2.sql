declare  @sp_who2 TABLE(SPID INT,Status VARCHAR(255),
      Login  VARCHAR(255),HostName  VARCHAR(255),
      BlkBy  VARCHAR(255),DBName  VARCHAR(255),
      Command VARCHAR(255),CPUTime INT,
      DiskIO INT,LastBatch VARCHAR(255),
      ProgramName VARCHAR(255),SPID2 INT,
      REQUESTID INT)
INSERT INTO @sp_who2 EXEC sp_who2


SELECT      *
FROM        @sp_who2
-- Add any filtering of the results here :
WHERE  dbname = 'interactive'
-- Add any sorting of the results here :
ORDER BY    lastbatch ASC


USE [master]
GO
SELECT SUSER_SID('crwebuser')
GO


select *
from sqltest.dbo.interactiveDB_size
order by counter desc