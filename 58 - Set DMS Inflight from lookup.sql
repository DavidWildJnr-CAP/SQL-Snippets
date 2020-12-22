

DECLARE	--keep

	@C				AS CURSOR, -- Keep this variable
	@counter	as bigint,  -- Replace these vars with your own from here     
	@filename as varchar(255),
	@FromPractice as varchar(20),
	@ToPractice as varchar(20); -- To Here

SET @C = CURSOR FAST_FORWARD FOR  -- Keep

--Put the Select Statement Between Here

select --top 1
		f.counter,
		import_filename,
		f.Practice_Code,
		case 
			when f.Practice_Code = 'ARC' then 'DMS'
			else 'PDM'
		end as ChangeTo
from consensus.dbo.nhs_DMS_file_lookup l
		inner join consensus.ca.tbl_in_flight_data f on f.NHS_Number = l.nhs_number
		left join consensus.dbo.tbl_osmr_CS_Routes r on r.Practice_Code = f.Practice_Code
where f.status = 0
and r.Service_Centre_Code  not  in ('dms','pdm')

--And Here

OPEN @C;  -- Keep This

 
--Leave @C alone. Change the other @ vars to match the returned fields above.  IN ORDER
FETCH NEXT FROM @C INTO @Counter,@Filename,@FromPractice,@ToPractice; 


WHILE @@fetch_status = 0  -- Leave

BEGIN --Leave

--Put the update bit or whatever you want to do here.

Update  consensus.ca.tbl_in_flight_data
set Practice_Code = @ToPractice,
	comment = isnull(comment,' ') + 'Changed from practice code '+ @FromPractice + ' as part of DMS/PDM Lookup File ['+ @filename + ']'
where counter = @counter;

--print @counter;
	
--To Here
  FETCH NEXT FROM @C INTO @Counter,@Filename,@FromPractice,@ToPractice;  -- Put The same variables as the fetch section 

END;


