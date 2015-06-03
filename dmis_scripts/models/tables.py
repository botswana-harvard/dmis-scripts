from sqlalchemy.ext.automap import automap_base
from sqlalchemy import Table, MetaData, create_engine


from . import connection_string


Base = automap_base()
engine = create_engine(connection_string, echo=True)
metadata = MetaData(bind=engine)


class Receive(Base):
    """LAB01"""
    __table__ = Table('LAB21Response', metadata, autoload=True)


class Result(Base):
    """LAB21"""
    __table__ = Table('LAB21Response', metadata, autoload=True)


class ResultItem(Base):
    """LAB21D"""
    __table__ = Table('LAB21ResponseQ001X0', metadata, autoload=True)


class ValidationBatch(Base):
    """LAB23"""
    __table__ = Table('LAB23Response', metadata, autoload=True)


class ValidationBatchItem(Base):
    """LAB23D"""
    __table__ = Table('LAB23ResponseQ001X0', metadata, autoload=True)
