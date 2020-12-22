--Equivilent to a FULL join when using TVF
--Returns top 100 files which HAVE been set to status 5
select top 100 -- Just for the test
		f.filenumber,
		f.timestamp as FilesTableTimestamp,
		s.transaction_type,
		s.date as TransactionTimestamp
from consensus.dbo.files F 
		cross apply -- Use this like a full join when using this TVF
				(
				select * 
				from consensus.dbo.FileTransactionsFull_fn (f.filenumber) 
				where to_status = 5 -- we only want status 5 transactions
				)  s;
---------------------------------------------------------------------------------------------------------------------




--Equivilent to a left join when using TVF
--Returns top 100 files and a date when they went to status 5 IF they went to status 5
select top 100 -- Just for the test
		f.filenumber,
		f.timestamp as FilesTableTimestamp,
		s.transaction_type,
		s.date as TransactionTimestamp
from consensus.dbo.files F 
		outer apply -- Use this like a left join when using this TVF
				(
				select * 
				from consensus.dbo.FileTransactionsFull_fn (f.filenumber) 
				where to_status = 5 -- we only want status 5 transactions
				)  s;
----------------------------------------------------------------------------------------------------------------------------