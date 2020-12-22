select NHS_Number,count(*)
from consensus.[ca].[tbl_in_flight_data]
where practice_code = 'K82064'
and timestamp is not null
group by NHS_Number
having count(*) > 1

--4999898942  -- last despatched to K82064 on 2016-06-06 Will go to E81037 next time
--6283142656  -- last despatched to K82064 on 2016-07-04 COULD GO BACK if scanned before 2016-10-04 due to 3 month duplicate rule.
--6395625241  -- last despatched to K82064 on 2016-06-27 COULD GO BACK if scanned before 2016-09-27 due to 3 month duplicate rule.
--6469504833  -- last despatched to K82064 on 2016-06-27 Due to Duplicate rule COULD GO BACK if scanned before 2016-09-27 due to 3 month duplicate rule.
--7135028015    --last despatched to K82064 on 2016-07-14 COULD GO BACK if scanned before 2016-07-14 due to 3 month duplicate rule.

select *
from consensus.[ca].[tbl_in_flight_data]
where NHS_Number = '7135028015'
and status in (1,2)


INSERT INTO [ca].[tbl_in_flight_data]
           ([NHS_Number],[Practice_Code],[NHIS_Cipher],[tbl_osmr_file1_counter],[returned_delivery_address]
           ,[CS_Barcode] ,[CS_Confirmation],[status],[Comment] ,[Duplicate File] ,[timestamp]  ,[userid],[old_nhsnumber] ,[DataSource]
		   ,[Records_movements_id],[tbl_osmr_file2_counter] ,[Filenumber]  ,[Itemnumber]  ,[StartDate])
	VALUES
           ('6395625241' ,'ARC' ,null ,0,null, null , null , 0 , 'Loop File Identified DAW 2016-07-19' , 0 , null , null ,  null , null ,  null , null 
		   ,null, null , getdate()  )


drop table #tmp

with live_CTE as
(
	select NHS_Number,
			counter,
			isnull(StartDate,'1900-01-01') as StartDate,
			Practice_Code,
			status
	from consensus.[ca].[tbl_in_flight_data]
	where status = 0
	and Practice_Code <> 'arc'
),
past_cte as
(
	select NHS_Number,
			counter,
			isnull(StartDate,'1900-01-01') as StartDate,
			Practice_Code,
			status
	from consensus.[ca].[tbl_in_flight_data]
	where status in(1,2)
	and Practice_Code <> 'arc'
)
select l.counter as liveCounter,
		p.counter as PastCounter,
		l.NHS_Number as LiveNHS,
		p.NHS_Number as PastNHS,
		l.startdate as LiveStartDate,
		p.startdate as PastStartDate,
		l.Practice_Code as LivePractice_Code,
		p.Practice_Code as PastPractice_Code,
		l.status as LiveStatus,
		p.status as PastStatus,
		row_number() 
			over (partition by p.NHS_Number order by p.counter desc) as RowNum
into #tmp
from live_CTE l 
		inner join past_cte p on l.NHS_Number = p.NHS_Number
								and l.StartDate = p.StartDate
								and l.Practice_Code = p.Practice_Code
where p.Practice_Code <> 'ARC'


select *
from #tmp
where rownum = 1
and LivePractice_Code <> 'ARC'


select distinct comment 
from consensus.[ca].[tbl_in_flight_data]
where Practice_Code = 'arc'
and comment is not null
order by counter desc


update consensus.[ca].[tbl_in_flight_data]
set practice_Code = 'ARC',
comment = isnull(f.comment,'') + 'Prevent ReDespatch to sending practice. previous code - ' + isnull(f.practice_code,'')
--select *,
--isnull(f.comment,'') + ' |Prevent ReDespatch to sending practice. previous code - ' + isnull(f.practice_code,'')
from consensus.[ca].[tbl_in_flight_data] F 
		inner join #tmp t on t.liveCounter = f.counter

