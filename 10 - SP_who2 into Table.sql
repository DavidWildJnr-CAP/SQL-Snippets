-------------------------------------------------------------------------------------------------
If object_id('tempdb..#TMP_SPWHO2') is not null
begin
	drop table #TMP_SPWHO2
end

CREATE TABLE #TMP_SPWHO2
(
   SPID int,
   [Status] varchar(100),
   [Login] varchar(100),
   HostName varchar(100),
   BlkBy varchar(100),
   DBName varchar(100),
   Command varchar(100),
   CPUTime bigint,
   DiskIO bigint,
   LastBatch varchar(100),
   ProgramName varchar(100),
   SPID_ int,
   REQUESTID int
)

INSERT INTO #TMP_SPWHO2
Exec sp_who2

select * from #TMP_SPWHO2 where dbname = 'retain'order by CPUTime desc

select * from #TMP_SPWHO2 order by DiskIO desc

---------------------------------------------------------------------------------------------------
