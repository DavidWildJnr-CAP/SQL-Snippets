--PRESS [CTRL-SHIFT-M] To populate variables

-- Start Date - First of previous Month
-- End Date - First of current month

--Duplicate on Scans of the same file.
update mops.dbo.tbl_AA_DLA_Picks 
set dupl_source = 1
where timestamp between '<StartDate,datetime,>' and '<EndDate,datetime,>'
	and  duplicate = 1
	and validnino = 1
	and valid = 1
	and import_number > 1
	and dupl_source is null
	and insert_source = 'S';

GO
---------------------------------------------------------------------------------------------------------
--Within the same file on the same scan pass
with NonDupFiles_CTE as
(
	select *
	--ROW_NUMBER() OVER(PARTITION BY folder_name,nino,benefitType ORDER BY id ) as rownum
	from mops.dbo.tbl_AA_DLA_Picks p
	where timestamp between '<StartDate,datetime,>' and '<EndDate,datetime,>'
	and  duplicate = 0
	and validnino = 1
	and valid = 1
	--and import_number > 1
	and dupl_source is null
	and insert_source = 'S'
),
DupFiles_CTE as
(
	select *
	--ROW_NUMBER() OVER(PARTITION BY folder_name,nino,benefitType ORDER BY id ) as rownum
	from mops.dbo.tbl_AA_DLA_Picks p
	where timestamp between '<StartDate,datetime,>' and '<EndDate,datetime,>'
	and  duplicate = 1
	and validnino = 1
	and valid = 1
	--and import_number > 1
	and dupl_source is null
	and insert_source = 'S'
),
Join_CTE as
(
	select d.*
	from NonDupFiles_CTE nd
			inner join DupFiles_CTE d on d.folder_Name = nd.Folder_Name 
										and isnull(nd.updated_nino,nd.nino) =  isnull(d.updated_nino,d.nino)
										and nd.BenefitType = d.BenefitType
)
update mops.dbo.tbl_AA_DLA_Picks
set dupl_source = 2
from Join_CTE c
		inner join mops.dbo.tbl_AA_DLA_Picks p on p.id=c.id;
		
GO
--------------------------------------------------------------------------------
--5 Day

update mops.dbo.tbl_AA_DLA_Picks
set dupl_Source = 5
where timestamp between  '<StartDate,datetime,>' and '<EndDate,datetime,>'
	and  duplicate = 1
	and validnino = 1
	and valid = 1
	and dupl_source is null;
		
GO

update mops.dbo.tbl_AA_DLA_Picks 
set dupl_source = 1
where timestamp between  '<StartDate,datetime,>' and '<EndDate,datetime,>'
	and  duplicate = 1
	and validnino = 1
	and valid = 1
	and import_number > 1
	and dupl_source is null
	and insert_source = 'S';

GO

--The Following check should return Zero Rows

select *
from mops.dbo.tbl_AA_DLA_Picks 
where timestamp between   '<StartDate,datetime,>' and '<EndDate,datetime,>'
	and  duplicate = 1
	and validnino = 1
	and valid = 1
	--and import_number > 1
	and dupl_source is null