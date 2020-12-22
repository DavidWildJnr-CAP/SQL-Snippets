SELECT ps.database_id, 
		ps.OBJECT_ID,
		object_name(ps.OBJECT_ID),
		ps.index_id, b.name,
		ps.avg_fragmentation_in_percent
--into #DAW
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS ps
		INNER JOIN sys.indexes AS b ON ps.OBJECT_ID = b.OBJECT_ID
			AND ps.index_id = b.index_id
WHERE ps.database_id = DB_ID()
		--and b.name is not null
ORDER BY ps.OBJECT_ID

