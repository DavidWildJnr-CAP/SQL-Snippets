update #TMP_Req
set currentLocation = CONVERT(varchar(4), l.Warehouse) + '*' + l.RowNum + '*' + CONVERT(varchar(4), l.Bay) 
                      + '*' + CONVERT(varchar(4), l.LevelNum) + '/' + CONVERT(varchar(4), l.Position_z) + '*' + CONVERT(varchar(4), l.Position_x) + '*' + CONVERT(varchar(4), 
                      l.Position_y)
from #TMP_Req t
		inner join mops.dbo.location l with(nolock) on l.boxnumber = t.boxnumber