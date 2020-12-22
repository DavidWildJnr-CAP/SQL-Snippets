-------------------------------------------------------------------------------------------------------------------------------------
declare @MyUnixTimestamp bigint
select @MyUnixTimestamp = 1529922051126

--select @MyUnixTimestamp

-- Using dateadd to add seconds to 1970-01-01
--Simple Method to UTC
select dateadd(ss,@MyUnixTimestamp/1000,'1970-01-01')
--2018-06-25 10:20:51.000
---------------------------------------------------------------------------------------------------------------------------------------------
-- The Helpdesk Method - To Local Time
declare @MyTimeStamp as bigint = 1531984857000
select CONVERT(VARCHAR(20), dateadd(s, datediff(s, getutcdate(), getdate()) + (@MyTimeStamp / 1000), '1970-01-01 00:00:00'), 121)
--2018-06-25 11:20:51.


--CURRENT TIME TO UNIX Timestamp
SELECT  cast(DATEDIFF(SECOND,{d '1970-01-01'}, getutcdate()) as bigint) * 1000




declare @MyTimeStamp as bigint = 1529922051126
select dateadd(s, datediff(s, getutcdate(), getdate()) + (@MyTimeStamp / 1000), '1970-01-01 00:00:00')




--Convert date to utc
SELECT DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), YOUR_DATE);

