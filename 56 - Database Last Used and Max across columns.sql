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
select *,
		 (SELECT Max(v) 
		FROM (VALUES (last_user_seek), (last_user_scan), (last_user_lookup),(last_user_update)) AS value(v)) as [MaxDate]
from cte

SELECT sqlserver_start_time FROM sys.dm_os_sys_info