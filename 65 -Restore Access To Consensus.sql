/* Consensus File Path

\\10.82.54.144\apps\Consensus

*/

--Check for username in secure table 
select *
from consensus.dbo.secure
where userid = 'test_Baileym2'; -- this should now be the windows login.

--Add If Necceary 

insert into consensus.dbo.secure (userid,expires,expevery,expdays,AuthReq,AuthNet,AuthSuper,Surname,firstname,designation,eNotify,CostCentre,IntDept,UsrDelAddr)
values ('test_Baileym2' ,'2018-12-12',0,0,0,0,0,'Test','Account','000000000','0','','','');

--Check for existing access 
select *
from consensus.dbo.RoleAccess
where userid = 'test_Baileym2';

--Add developer role to user.
insert into consensus.dbo.RoleAccess values ('test_Baileym2',21);


update consensus.dbo.secure 
set designation = '10060183'
where userid = 'test_Baileym2'
