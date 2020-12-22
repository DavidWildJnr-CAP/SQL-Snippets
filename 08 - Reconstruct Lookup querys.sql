Select trantype, ' DELETE ' + DeleteStr
from [MI].[dbo].[mi_Lookup]


select trantype,'INSERT ' + InsertStr + ' SELECT ' + SelectStr + ' FROM ' + FromStr + ' WHERE ' + WhereStr 
from [MI].[dbo].[mi_Lookup]

