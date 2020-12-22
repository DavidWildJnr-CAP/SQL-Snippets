select *,'update consensus.dbo.requisition set status = 0 where status = 10 and requisition = ' + convert(varchar,requisition) + ';' 
from consensus.dbo.requisition
where type= 'item'
and (Authority_Code <> 'MNL' and attention not like '%purple%' and attention not like '%Project%B%')
and status = 10


update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784227;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784254;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784262;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784314;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784315;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784317;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784340;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784341;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784346;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784377;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784381;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784383;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784384;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784388;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784414;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784435;
update consensus.dbo.requisition set status = 0 where status = 10 and requisition = 784439;


exec consensus.[dbo].[nhs_fix_paper_req_status]

select *
from consensus.dbo.TransactionType


select *
from consensus.dbo.tbl_Originating_Location


insert into consensus.dbo.tbl_Originating_Location
select 'Shehedeh Medical Centre','BI490–GMC',1,'BAU','GP Closure'

JE230  –   GP-GMC
Garton Medical Centre
 
BI490 –    GP-SMC
Shehedeh Medical Centre

consensus.[dbo].[nhs_Insert_ATN_row] '6062397112','Call 29392'