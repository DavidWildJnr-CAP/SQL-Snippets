--Examples

--Create SQL Login

CREATE LOGIN [NewLogin] WITH PASSWORD=N'Newpassword', DEFAULT_DATABASE=[<A Database>], DEFAULT_LANGUAGE=[British]

--Windows Login
CREATE LOGIN  [Domain\login] FROM WINDOWS WITH DEFAULT_DATABASE=[<A Database>], DEFAULT_LANGUAGE=[British]



--Create Exicutor Role If Required

USE <A Database>
-- Create a db_executor role
CREATE ROLE db_executor

-- Grant execute rights to the new role
GRANT EXECUTE TO db_executor

GO


--Create User

USE <A Database>

CREATE USER [<Login Name From Above>] FOR LOGIN [<Login Name From Above>] WITH DEFAULT_SCHEMA=[dbo]


Grant CONNECT TO [<Login Name From Above>]  AS [dbo]

EXEC sp_addrolemember 'db_datawriter', '<Login Name From Above>';
EXEC sp_addrolemember 'db_datareader', '<Login Name From Above>';
EXEC sp_addrolemember 'db_executor', '<Login Name From Above>';