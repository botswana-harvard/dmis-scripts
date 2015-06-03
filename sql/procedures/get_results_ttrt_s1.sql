USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[GetResultsTTRT_S1]    Script Date: 06/03/2015 15:39:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetResultsTTRT_S1]
@SourceTBL VARCHAR(50)
AS

declare @Nsql NVARCHAR(4000)

/*update assay date*/
exec Q0024 @SourceTBL
/*update machine serial number if NULL*/
exec Q0066 @SourceTBL
