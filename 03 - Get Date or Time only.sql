--Get Date Only

select DATEADD(day, DATEDIFF(day,'19000101', GETDATE()),'19000101')

--Get Time only
SELECT DATEADD(
  second,
  DATEDIFF(
     second, 
     DATEADD(day, DATEDIFF(day,
      0, GETDATE()), 0), -- date only 
     GETDATE()), 
  0);



  