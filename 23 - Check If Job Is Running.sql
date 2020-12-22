DECLARE @JOB_NAME SYSNAME 

set @JOB_NAME= N'MSP_AA_DLA_Nap_Matching_Hourly_Triggered_From_MI_9'; 
 
IF NOT EXISTS(     
        select 1 
        from msdb.dbo.sysjobs_view job  
        inner join msdb.dbo.sysjobactivity activity on job.job_id = activity.job_id 
        where  
            activity.run_Requested_date is not null  
        and activity.stop_execution_date is null  
        and job.name = @JOB_NAME 
        ) 
BEGIN      
    DECLARE	--keep

		@C as CURSOR,
		@UserID as varchar(25),
		@BoxNumber as varchar(20), 
		@FileNumber as varchar(20),
		@ItemBarcode as varchar(20), 
		@Text1 as varchar(100), 
		@Text2 as varchar(100), 
		@Text3 as varchar(100), 
		@Text4 as varchar(100), 
		@Text5 as varchar(100), 
		@Text6 as varchar(100), 
		@Text7 as varchar(100), 
		@Text8 as varchar(100), 
		@Text9 as varchar(100), 
		@Text10 as varchar(100), 
		@Date1 as Datetime, 
		@Date2 as datetime, 
		@Date3 as datetime, 
		@Num1 as real, 
		@Num2 as real, 
		@ItemDescription as varchar(100),
		@NapIndexID as int;

	SET @C = CURSOR FAST_FORWARD FOR
	--sp_linkedservers
		SELECT 'V63' as UserID,
			i.BoxBarcode,
			f.filenumber,
			i.ItemBarcode,
			f.text1,
			f.text2,
			f.text3,
			f.text4,
			f.text5,
			f.text6,
			f.text7,
			f.text8,
			f.text9,
			f.text10,
			f.Date1,
			f.Date2,
			f.Date3,
			f.Number1,
			f.Number2,
			'0065*17_AA_BENEFIT' as ItemDescription,
			i.id as NapIndexID
			--ROW_NUMBER() OVER(PARTITION BY i.itembarcode ORDER BY I.id ) as rownum
			
		FROM DWPPRHWSQL01.[MI].[dbo].[DLA_AA_NAP_Indexing_Log] I with(nolock)
			inner join mops.dbo.files f with(nolock) on f.text1 = i.NINO 
						--and f.text4 = i.Benefit_Type 
						and f.linkable = 1
			inner join mops.dbo.box b with(nolock) on f.boxnumber = b.boxnumber and b.department in ('18','17')
			left join mops.dbo.files f2 with(nolock) on f2.filenumber = i.ItemBarcode
			left join mops.dbo.items it with(nolock) on it.itembarcode = i.itembarcode 
		where i.status = 0
			--and i.action = 'Logged' -- added at BA request 2013-10-08
			and f2.filenumber is null -- Make absolutly sure the file does not exist.
			and it.itembarcode is null -- Make absolutly sure that the item is not in the item table
		
	OPEN @C; 

	FETCH NEXT FROM @C INTO @UserID, @BoxNumber, @FileNumber, @ItemBarcode, @Text1, @Text2, @Text3, @Text4, @Text5, @Text6, @Text7, @Text8, @Text9, @Text10, @Date1, @Date2, @Date3, @Num1, @Num2, @ItemDescription,@NapIndexID; 


	WHILE @@fetch_status = 0  -- Leave

	BEGIN --Leave
		BEGIN TRY -- On some occasions items were indexed whilst the job was running
			IF @FileNumber <> @ItemBarcode -- Belt and Braces Cannot insert an item linked to iteself.
				BEGIN
					Exec mops.dbo.FARIOOMI_AddItem @UserID, @BoxNumber, @FileNumber, @ItemBarcode, @Text1, @Text2, @Text3, @Text4, @Text5, @Text6, @Text7, @Text8, @Text9, @Text10, @Date1, @Date2, @Date3, @Num1, @Num2, @ItemDescription;

					Update DWPPRHWSQL01.[MI].[dbo].[DLA_AA_NAP_Indexing_Log] 
					set status = -1,filebarcode = @Filenumber,SystemMatchTimestamp = getdate()
					where id = @NapIndexID;

					update mops.dbo.items
					set status = -2
					where itembarcode = @ItemBarcode;
				END
		END TRY
		
		BEGIN CATCH
			print @FileNumber;
		END CATCH
	FETCH NEXT FROM @C INTO @UserID, @BoxNumber, @FileNumber, @ItemBarcode, @Text1, @Text2, @Text3, @Text4, @Text5, @Text6, @Text7, @Text8, @Text9, @Text10, @Date1, @Date2, @Date3, @Num1, @Num2, @ItemDescription,@NapIndexID; 

	END;
END 
ELSE 
BEGIN 
    PRINT 'Job ''' + @JOB_NAME + ''' is currently running.  This Job will not start '; 
END 