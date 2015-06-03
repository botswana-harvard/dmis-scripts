USE [BHPLAB]
GO
/****** Object:  Table [dbo].[_TCPDataAstmParseIN]    Script Date: 06/03/2015 15:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_TCPDataAstmParseIN](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[interface] [varchar](10) NULL,
	[remote_IP] [char](16) NULL,
	[remote_port] [char](10) NULL,
	[local_ip] [char](16) NULL,
	[local_port] [char](10) NULL,
	[ASTM_RECID] [varchar](1) NULL,
	[ASTM_POSITION] [varchar](10) NULL,
	[ASTM_MID] [varchar](25) NULL,
	[tcp_data_raw_in_ID] [int] NULL,
	[GUIDParsed] [uniqueidentifier] NULL,
	[ASTM_PID] [varchar](25) NULL CONSTRAINT [DF__TCPDataAstmParseIN_ASTM_PID]  DEFAULT ((-9)),
	[ASTM_HEADERDATE] [datetime] NULL CONSTRAINT [DF__TCPDataAstmParseIN_ASTM_HEADERDATE]  DEFAULT ('09/09/9999'),
	[ASTM_TESTID] [varchar](25) NULL CONSTRAINT [DF__TCPDataAstmParseIN_ASTM_TESTID]  DEFAULT ((-9)),
	[ASTM_IID] [varchar](25) NULL CONSTRAINT [DF__TCPDataAstmParseIN_ASTM_IID]  DEFAULT ((-9)),
	[ASTM_RESULT] [varchar](25) NULL CONSTRAINT [DF__TCPDataAstmParseIN_ASTM_RESULT]  DEFAULT ((-9)),
	[ASTM_FLAG] [varchar](25) NULL CONSTRAINT [DF__TCPDataAstmParseIN_ASTM_FLAG]  DEFAULT ((-9)),
	[RESULT_GUID] [uniqueidentifier] NULL CONSTRAINT [DF__TCPDataAstmParseIN_RESULT_GUID]  DEFAULT (newid()),
	[RESULT_SENT] [int] NULL CONSTRAINT [DF__TCPDataAstmParseIN_RESULT_SENT]  DEFAULT ((-9)),
	[1] [varchar](255) NULL,
	[2] [varchar](255) NULL,
	[3] [varchar](255) NULL,
	[4] [varchar](255) NULL,
	[5] [varchar](255) NULL,
	[6] [varchar](255) NULL,
	[7] [varchar](255) NULL,
	[8] [varchar](255) NULL,
	[9] [varchar](255) NULL,
	[10] [varchar](255) NULL,
	[11] [varchar](255) NULL,
	[12] [varchar](255) NULL,
	[13] [varchar](255) NULL,
	[14] [varchar](255) NULL,
	[15] [varchar](255) NULL,
	[16] [varchar](255) NULL,
	[17] [varchar](255) NULL,
	[18] [varchar](255) NULL,
	[19] [varchar](255) NULL,
	[20] [varchar](255) NULL,
	[21] [varchar](255) NULL,
	[22] [varchar](255) NULL,
	[23] [varchar](255) NULL,
	[24] [varchar](255) NULL,
	[25] [varchar](255) NULL,
	[26] [varchar](255) NULL,
	[27] [varchar](255) NULL,
	[28] [varchar](255) NULL,
	[29] [varchar](255) NULL,
	[30] [varchar](255) NULL,
	[31] [varchar](255) NULL,
	[32] [varchar](255) NULL,
	[33] [varchar](255) NULL,
	[34] [varchar](255) NULL,
	[35] [varchar](255) NULL,
	[36] [varchar](255) NULL,
	[37] [varchar](255) NULL,
	[38] [varchar](255) NULL,
	[39] [varchar](255) NULL,
	[40] [varchar](255) NULL,
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_QAReviewCode]  DEFAULT (1),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_dateCreated]  DEFAULT (getdate()),
	[datelastModified] [datetime] NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_datelastModified]  DEFAULT (getdate()),
	[version] [varchar](10) NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_version]  DEFAULT ('1.0'),
	[RID] [varchar](10) NOT NULL CONSTRAINT [DF__TCPDataAstmParseIN_RID]  DEFAULT ((-9)),
 CONSTRAINT [PK__TCPDataAstmParseIN] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
