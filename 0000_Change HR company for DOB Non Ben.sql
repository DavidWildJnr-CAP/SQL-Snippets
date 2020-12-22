--ADD THE NEW VIEW DEFINITION BY COPING AN OLD ONE.
Insert into [MOPS].[dbo].[ViewDefinition]
SELECT  'HR_NON_BENEFIT'
      ,'WildDa'
      ,[SQLstatement]
      ,[Text1]
      ,[Text2]
      ,[Text3]
      ,[Text4]
      ,[Text5]
      ,[Text6]
      ,[Text7]
      ,[Text8]
      ,[Text9]
      ,[Text10]
      ,'DOB'  -- This is the Review2 Date
      ,[Date2]
      ,[Date3]
      ,[Numeric1]
      ,[Numeric2]
      ,[Pos1]
      ,[Pos2]
      ,[Pos3]
      ,[Pos4]
      ,[Pos5]
      ,[Pos6]
      ,[Pos7]
      ,[Pos8]
      ,[Pos9]
      ,[Pos10]
      ,[Pos11]
      ,[Pos12]
      ,[Pos13]
      ,[Pos14]
      ,[Pos15]
  FROM [MOPS].[dbo].[ViewDefinition]
  where viewName = 'NON_BENEFIT';
  
  
  --UPDATE THE BRIEF DESCRIPTION FOR CODE 0000 DEPT 08 ONLY
  update [MOPS].[dbo].[BriefDescription]
 set PastDatErr1 = 'DOB MUST BE IN THE PAST',
 DateVal1 = 2,
 ViewName ='HR_NON_BENEFIT'
 --select * from [MOPS].[dbo].[BriefDescription]
 where department = '08'
 and code = '0000'
 and [DESCRIPTION] ='0000*08_HUMAN_RESOURCES_NON_BENEFIT';
 
 select *
 from [MOPS].[dbo].[ViewDefinition]
 
 select * from [MOPS].[dbo].[BriefDescription]
 where department = '08'
 and code = '0000'