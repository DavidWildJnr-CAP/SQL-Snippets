/*
1	Shelving
2	Pallet Racking
3	Area 3 Flooring Level
4	Faverdale
5	Area 5
*/

-- Find the locations which need adding
-- 
--insert into mi.[dbo].[LocationAreaReporting]
select distinct l.warehouse,
				l.rownum,
				l.bay,
				l.LevelNum,
				'4' as SectionNumber, -- ADD SECTION NUMBER
				null as SubsectionNumber,  -- ADD SUBSECTION NUMBER if required
				'1703 G - GOS' as SectionDescription,
				null as WarehouseLabel,
				'Faverdale' as StorageLocation
from mi.[dbo].[LocationAreaReporting] lr
		right join consensus.dbo.location l  on lr.warehouse = l.Warehouse
														and lr.RowNum = l.RowNum
														and lr.Bay = l.bay
														and lr.LevelNum = l.LevelNum
where lr.Warehouse is null
and l.warehouse ='1703'
and l.rownum = 'G'


--select *from 	mi.[dbo].[LocationAreaReporting]
where  WarehouseLabel = '1701 Z'
and sectionnumber = 5
and sectiondescription = 'Area 5 - MREs and DS'


update 	mi.[dbo].[LocationAreaReporting]
set SectionDescription = '1701 Z'
where  WarehouseLabel = '1701 Z'
and sectionnumber = 5
and sectiondescription = 'Area 5 - MREs and DS'


1700 X Full	1700 X	Area 3 Flooring Level