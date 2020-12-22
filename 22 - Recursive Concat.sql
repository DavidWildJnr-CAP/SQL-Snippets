--SET STATISTICS IO on 
--VARIABLES
------------------------------------------------------------------------------------------------------
declare @UniversalHourlyTarget as decimal;
Declare @CurrentDateNoTime as datetime;

set @UniversalHourlyTarget = 40000;
set @CurrentDateNoTime = DATEADD(day, DATEDIFF(day,'19000101', GETDATE()),'19000101');


--Staging Table for record level results before concat.
DECLARE @LineResults 
TABLE(
	ID int not null,
	Line varchar(255) NOT NULL
);

------------------------------------------------------------------------------------------------------

with Brian_CTE as -- Get the warehouses list
(

	select distinct processingwh 
	from v63_hrly_rates
	where start_time BETWEEN @CurrentDateNoTime AND dateadd(dd,1,@CurrentDateNoTime)
			and end_time BETWEEN @CurrentDateNoTime AND dateadd(dd,1,@CurrentDateNoTime)
),
Counts_CTE as -- Add the counts to the warehouses
(
	select case 
				--Format the labels here.
				when c.processingwh <> 999 then '(' + CONVERT(varchar,c.processingwh) + ')'
				else '(Lingfield)'
			end as processingwh,
			isnull(SUM(activity),0) as Activity

	FROM v63_hrly_rates r
			inner join Brian_CTE c on c.PROCESSINGWH = r.PROCESSINGWH
	where start_time BETWEEN @CurrentDateNoTime AND dateadd(dd,1,@CurrentDateNoTime)
			and end_time BETWEEN @CurrentDateNoTime AND dateadd(dd,1,@CurrentDateNoTime)
	group by case -- A Bit lazy but saves another cte...
				when c.processingwh <> 999 then '(' + CONVERT(varchar,c.processingwh) + ')'
				else '(Lingfield)'
			end
),

AddPC_CTE as -- Add The persentages.
(
	select processingwh,
			Activity,
			convert(varchar, convert(decimal(5,2),(ROUND(Activity/@UniversalHourlyTarget*100,2,2)))) as PC
	from Counts_CTE
),

Format_CTE as  -- Convert the fields into a concatanated single field and add the header row.
(
	select 0 as orderby, -- just so the header will be at the top in the table
			'Warehouse Breakdown ' + char(13) + char(10) + char(13) + char(10) as line
	
	UNION ALL 
	
	select 1 as orderby,  -- just so the header will be at the top in the table
			convert(varchar,processingwh + ' ' + CONVERT(varchar,Activity) + ', ' + CONVERT(varchar,PC)) + '%' + char(13) + char(10) as Line
	from AddPC_CTE
	
	
)
--put the results into a staging table.
insert into @LineResults
select ROW_NUMBER() OVER(ORDER BY orderby,line ),
		line 
from Format_CTE;



With Concat_CTE(ID,line) as
(
	--This is the ANCHOR Section
	select ID,
			Line 
	from @LineResults
	where ID = 1
	
	UNION ALL
	
	--This is the RECURSIVE Section
	select t.id,
			convert(varchar(255),c.line + ' ' + t.line)
	from Concat_CTE c 
			inner join @LineResults t on t.ID = c.ID +1

)
--Finally The singe line!!!!!!!
select  top 1 line
from Concat_CTE
order by ID desc;

--REMEMBER TO SET RESULTS TO TEXT..........