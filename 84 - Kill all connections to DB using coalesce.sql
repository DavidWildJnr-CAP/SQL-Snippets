DECLARE @String VARCHAR(1000) 

SELECT @String = COALESCE(@String,'') + cicbatchname + ';'  
FROM [CIC_InboundMI].[dbo].[CapitaBnym_export_DOC]
where ScanDateTime > '2020-10-26'

SELECT @String AS DepartmentNames 

svc_cic_gmci_test
P1tElbowFlat08