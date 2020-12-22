--Get a List of tables in the current DB
SELECT * FROM sysobjects WHERE xtype='U'

--Check the name of the publication for the query below
SELECT Publication, Publisher_DB FROM Distribution.dbo.MSpublications;


--Plug in the infor from above and run
DECLARE @publication AS sysname;
SET @publication = N'MOPSMI';

USE [MOPS]
EXEC sp_helparticle
  @publication = @publication;
 --order by articlename;
GO
