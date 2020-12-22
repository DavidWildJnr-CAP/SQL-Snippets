
--RUN THIS PART
BACKUP DATABASE WebProofV12 
TO  DISK = N'G:\Backup\WebProofV12_PreUpgrade_20201112.bak' 
WITH COMPRESSION,
COPY_ONLY,
stats = 10;

--THEN THIS TO VERIFY
RESTORE VERIFYONLY FROM DISK = 'G:\Backup\WebProofV12_PreUpgrade_20201112.bak';



SELECT max(last_user_update)
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID( 'consensus')
AND OBJECT_ID=OBJECT_ID('files')


nhs_process_bespoke_search 'Bespoke searches_DMS_MRE_26082020'

select @@SERVERNAME