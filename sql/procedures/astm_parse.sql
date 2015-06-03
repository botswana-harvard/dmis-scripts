USE [BHPLAB]
GO
/****** Object:  StoredProcedure [dbo].[_astm_parse]    Script Date: 06/03/2015 15:41:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[_astm_parse]
as

set nocount on

/*
take raw data from tcpdatarawIN and by delimited put into separate fields in tcpdataAstmIN
*/



declare @n INT
declare @insert_id INT
declare @sql VARCHAR(8000)
declare @sql_set VARCHAR(8000)
declare @astm_recid varchar(1)
declare @astm_position INT
declare @tcp_string as varchar(8000)
declare @fld_value as varchar(255)
declare @this_astm_recid varchar(1)
declare @3 varchar(100)
declare @4 varchar(100)
declare @7 varchar(100)
declare @9 varchar(100)
declare @pid varchar(100)
declare @id INT
declare @frame INT
declare @13 VARCHAR(25)
declare @24 VARCHAR(25)
declare @GUIDParsed uniqueidentifier
declare @local_ip varchar(16)
declare @local_port varchar(10)
declare @remote_ip varchar(16)
declare @remote_port varchar(10)

set @GUIDParsed=newid()


/*get list of sources*/
declare B cursor LOCAL for
	select remote_ip, remote_port,local_ip, local_port from _TCPDataRawIn 
	where GUIDparsed is NULL
	group by remote_ip, remote_port,local_ip, local_port 
open B
fetch next from B into @remote_IP, @remote_port, @local_ip, @local_port

while @@fetch_status=0
	begin
		set @GUIDParsed=newid()
		/*flag this batch of records*/
		update _TCPdataRawIn set GUIDParsed=@GUIDParsed
		from (select [ID] from _TCPDataRawIn where GUIDParsed is NULL and remote_ip=@remote_IP and remote_port=@remote_port and local_ip=@local_ip and local_port=@local_port 
		--and remote_port is NOT NULL
		) as A
		where _TCPdataRawIn.ID=A.[ID]
		
		
		
		/*must be ordered correctly so that only records from a single source are ordered by ID, 
		otherwise things could ghet mixed up.*/
		declare c cursor LOCAL for
		select id,tcp_string,local_ip, local_port,remote_ip, remote_port from _TCPdataRawIn where GUIDParsed=@GUIDParsed  order by remote_IP,remote_Port,local_IP, local_port,[ID] 
		open c
		fetch next from c into @id, @tcp_string,@local_ip, @local_port, @remote_ip, @remote_port
		while @@fetch_status=0
			begin
				/*has this record already been parsed?*/
				if (select count(*) from _TCPDataAstmParseIN where tcp_data_raw_in_ID=@id)=0
					begin
						set @sql=''
						set @sql_set=''
						insert into _TCPDataAstmParseIN (local_ip, local_port, remote_ip, remote_port,tcp_data_raw_in_ID, GUIDParsed,astm_recid,astm_position) values (@local_ip, @local_port, @remote_ip, @remote_port,@id,@GUIDParsed,substring(@tcp_string,2,1),substring(@tcp_string,1,1))
						set @insert_id=SCOPE_IDENTITY() /*get record ID for 40 updates to follow. All updates done on the same record*/
						declare d cursor LOCAL  for 
							select astm_recid,astm_position from _tcpASTMDict where astm_recid=substring(@tcp_string,2,1) order by astm_position
						open d
						fetch next from d into @astm_recid,@astm_position
						while @@fetch_status=0
							begin
								/*insert new record into parseIN table and link ID to RawIN table*/
								set @n=1 /*set count to be used as field names when updating*/
								while @n<=40 /*40 fields to fill in  parseIN table*/
									begin
										/*searching for delimiter "|", get first field*/
										if len(@tcp_string)<>0 and patindex('%|%', @tcp_string)<>0
											select @fld_value=substring(@tcp_string,1,patindex('%|%', @tcp_string)-1)
										else
											set @n=41
										if @n<=40
											begin
												/*build update statement for this one field value for field "@n"*/
												--set @sql = N'update _TCPDataAstmParseIN set ['+convert(nvarchar,@n)+']='''+@fld_value+''' where [id]='+convert(nvarchar,@insert_id)
												set @sql_set=@sql_set+'['+convert(nvarchar,@n)+']='''+@fld_value+''','
												--print @sql
												/*truncate tcp_string, first check that string has length*/
												if len(@tcp_string)<>0 and patindex('%|%', @tcp_string)<>0
													set @tcp_string=substring(@tcp_string,patindex('%|%', @tcp_string)+1, len(@tcp_string))
												else
													set @n=40
											end
										set @n=@n+1
									end	
								--update _TCPDataRawIN set dateparsed=getdate() where ID=@ID
								fetch next from d into @astm_recid,@astm_position
							end
						close d
						deallocate d
						if len(@sql_set)>0
						begin
							set @sql = 'update _TCPDataAstmParseIN set '+substring(@sql_set,1,len(@sql_set)-1)+' where [id]='+convert(nvarchar,@insert_id)
							exec (@sql)
						end
					end
				fetch next from c into @id, @tcp_string,@local_ip, @local_port, @remote_ip, @remote_port
			end
		close c
		deallocate c
		
	fetch next from B into @remote_IP, @remote_port, @local_ip, @local_port
end
close B
deallocate B









/*store all orders*/

/*store all results*/
