--Benefit
select SettingValue from mops.dbo.tbl_SOMSettings where type = 'Embargo' and Settingname = 'BenType'
--Dept
select SettingValue from mops.dbo.tbl_SOMSettings where type = 'Embargo' and Settingname = 'Dept'
--Code
select SettingValue from mops.dbo.tbl_SOMSettings where type = 'Embargo' and Settingname = 'Code'