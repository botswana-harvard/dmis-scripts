USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0209]    Script Date: 05/25/2015 16:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0209] AS

declare @BatchID varchar(25)
declare @PID varchar(25)
declare @QID1X0 uniqueidentifier


declare c cursor for 
	select distinct batchID, PID, QID1X0 from (
	select L23D.datesent,L23.batchid,L23.PID,L23D.QID1X0 
    from BHPLAB.DBO.LAB23ResponseQ001X0  as L23D
	left join BHPLAB.DBO._LID as LID on L23D.BHHRL_REF=LID.LID
	left join BHPLAB.DBO.LAB23Response as L23 on L23D.QID1X0=L23.Q001X0
	left join BHPLAB.DBO.LAB21Response as L21 on (L21.PID=L23D.BHHRL_REF and L21.TID=L23.TID)
	where 
	L21.PID is NULL
	and (result_accepted=1 or result_accepted=2)
	and LID.LID is not NULL
	and datesent<>convert(datetime, '09/09/9999',103)
	--and L23D.datereceived>convert(datetime, '15/09/2004',103)
	) as A
	order by batchID,PID
open c
fetch next from c into @batchID, @PID, @QID1X0
while @@fetch_status=0
begin
    	update LAB23ResponseQ001X0 set datesent =convert(datetime, '09/09/9999',103) where QID1X0=@QID1X0
    	exec Q0200 @PID,@BatchID, 1
    	insert into BHPLAB.DBO._lab_log (log_object,log_comment, datecreated, keyopcreated) values ('Q0200','RE-TRY for batch '+@PID+':'+@batchID, getdate(), suser_sname())

	fetch next from c into @batchID, @PID, @QID1X0
end
close c
deallocate c
