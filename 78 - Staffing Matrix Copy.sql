--STAFFING MATRIX

select *
from consensus.ca.[Staffing_Matrix]
where Employee_No IN 
(
'10476553',
'10494133',--
'10494296',--
'10494075'--
)


select *
from HRAbsence.dbo.[Staffing_Matrix]
where Employee_No IN 
(
'10476553',
'10494133',--
'10494296',--
'10494075'--
)

insert into consensus.ca.[Staffing_Matrix]
select Employee_No, Swipe_No, Title, First_Name, Last_Name, DOB, Gender, Address1, Address2, Town, County, Post_Code, Phone, Email, Start_Date, End_Date, Line_Manager, Role, Contract_Type, Cost_Centre, Created_By, Created_On, Updated_By, Updated_On
from HRAbsence.dbo.[Staffing_Matrix]
where Employee_No IN 
(
'10476553'
)

--BREAK TIMES
select *
from consensus.ca.[Staffing_Matrix_Break_Times]
where Employee_No ='10476553'

select *
from HRAbsence.dbo.[Staffing_Matrix_Break_Times]
where Employee_No ='10476553'


insert into consensus.ca.[Staffing_Matrix_Break_Times]
select Employee_No, Day_of_Week, Break_Start, Break_Finish, Updated_On, Updated_By
from HRAbsence.dbo.[Staffing_Matrix_Break_Times]
where Employee_No ='10476553'

--CONTRACTED HOURS
select *
from consensus.ca.Staffing_Matrix_Contracted_Hours
where Employee_No ='10476553'

select *
from HRAbsence.dbo.Staffing_Matrix_Contracted_Hours
where Employee_No ='10476553'

insert into consensus.ca.Staffing_Matrix_Contracted_Hours
select Employee_No, Day_of_Week, Shift_Start, Shift_Finish, Updated_On, Updated_By
from HRAbsence.dbo.Staffing_Matrix_Contracted_Hours
where Employee_No ='10476553'

select *
from consensus.ca.[Staffing_Matrix]
where First_Name = '