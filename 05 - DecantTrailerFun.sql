select Bay,
		case WD
			when '1' then 'Sunday'
			when '2' then 'Monday'
			when '3' then 'Tuesday'
			when '4' then 'Wednesday'
			when '5' then 'Thursday'
			when '6' then 'Friday'
			when '7' then 'Saturday'
		end as DeliveryDay,
		BoxCount,
		--LocationCount,
		(convert(float,boxcount)/convert(float,Locationcount))*100 as PC_Full
from
(
	select bays.bay, 
			datepart(dw,convert(datetime,('2013-'+right(bays.bay,2)+ '-'+left(bays.bay,2)))) as WD,
			(
				select count(*)
				from mops.dbo.location l with(nolock)
				where l.used ='y'
					and convert(int,bays.bay) = l.bay -- Conver back to Int to join
					and warehouse ='9990'
			) as BoxCount,
			(
				select count(*)
				from mops.dbo.location l with(nolock)
				where  convert(int,bays.bay) = l.bay -- Conver back to Int to join
					and warehouse ='9990'
			) as LocationCount  -- Boxes which are project Or Not  -- Boxes which are project Or Not
			
	from
	(
		select right('00' + convert(varchar,bay),4) as bay --Ensures that the date/Bay is always 4 digits
		from
		(
			select distinct(bay)
			from mops.dbo.location 
			where warehouse ='9990'
			and bay not in (1,2,3,4,5) -- Non Trailer Warehouses
		)as sub

	) as Bays 
) as Report order by right(bay,2),left(bay,2)  -- Order By Month Then Day