select @@servername


G:\EventSessions



CREATE EVENT SESSION [TLS_Check_Pre1.2]
    ON SERVER
    ADD EVENT sqlsni.trace(
    WHERE (([sqlserver].[like_i_sql_unicode_string]([text],N'%Handshake%TLS1.0%'))
 OR ([sqlserver].[like_i_sql_unicode_string]([text],N'%Handshake%TLS1.1%'))
--OR ([sqlserver].[like_i_sql_unicode_string]([text],N'%Handshake%TLS1.2%'))
))
    ADD TARGET package0.event_file
    (SET
        filename = N'G:\ExtendedEventSessions\tlsCheck.xel',
        max_file_size = (2),
        max_rollover_files = (10)
    )
    WITH (
        MAX_MEMORY = 2048 KB,
        EVENT_RETENTION_MODE = ALLOW_MULTIPLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 3 SECONDS,
        MAX_EVENT_SIZE = 0 KB,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
    );
GO

ALTER EVENT SESSION [TLS_Check_Pre1.2] ON SERVER STATE = start;

ALTER EVENT SESSION [tlsCheck] ON SERVER STATE = stop;

drop  EVENT SESSION [TLS_Check_Pre1.2]

;with AllData_CTE as
(
SELECT
        object_name,
        file_name,
        file_offset,
        event_data,
		-- CHARINDEX ( 'Protocol:' , event_data ),
		--  CHARINDEX ( 'timestamp="' , event_data ),
		--  len(event_data),
		--  replace(substring(event_data,CHARINDEX ( 'timestamp="' , event_data) ,35),'timestamp="','') as Timestamp,
		  convert(datetime,replace(substring(event_data,CHARINDEX ( 'timestamp="' , event_data) ,35),'timestamp="',''),127) as Timestamp,
		  replace(substring(event_data,CHARINDEX ( 'Protocol:' , event_data ),CHARINDEX ( 'PeerAddr:' , event_data )-CHARINDEX ( 'Protocol:' , event_data )),'Protocol: ','') as Protocol,
		  replace(substring(event_data,CHARINDEX ( 'PeerAddr:' , event_data ),CHARINDEX ( ']' , event_data, CHARINDEX ( 'PeerAddr:' , event_data ))-CHARINDEX ( 'PeerAddr:' , event_data )),'PeerAddr: ','') as IP,
        'CLICK_NEXT_CELL_TO_BROWSE_XML RESULTS!' AS [CLICK_NEXT_CELL_TO_BROWSE_XML_RESULTS],
        CAST(event_data AS XML) AS [event_data_XML]
                -- TODO: In ssms.exe results grid, double-click this xml cell!
    FROM
        sys.fn_xe_file_target_read_file(
				--'G:\ExtendedEventSessions\tlsCheck_0_132523104180560000.xel',
           -- 'G:\ExtendedEventSessions\tlsCheck_0_132520761528820000.xel',  -- Test on 2020-12-10
		   'G:\ExtendedEventSessions\tlsCheck_0_132526738564000000.xel',
            null, null, null
        )
)
select c.[file_name],
		max(c.timestamp),
		c.protocol,
		c.[IP]
		--cm.*
from AllData_CTE c
		left join siteDB.dbo.SQLconnectionmethods cm on cm.client_net_address = c.ip
														and cm.connect_time between dateadd(mm,-30,c.timestamp) and dateadd(mm,30,c.timestamp)
group by 
[file_name],
protocol,
[IP]

select *
from siteDB.dbo.SQLconnectionmethods
where client_net_address in (
'10.119.34.11',
'172.16.31.133'

)
order by timestamp desc

		--------------------------------------------

		CREATE EVENT SESSION [TLS_VerCheckPre1.2]
    ON SERVER
    ADD EVENT sqlsni.trace(
    WHERE (([sqlserver].[like_i_sql_unicode_string]([text],N'%Handshake%TLS%'))

))
    ADD TARGET package0.event_file
    (SET
        filename = N'G:\EventSessions\tlsCheck.xel',
        max_file_size = (2),
        max_rollover_files = (2)
    )
    WITH (
        MAX_MEMORY = 2048 KB,
        EVENT_RETENTION_MODE = ALLOW_MULTIPLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 3 SECONDS,
        MAX_EVENT_SIZE = 0 KB,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
    );
GO


SELECT   -- Find an event you want.
        p.name         AS [Package-Name],
        o.object_type,
        o.name         AS [Object-Name],
        o.description  AS [Object-Descr],
        p.guid         AS [Package-Guid]
    FROM
              sys.dm_xe_packages  AS p
        JOIN  sys.dm_xe_objects   AS o
                ON  p.guid = o.package_guid
    WHERE
        o.object_type = 'event'   --'action'  --'target'
        AND
        p.name LIKE '%'
        AND
        o.name LIKE '%sql%'
    ORDER BY
        p.name, o.object_type, o.name;