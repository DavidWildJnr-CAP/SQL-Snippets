--Check the range a box belongs to.

declare @fBCode float
declare @fBCF float
declare @fBCT float

set @fBCode='1008934361' --*** REMOVE THE B

Select * from mops.dbo.Barcode_Range where @fBCode >= BarCode_From and @fBCode <= BarCode_To

----------------------------------------------------------------------------------------
--Lazy way to create the temp table

select '1234567890b' as Boxnumber into #temp 

truncate table #temp  -- get rid of entry but leave temp table

------------------------------------------------------------------------------------------
--Full Range Of barcodes allocated
select * 
from #temp


declare @Boxno bigint
set @Boxno = 1008928361 -- BARCODE FROM


while @Boxno <= 1008940360 -- BARCODE TO
BEGIN
	insert into #temp
	select convert(varchar,@BoxNo) + 'B'
	set @boxno = @boxno + 1
END

----------------------------------------------------------
--Check the Range
select * 
from #temp

--See how mant are allocated to boxes
select * 
from #temp t inner join mops.dbo.box b on b.boxnumber = t.boxnumber

