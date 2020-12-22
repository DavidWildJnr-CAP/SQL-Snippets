--GRANT EXECUTE ON <procedurename> to <username>

SELECT 'GRANT EXECUTE ON '+ s.name +'.'+ obj.[name]+' ' +' to [AD\CIC-RG-SWD-Consensus]'

FROM sys.objects obj

INNER JOIN sys.database_permissions dp ON dp.major_id = obj.object_id
inner join sys.schemas s on s.schema_id = obj.Schema_id
WHERE obj.[type]  in ('tf','fn','p')--'p' -- stored procedure

AND dp.permission_name = 'EXECUTE'

AND dp.state IN ('G', 'W') -- GRANT or GRANT WITH GRANT

AND dp.grantee_principal_id =

(SELECT principal_id FROM sys.database_principals WHERE [name] = 'DWPMOPS\CIC-RG-Consensus')