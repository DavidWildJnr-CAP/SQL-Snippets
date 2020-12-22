IF OBJECT_ID('dbo.DimDate', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.[DimDate];
END


CREATE TABLE [dbo].[DimDate](
[DateId] [int] IDENTITY(1,1) NOT NULL,
TheDate datetime ,
TheDay Int,
TheDayName nvarchar(15),
TheWeek int,
TheISOWeek int,
TheDayOfWeek int,
TheMonth int,
TheMonthName nvarchar(15),
TheQuater int,
TheYear int,
TheFirstOfTheMonth datetime,
TheLastOfTheMonth datetime,
TheLastOfYear datetime,
TheDayOfYear int,
IsBankHoliday bit default(0)
);




DECLARE @StartDate  date = '20150101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 10, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
	TheLastOfTheMonth = dateadd(dd,-1,dateadd(mm,1,DATEFROMPARTS(YEAR(d), MONTH(d), 1))),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)	

  FROM d
)
insert into [dbo].[DimDate]( [TheDate], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek],[TheMonth], [TheMonthName], [TheQuater], [TheYear], [TheFirstOfTheMonth], [TheLastOfTheMonth],TheLastOfYear, [TheDayOfYear])
SELECT * FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);


--UPDATE BANK HOLIDAYS
--UK BHols from https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwi88av2ovDrAhVKRRUIHdUbAigQFjAAegQIBhAB&url=https%3A%2F%2Fwww.dmo.gov.uk%2Fmedia%2F15008%2Fukbankholidays.xls&usg=AOvVaw2rFeWg1uub_huEatCkY6Yt
update dimdate
set isbankholiday = 1
where thedate IN 
(
'2015-01-01',
'2015-04-03',
'2015-04-06',
'2015-05-04',
'2015-05-25',
'2015-08-31',
'2015-12-25',
'2015-12-28',
'2016-01-01',
'2016-03-25',
'2016-03-28',
'2016-05-02',
'2016-05-30',
'2016-08-29',
'2016-12-26',
'2016-12-27',
'2017-01-02',
'2017-04-14',
'2017-04-17',
'2017-05-01',
'2017-05-29',
'2017-08-28',
'2017-12-25',
'2017-12-26',
'2018-01-01',
'2018-03-30',
'2018-04-02',
'2018-05-07',
'2018-05-28',
'2018-08-27',
'2018-12-25',
'2018-12-26',
'2019-01-01',
'2019-04-19',
'2019-04-22',
'2019-05-06',
'2019-05-27',
'2019-08-26',
'2019-12-25',
'2019-12-26',
'2020-01-01',
'2020-04-10',
'2020-04-13',
'2020-05-04',
'2020-05-25',
'2020-08-31',
'2020-12-25',
'2020-12-28',
'2021-01-01',
'2021-04-02',
'2021-04-05',
'2021-05-03',
'2021-05-31',
'2021-08-30',
'2021-12-27',
'2021-12-28',
'2022-01-03',
'2022-04-15',
'2022-04-18',
'2022-05-02',
'2022-05-30',
'2022-08-29',
'2022-12-26',
'2022-12-27',
'2023-01-02',
'2023-04-07',
'2023-04-10',
'2023-05-01',
'2023-05-29',
'2023-08-28',
'2023-12-25',
'2023-12-26',
'2024-01-01',
'2024-03-29',
'2024-04-01',
'2024-05-06',
'2024-05-27',
'2024-08-26',
'2024-12-25',
'2024-12-26'
)



