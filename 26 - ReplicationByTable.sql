--RUN ON LIVE

USE distribution;

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT DISTINCT @@SERVERNAME  as [Server],
	--,a.article_id,
	a.Article,
	p.Publication,
	SUBSTRING(agents.[name], 16, 35) AS [Name],
	--,s.agent_id
	s.UndelivCmdsInDistDB,
	s.DelivCmdsInDistDB,
	UndelivCmdsInDistDB + DelivCmdsInDistDB  AS TotalTrans
FROM dbo.MSdistribution_status AS s
INNER JOIN dbo.MSdistribution_agents AS agents
	ON agents.[id] = s.agent_id
INNER JOIN dbo.MSpublications AS p
	ON p.publication = agents.publication
INNER JOIN dbo.MSarticles AS a
	ON a.article_id = s.article_id
		AND p.publication_id = a.publication_id
WHERE 1 = 1
	AND s.UndelivCmdsInDistDB <> 0
	AND agents.subscriber_db NOT LIKE 'virtual' 
	--AND p.Publisher_db = ”
	--AND a.Article LIKE  ”
	AND p.Publication IN ('MOPSMI')
--AND s.agent_id NOT IN ()
ORDER BY s.UndelivCmdsInDistDB DESC
OPTION (RECOMPILE);
