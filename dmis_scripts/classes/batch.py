from collections import namedtuple

from datetime import datetime, date

from django.conf import settings

import pymssql
import _mssql

ValidatedBatch = namedtuple('ValidatedBatch', 'pid batch_id batch_seq_id')


class BatchError(Exception):
    pass


class Batch(object):

    server = 'test_server'  # settings.PYMSSQL_TEST_SERVER
    user = 'xxx'  # settings.PYMSSQL_TEST_USERNAME
    password = 'xxx'  # settings.PYMSSQL_TEST_PASSWORD
    db = 'BHPLAB'

    def __init__(self):
        self._batches = []
        self.datetime_format = '%Y-%m-%d %H:%M'
        self.process_date = date.today().strftime('%d-%m-%Y')

    def start(self):
        for batch in self.unprocessed_batches:
            try:
                self.process_batch(batch)
            except BatchError as e:
                print ('Failed to process batch {}. Got {}.'.format(batch, e))

    @property
    def unprocessed_batches(self):
        if not self._batches:
            with _mssql.connect(self.server, self.user, self.password) as conn:
                conn.execute_query(self.unprocessed_batches_sql)
                for row in conn:
                    self._batches.append(
                        ValidatedBatch(
                            pid=row['pid'],
                            batch_id=row['batch_id'],
                            batch_seq_id=row['batch_seq_id'])
                    )
                    self.update_log(
                        conn,
                        pid=row['pid'],
                        batch_id=row['batch_id']
                    )
        return self._batches

    @property
    def unprocessed_batches_sql(self):
        return (
            'select distinct PID as pid,batchID as batch_id, SeqID as batch_seq_id '
            'from bhplab.dbo.LAB23Response as L23 '
            'left join bhplab.dbo.LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 '
            'where datesent=convert(datetime,\'09/09/9999\',103) and (result_accepted=1 or result_accepted=2) '
            'order by PID,batchID, Seqid')

    def update_log(self, conn, pid, batch_id):
        sql = (
            'insert into BHPLAB.DBO._LAB_LOG (log_object,log_comment, '
            ' datecreated, keyopcreated) VALUES (\'Q0205\',\'Starting transfer '
            'for {pid}:{batch_id}. See also Q0200\',\'{date}\', \'{user}\')'.format(
                pid=pid, batch_id=batch_id, date=datetime.now().strftime(self.datetime_format), user='python'))
        conn.execute_non_query(sql)

    def process_batch(self, batch):
        """Process each result in the batch."""
        with _mssql.connect(self.server, self.user, self.password) as batch_conn:
            try:
                batch_conn.execute_query(self.batch_sql(*batch))
            except _mssql.MSSQLDatabaseException:
                print(self.batch_sql(*batch))
                raise
            for validated_result in batch_conn:
                result = self.get_or_create_result(validated_result)
                with _mssql.connect(self.server, self.user, self.password) as batch_result_conn:
                    try:
                        batch_result_conn.execute_query(self.batch_result_sql(result['result_guid']))
                    except _mssql.MSSQLDatabaseException:
                        print(self.batch_result_sql(result['result_guid']))
                        raise
                    for result_item in batch_result_conn:
                        result_item_id = self.get_or_create_result_item(result_item)
                        print(result_item_id)
                        # flag validated result as processed

    def batch_sql(self, pid, batch_id, batch_seq_id):
        return (
            'select l23d.bhhrl_ref as specimen_identifier, \'BHPLAB\' as protocolnumber, \'1.0\' as version, '
            'convert(datetime,L23.sample_assay_date,103) as headerdate, '
            'convert(varchar,getdate(),103) as reportdate, l23.TID as testprofile, L23D.result_guid, '
            '\'LAB23:\'+L23.BATCHID as rid, 1 as seqid, \'-9\' as siteid, \'-9\' as visitid, '
            '\'-9\' as pinitials, L23.tid '
            'from bhplab.dbo.LAB23Response as L23 '
            'left join bhplab.dbo.LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 '
            'where pid=\'{}\' and batchid=\'{}\' and seqid=\'{}\'').format(pid, batch_id, batch_seq_id)

    def get_or_create_result(self, result):
        sql = (
            'insert into bhplab.dbo.LAB21Response (PID,protocolnumber,version,headerdate,reportdate,testprofile,'
            'result_guid,rid,seqid,siteid, visitid, pinitials,tid ) values ('
            '\'{pid}\', \'{protocolnumber}\',\'{version}\',\'{headerdate}\',\'{reportdate}\',\'{testprofile}\','
            '\'{result_guid}\',\'{rid}\',\'{seqid}\',\'{siteid}\', \'{visitid}\', \'{pinitials}\',\'{tid}\')').format(
                pid=result['specimen_identifier'],
                protocolnumber=result['protocolnumber'],
                version=result['version'],
                headerdate=result['headerdate'],  # .strftime(self.datetime_format),
                reportdate=result['reportdate'],  # .strftime(self.datetime_format),
                testprofile=result['testprofile'],
                result_guid=result['result_guid'],
                rid=result['rid'],
                seqid=result['seqid'],
                siteid=result['siteid'],
                visitid=result['visitid'],
                pinitials=result['pinitials'],
                tid=result['tid'])
        with _mssql.connect(self.server, self.user, self.password) as conn:
            try:
                conn.execute_non_query(sql)
            except _mssql.MSSQLDatabaseException as e:
                if e.number == 2627:
                    pass
                else:
                    raise
            print(result['result_guid'])
            return conn.execute_row(
                'select pid,protocolnumber,version,headerdate,reportdate,testprofile,'
                'result_guid,rid,seqid,siteid, visitid, pinitials,tid  from bhplab.dbo.LAB21Response '
                'where result_guid=\'{result_guid}\''.format(result_guid=result['result_guid']))
        return None

    def batch_result_sql(self, result_guid):
        return (
            'SELECT l21.q001x0 as qid1x0, l23d.bhhrl_ref as lid, '
            'convert(varchar,l21.headerdate,103) as sample_assay_date, '
            'l23.utestid, '
            'result=case l23d.result_accepted when 1 then l23d.result else \'*\' end, '
            'result_quantifier, 1 as rsequence, \'-\' as flag, \'f\' as status,'
            'l23.machine_id as mid, \'-3\' as comment, \'-9\' as export_batchid, '
            'l21.rid as validation_ref, \'-9\' as rid, l23d.keyopcreated, l23d.keyoplastmodified '
            'FROM BHPLAB.DBO.LAB21Response as L21 '
            'left join BHPLAB.DBO.LAB23ResponseQ001X0 as L23D on L21.result_guid=L23D.result_guid '
            'left join BHPLAB.DBO.LAB23Response as L23 on L23.Q001X0=L23D.QID1X0 '
            'where L23D.result_guid=\'{result_guid}\''.format(result_guid=result_guid)
        )

    def get_or_create_result_item(self, result_item):
        sql = (
            'INSERT INTO BHPLAB.DBO.LAB21ResponseQ001X0 (qid1x0,lid,sample_assay_date,utestid,'
            'result,result_quantifier,rsequence,flag,status,mid,comment,export_batchid,'
            'validation_ref,rid,keyopcreated,keyoplastmodified) values ('
            '\'{qid1x0}\',\'{lid}\',\'{sample_assay_date}\',\'{utestid}\','
            '\'{result}\',\'{result_quantifier}\',\'{rsequence}\',\'{flag}\',\'{status}\',\'{mid}\',\'{comment}\','
            '\'{export_batchid}\',\'{validation_ref}\',\'{rid}\',\'{keyopcreated}\',\'{keyoplastmodified}\')'.format(
                qid1x0=result_item['qid1x0'],
                lid=result_item['lid'],
                sample_assay_date=result_item['sample_assay_date'],
                utestid=result_item['utestid'],
                result=result_item['result'],
                result_quantifier=result_item['result_quantifier'],
                rsequence=result_item['rsequence'],
                flag=result_item['flag'],
                status=result_item['status'],
                mid=result_item['mid'],
                comment=result_item['comment'],
                export_batchid=result_item['export_batchid'],
                validation_ref=result_item['validation_ref'],
                rid=result_item['rid'],
                keyopcreated=result_item['keyopcreated'],
                keyoplastmodified=result_item['keyoplastmodified'])
        )
        with _mssql.connect(self.server, self.user, self.password) as conn:
            try:
                conn.execute_non_query(sql)
            except _mssql.MSSQLDatabaseException as e:
                print(sql)
                raise
            return conn.execute_row('select SCOPE_IDENTITY() as last_id')['last_id']
        return None

    @property
    def batch_results_sql(self):
        return (
            'select L23D.BHHRL_REF as specimen_identifier, \'BHPLAB\' as protocolnumber, \'1.0\' as version, '
            'convert(datetime,L23.sample_assay_date,103) as headerdate, '
            'convert(varchar,getdate(),103) as reportdate, L23.TID as testprofile, L23D.result_guid, '
            '\'LAB23:\'+L23.BATCHID as rid, 1 as seqid, \'-9\' as siteid, \'-9\' as visitid, '
            '\'-9\' as pinitials, L23.tid '
            'from bhplab.dbo.LAB23Response as L23 '
            'left join bhplab.dbo.LAB23ResponseQ001X0 as L23D on L23.Q001X0=L23D.QID1X0 '
            'left join bhplab.dbo.LAB21Response as L21 on (L23D.BHHRL_REF=L21.PID and L23.TID=L21.TID) '
            'where (L23D.result_accepted=1 or L23D.result_accepted=2) and L21.PID is NULL '
            'and L23D.datesent=convert(datetime,\'09/09/9999\',103)'
        )
