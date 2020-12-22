-- CPU HISTORY
--RUN IN 2 PARTS

DECLARE @ms_ticks_now BIGINT

SELECT @ms_ticks_now = ms_ticks
FROM sys.dm_os_sys_info;

SELECT TOP 256 record_id -- ******* CHANGE THIS NUMBER TO ALTER NUMBER OF MINUTES ************
	,dateadd(ms, - 1 * (@ms_ticks_now - [timestamp]), GetDate()) AS EventTime
	,SQLProcessUtilization
	,SystemIdle
	,100 - SystemIdle - SQLProcessUtilization AS OtherProcessUtilization
FROM (
	SELECT record.value('(./Record/@id)[1]', 'int') AS record_id
		,record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') AS SystemIdle
		,record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS SQLProcessUtilization
		,TIMESTAMP
	FROM (
		SELECT TIMESTAMP
			,convert(XML, record) AS record
		FROM sys.dm_os_ring_buffers
		WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
			AND record LIKE '%<SystemHealth>%'
		) AS x
	) AS y
ORDER BY record_id desc;

------------------------------------------------------------------------------------------------------------------------
--WHAT IS THE HIGHEST PROCESS NOW ?????
SELECT 
	r.session_id
	,st.TEXT AS batch_text
	,SUBSTRING(st.TEXT, statement_start_offset / 2 + 1, (
			(
				CASE 
					WHEN r.statement_end_offset = - 1
						THEN (LEN(CONVERT(NVARCHAR(max), st.TEXT)) * 2)
					ELSE r.statement_end_offset
					END
				) - r.statement_start_offset
			) / 2 + 1) AS statement_text
	,qp.query_plan AS 'XML Plan'
	,r.*
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(r.plan_handle) AS qp
ORDER BY cpu_time DESC

sp_who2

https://checkmk.capita-ic.co.uk/Azure/check_mk/view.py?host=trm.capita-ic.co.uk&site=Azure&view_name=host#
