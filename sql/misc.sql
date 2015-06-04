-- select * from bhplab.dbo.lab01response where pid='XE55409'
-- select * from bhplab.dbo.lab23responseQ001X0 where bhhrl_ref='XE55409'
/*
select l21d.* from bhplab.dbo.lab21response as l21
left join bhplab.dbo.lab21responseQ001x0 as l21d on l21.q001x0=l21d.qid1x0
where pid='XE55409'

select top 10 * from bhplab.dbo.lab05response as l5
left order by datecreated desc

select top 10 LID, LTRIM([panel name]) as [panel name], [(Average) CD3+CD4+ Abs Cnt] from bhplab.dbo.results_101
where LID='XE55409'
order by dateimported desc

select * from  bhplab.dbo._lab_tests_dict where [panel name]='CD3/CD8/CD45/CD4 TruC' order by [panel name], utestid
*/
-- select top 1000 [3] from bhplab.dbo._TCPDataAstmParseIN where ASTM_RECID='P' order by id desc
-- select * from bhplab.dbo._TCPDataAstmParseIN where [3] LIKE '%XE549'

--select * from  bhplab.dbo._lab_tests_dict where [panel name]='HARVARD CD4'
--select top 1000 * from bhplab.dbo._lab_log order by id desc

select top 100 r.* from bhplab.dbo.results_101 as R
left join bhplab.dbo.LAB21Response as L21 on R.LAB21_ID=L21.ID
left join bhplab.dbo.LAB21ResponseQ001X0 as L21D on L21.Q001X0=L21D.QID1X0
where R.LAB21_ID IS NULL
order by dateimported desc


/*select distinct transferProcessID 
from bhplab.dbo.results_101_getresults_temp 
where transferProcessID is NOT NULL and transferIsDuplicate<>1
	*/