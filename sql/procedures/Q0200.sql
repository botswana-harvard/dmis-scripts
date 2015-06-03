USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0200]    Script Date: 05/25/2015 18:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0200] 

@PID varchar(25),
@BatchID varchar(15),
@seqid INT


AS

/*

undo code, but specifiy batchID and datesent, dont just run this
??update LAB23ResponseQ001X0 set datesent=convert(datetime,'09/09/9999', 103)
??delete from LAB21Response where substring(RID,1,5)='LAB23'
??delete from LAB21ResponseQ001X0 where substring(validation_ref,1,5)='LAB23'
update LAB23ResponseQ001X0 set result_accepted=-9 
from (select L23D.ID 
	from LAB23Response as L23
	left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 
	where L23.batchID='747107') as A 
where A.ID=LAB23ResponseQ001X0.ID

*/

declare @DDMMYYYY datetime

/*save current datetiem into a variable. this will be date/time record sent*/
set @DDMMYYYY=getdate()

/* flag records with the date for export to LAB21*/
if @batchID='ALL'
	update LAB23ResponseQ001X0 set datesent=convert(datetime,@DDMMYYYY, 103)  
	where datesent=convert(datetime,'09/09/9999',103) and (result_accepted=1 or result_accepted=2) 
else
	update LAB23ResponseQ001X0 set datesent=convert(datetime,@DDMMYYYY, 103) 
	from ( 
		select L23D.ID from LAB23Response as L23
		left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 
		where datesent=convert(datetime,'09/09/9999',103) 
			and (result_accepted=1 or result_accepted=2) 
			and L23.PID=@PID
			and BatchID=@BatchID and seqid=@seqid
	) as A where A.ID=LAB23ResponseQ001X0.ID


begin transaction

	--check for any results already on file
	update LAB23ResponseQ001X0 set result_accepted=result_accepted+10
	from	 (
	select L23D.ID
	from LAB23Response as L23
	left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 
	left join LAB21Response as L21 on (L23D.BHHRL_REF=L21.PID and L23.TID=L21.TID) --L23D.BHHRL_REF=L21.PID
	left join LAB21ResponseQ001X0 as L21D on L21.Q001X0=L21D.QID1X0
	where (L23D.result_accepted=1 or L23D.result_accepted=2) 
	and L21D.UTESTID=L23.UTESTID 
	and L23D.datesent=convert(datetime,@DDMMYYYY,103)) as A
	where A.ID=LAB23ResponseQ001X0.ID
		
	--create master record in LAB21Response
	/*insert flagged records into LAB21 if they do not currently exist*/
	insert into LAB21Response (PID,protocolnumber,version,headerdate,reportdate,testprofile,result_guid,rid,seqid,siteid, visitid, pinitials,tid )
	select 
	L23D.BHHRL_REF as PID,
	'BHPLAB' as protocolnumber,
	'1.0' as version,
	convert(datetime,L23.sample_assay_date,103) as headerdate,
	convert(varchar,getdate(),103) as reportdate,
	L23.TID as testprofile,
	L23D.result_guid,
	'LAB23:'+L23.BATCHID as rid,
	1 as seqid,
	'-9' as siteid,
	'-9' as visitid,
	'-9' as pinitials,
	L23.tid
	/*UTESTID,RESULT,RESULT_ACCEPTED,RESULT_GUID,'LAB23:'+BATCHID as RID */
	from LAB23Response as L23
	left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 
	left join LAB21Response as L21 on (L23D.BHHRL_REF=L21.PID and L23.TID=L21.TID) --L23D.BHHRL_REF=L21.PID
	--left join LAB01Response as L on (L23.TID=L.TID and L23D.BHHRL_REF=L.PID)
	where (L23D.result_accepted=1 or L23D.result_accepted=2) 
	and L21.PID is  NULL 
	and L23D.datesent=convert(datetime,@DDMMYYYY,103)
	
	if @@ERROR<>0
		begin
			rollback transaction
			update LAB23ResponseQ001X0 set datesent=convert(datetime,'09/09/9999', 103) where datesent=@DDMMYYYY
			insert into BHPLAB.DBO._lab_log (log_object,log_comment, datecreated, keyopcreated) values ('Q0200','INSERT INTO LAB21 failed for batch '+@PID+':'+@batchID, getdate(), suser_sname())
			GOTO end_of_batch
		end		
	
	
	--insert details 
	INSERT INTO BHPLAB.DBO.LAB21ResponseQ001X0 (QID1X0,LID,sample_assay_date,UTESTID,RESULT,RESULT_QUANTIFIER,RSEQUENCE,FLAG,STATUS,MID,COMMENT,
    export_BatchID,validation_ref,RID,keyopcreated,keyoplastmodified)
	SELECT  
	L21.Q001X0 as QID1X0,
	L23D.BHHRL_REF as LID,
	convert(varchar,L21.headerdate,103) as sample_assay_date,
	L23.UTESTID,
	RESULT= case L23D.result_accepted when 1 then L23D.RESULT else '*' end,
	RESULT_QUANTIFIER,
	1 as RSEQUENCE,
	'-' as FLAG,
	'F' as STATUS,
	L23.machine_id as MID,
	'-3' as COMMENT,
	'-9' as export_batchID,
	L21.RID as validation_ref,
	'-9' as RID,
    L23D.keyopcreated,
    L23D.keyoplastmodified
	FROM 
	BHPLAB.DBO.LAB21Response as L21
	left join BHPLAB.DBO.LAB23ResponseQ001X0 as L23D on L21.result_guid=L23D.result_guid
	left join BHPLAB.DBO.LAB23Response as L23 on L23.Q001X0=L23D.QID1X0
	where L23D.result_guid is NOT NULL and L23.Q001X0 is NOT NULL
	and (L23D.result_accepted=1 or L23D.result_accepted=2) and L23D.datesent=convert(datetime,@DDMMYYYY,103)
	

	if @@ERROR<>0
		begin
			rollback transaction
			update LAB23ResponseQ001X0 set datesent=convert(datetime,'09/09/9999', 103) where datesent=@DDMMYYYY
			insert into BHPLAB.DBO._lab_log (log_object,log_comment, datecreated, keyopcreated) values ('Q0200','INSERT INTO LAB21D failed for batch '+@PID+':'+@batchID, getdate(), suser_sname())
			GOTO end_of_batch
		end		

	--update viral load PHM with LOG10
	exec Q0157

	if @@ERROR<>0
		begin
			rollback transaction
			update LAB23ResponseQ001X0 set datesent=convert(datetime,'09/09/9999', 103) where datesent=@DDMMYYYY
			insert into BHPLAB.DBO._lab_log (log_object,log_comment, datecreated, keyopcreated) values ('Q0200','EXEC Q0157 failed for batch '+@PID+':'+@batchID, getdate(), suser_sname())
			GOTO end_of_batch
		end		


commit transaction

end_of_batch:
