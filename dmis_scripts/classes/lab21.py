import pymssql

from datetime import date
from django.conf import settings


class lab21(object):
    server = settings.PYMSSQL_TEST_SERVER
    user = settings.PYMSSQL_TEST_USERNAME
    password = settings.PYMSSQL_TEST_PASSWORD
    db = 'bhplab'

    def update_existing(self):
        """Check and updates any results already on file."""

        sql = 'update LAB23ResponseQ001X0 set result_accepted=result_accepted+10 '
        'from (select L23D.ID from LAB23Response as L23 '
        'left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 '
        'left join LAB21Response as L21 on (L23D.BHHRL_REF=L21.PID and L23.TID=L21.TID) '
        'left join LAB21ResponseQ001X0 as L21D on L21.Q001X0=L21D.QID1X0 '
        'where (L23D.result_accepted=1 or L23D.result_accepted=2) and '
        'L21D.UTESTID=L23.UTESTID and '
        'L23D.datesent=convert(datetime,{date},103) '
        ') as A where A.ID=LAB23ResponseQ001X0.ID'.format(date())
        with pymssql.connect(self.server, self.user, self.password, "bhplab") as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute(sql)

    def create_new(self):
        sql = """
    insert into LAB21Response (PID,protocolnumber,version,headerdate,reportdate,testprofile,result_guid,rid,seqid,siteid, visitid, pinitials,tid )
    select L23D.BHHRL_REF as PID, 'BHPLAB' as protocolnumber, '1.0' as version, convert(datetime,L23.sample_assay_date,103) as headerdate,
    convert(varchar,getdate(),103) as reportdate, L23.TID as testprofile, L23D.result_guid, 'LAB23:'+L23.BATCHID as rid, 1 as seqid,
    '-9' as siteid, '-9' as visitid, '-9' as pinitials, L23.tid
    from LAB23Response as L23
    left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0
    left join LAB21Response as L21 on (L23D.BHHRL_REF=L21.PID and L23.TID=L21.TID) --L23D.BHHRL_REF=L21.PID
    where (L23D.result_accepted=1 or L23D.result_accepted=2) and L21.PID is  NULL
    and L23D.datesent=convert(datetime,{date},103)"""
        with pymssql.connect(self.server, self.user, self.password, "bhplab") as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute(sql.format(date=date()))

    def insert_details(self, cursor):

        sql = """INSERT INTO BHPLAB.DBO.LAB21ResponseQ001X0 (QID1X0,LID,sample_assay_date,UTESTID,RESULT,RESULT_QUANTIFIER,RSEQUENCE,FLAG,STATUS,MID,COMMENT,
    export_BatchID,validation_ref,RID,keyopcreated,keyoplastmodified)
    SELECT L21.Q001X0 as QID1X0, L23D.BHHRL_REF as LID, convert(varchar,L21.headerdate,103) as sample_assay_date,
    L23.UTESTID, RESULT= case L23D.result_accepted when 1 then L23D.RESULT else '*' end,
    RESULT_QUANTIFIER, 1 as RSEQUENCE, '-' as FLAG, 'F' as STATUS, L23.machine_id as MID, '-3' as COMMENT,
    '-9' as export_batchID, L21.RID as validation_ref, '-9' as RID. L23D.keyopcreated, L23D.keyoplastmodified
    FROM BHPLAB.DBO.LAB21Response as L21
    left join BHPLAB.DBO.LAB23ResponseQ001X0 as L23D on L21.result_guid=L23D.result_guid
    left join BHPLAB.DBO.LAB23Response as L23 on L23.Q001X0=L23D.QID1X0
    where L23D.result_guid is NOT NULL and L23.Q001X0 is NOT NULL
    and (L23D.result_accepted=1 or L23D.result_accepted=2) and L23D.datesent=convert(datetime,{date},103)"""
        with pymssql.connect(self.server, self.user, self.password, "bhplab") as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute(sql.format(date=date()))

    def undo(self, pid, batch_id):
        sql = """update LAB23ResponseQ001X0 set datesent=convert(datetime,'09/09/9999', 103) where datesent=@DDMMYYYY
            insert into BHPLAB.DBO._lab_log (log_object,log_comment, datecreated, keyopcreated) values ('Q0200','INSERT INTO LAB21 failed for batch {pid}:{batch_id}, getdate(), suser_sname())"""
        with pymssql.connect(self.server, self.user, self.password, "bhplab") as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute(sql.format(pid=pid, batch_id=batch_id))
