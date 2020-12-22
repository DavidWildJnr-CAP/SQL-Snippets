

SELECT
    v.name ,
    m.definition 
FROM 
    sys.views v
INNER JOIN 
    sys.sql_modules m ON v.object_id = m.object_id
where m.definition like '%mi.dbo%'
and v.name like 'Trans%'
and v.name not like '%DWPPRHWSQL01.mi.dbo%'