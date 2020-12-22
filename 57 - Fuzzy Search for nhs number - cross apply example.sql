/*
This is an example of a fuzzy search for an nhs number and also an example of how to join to a table function


*/

declare @inputNHS as varchar(50) =  '4485646467';  -- Put the nhs number here
declare @MatchPC as int = 95;  -- percentacge match threshhold



with match_CTE as
(
select f.filenumber,
		f.text1,
		fn.score
	--	f.timestamp
from consensus.dbo.files f 
Cross apply consensus.dbo.FuzySearchTVF(@inputNHS,f.text1) fn
where fn.score >= @MatchPC
)
Select c.*,
		f.boxnumber,
		f.text2 as Forenames,
		f.text3 as Surname,
		f.timestamp as IndexDate,
		case
			when f.status = -2 then b.status
			else f.status
		end as EffStat,
		CONVERT(varchar(4), l.Warehouse) + '*' + l.RowNum + '*' + CONVERT(varchar(4), l.Bay) + '*' + CONVERT(varchar(4), l.LevelNum) + '/' + CONVERT(varchar(4), l.Position_Z) 
                         + '*' + CONVERT(varchar(4), l.Position_X) + '*' + CONVERT(varchar(4), l.Position_Y) AS Location
from match_CTE c
		left join consensus.dbo.files f on f.filenumber = c.filenumber
		left join consensus.dbo.box b on b.boxnumber = f.boxnumber
		left join consensus.dbo.location l on l.boxnumber = f.boxnumber
order by c.score desc