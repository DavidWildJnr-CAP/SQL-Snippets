use mops;

GO

ALTER TABLE tbl_PP_Consolidation
ADD downloaded datetime;

GO

insert into sysactions(Name,ActionType)
values('SOM_PP_Consolidation','S');

GO

insert into tbl_PP_requisitions_PickTypes(PickType, [Description], [Group], colour, workstream)
values('BCONS','Box Consolidation','Other','yellow','Operations');

GO

--Manualy add SOM_PP_Consolidation action to DMC-IT Role

--add this line to the [tbl_PP_Requisitons_Summary] Trigger 

/*
IF @PickType = 'BCONS'
						BEGIN
							 Update tbl_PP_Consolidation SET Status = 0 WHERE Status = 1 and id = @Requisition
						END 
*/

--Put index on proj table

USE [MOPS]
GO

/****** Object:  Index [INX_NC_Status_Boxnumber_Picked]    Script Date: 02/26/2013 11:57:24 ******/
CREATE NONCLUSTERED INDEX [INX_NC_Status_Boxnumber_Picked] ON [dbo].[tbl_PP_Projects] 
(
	[BoxNumber] ASC,
	[Status] ASC,
	[Picked] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


