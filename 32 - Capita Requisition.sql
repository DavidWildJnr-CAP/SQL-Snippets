drop table #tmp

select boxnumber,code,department,status
into #tmp
from consensus.dbo.box 
where boxnumber in
(
'3000358360B',
'3000202624B',
'3000404909B',
'3000456300B',
'3000235034B'
 ) 

 select *
 from consensus.dbo.box where boxnumber = '3000355768B '

select *
from #tmp


DECLARE	--keep

	@C				AS CURSOR, -- Keep this variable
	@Boxnumber	as varchar(20),  -- Replace these vars with your own from here     
	@Code as varchar(20),
	@Department as Varchar(5), -- To Here
	@dt as datetime;
	

SET @C = CURSOR FAST_FORWARD FOR  -- Keep

--Put the Select Statement Between Here

select boxnumber,Code,Department,getdate()
from #tmp
--And Here

OPEN @C;  -- Keep This

 
--Leave @C alone. Change the other @ vars to match the returned fields above.  IN ORDER
FETCH NEXT FROM @C INTO @Boxnumber,@Code,@Department,@dt; 


WHILE @@fetch_status = 0  -- Leave

BEGIN --Leave

--Put the update bit or whatever you want to do here.

EXEC consensus.dbo.FARIOOMI_CapitaRequest 
					@boxnumber,
					null,
					NULL,
					'KellyV',
					'KellyV',
					@Code,
					@Department,
					'Next Day',
					'Sharon Reedman call 29798',
					'Sharon Reedman call 29798',
					NULL,
					NULL,
					1,
					'Sharon Reedman call 29798',
					@dt
	
--To Here
  FETCH NEXT FROM @C INTO @Boxnumber,@Code,@Department,@dt;  -- Put The same variables as the fetch section 

END

select *
from consensus.dbo.files


select 'update consensus.dbo.requisition set status = -1 where requisition = ' + convert(varchar,requisition) as Req,
'update consensus.dbo.box set status = 10 where status = 5 and boxnumber = ''' + boxnumber +''''
from consensus.dbo.requisition
where requisition in (
815279,
815278,
815277
815276
815275
)
order by requisition desc


update consensus.dbo.requisition set status = -1 where requisition = 46977
update consensus.dbo.box set status = 10 where boxnumber = '3000081597B'

select *
from Consensus.dbo.Requisition                                                                                                                                                                                                                                    
order by requisition desc



update consensus.dbo.requisition set status = -1 where requisition = 239244
update consensus.dbo.box set status = 10 where boxnumber = '3000193354B'

[dbo].[nhs_Insert_SAR_row] '6067833603','call 25564'


select *
from #tmp t
	left join consensus.dbo.requisition r on r.boxnumber = t.boxnumber
	where r.boxnumber is null
an