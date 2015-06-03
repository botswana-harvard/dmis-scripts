USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0215]    Script Date: 05/25/2015 16:52:59 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0215]
@Container varchar(25),
@Container_reference varchar(250)
AS



if @container='sample'
	select  Freezer=case when ST305.freezer_name is NULL then 'unknown' else 
	'<A href="/dmx/reports/study/qa.asp?@FreezerID='+ST305.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B161667B3-29B1-4969-87A6-24EEA730DC6F%7D&cat=Storage%3A+Container&hasprm=Y">'+ST305.freezer_name+' ('+ST305.PID+')</A>' end, 
	Rack=case when ST405.rack_name is NULL then 'unknown' else 
	'<A href="/dmx/reports/study/qa.asp?@rackID='+ST405.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B2E51D856-A330-4B86-9ED9-8EF2C4CD7B18%7D&cat=Storage%3A+Container&hasprm=Y">'+ST405.rack_name+' ('+ST405.PID+')</A>' end,
	Box='<A href="http://dmc.bhp.org.bw/dmx/reports/study/qa.asp?@boxID='+ST505.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7BD826B655-4665-4697-93B0-121B5BB8514A%7D&cat=Storage%3A+Container&hasprm=Y">'+ST505.box_name+' ('+ST505.PID+')</A>', 
	ST505D.sample_id as [Sample],
	Pos=ST505D.box_col,
	Pos=ST505D.sample_type
	from ST505Response as ST505 
		left join ST505ResponseQ001X0 as ST505D on ST505.Q001X0=QID1X0
		left join ST405ResponseQ001X0 as ST405D on ST405D.box_id=ST505.PID
		left join ST405Response as ST405 on ST405.Q001X0=ST405D.QID1X0
		left join ST305ResponseQ001X0 as ST305D on ST305D.rack_id=ST405.PID
		left join ST305Response as ST305 on ST305D.QID1X0=ST305.Q001X0
--		where patindex('%'+@Container_reference+'%', ST505D.sample_id)<>0
		where patindex('%'+ST505D.sample_id+'%', @Container_reference)<>0
	order by ST505.PID, ST505D.box_col

if @container='box'
	select A.Freezer,A.Rack, A.Box,(select count(*) from ST505ResponseQ001X0 where QID1X0=A.Q001X0 and sample_id<>'empty') as Samples , display_rows as Capacity
	from (
		select Freezer=case when ST305.freezer_name is NULL then 'unknown' else 
		'<A href="/dmx/reports/study/qa.asp?@FreezerID='+ST305.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B161667B3-29B1-4969-87A6-24EEA730DC6F%7D&cat=Storage%3A+Container&hasprm=Y">'+ST305.freezer_name+' ('+ST305.PID+')</A>' end, 
		Rack=case when ST405.rack_name is NULL then 'unknown' else 
		'<A href="/dmx/reports/study/qa.asp?@rackID='+ST405.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B2E51D856-A330-4B86-9ED9-8EF2C4CD7B18%7D&cat=Storage%3A+Container&hasprm=Y">'+ST405.rack_name+' ('+ST405.PID+')</A>' end,
		Box='<A href="http://dmc.bhp.org.bw/dmx/reports/study/qa.asp?@boxID='+ST505.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7BD826B655-4665-4697-93B0-121B5BB8514A%7D&cat=Storage%3A+Container&hasprm=Y">'+ST505.box_name+' ('+ST505.PID+')</A>',
		ST505.display_rows,ST505.Q001X0, ST505.PID as BOXID
		from ST505Response as ST505 
			left join ST505ResponseQ001X0 as ST505D on ST505.Q001X0=QID1X0
			left join ST405ResponseQ001X0 as ST405D on ST405D.box_id=ST505.PID
			left join ST405Response as ST405 on ST405.Q001X0=ST405D.QID1X0
			left join ST305ResponseQ001X0 as ST305D on ST305D.rack_id=ST405.PID
			left join ST305Response as ST305 on ST305D.QID1X0=ST305.Q001X0
			where patindex('%'+@Container_reference+'%', ST505.box_name+ST505.PID)<>0 or patindex('%'+@Container_reference +'%',ST505.box_name+ST505.PID)<>0
		group by ST305.PID,ST305.freezer_name,ST405.PID,ST405.rack_name,ST505.PID,ST505.box_name,ST505.Q001X0, st505.display_rows
	) as A
	order by A.BOXID

if @container='rack'
	begin
		select distinct Freezer=case when ST305.freezer_name is NULL then 'unknown' else 
		'<A href="/dmx/reports/study/qa.asp?@FreezerID='+ST305.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B161667B3-29B1-4969-87A6-24EEA730DC6F%7D&cat=Storage%3A+Container&hasprm=Y">'+ST305.freezer_name+' ('+ST305.PID+')</A>' end, 
		Rack=case when ST405.rack_name is NULL then 'unknown' else 
		'<A href="/dmx/reports/study/qa.asp?@rackID='+ST405.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B2E51D856-A330-4B86-9ED9-8EF2C4CD7B18%7D&cat=Storage%3A+Container&hasprm=Y">'+ST405.rack_name+' ('+ST405.PID+')</A>' end
		from ST405Response as ST405 
			left join ST405ResponseQ001X0 as ST405D on ST405.Q001X0=QID1X0
			left join ST305ResponseQ001X0 as ST305D on ST305D.rack_id=ST405.PID
			left join ST305Response as ST305 on ST305D.QID1X0=ST305.Q001X0
			where patindex('%'+@Container_reference+'%',ST405.PID+ST405.rack_name)<>0 or patindex('%'+@Container_reference+'%',ST405.rack_name+ST405.PID)<>0
				or patindex('%'+ST405.PID+'%',@Container_reference)<>0
				or patindex('%'+ST405.rack_name+'%',@Container_reference)<>0
		select '<font class="vbar">'+convert(varchar,@@rowcount)+' racks</font>' as [html]
	end


if @container='freezer'
	begin
		select distinct Freezer=case when ST305.freezer_name is NULL then 'unknown' else 
		'<A href="/dmx/reports/study/qa.asp?@FreezerID='+ST305.PID+'&submit=Submit&studyid=BHPLAB&test=999&mid=&crfversion=1.0&batch=&s=DMC&h=REPORTS&guid=%7B161667B3-29B1-4969-87A6-24EEA730DC6F%7D&cat=Storage%3A+Container&hasprm=Y">'+ST305.freezer_name+' ('+ST305.PID+')</A>' end
		from ST305Response as ST305 
			left join ST305ResponseQ001X0 as ST305D on ST305.Q001X0=QID1X0
			where patindex('%'+@Container_reference+'%',ST305.PID+ST305.freezer_name)<>0 or patindex('%'+@Container_reference+'%',ST305.freezer_name+ST305.PID)<>0
				or patindex('%'+ST305.PID+'%',@Container_reference)<>0
				or patindex('%'+ST305.freezer_name+'%',@Container_reference)<>0
		select '<font class="vbar">'+convert(varchar,@@rowcount)+' freezers</font>' as [html]
	end
if @container='?'
	select '<font class=vbar>Please specify a container to search</font>' as [html]

/*
declare @BOX_ID varchar(10)
select @BOX_ID=ST.PID
from ST200Response as ST left join ST200ResponseQ001X0 as STD on Q001X0=QID1X0 
where STD.BHHRL_REF=@BHHRL_REF

if @BOX_ID is NULL 
	select '<font class=vbar>A Sample with reference '+@BHHRL_REF+' could not be found</font>' as [html]
else
	exec Q0214 @BOX_ID
*/
