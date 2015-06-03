USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0125]    Script Date: 05/25/2015 18:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0125] 

@result_accepted INT=1

AS
set nocount on
declare @newid UNIQUEIDENTIFIER
declare @ID INT
declare @lab21_id int
declare @sample_id VARCHAR(20)
declare @serial_number VARCHAR(100)
declare @sample_assay_date datetime
declare @dateImported datetime
declare @panel_name varchar(100)
declare @result_guid UNIQUEIDENTIFIER
declare @sql varchar(8000)
declare @fld varchar(200)
declare @utestid varchar(50)
declare @archive_filename varchar(100)

/*import CD4 results from results_101 into LAB21
Only accepted results
*/
SET DATEFORMAT dmy

/*insert into _lab_log ([log_object], log_comment) values ('Q0125','started')*/

declare cQ0125 cursor for 
	select R.[ID],LTRIM(UPPER(r.[panel name])),R.[cytometer serial number],R.[sample id],
	R.sample_assay_date,
		R.dateImported,R.result_guid,R.archive_filename 
		from bhplab.dbo.results_101 as R
	left join bhplab.dbo.LAB05Response as L5 on R.result_guid=L5.result_guid
	where LAB21_ID=-9 and patindex('%[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9]%',[sample id])<>0 and result_accepted=@result_accepted
 		--order by [sample id]
open cQ0125
fetch next from cQ0125 into @ID,@panel_name, @serial_number,@sample_id, @sample_assay_date, @dateImported, @result_guid,@archive_filename

while @@fetch_status=0
begin
	/*open a new result record*/
	set @lab21_id = NULL
	/*see if a record exists in LAB21. Implies the result record may have been started*/
	select @lab21_id=id from bhplab.dbo.LAB21Response where PID=@sample_id
	
	if @LAB21_ID is NULL /*if no LAB21, insert one and get the ID*/
		begin
			insert into bhplab.dbo.LAB21Response (PID,protocolnumber,version,headerdate,reportdate,testprofile,result_guid,rid, seqid, siteid, visitid, pinitials,tid) values (@sample_id,'BHPLAB','1.0',@dateImported,convert(varchar,@sample_assay_date,103)+' '+substring(convert(varchar,@sample_assay_date,108),1,5),@panel_name,@result_guid,'test', 1,'-1','-1', 'XX', '-1')
			set @lab21_id=SCOPE_IDENTITY()
		end

	
	if @lab21_id is NULL /*confirm you have LAB21 ID*/
		update results_101 set LAB21_ID=-9 where ID=@ID
	else
		begin
			/*get Q001X0 (guid) */
			select @newid=Q001X0 from LAB21Response where id=@lab21_id /*get GUID to link LAB21D*/

			if (select count(*) from  _lab_tests_dict where LTRIM(UPPER([panel name]))=@panel_name and utestid<>'-9')=0 /*track any unknown  panel names and insert into DB for future reference*/
				insert into _lab_log ([log_object], log_comment) values ('Q0125','['+isNull(@panel_name,'??null??')+']: unknown panel name for LID='+IsNull(@sample_id,'??NULL??')+'. cannot transfer result to LAB21')

			else
				begin	/*have recid, guid, panel name, testids...OK*/
					declare cQ0125_1 cursor for	/*get full list of UTESTID'd for this test based on the test panel name*/
						select distinct fld,utestid from  _lab_tests_dict 
						where UPPER([panel name])=@panel_name and utestid<>'-9'
						order by utestid
					open cQ0125_1
					fetch next from cQ0125_1 into @fld,@utestid
					while @@fetch_status=0
						begin
							set @sql = '
							declare @result varchar(255)
							declare @result_accepted INT
							declare @export_batchID VARCHAR(50)
							set @result_accepted='+convert(varchar,@result_accepted)+'
							set @result = NULL
							if @result_accepted=1
								select @result=['+@fld+'],@export_batchID=export_batchID from results_101 where ID='+convert(varchar,@ID)+'
							if @result_accepted=2
								select @result=''*'',@export_batchID=export_batchID from results_101 where ID='+convert(varchar,@ID)+'
							if @result is NOT NULL
								INSERT INTO bhplab.dbo.LAB21ResponseQ001X0 (QID1X0,UTESTID,RESULT,sample_assay_date,rsequence,flag,status,mid,validation_ref,version,export_batchID) values ('''+convert(varchar(1000),@newid)+''','''+@utestid+''',@result,'''+convert(varchar,@sample_assay_date,103)+' '+substring(convert(varchar,@sample_assay_date,108),1,5)+''',1,''-'',''F'','''+@serial_number+''','''+@archive_filename+''',''1.0'',IsNull(@export_batchID,''-9''))'
							--print @sql
							exec(@sql)
							fetch next from cQ0125_1 into @fld,@utestid
						end
					close cQ0125_1
					deallocate cQ0125_1
					update bhplab.dbo.results_101 set LAB21_ID=@lab21_id where ID=@ID
				end 
		end
	fetch next from cQ0125 into @ID,@panel_name, @serial_number,@sample_id, @sample_assay_date, @dateImported, @result_guid,@archive_filename
end
close cQ0125
deallocate cQ0125

/*unflag recs in results_101 where nothing was transfered*/
update bhplab.dbo.results_101 set LAB21_ID=-9,dateLastModified=getdate() from(
select R.[ID] from results_101 as R
left join bhplab.dbo.LAB21Response as L21 on R.LAB21_ID=L21.ID
left join bhplab.dbo.LAB21ResponseQ001X0 as L21D on L21.Q001X0=L21D.QID1X0
where L21D.ID IS NULL and R.LAB21_ID <>'-9'
) as A
where A.ID=results_101.ID






/*
select top 10 * from LAB21ResponseQ001X0
select top 10 * from LAB05Response
select top 100 * from results_101 where LAB21_ID=-9 order by [sample id]

*/

--select * from results_101 where [sample id]='AB03263'
--select * from LAB01Response where [pid]='AB03263'


/*
select * from LAB21Response as L21
left join LAB21ResponseQ001X0 as L21D on L21.Q001X0=L21D.QID1X0
where L21.rid='TEST'

select top 100 * from LAB21ResponseQ001X0
*/

--select * from results_101 where LAB21_ID<>-9 and [sample id]='AB00188'
/*
delete from LAB21Response where rid='TEST'
update results_101 set LAB21_ID=-9
*/

--select * from _lab_tests_dict where [panel name]='CD3/CD8/CD45/CD4 TruC'
/*
delete from LAB21ResponseQ001X0 where UTESTID='CD4'
delete from LAB21ResponseQ001X0 where UTESTID='CD4%'
delete from LAB21ResponseQ001X0 where UTESTID='CD8'
delete from LAB21ResponseQ001X0 where UTESTID='CD8%'
*/


/*
select top 10 R.[ID],R.[panel name],R.[cytometer serial number],R.[sample id],
	R.sample_assay_date,
convert(varchar,sample_assay_date,103)+' '+substring(convert(varchar,sample_assay_date,108),1,5) as CCCCC,
		R.dateImported,R.result_guid,R.archive_filename 
		from results_101 as R
*/


/*insert into _lab_log ([log_object], log_comment) values ('Q0125','complete')*/
