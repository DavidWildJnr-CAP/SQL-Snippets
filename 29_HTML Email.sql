DECLARE @tableHTML  NVARCHAR(MAX) ;

SET @tableHTML =  
    N'<H1>TITLE LINE</H1>' +
    N'<table border="1">' +
    N'<tr><th>Field 01</th><th>Field 02</th>' +
    N'<th>Field 03</th><th>Field 04</th><th>Field 05</th>' +
    N'<th>Field 06</th></tr>' +
    CAST ( ( SELECT top 10 td = f.filenumber,       '',
                    td = f.filenumber, '',
                    td = f.filenumber, '',
                    td = f.filenumber, '',
                    td = f.filenumber, '',
                    td = f.filenumber
              FROM mops.dbo.files as f with(nolock)
              --JOIN AdventureWorks.Production.Product AS p
              --ON wo.ProductID = p.ProductID
              --WHERE timestamp > '2015-03-19'
               -- AND DATEDIFF(dd, '2004-04-30', DueDate) < 2 
              --ORDER BY f.timestamp ASC
                       --(p.ListPrice - p.StandardCost) * wo.OrderQty DESC
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;


--select @tableHTML
EXEC msdb.dbo.sp_send_dbmail @recipients='david.wild@capita.co.uk',
@profile_name='MI Team Email Alerts', 
    @subject = 'HTML Test',
    @body = @tableHTML,
    @body_format = 'HTML' ;
    
    select CAST(select top 10 * from mops.dbo.files