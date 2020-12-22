/*
insert and populate an ID row in the spreadsheet at position A

=CONCATENATE("insert into #tmp values(",A2,",'",B2,"','",F2,"')")

*/

drop table #tmp

create table #tmp
(counter int,
nhs_number varchar(50),
practice_code varchar(50)
)
insert into #tmp values(1,'4883953092','')
insert into #tmp values(2,'4442838437','')
insert into #tmp values(3,'4168003922','')
insert into #tmp values(4,'4341199749','')
insert into #tmp values(5,'4947850922','')
insert into #tmp values(6,'6085145365','')
insert into #tmp values(7,'7045371292','')
insert into #tmp values(8,'4883425266','')
insert into #tmp values(9,'7041291391','')
insert into #tmp values(10,'4010508221','')
insert into #tmp values(11,'4626772978','')
insert into #tmp values(12,'7081255159','')
insert into #tmp values(13,'7057450087','')
insert into #tmp values(14,'6226909447','')
insert into #tmp values(15,'6148764288','')
insert into #tmp values(16,'7073965576','')
insert into #tmp values(17,'4426330548','')
insert into #tmp values(18,'6300701239','')
insert into #tmp values(19,'7078929381','')
insert into #tmp values(20,'4994144497','')
insert into #tmp values(21,'4386982566','')
insert into #tmp values(22,'4545544002','')
insert into #tmp values(23,'6302866790','')
insert into #tmp values(24,'4360241356','')
insert into #tmp values(25,'7081980864','')
insert into #tmp values(26,'4268829008','')
insert into #tmp values(27,'6320715596','')
insert into #tmp values(28,'6403711237','')
insert into #tmp values(29,'6070824571','')
insert into #tmp values(30,'6044613828','')
insert into #tmp values(31,'4284829084','')
insert into #tmp values(32,'6267093824','')
insert into #tmp values(33,'6107193758','')
insert into #tmp values(34,'6515679696','')
insert into #tmp values(35,'6071535735','')
insert into #tmp values(36,'4765962660','')
insert into #tmp values(37,'3821848715','')
insert into #tmp values(38,'6206584240','')
insert into #tmp values(39,'6048555016','')
insert into #tmp values(40,'4842914882','')
insert into #tmp values(41,'4291733070','')
insert into #tmp values(42,'6091243896','')
insert into #tmp values(43,'7037900885','')
insert into #tmp values(44,'7098170291','')
insert into #tmp values(45,'4386230424','')
insert into #tmp values(46,'4260742337','')
insert into #tmp values(47,'4380859207','')



select count(*)
from #tmp



	
	
	
	With Warehouse_CTE as
	(
		select u.counter,
				u.nhs_number,
				--isnull(u.date_recived,u.timestamp) as date_recived,
				--u.import_filename,
				isnull(u.practice_code,'') as RequestedPracticeCode,
				--u.status as ListStatus,
				f.filenumber,
				b.boxnumber,
				case
					when isnull(f.status,-99) = -2 then b.status 
					else isnull(f.status,-99)
				end as EffStat,
				--u.requisition,
				row_number()
					over (partition by u.counter,u.nhs_number order by u.counter desc) as RowNum_WH
	--into #tmp
		from #tmp u
				left join consensus.dbo.files f with(nolock) on f.text1 = u.nhs_number
				left join consensus.dbo.box b  with(nolock) on b.boxnumber = f.boxnumber
		--where reject_reason is null
	),
	InFlight_Despatched_CTE as
	(
		select w.counter,
				w.nhs_number,
				--w.date_recived,
				--w.import_filename,
				w.RequestedPracticeCode,
				--ListStatus,
				isnull(sc.Description,'') as EffStat,
				isnull(w.filenumber,'') as FileNumber,
				isnull(w.boxnumber,'') as Boxnumber,
				case
					when f.status = 0 then 'Awaiting Despatch'
					when f.status in (1,2) then 'Despatched'
					else ''
				end as InFlightStatus,
				isnull(f.practice_code,'') as InFlightPracticeCode,
				isnull(convert(varchar,f.timestamp,120),'') as InflightDespatchTime,
				--w.requisition,
				row_number()
						over (partition by w.counter,w.nhs_number order by f.insertdate desc) as RowNum_IF
		from Warehouse_CTE w 
				left join consensus.[ca].[tbl_in_flight_data] f  with(nolock) on f.NHS_Number = w.nhs_number
														and f.status in (1,2) -- Exclude the PW 12
				left join consensus.[dbo].[StatusCodes] sc  on w.EffStat = sc.status
		where RowNum_WH = 1
	),
	Awaiting_inFlight_CTE as
	(
	select f.counter,
			f.nhs_number,                                         
			--f.date_recived,            
			--f.import_filename, 
			f.RequestedPracticeCode,                                                                                     
			--f.ListStatus,  
			f.EffStat,    
			f.FileNumber, 
			f.boxnumber,
			f.InFlightStatus,     
			f.InFlightPracticeCode,
			f.InflightDespatchTime,
			case
					when fl.status = 0 then 'Awaiting Despatch'
					when fl.status in (1,2) then 'Despatched'
					else ''
				end as AwaitingInFlightStatus,
				isnull(fl.practice_code,'') as AwaitingInFlightPracticeCode,
				--f.requisition,
				row_number()
						over (partition by f.counter,f.nhs_number order by fl.insertdate desc) as RowNum_AIF                                                                                                                                                                                
	from InFlight_Despatched_CTE F 
			left join consensus.[ca].[tbl_in_flight_data] fl  with(nolock) on fl.NHS_Number = f.nhs_number
														and fl.status in (0) -- Exclude the PW 12
	where RowNum_if = 1
	),
	requisition_CTE as
	(
		select aif.counter,
				aif.nhs_number,
				--aif.date_recived,
				--aif.import_filename, 
				aif.RequestedPracticeCode,                                                                                    
			--	aif.ListStatus,  
				aif.EffStat,    
				aif.FileNumber, 
				aif.Boxnumber, 
				aif.InFlightStatus,     
				aif.InFlightPracticeCode,
				aif.InflightDespatchTime,
				aif.AwaitingInFlightStatus,
				aif.AwaitingInFlightPracticeCode,
				case
					when r.requisition is not null then 'Requisition No [' + isnull(convert(varchar,r.requisition),' ')+'] ' + isnull(mr.Additional_Infomation,'') + ' - ' + isnull(mr.attention,'')
					else ''
				end as consensus_Requisition,
				isnull(rs.Description,'') as consensus_Requisition_Status,
				isnull(convert(varchar,r.Date_Completed,120),'') as ConsensusDespatchDate,
				--isnull(convert(varchar,aif.requisition),'') as Requisition,
				row_number()
							over (partition by aif.counter,aif.nhs_number order by r.requisition desc) as RowNum_Req
				--r.Delivery_Address,
				--r.Date_Completed
		from Awaiting_inFlight_CTE aif
				left join Consensus.dbo.requisition r  with(nolock) on (	
															r.FileNumber = aif.FileNumber
															or
															r.BoxNumber = aif.Boxnumber
														)
				left join [Consensus].[dbo].[nhs_manual_requisitions] mr  with(nolock) on mr.requisition = r.requisition
				left join consensus.[dbo].[ReqStatus] rs  with(nolock) on rs.Status = r.Status

		where RowNum_AIF = 1
	)
	select	nhs_number,
				--date_recived,
				--import_filename,   
				RequestedPracticeCode,                                                                                   
				--ListStatus,  
				EffStat,    
				FileNumber, 
				Boxnumber, 
				InFlightStatus,     
				InFlightPracticeCode,
				InflightDespatchTime,
				AwaitingInFlightStatus,
				AwaitingInFlightPracticeCode,
				consensus_Requisition,
				consensus_Requisition_Status,
				ConsensusDespatchDate,
				counter as UrgentCounter--,
				--Requisition
	from requisition_CTE
	where RowNum_Req =1
	--and date_recived >= @StartDate and date_recived <= @Enddate
	order by counter--date_recived,import_filename,nhs_number;

