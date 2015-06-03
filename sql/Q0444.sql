CREATE PROCEDURE [dbo].[Q0444] 
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
		exec bhplab.dbo.GetResultsTTRT_S2 'results_101_getresults_temp','results_101',@id
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

