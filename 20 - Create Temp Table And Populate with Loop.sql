SET NOCOUNT ON;

--Clean UP
If object_id('tempdb..#TMP') is not null
begin
	drop table #TMP
end;
-------------------------------------------------------------------------------------------
--Vars
declare @Boxnum  as int;
set @boxnum = 1;

--Create Temp Table
CREATE TABLE #TMP
(
	BoxNumber  varchar(2)
) ON [PRIMARY];

--------------------------------------------------------------------------------------------
--Add LP Box Manualy
insert into #TMP
values('LG');

--------------------------------------------------------------------------------------------
--Loop To Add Remaining Boxes

while @Boxnum < 61
begin
	insert into #TMP
	values(convert(varchar,@BoxNum))
	set @boxnum = @boxnum +1
end;
-------------------------------------------------------------------------------
--Check
select * from #TMP;

