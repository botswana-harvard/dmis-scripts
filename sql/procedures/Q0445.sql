USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0444]    Script Date: 06/05/2015 08:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Q0444] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @id UNIQUEIDENTIFIER
	declare d cursor for 
		select distinct transferProcessID from bhplab.dbo.results_101_getresults_temp 
		where transferProcessID is NOT NULL and transferIsDuplicate<>1
	open d
	fetch next from d into @id

	while @@fetch_status=0
	begin
        /* insert from results_101_temp to results_101 for this process_id*/
		exec bhplab.dbo.Q0445 @id
		fetch next from d into @id
	end 
	close d
	deallocate d

	/*flag duplicates*/
	update results_101 set isDuplicate=1 from
	(select [sample id] from results_101 
	group by [sample id]
	having count(*)>1) as A 
	where A.[sample id]=results_101.[sample id]
END

