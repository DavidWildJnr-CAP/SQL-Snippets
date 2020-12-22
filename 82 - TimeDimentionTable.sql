IF OBJECT_ID('dbo.DimTime', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.DimTime;
END
 
-- Then create a new table
CREATE TABLE [dbo].[DimTime](
    [TimeId] [int] IDENTITY(1,1) NOT NULL,
    [Time] [time](0) not null,
    [Hour] [int] NULL,
    [Minute] [int] NULL,
    [MilitaryHour] int NOT null,
    [MilitaryMinute] int NOT null,
    [AMPM] [varchar](2) NOT NULL,
    [DayPartEN] [varchar](10) NULL,
  --  [DayPartNL] [varchar](10) NULL,
    [HourFromTo12] [varchar](17) NULL,
    [HourFromTo24] [varchar](13) NULL,
    [Notation12] [varchar](10) NULL,
    [Notation24] [varchar](10) NULL
);
 
-- Needed if the dimension already existed
-- with other column, otherwise the validation
-- of the insert could fail.
GO
 
-- Create a time and a counter variable for the loop
DECLARE @Time as time;
SET @Time = '0:00';
 
DECLARE @counter as int;
SET @counter = 0;
 
 
-- Two variables to store the day part for two languages
DECLARE @daypartEN as varchar(20);
set @daypartEN = '';
 
DECLARE @daypartNL as varchar(20);
SET @daypartNL = '';
 
 
-- Loop 1440 times (24hours * 60minutes)
WHILE @counter < 1440
BEGIN
 
    -- Determine datepart
    SELECT  @daypartEN = CASE
                         WHEN (@Time >= '0:00' and @Time < '6:00') THEN 'Night'
                         WHEN (@Time >= '6:00' and @Time < '12:00') THEN 'Morning'
                         WHEN (@Time >= '12:00' and @Time < '18:00') THEN 'Afternoon'
                         ELSE 'Evening'
                         END
    ,       @daypartNL = CASE
                         WHEN (@Time >= '0:00' and @Time < '6:00') THEN 'Nacht'
                         WHEN (@Time >= '6:00' and @Time < '12:00') THEN 'Ochtend'
                         WHEN (@Time >= '12:00' and @Time < '18:00') THEN 'Middag'
                         ELSE 'Avond'
                         END;
 
    INSERT INTO DimTime ([TheTime]
                       , [Hour]
                       , [Minute]
                       , [MilitaryHour]
                       , [MilitaryMinute]
                       , [AMPM]
                       , [DayPartEN]
                      -- , [DayPartNL]
                       , [HourFromTo12]
                       , [HourFromTo24]
                       , [Notation12]
                       , [Notation24])
                VALUES (@Time
                       , DATEPART(Hour, @Time) + 1
                       , DATEPART(Minute, @Time) + 1
                       , DATEPART(Hour, @Time)
                       , DATEPART(Minute, @Time)
                       , CASE WHEN (DATEPART(Hour, @Time) < 12) THEN 'AM' ELSE 'PM' END
                       , @daypartEN
                     --  , @daypartNL
                       , CONVERT(varchar(10), DATEADD(Minute, -DATEPART(Minute,@Time), @Time),100)  + ' - ' + CONVERT(varchar(10), DATEADD(Hour, 1, DATEADD(Minute, -DATEPART(Minute,@Time), @Time)),100)
                       , CAST(DATEADD(Minute, -DATEPART(Minute,@Time), @Time) as varchar(5)) + ' - ' + CAST(DATEADD(Hour, 1, DATEADD(Minute, -DATEPART(Minute,@Time), @Time)) as varchar(5))
                       , CONVERT(varchar(10), @Time,100)
                       , CAST(@Time as varchar(5))
                       );
 
    -- Raise time with one minute
    SET @Time = DATEADD(minute, 1, @Time);
 
    -- Raise counter by one
    set @counter = @counter + 1;
END


alter table DimTime add primary key (Time)