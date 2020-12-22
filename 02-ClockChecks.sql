

select distinct(cd.clockID),
		cl.location,
		max(trxdate) as LastConnectionTime,
		datediff(hh,max(trxdate) ,getdate()) as HoursSinceDownload

from  mi.dbo.tbl_ClockData cd
		inner join mi.dbo.tbl_ClockLocation cl on cd.clockid = cl.clockid

where entrytype ='A'

group by cd.clockid,cl.location 
order by cd.clockid,cl.location


