use ReportServer;

GO

SELECT Subscriptions.Description AS SubscriptionName
	  ,Schedule.ScheduleID AS JobID
	  ,Catalog.Name AS ReportName
FROM dbo.Subscriptions
	INNER JOIN dbo.ReportSchedule
		ON ReportSchedule.SubscriptionID = Subscriptions.SubscriptionID
	INNER JOIN dbo.Schedule
		ON ReportSchedule.ScheduleID = Schedule.ScheduleID
	INNER JOIN dbo.Catalog
		ON ReportSchedule.ReportID = Catalog.ItemID
		AND Subscriptions.Report_OID = Catalog.ItemID
ORDER BY CAST(Schedule.ScheduleID AS VARCHAR(100));



USE msdb ;  
GO  

EXEC sp_start_job N'4F3C470D-B8B5-4B45-96CC-D578E97B8C7C' ;  
