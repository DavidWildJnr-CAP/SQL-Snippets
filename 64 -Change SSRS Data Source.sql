USE ReportServer;

--show all the reports which has no connection string
SELECT cLog.Path,dSource.name
FROM   DataSource    AS dSource
       JOIN CATALOG  AS cLog ON  cLog.ItemID = dSource.ItemID
WHERE  dSource.flags = dSource.flags 
		AND dSource.Link IS NULL 
		AND dSource.ConnectionString IS NULL 
      -- Additional search criteiria
	 -- AND dSource.NAME = 'NameofDatasource' AND cLog.path LIKE '%foldername%'
ORDER BY
       PATH

--To Get latest [Link] - You need to set up one of reports by manually setting the Datasource path and execute below query this will provide you latest [Link]. 

SELECT ds.Link
FROM   DataSource    AS ds
       JOIN CATALOG  AS c ON  c.ItemID = ds.ItemID
WHERE  ds.NAME = 'NameofDatasource' AND c.path LIKE '%foldername%' AND ds.Link IS NOT NULL

--update it with the same where clause. So it will update latest [Link] to all reports. 
UPDATE dSource set [Flags] = [Flags] | 2, [Link] = 'PutLatestLink'
FROM   DataSource    AS dSource
       JOIN CATALOG  AS cLog ON  cLog.ItemID = dSource.ItemID
WHERE  dSource.flags = dSource.flags AND dSource.Link IS NULL AND dSource.ConnectionString IS NULL 
        AND dSource.NAME = 'NameofDatasource' AND cLog.path LIKE '%foldername%'