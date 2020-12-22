--FILES
select a.date,
		a.filenumber,
		a.transaction_type,
		a.from_status,
		a.to_status,
		b.transaction_type
from mops.dbo.filetransactions a with(nolock)
		left join mops.dbo.filetransactions b with(nolock) on a.filenumber = b.filenumber
															and a.counter < b.counter
															and b.transaction_type = 'FS_DEST'
where a.date > '2015-08-04'
and a.transaction_type in ('fs','FS_DHF')
and a.to_status = 11
--and a.from_status = 2
order by a.counter;


--ITEMS
select a.date,
		a.itembarcode,
		a.transaction_type,
		a.from_status,
		a.to_status,
		b.transaction_type
from mops.dbo.itemtransactions a with(nolock)
		left join mops.dbo.itemtransactions b with(nolock) on a.itembarcode = b.itembarcode
															and a.counter < b.counter
															and b.transaction_type = 'IS_DEST'
where a.date > '2015-08-04'
and a.transaction_type = 'Is'
and a.to_status = 11
--and a.from_status = 10
order by a.counter;

--BOXES
select a.date,
		a.Boxnumber,
		a.transaction_type,
		a.from_status,
		a.to_status,
		b.transaction_type
from mops.dbo.itemtransactions a with(nolock)
		left join mops.dbo.boxtransactions b with(nolock) on a.boxnumber = b.boxnumber
															and a.counter < b.counter
															and b.transaction_type = 'BS_DEST'
where a.date > '2015-08-04'
and a.transaction_type in ('bs','BS_DHF')
and a.to_status = 11
--and a.from_status = 10
order by a.counter;
