
/*
PARAMETERS:
<OperatorName,sysname,Alerts> - Name of the Operator/Alias to alert.
@notification_method 1 - Bitmap of notification types/options: 1 = email, 
2 = pager, 4 = netsend
*/
 
USE msdb
GO
 
EXEC msdb. dbo.sp_add_alert @name = N'823 - Read/Write Failure',
    @message_id = 823,
    @severity = 0,
    @enabled = 1,
    @delay_between_responses = 0,
    @include_event_description_in = 1
GO
EXEC msdb .dbo. sp_add_notification
        @alert_name=N'823 - Read/Write Failure' ,
        @operator_name =N'<OperatorName,sysname,Alerts>' ,
        @notification_method = 1;   -- 1 for email
 
EXEC msdb. dbo.sp_add_alert @name = N'824 - Page Error',
    @message_id = 824,
    @severity = 0,
    @enabled = 1,
    @delay_between_responses = 0,
    @include_event_description_in = 1
GO
EXEC msdb .dbo. sp_add_notification
        @alert_name=N'824 - Page Error' ,
        @operator_name =N'<OperatorName,sysname,Alerts>' ,
        @notification_method = 1;   -- 1 for email
 
EXEC msdb. dbo.sp_add_alert @name = N'825 - Read-Retry Required',
    @message_id = 825,
    @severity = 0,
    @enabled = 1,
    @delay_between_responses = 0,
    @include_event_description_in = 1
GO
EXEC msdb .dbo. sp_add_notification
        @alert_name=N'825 - Read-Retry Required' ,
        @operator_name =N'<OperatorName,sysname,Alerts>' ,
        @notification_method = 1;   -- 1 for email