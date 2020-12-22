DECLARE @SPWHO2 TABLE(
        SPID INT,
        Status VARCHAR(MAX),
        LOGIN VARCHAR(MAX),
        HostName VARCHAR(MAX),
        BlkBy VARCHAR(MAX),
        DBName VARCHAR(MAX),
        Command VARCHAR(MAX),
        CPUTime INT,
        DiskIO INT,
        LastBatch VARCHAR(MAX),
        ProgramName VARCHAR(MAX),
        SPID_1 INT,
        REQUESTID INT
)

INSERT INTO @SPWHO2 EXEC sp_who2;


SELECT c.session_id, 
		c.connect_time, 
		c.net_transport, 
		c.encrypt_option, 
		c.auth_scheme, 
		c.client_net_address,
		s.status,
		s.login,
		s.hostname,
		s.ProgramName,
		s.DBName,
		s.CPUTime,
		s.DiskIO,
		s.LastBatch
FROM sys.dm_exec_connections c
		inner join @SPWHO2 S on s.SPID = c.session_id
where client_net_address <> '<local machine>'
and c.encrypt_option = 'false' -- Comment out or set to 'yes' as Neccasery 
and dbname = 'APTDBes'