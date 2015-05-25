from datetime import datetime

from django.conf import settings

import pymssql


class Batch(object):

    server = settings.PYMSSQL_TEST_SERVER
    user = settings.PYMSSQL_TEST_USERNAME
    password = settings.PYMSSQL_TEST_PASSWORD
    db = 'BHPLAB'

    def process_unsent_batches(self):
        with pymssql.connect(self.server, self.user, self.password, "bhplab") as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute(self.unsent_batches_sql)
                for row in cursor:
                    self.update_log(cursor, row)
                    'exec Q0200 @PID, @batchID, @seqid'

    def update_log(self, cursor, row):
        cursor.execute(
            'insert into BHPLAB.DBO._LAB_LOG (log_object,log_comment, '
            'datecreated, keyopcreated) VALUES (\'Q0205\',\'Starting transfer '
            'for {pid}:{batch_id}. See also Q0200\',{date}, {user}'.format(
                pid=row['PID'], batch_id=row['batchID'], date=datetime.now(), user='python'))

    @property
    def unsent_batches_sql(self):
        return (
            'select distinct PID,batchID, SeqID from LAB23Response as L23'
            'left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0'
            'where datesent=convert(datetime,\'09/09/9999\',103) and (result_accepted=1 or result_accepted=2)'
            'and PID not IN (    select distinct PID    from ('
            'select BHHRL_REF,PID,BatchID,Seqid'
            'from LAB23Response as L23'
            'left join LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0'
            'where datesent=convert(datetime,\'09/09/9999\',103) and (result_accepted=1 or result_accepted=2)'
            'group by BHHRL_REF, PID ,batchID,Seqid'
            'having  count(BHHRL_REF)>1) as A)'
            'order by PID,batchID, Seqid')
