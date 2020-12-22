1701 N pallets 1-100

 select *--used,count(*)
 from consensus.dbo.location
 where warehouse = '1701'
 and rownum = 'N'
 
and Bay >=1 and bay<=100
--and levelnum = 11
 group by used



select *,'delete from Consensus.dbo.location where warehouse = ''' + convert(varchar,Warehouse) + ''' and rownum = ''' + RowNum +''' and bay = ''' + CONVERT(varchar,bay) + ''' and levelnum = ' + CONVERT(varchar,levelnum) + ' and position_z = ' + CONVERT(varchar,position_z) + ' and position_x = ' + CONVERT(varchar,Position_X) + ' and position_y = ' + CONVERT(varchar,Position_Y) + ';'
from Consensus.dbo.location
where Warehouse = '1701'
and RowNum = 'N'
and Bay >=1 and bay<=100
--and LevelNum = 11
--and Position_Z = '1'
--and Position_X = '4'
--and Position_Y = '1'
and Used = 'y'


select *

from mi.dbo.LocationAreaReporting
where warehouse = '1701'
