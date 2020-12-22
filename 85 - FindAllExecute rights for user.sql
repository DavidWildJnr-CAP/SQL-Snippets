SELECT [name]
FROM sys.objects obj
INNER JOIN sys.database_permissions dp ON dp.major_id = obj.object_id
WHERE obj.[type] = 'P' -- stored procedure
AND dp.permission_name = 'EXECUTE'
AND dp.state IN ('G', 'W') -- GRANT or GRANT WITH GRANT
AND dp.grantee_principal_id =
(SELECT principal_id FROM sys.database_principals WHERE [name] = 'CSS\SVC_NHS-OSMR-Import')