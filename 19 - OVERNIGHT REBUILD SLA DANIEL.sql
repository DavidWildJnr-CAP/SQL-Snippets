declare @StartDate datetime
set @StartDate = '2009-02-18'
--will calculate the row for the day before
--end date not included, +1 to include
declare @EndDate datetime
set @EndDate = dateadd(d, 0, '2009-03-04')


declare @counter int
set @counter = datediff(d, @StartDate, @EndDate)

declare @index int
set @index = 0

while @index < @counter

BEGIN

--select (dateadd(d, @index, @StartDate)) as Date_To_Use


------------------ QUERY HERE --------------------------




--Create The Temp Date Table

--drop table mi.dbo.tmpSLADate

--select convert(datetime,mi.dbo.getdatenotime(GetDate())) as Date into mi.dbo.tmpSLADate 

 

update  mi.dbo.tmpSLADate

--set date = '2009-02-17 00:00:00.000'

 
set date =(dateadd(d, @index, @StartDate))
 

-- Select all reqs from the Req Day Required into a temp table

drop table mi.dbo.rpt_SLA_tmpReq

select mops.dbo.GetReqDate(r.date_req) as [Date], date_req,mi.dbo.GetSLASiteCode(r.warehouse) as warehouse, requisition, type, operator, status, nfound, filenumber, boxnumber, convert(datetime,'1900-01-01') as NDHF, convert(int,0) as SLAok  

into mi.dbo.rpt_SLA_tmpReq 

from mops.dbo.requisition r with (nolock)

where r.date_req > dateadd(day, -3, (select date from mi.dbo.tmpSLADate)) and mops.dbo.GetReqDate(r.date_req) = dateadd(day,-1,mops.dbo.GetDateNoTimeXX((select date from mi.dbo.tmpSLADate))) 

and left(r.operator,2)='f:' and r.type in ('file','box','filpw','boxpw')

--GO

 

 

 

-- Delete any requisitions from the FARIO test office

delete from mi.dbo.rpt_SLA_tmpReq where operator like 'f:99999%'

--GO

 

-- For completed file reqs add the completion timestamp

update mi.dbo.rpt_SLA_tmpReq set ndhf=(select top 1 ft.DATE from mops.dbo.filetransactions ft with(nolock) where 

ft.transaction_type='f-ndhf' and ft.filenumber = mi.dbo.rpt_SLA_tmpReq.filenumber and ft.requisition=mi.dbo.rpt_SLA_tmpReq.requisition)

where type='FILE'

--GO

 

-- For completed Box Reqs add the completion timestamp

update mi.dbo.rpt_SLA_tmpReq set ndhf=(select top 1 bt.DATE from mops.dbo.boxtransactions bt with (nolock) where 

bt.transaction_type='b-ndhf' and bt.boxnumber = mi.dbo.rpt_SLA_tmpReq.boxnumber and bt.requisition=mi.dbo.rpt_SLA_tmpReq.requisition) 

where type='BOX'

--GO

 

-- For Completed PW Reqs - Updated with timestamp from ReqHistory table

update mi.dbo.rpt_SLA_tmpReq set NDHF = (

select trxdate from mops.dbo.reqhistory with (nolock) where requisition = mi.dbo.rpt_SLA_tmpReq.requisition and to_status = -1)

where type in ('filpw','boxpw') and status = -1

--GO

 

 

 

 

 

 

 

-- Now work out what was completed within SLA

declare @ReqDate as datetime

declare @DespStart as datetime

declare @DespEnd as datetime

declare @ReqEnd as datetime

 

set @ReqDate = mops.dbo.GetDateNoTime((select date from mi.dbo.tmpSLADate)) -- No Time Element

set @ReqDate = dateadd(day, -1, @ReqDate)

set @ReqEnd = @ReqDate + 0.70833333333333337 -- 17:00

set @DespEnd =  @ReqDate+ 0.83333333333333337 -- 20:00

set @DespStart = dateadd(day, -1, @DespEnd) - 0.125 -- 3 hrs

-- Adjust if Saturday/Sunday

if datepart(weekday, @DespStart)=7 set @DespStart=dateadd(day,-1, @DespStart)

if datepart(weekday, @DespStart)=1 set @DespStart=dateadd(day,-2, @DespStart)

--UPDATE TO NOT INCLUDE CAPITA NF's.

update mi.dbo.rpt_SLA_tmpReq set nfound = 0 where nfound = 1 and len(FileNumber) >= 11

 

--select @ReqDate, @ReqEnd, @DespStart, @DespEnd

update mi.dbo.rpt_SLA_tmpReq set slaok=1 where ndhf >= @DespStart and ndhf<= @DespEnd

 

--Delete the row if it already exists

delete from mi.dbo.rpt_DailySLA_Split where Date = @ReqDate

 

--Insert a row for all the SiteCodes. This will enusre they are automatically picked up in future!!

insert into mi.dbo.rpt_DailySLA_Split (Date, SiteCode)

select @ReqDate, SiteCode from mi.dbo.rpt_DailySLA_Split Where Date = dateadd(day,-1,@ReqDate) Order By SiteCode

 

update mi.dbo.rpt_DailySLA_Split set TotalIn = (select count(*) from mi.dbo.rpt_SLA_tmpReq where warehouse = mi.dbo.rpt_DailySLA_Split.SiteCode)

where [date]=@ReqDate

 

update mi.dbo.rpt_DailySLA_Split set TotalOutInSLA = (select count(*) from mi.dbo.rpt_SLA_tmpReq with (nolock) where slaok=1 and warehouse = mi.dbo.rpt_DailySLA_Split.SiteCode) 

where [date]=@ReqDate

 

update mi.dbo.rpt_DailySLA_Split set Cancelled = (select count(*) from mi.dbo.rpt_SLA_tmpReq with (nolock) where status=11 and warehouse = mi.dbo.rpt_DailySLA_Split.SiteCode)

where [date]=@ReqDate

 

update mi.dbo.rpt_DailySLA_Split set NF = (select count(*) from mi.dbo.rpt_SLA_tmpReq  with (nolock) where nfound=1 and warehouse = mi.dbo.rpt_DailySLA_Split.SiteCode) 

where [date]=@ReqDate

 

update mi.dbo.rpt_DailySLA_Split set ItemsIn = (select count(*) from mops.dbo.requisition r with (nolock) 

where r.date_req > dateadd(day, -3, (select date from mi.dbo.tmpSLADate)) and mops.dbo.GetReqDate(r.date_req)=dateadd(day,-1,mops.dbo.GetDateNoTimeXX((select date from mi.dbo.tmpSLADate)))

and left(r.operator,2)='f:' and r.type = 'item' and mi.dbo.GetSLASiteCode(r.warehouse)=mi.dbo.rpt_DailySLA_Split.SiteCode) where [date] = @ReqDate

 

-- Now because their could be more than one sitecode in the table, we need to loop through them somehow to work the

-- SLAIn and SLAOut for each one individually. The best way to do this is using a cursor!! This is in a seperate 

-- stored procedure to try and keep this script a little tidyer.

 

exec mi.dbo.rpt_DailySLA_Split_WorkSLA @ReqDate

--GO

 

-- Now run the weekend clear up script just incase

exec mi.dbo.rpt_DailySLA_Split_Weekend

--GO







-------------------END QUERY ----------------------------

set @index = @index + 1

end











