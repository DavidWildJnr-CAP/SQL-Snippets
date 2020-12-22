
--TempTable Test
If object_id('tempdb..<TempTableName,Varchar,>') is not null
begin
	drop table <TempTableName,Varchar,>
end


--Standard Test
If object_id('<TempTableName,Varchar,>') is not null
begin
	drop table <TempTableName,Varchar,>
end


cicvpmfbkp01.capita-ics.co.uk

