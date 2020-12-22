--ADD SCHEMA
IF (
		NOT EXISTS (
			SELECT *
			FROM sys.schemas
			WHERE NAME = 'ca'
			)
		)
BEGIN
	EXEC ('CREATE SCHEMA [ca] AUTHORIZATION [dbo]')
END

--MOVE TABLES
ALTER SCHEMA ca TRANSFER dbo.tbl_Master_Box_Types;

ALTER SCHEMA ca TRANSFER dbo.tbl_Master_Descriptions;

ALTER SCHEMA ca TRANSFER dbo.tbl_Master_Details;

ALTER SCHEMA ca TRANSFER dbo.tbl_Master_Module;

ALTER SCHEMA ca TRANSFER dbo.tbl_Master_Summary;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_ProjectList;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Box_Put_Aways_Details;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Box_Put_Aways_Summary;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_BoxRepair;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_BoxRepair_Status_Code;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_BoxRepair_Transactions;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_BoxRepairold;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Consolidation;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_MessyBoxes;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Projects;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Projects_Status;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_requisitions;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_requisitions_PickTypes;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_requisitions_PickTypes_Actions;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_requisitions_PickTypes_SQL_to_Execute_by_Scanner_Action;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_requisitions_Status;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Requisitons_Summary;

ALTER SCHEMA ca TRANSFER dbo.tbl_PP_Scanners;

ALTER SCHEMA ca TRANSFER dbo.tbl_Bank_Holidays;

ALTER SCHEMA ca TRANSFER dbo.tbl_BenefitType;

ALTER SCHEMA ca TRANSFER dbo.tbl_BNR_QC;

ALTER SCHEMA ca TRANSFER dbo.tbl_Box_Receipt;

ALTER SCHEMA ca TRANSFER dbo.tbl_BoxFileItemDetailedSearch;

ALTER SCHEMA ca TRANSFER dbo.tbl_ConsensusSettings;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOM_FileDestruct;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOM_logging_1;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOM_logging_2;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOM_logging_3;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOMItemDestructs1;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOMItemDestructs2;

ALTER SCHEMA ca TRANSFER dbo.tbl_SOMManualReqSearches;

-----------------------------------------------------------------------------------------------
--REVERT
ALTER SCHEMA dbo TRANSFER ca.tbl_Master_Box_Types;

ALTER SCHEMA dbo TRANSFER ca.tbl_Master_Descriptions;

ALTER SCHEMA dbo TRANSFER ca.tbl_Master_Details;

ALTER SCHEMA dbo TRANSFER ca.tbl_Master_Module;

ALTER SCHEMA dbo TRANSFER ca.tbl_Master_Summary;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_ProjectList;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Box_Put_Aways_Details;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Box_Put_Aways_Summary;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_BoxRepair;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_BoxRepair_Status_Code;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_BoxRepair_Transactions;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_BoxRepairold;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Consolidation;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_MessyBoxes;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Projects;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Projects_Status;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_requisitions;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_requisitions_PickTypes;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_requisitions_PickTypes_Actions;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_requisitions_PickTypes_SQL_to_Execute_by_Scanner_Action;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_requisitions_Status;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Requisitons_Summary;

ALTER SCHEMA dbo TRANSFER ca.tbl_PP_Scanners;

ALTER SCHEMA dbo TRANSFER ca.tbl_Bank_Holidays;

ALTER SCHEMA dbo TRANSFER ca.tbl_BenefitType;

ALTER SCHEMA dbo TRANSFER ca.tbl_BNR_QC;

ALTER SCHEMA dbo TRANSFER ca.tbl_Box_Receipt;

ALTER SCHEMA dbo TRANSFER ca.tbl_BoxFileItemDetailedSearch;

ALTER SCHEMA dbo TRANSFER ca.tbl_ConsensusSettings;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOM_FileDestruct;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOM_logging_1;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOM_logging_2;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOM_logging_3;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOMItemDestructs1;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOMItemDestructs2;

ALTER SCHEMA dbo TRANSFER ca.tbl_SOMManualReqSearches;

