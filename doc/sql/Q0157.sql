USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0157]    Script Date: 05/25/2015 18:28:55 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0157] AS

/*clean up VL data coming from AMPLILINK software*/

/*amplilink smetimes sends the result as this,,,,this is invalid.*/
delete from LAB21ResponseQ001X0 where lower(result)='no result'

/*update RESULT LO--not expected */
update LAB21ResponseQ001X0 set result='400', flag='<\<' where UTESTID='PHM' and ISNUMERIC(RESULT)=1 and convert(FLOAT,result)<400.0
/*update target LO --not expected */
update LAB21ResponseQ001X0 set result='400', flag='<\LO' where UTESTID='PHM' and result='' and flag='L'
/*clean any not integer 400's*/
update LAB21ResponseQ001X0 set result='400', result_quantifier='<' where result='<400'  and UTESTID='PHM'
/*update MACHINE*/
--update LAB21ResponseQ001X0 set MID='142.1' where MID='PHM'

/*update target HI*/
update LAB21ResponseQ001X0 set result='750000', flag='>\HI' where UTESTID='PHM' and flag='>'
/*update RESULT HI results*/
update LAB21ResponseQ001X0 set result='750000', flag='>\>' where ISNUMERIC(RESULT)=1 and UTESTID='PHM' and convert(float,RESULT)>750000.0 and flag<>'>/HI'

/*add LOG10 for those without it. TestID must be PHM and result must be a numeric*/
insert into LAB21ResponseQ001X0 (QID1X0,LID, sample_assay_date,UTESTID,RESULT,RSEQUENCE,FLAG,STATUS,MID,validation_ref) 
select Q001X0 as QID1X0,
PID as LID, 
L21D_PHM.sample_assay_date,
'LOG10' as UTESTID,
convert(varchar(50),log10(convert(float,L21D_PHM.RESULT))) as RESULT,
1 as RSEQUENCE, '-' as FLAG,'F' as STATUS,
L21D_PHM.MID,validation_ref
from LAB21Response as L21 
left join (select QID1X0, UTESTID,sample_assay_date, RESULT, MID,validation_ref from LAB21ResponseQ001X0 where UTESTID='PHM' and IsNumeric(RESULT)=1 and RESULT is NOT NULL) as L21D_PHM on L21.Q001X0=L21D_PHM.QID1X0 
left join (select QID1X0, UTESTID from LAB21ResponseQ001X0 where UTESTID='LOG10' and IsNumeric(RESULT)=1) as L21D_LOG on L21.Q001X0=L21D_LOG.QID1X0 
where L21D_LOG.QID1X0 is NULL and L21D_PHM.QID1X0 is NOT NULL

/*add LOG10 for those without it. TestID must be HIM-CAP and result must be a numeric*/
insert into LAB21ResponseQ001X0 (QID1X0,LID, sample_assay_date,UTESTID,RESULT,RSEQUENCE,FLAG,STATUS,MID,validation_ref) 
select Q001X0 as QID1X0,
PID as LID, 
L21D_PHM.sample_assay_date,
'LOG10' as UTESTID,
convert(varchar(50),log10(convert(float,L21D_PHM.RESULT))) as RESULT,
1 as RSEQUENCE, '-' as FLAG,'F' as STATUS,
L21D_PHM.MID,validation_ref
from LAB21Response as L21 
left join (select QID1X0, UTESTID,sample_assay_date, RESULT, MID,validation_ref from LAB21ResponseQ001X0 where UTESTID='HIM-CAP' and IsNumeric(RESULT)=1 and RESULT is NOT NULL) as L21D_PHM on L21.Q001X0=L21D_PHM.QID1X0 
left join (select QID1X0, UTESTID from LAB21ResponseQ001X0 where UTESTID='LOG10' and IsNumeric(RESULT)=1) as L21D_LOG on L21.Q001X0=L21D_LOG.QID1X0 
where L21D_LOG.QID1X0 is NULL and L21D_PHM.QID1X0 is NOT NULL

/*add LOG10 for those without it. TestID must be NucS and result must be a numeric*/
insert into LAB21ResponseQ001X0 (QID1X0,LID, sample_assay_date,UTESTID,RESULT,RSEQUENCE,FLAG,STATUS,MID,validation_ref) 
select Q001X0 as QID1X0,
PID as LID, 
L21D_PHM.sample_assay_date,
'LOG10' as UTESTID,
convert(varchar(50),log10(convert(float,L21D_PHM.RESULT))) as RESULT,
1 as RSEQUENCE, '-' as FLAG,'F' as STATUS,
L21D_PHM.MID,validation_ref
from LAB21Response as L21 
left join (select QID1X0, UTESTID,sample_assay_date, RESULT, MID,validation_ref from LAB21ResponseQ001X0 where UTESTID='NUCS' and IsNumeric(RESULT)=1 and RESULT is NOT NULL) as L21D_PHM on L21.Q001X0=L21D_PHM.QID1X0 
left join (select QID1X0, UTESTID from LAB21ResponseQ001X0 where UTESTID='LOG10' and IsNumeric(RESULT)=1) as L21D_LOG on L21.Q001X0=L21D_LOG.QID1X0 
where L21D_LOG.QID1X0 is NULL and L21D_PHM.QID1X0 is NOT NULL

/*add LOG10 for those without it. TestID must be NucS and result must be a numeric*/
insert into LAB21ResponseQ001X0 (QID1X0,LID, sample_assay_date,UTESTID,RESULT,RSEQUENCE,FLAG,STATUS,MID,validation_ref) 
select Q001X0 as QID1X0,
PID as LID, 
L21D_PHM.sample_assay_date,
'LOG10' as UTESTID,
convert(varchar(50),log10(convert(float,L21D_PHM.RESULT))) as RESULT,
1 as RSEQUENCE, '-' as FLAG,'F' as STATUS,
L21D_PHM.MID,validation_ref
from LAB21Response as L21 
left join (select QID1X0, UTESTID,sample_assay_date, RESULT, MID,validation_ref from LAB21ResponseQ001X0 where UTESTID='PHS' and IsNumeric(RESULT)=1 and RESULT is NOT NULL) as L21D_PHM on L21.Q001X0=L21D_PHM.QID1X0 
left join (select QID1X0, UTESTID from LAB21ResponseQ001X0 where UTESTID='LOG10' and IsNumeric(RESULT)=1) as L21D_LOG on L21.Q001X0=L21D_LOG.QID1X0 
where L21D_LOG.QID1X0 is NULL and L21D_PHM.QID1X0 is NOT NULL
