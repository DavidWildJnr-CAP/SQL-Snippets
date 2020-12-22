with files_CTE as
(
select distinct import_file_name
from consensus.[dbo].[tbl_osmr_file1]
where importDate is null

union all

select distinct import_file_name
from consensus.[dbo].[tbl_osmr_file2]
where importDate is null



--order by import_file_name
)
--select left(replace(import_file_name,'osmr'),'',3),count(*)


select replace(left(replace(import_file_name,'osmr_',''),3),'_',''),count(*)
from files_CTE
group by replace(left(replace(import_file_name,'osmr_',''),3),'_','')
order by replace(left(replace(import_file_name,'osmr_',''),3),'_','')