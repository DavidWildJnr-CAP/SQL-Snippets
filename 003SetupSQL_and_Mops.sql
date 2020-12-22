--Create SQL Login from Windows AC account

--MUST BE LOGGED IN AS DBO i.e. MO_Reporting
use mops
create login [DWPMOPS\WildD3] from windows;
GO

--Allow Connect access to standard databases
use mops;
GO
CREATE USER [WildD3] FOR LOGIN [DWPMOPS\WildD3]
GO
grant connect to [WildD3];
GO
use mi;
GO
CREATE USER [WildD3] FOR LOGIN [DWPMOPS\WildD3]
GO
grant connect to [WildD3];
GO
use metrofile_imaging;
GO
CREATE USER [WildD3] FOR LOGIN [DWPMOPS\WildD3]
GO
grant connect to [WildD3];
GO

--select * from mops.dbo.secure
--Add User To Secure
insert into mops.dbo.secure
		(UserId, Passw, Expires, ExpEvery, ExpDays, AuthReq, AuthNet, AuthSuper, Surname, Firstname, Designation, eNotify)
values('WildD3','wild','2011-11-09','0','0','0','0','Wild','David','1234567','0')

--Add user to RAuthrts
insert  into mops.dbo.RAuthrts
		(userid,code,Descr)
values ('WildD3','DWP','DWP Heywood')     

--Add User to Roles

--Add User to access                                  

select * from mops.dbo.RAuthrts where userid = 'wildd2'