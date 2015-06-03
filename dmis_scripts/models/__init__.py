from sqlalchemy.ext.declarative import declarative_base

server = 'test_server'  # settings.PYMSSQL_TEST_SERVER
user = 'xxx'  # settings.PYMSSQL_TEST_USERNAME
password = 'xxx'  # settings.PYMSSQL_TEST_PASSWORD
db = 'bhplab'

connection_string = 'mssql+pymssql://{usr}:{pwd}@{srv}/{db}?charset=utf8'.format(
    usr=user, pwd=password, srv=server, db=db)
