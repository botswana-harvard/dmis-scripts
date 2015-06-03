USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[GetResultsTransferToResultTBL]    Script Date: 06/03/2015 15:01:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetResultsTransferToResultTBL] 
@SourceTBL VARCHAR(50),
@DestinationTBL VARCHAR(50)

AS

declare @ErrorSave INT
declare @newid uniqueidentifier
declare @NSql NVARCHAR(1000)
set @newid=newid()

set @ErrorSave=0

/*update to flag records to process for this pass*/
set @Nsql = N'update '+@SourceTBL+' set TransferProcessID='''+convert(varchar(1000),@newid)+''',TransferProcessDate=getdate() where TransferProcessID is NULL'
exec sp_executesql @Nsql

IF (@@ERROR <> 0)
   SET @ErrorSave = @@ERROR

--exec GetResultsTTRT_S1 @SourceTBL
exec GetResultsTTRT_S2 @SourceTBL,@DestinationTBL,@newid

IF (@@ERROR <> 0)
   SET @ErrorSave = @@ERROR

-- Returns 0 if neither SELECT statement had
-- an error, otherwise returns the last error.
RETURN @ErrorSave
