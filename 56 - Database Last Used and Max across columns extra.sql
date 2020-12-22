with CTE as
(
SELECT d.name,
last_user_seek = MAX(last_user_seek),
last_user_scan = MAX(last_user_scan),
last_user_lookup = MAX(last_user_lookup),
last_user_update = MAX(last_user_update)
FROM sys.dm_db_index_usage_stats AS i
		JOIN sys.databases AS d ON i.database_id=d.database_id
GROUP BY d.name
)
select sd.name,
		 (SELECT Max(v) 
		FROM (VALUES (last_user_seek), (last_user_scan), (last_user_lookup)) AS value(v)) as LastRead,
		c.last_user_update
from master.dbo.sysdatabases sd 
		left join cte c on c.name = sd.name
where sd.name not in ('master','model','msdb','tempdb','distribution')
order by sd.name;

SELECT sqlserver_start_time FROM sys.dm_os_sys_info
		

SELECT name,
		filename
 FROM master.dbo.sysdatabases
 where  name not in ('master','model','msdb','tempdb','distribution')
 order by name

 SELECT 'Version - ' + @@VERSION
 select @@servername



----------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
	A.[database_name]
,	AVG( A.[Backup Size (MB)] - A.[Previous Backup Size (MB)] ) OVER ( PARTITION BY A.[database_name] ) AS [Avg Size Diff From Previous (MB)]
,	MAX( A.[Backup Size (MB)] - A.[Previous Backup Size (MB)] ) OVER ( PARTITION BY A.[database_name] ) AS [Max Size Diff From Previous (MB)]
,	MIN( A.[Backup Size (MB)] - A.[Previous Backup Size (MB)] ) OVER ( PARTITION BY A.[database_name] ) AS [Min Size Diff From Previous (MB)]
,	A.[Sample Size]
FROM 
(
	SELECT
		s.[database_name]
	--,	s.[backup_start_date]
	,	COUNT(*) OVER ( PARTITION BY s.[database_name] ) AS [Sample Size]
	,	CAST ( ( s.[backup_size] / 1024 / 1024 ) AS INT ) AS [Backup Size (MB)]
	,	CAST ( ( LAG(s.[backup_size] ) 
			OVER ( PARTITION BY s.[database_name] ORDER BY s.[backup_start_date] ) / 1024 / 1024 ) AS INT ) AS [Previous Backup Size (MB)]
	FROM 
		[msdb]..[backupset] s
	WHERE
		s.[type] = 'D' --full backup
	--ORDER BY
	--	s.[database_name]
	--,	s.[backup_start_date]
) AS A
where database_name not in ('master','model','msdb','tempdb')
ORDER BY
	database_name;


	select @@servername