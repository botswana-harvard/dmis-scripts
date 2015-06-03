USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[Q0268]    Script Date: 05/25/2015 16:52:17 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q0268] AS

/*update invalid codes*/

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='CHOLL' where utestid='CHOLL2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='CHOLL' where utestid='CHOL2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='CHOL/HDL' where utestid='CHOLL2/HDL'

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='BIL-T' where utestid='BILTS'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='LACT' where utestid='LACT2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='FERR' where utestid='FERR2'	

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='CRPL' where utestid='CRPLX'	
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='CRPL' where utestid='CRPL2'	

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='GGT' where utestid='GGTL'	
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='GGT' where utestid='GGTI2'	

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='ALPL' where utestid='ALPL2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='ALPL' where utestid='ALP2L'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='ALPL' where utestid='ALPL6'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='ALPL' where utestid='ALP2S'

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='AMY-L' where utestid='AMYL2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='CO2-S' where utestid='CO2-L'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='TRSF' where utestid='TRSF2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='LDL-C' where utestid='LDLC-C'

update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='ALB' where utestid='ALB2'
update BHPLAB.DBO.LAB21ResponseQ001X0 set utestid='PREA' where utestid='PREA2'


/*update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='CHOLL' where utestid='CHOLL2'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='CHOLL' where utestid='CHOL2'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='CHOL/HDL' where utestid='CHOLL2/HDL'

update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='BIL-T' where utestid='BILTS'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='LACT' where utestid='LACT2'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='FERR' where utestid='FERR2'	

update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='CRPL' where utestid='CRPLX'	
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='CRPL' where utestid='CRPL2'	

update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='GGT' where utestid='GGTL'	
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='GGT' where utestid='GGTI2'	

update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='ALPL' where utestid='ALPL2'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='ALPL' where utestid='ALP2L'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='ALPL' where utestid='ALPL6'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='ALPL' where utestid='ALP2S'

update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='AMY-L' where utestid='AMYL2'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='CO2-S' where utestid='CO2-L'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='TRSF' where utestid='TRSF2'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='LDL-C' where utestid='LDLC-C'
update BHPLAB.DBO.INTEGRA_ARCHIVE set utestid='ALB' where utestid='ALB2'
*/
