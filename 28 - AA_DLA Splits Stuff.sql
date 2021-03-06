/****** Script for SelectTopNRows command from SSMS  ******/
/*
SELECT *
into [mops].[dbo].[tbl_AA_DLA_MU_Splits_20150305]
  FROM [mops].[dbo].[tbl_AA_DLA_MU_Splits];
 */ 
--mu 39
--keep 12
  
 SELECT *

  FROM [mops].[dbo].[tbl_AA_DLA_MU_Splits]
  where managmentunit = '72'
  
  update [mops].[dbo].[tbl_AA_DLA_MU_Splits]
  set SomDisplayValue = '66'
  where id = 27
  
  
  delete from [mops].[dbo].[tbl_AA_DLA_MU_Splits]
  where id in('32')
  


  
  update [mops].[dbo].[tbl_AA_DLA_MU_Splits]
  set ManagmentUnit = '72', 
	OfficeNumber = '09872', 
	[Description] = 'RESIDUAL DLA-BBC 2-SEO 1', 
	[Site] = 'Blackpool Benefit Centre', 
	CourierAddress = 'Blackpool Benefit Centre', 
	SiteFullAddress = 'Warbreck House, Warbreck Hill Road, Blackpool, Lancashire FY2 0UZ', 
	Room = 'A204', 
	Lobby = 'B', 
	Team = '2.3', 
	SurnameFrom = 'A', 
	InitialFrom = 'A', 
	SurnameTo = 'RIC', 
	InitialTo = 'Z', 
	SortLabel = 'ROOM A204-LOBBY B (A-RIC)', 
	TeamLabel = 'MU72-BBC2-SEO1-TEAM 2.3', 
	PrimaryMU = '1', 
	SomDisplayValue = '72', 
	postcode_part = 'FY2',
	[disable] = 0
where id = 33

insert into mops.dbo.tbl_AA_DLA_MU_Splits (ManagmentUnit, OfficeNumber, Description, Site, CourierAddress, SiteFullAddress, Room, Lobby, Team, SurnameFrom, InitialFrom, SurnameTo, InitialTo, SortLabel, TeamLabel, PrimaryMU, SomDisplayValue, postcode_part, Disable)
select '72',
		'09872',
		'RESIDUAL DLA-BBC 2-SEO 1',
		'Blackpool Benefit Centre',
		'Blackpool Benefit Centre',
		'Warbreck House, Warbreck Hill Road, Blackpool, Lancashire FY2 0UZ',
		'A202',
		'B',
		'2.2',
		'RID',
		'A',
		'ZZZ',
		'Z',
		'ROOM A202 - LOBBY B (RID - Z)',
		'MU72-BBC2-SEO1-TEAM 2.2',
		'0',
		'72',
		'FY2',
		'0'
		
		
		