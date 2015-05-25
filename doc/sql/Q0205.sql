USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0205]    Script Date: 05/25/2015 16:50:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0205] AS

--batch system transfer validated results from LAB23 to LAB21
-- main procedure is Q0200

declare @batchID varchar(25)
declare @seqid INT
declare @PID varchar(25)

/*select available batches not previously sent*/
declare cQ0200 cursor for
	/*select distinct PID,batchID, SeqID from LAB23Response as L23
	left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0
	where datesent=convert(datetime,'09/09/9999',103) and (result_accepted=1 or result_accepted=2) 
	order by PID,batchID, Seqid*/
	select distinct PID,batchID, SeqID from LAB23Response as L23
	left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0
	where datesent=convert(datetime,'09/09/9999',103) and (result_accepted=1 or result_accepted=2) 
	and PID not IN (	select distinct PID	from (
	select BHHRL_REF,PID,BatchID,Seqid
		from LAB23Response as L23
		left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0
		where datesent=convert(datetime,'09/09/9999',103) and (result_accepted=1 or result_accepted=2) 
		group by BHHRL_REF, PID ,batchID,Seqid
		having  count(BHHRL_REF)>1) as A)
	order by PID,batchID, Seqid

open cQ0200
fetch next from cQ0200 into @PID,@batchID, @seqid
/*loop available batches not previously sent, and pass batchID and seqid to SP Q0200*/
while @@fetch_status=0
begin
	insert into BHPLAB.DBO._LAB_LOG (log_object,log_comment,datecreated, keyopcreated) VALUES ('Q0205','Starting transfer for '+@PID+':'+@batchID+'. See also Q0200',getdate(), suser_sname())
	exec Q0200 @PID, @batchID, @seqid
	--select @batchID, @seqid
	fetch next from cQ0200 into @PID,@batchID, @seqid
end
close cQ0200
deallocate cQ0200
