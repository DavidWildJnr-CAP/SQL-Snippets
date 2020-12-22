--Cursor to update Transit boxes 
--Only usefull for reading records from first to last.

DECLARE	--keep

	@C				AS CURSOR, -- Keep this variable
	@DeliveryAddress	as varchar(255),  -- Replace these vars with your own from here     
	@FAO as varchar (255), -- To Here
	
	@Requisition as int,
	@Surname as varchar(255),
	@Initial as varchar(255);
	

SET @C = CURSOR FAST_FORWARD FOR  -- Keep

--Put the Select Statement Between Here

select r.requisition,
		f.text2,
		f.text3
from mops.dbo.requisition r
		inner join mops.dbo.files f on f.filenumber = r.filenumber
where date_req > '2013-08-05'
and operator like 'f:S%' 
AND RIGHT(OPERATOR,2) = '68'

--And Here

OPEN @C;  -- Keep This

 
--Leave @C alone. Change the other @ vars to match the returned fields above.  IN ORDER
FETCH NEXT FROM @C INTO @Requisition,@Surname,@Initial; 


WHILE @@fetch_status = 0  -- Leave

BEGIN --Leave

--Put the update bit or whatever you want to do here.
EXEC mops.dbo.sp_AA_DLA_MU_DeliveryDetails 68, @Surname,@Initial, @DeliveryAddress OUTPUT, @FAO OUTPUT;

Update mops.dbo.requisition
set Delivery_address = @DeliveryAddress, attention = @FAO, Comments = @FAO, intcomm = @FAO
where requisition = @Requisition
	
--To Here
  FETCH NEXT FROM @C INTO @Requisition,@Surname,@Initial; ;  -- Put The same variables as the fetch section 

END

--No Need to deallocate cursors as this is a new way of doing it.