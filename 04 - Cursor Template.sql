--Cursor to update Transit boxes 
--Only usefull for reading records from first to last.

DECLARE	--keep

	@C				AS CURSOR, -- Keep this variable
	@requisition	as varchar(20),  -- Replace these vars with your own from here     
	@warehouse		AS smallint,
	@rownum			AS varchar(5),
	@bay			as smallint,
	@levelnum       AS smallint,
	@position_z      AS smallint,
	@position_x		AS smallint,
	@position_y		AS smallint; -- To Here
	

SET @C = CURSOR FAST_FORWARD FOR  -- Keep

--Put the Select Statement Between Here

SELECT r.requisition,
		l.warehouse,
		l.rownum,
		l.bay,
		l.levelnum,
		l.position_z,
		l.position_x,
		l.position_y
from mops.dbo.requisition r
		inner join mops.dbo.files f on f.filenumber = r.filenumber
		inner join mops.dbo.location l on l.boxnumber = f.boxnumber
		where r.date_req > '2010-05-01' 
			and r.warehouse ='9990' -- check that the req was raised for 9990
			and l.warehouse <>'9990' -- Check that the 
			and l.warehouse like '12%'

--And Here

OPEN @C;  -- Keep This

 
--Leave @C alone. Change the other @ vars to match the returned fields above.  IN ORDER
FETCH NEXT FROM @C INTO @requisition,@warehouse,@rownum,@bay,@levelnum,@position_z,@position_x,@position_y; 


WHILE @@fetch_status = 0  -- Leave

BEGIN --Leave

--Put the update bit or whatever you want to do here.
	print 'update mops.dbo.requisition set warehouse =''' +
		convert(varchar,@warehouse) + ''', rownum =''' + 
		@rownum + ''' , bay =''' + convert(varchar,@bay)+
		''', levelnum =''' + convert(varchar,@levelnum) +''', position_z ='''
		+ convert(varchar,@position_z)+ ''', position_x ='''
		+ convert(varchar,@position_x)+ ''', position_y ='''
		+ convert(varchar,@position_y)+ ''' where requisition =''' + convert(varchar,@requisition) + ''''


  update mops.dbo.requisition set warehouse =@warehouse, rownum =@rownum, 
		bay =@bay, levelnum =@levelnum, position_z =@position_z, position_x = @position_x, position_y = @position_y 
	where requisition =@requisition;
--To Here
  FETCH NEXT FROM @C INTO @requisition,@warehouse,@rownum,@bay,@levelnum,@position_z,@position_x,@position_y;  -- Put The same variables as the fetch section 

END

--No Need to deallocate cursors as this is a new way of doing it.