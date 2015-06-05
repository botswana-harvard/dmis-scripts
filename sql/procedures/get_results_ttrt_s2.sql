USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[GetResultsTTRT_S2]    Script Date: 06/03/2015 15:40:01 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetResultsTTRT_S2]

@SourceTBL VARCHAR(50),
@DestinationTBL VARCHAR(50),
@newid UNIQUEIDENTIFIER

AS

declare @Nsql NVARCHAR(4000)
declare @ErrorSave INT
Set @ErrorSave=0


/*look for duplicates between result table and records in this holding table
if duplicate, do not transfer*/



/*look for duplicates in just the holding table for this process ID
flag all duplicates as =1*/

set @Nsql = N'
declare @id INT
declare @lid varchar(15)
declare @sample_assay_date datetime
declare @this_lid varchar(15)
declare @this_sample_assay_date datetime
declare E cursor for 
	select id,[sample id],sample_assay_date from  '+@SourceTBL+'  where TransferProcessID='''+convert(varchar(1000),@newid)+'''
		order by [sample id],sample_assay_date,dateImported desc
open E
fetch next from E into @id,@lid,@sample_assay_date

set @this_lid=''''
set @this_sample_assay_date=convert(datetime,''01/01/1900'',103)

while @@fetch_status=0
begin
	if @lid=@this_lid and @this_sample_assay_date=@sample_assay_date
		update  '+@SourceTBL+' set transferIsDuplicate=1 where ID=@id

	set @this_lid=@lid
	set @this_sample_assay_date=@sample_assay_date

	fetch next from E into @id,@lid,@sample_assay_date
end
close E
deallocate E'
exec sp_executesql @Nsql

IF (@@ERROR <> 0)
   SET @ErrorSave = @@ERROR

/*STEP 2*/

/*update to flag records that already exist in main result TBL
ignore those already flagged above*/
set @Nsql = 'update '+@SourceTBL+' set TransferIsDuplicate=1
from 
(select t.result_GUID from '+@SourceTBL+' as t
left join '+@destinationTBL+' as r on t.[sample id]=r.[sample id] 
where r.[sample_assay_date]=t.sample_assay_date) as A
where A.result_GUID='+@SourceTBL+'.result_GUID
and TransferProcessID='''+convert(varchar(1000),@newid)+''' and transferIsDuplicate<>1 '

print @Nsql
-- exec sp_executesql @Nsql


IF (@@ERROR <> 0)
   SET @ErrorSave = @@ERROR

/*STEP 3*/

/*build field list for INSERT and SELECT statement*/
declare @sql VARCHAR(8000)
declare @sql1 VARCHAR(8000)
declare @sql_prefix VARCHAR(8000)
declare @sql_suffix VARCHAR(8000)
declare @fld varchar(1000)
declare @name varchar(1000)
declare @cnt INT
set @cnt=0
set @sql=''
set @sql1=''
set @sql_prefix=''
set @sql_suffix=''
declare c cursor for
	select c.name from sysobjects as o 
	left join syscolumns as c on o.id=c.id 
	where o.name=@SourceTBL and c.name<>'LID' and
	c.name<>'TransferDateTransfered' and
	c.name<>'TransferIsDuplicate' and c.name<>'TransferProcessDate'
open c
fetch next from c into @fld
while @@fetch_status=0
begin
	set @cnt=@cnt+len('['+@fld+'], ')
	set @sql = @sql +'['+@fld+'], '
	if len(@sql)>7500
	begin
		set @sql1=@sql
		set @sql=''
	end	
	fetch next from c into @fld
end
close c
deallocate c
if @sql1<>'' and @sql=''
	set @sql1=substring(@sql1,1,len(@sql1)-1)
else
	set @sql=substring(@sql,1,len(@sql)-1)

/*build INSERT statement*/
set @sql_prefix='SET IDENTITY_INSERT '+@destinationTBL+' ON 
		if (select count(*) from '+@destinationTBL+' where TransferProcessID='''+convert(varchar(1000),@newid)+''' )=0'

set @sql_suffix=' from '+@SourceTBL+' where TransferProcessID='''+convert(varchar(1000),@newid)+''' and TransferIsDuplicate=2'
/*EXECUTE*/

-- exec (@sql_prefix+' insert into '+@destinationTBL+' ('+@sql1+@sql+') select '+@sql1+@sql+@sql_suffix)
print @sql_prefix+' insert into '+@destinationTBL+' ('+@sql1+@sql+') select '+@sql1+@sql+@sql_suffix

IF (@@ERROR <> 0)
   SET @ErrorSave = @@ERROR

--select @@rowcount as [Inserted]

-- Returns 0 if neither SELECT statement had
-- an error, otherwise returns the last error.
RETURN @ErrorSave
