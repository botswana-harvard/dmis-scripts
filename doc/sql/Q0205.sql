USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0208]    Script Date: 05/25/2015 16:49:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0208] AS

declare @msg varchar(500)
declare @query varchar(1000)
declare @subject varchar(1000)
declare @fn varchar(100)
declare @email varchar(100)
DECLARE @cmd sysname, @var sysname

Set @email='bkhumotaka@bhp.org.bw;smoyo@bhp.org.bw;ewidenfelt@bhp.org.bw'




set @query= 'select substring(A.PID,1,8) as BARCODE, 
	L.TID, substring(L.PAT_ID,1,12) as PAT_ID, substring(convert(varchar,L.headerdate,103),1,10) as Received, 
	substring(L.sample_time_received,1,6) as [Time], 
	substring(L.sample_protocolnumber,1,10) as protocol, substring(L.KeyOpCreated,1,15) as EnteredBy
from (select PID, count(PID) as samples
from bhplab.dbo.LAb01Response group by PID,headerdate having count(PID)>1 ) as A
left join bhplab.dbo.LAB01Response as L on A.PID=L.PID
where PAT_ID<>''NOT TRACKED'' and PAT_ID<>''CONTROL (QC)'' and pat_ID<>''NO PATINFO'' and PAT_ID<>''DEBSWANA''
and L.headerdate>=dateadd(dd,-60, getdate())
order by L.headerdate desc ,A.PID'


--select @email=email_dc from bhp.dbo._sites where siteid=(select siteid from _randlist where substring(PID,1,8)=substring(@pid,1,8)) and protocolnumber=@protocolnumber
if @email is NULL 
	Set @email='ewidenfelt@bhp.org.bw'

set @email=@email+';ewidenfelt@bhp.org.bw'

set @msg='Hi'+char(13)+char(13)+
	'A duplicate barcode has been entered at sample reception. Here is a list of the duplicates entered and not resolved for the past 60 days.'+char(13)+char(13)+
	'The DMIS will accept the same barcode be used for different tests. In the cases listed here it is more likely that this was not the intention of the lab technician'+char(13)+char(13)+
	'Please refer any queries to the BHHRL Quality Control Manager.'+char(13)+char(13)+
	'Thank you'+char(13)+char(13)+
	'DMIS'+char(13)+char(13)+char(13)+char(13)+'List of Duplicates'+char(13)+char(13)

set @subject  = 'Duplicate barcode(s) detected in DMIS. Please investigate.' 
--set @fn=@pid+'_'+convert(varchar,year(getdate()))+convert(varchar,month(getdate()))+convert(varchar,day(getdate()))+'.txt'

EXEC master..xp_sendmail @recipients=@email, 
@query=@query,
@subject=@subject,
--@attach_results='true', @attachments=@fn,
@width=254,
@message=@msg,
@no_output='true'
