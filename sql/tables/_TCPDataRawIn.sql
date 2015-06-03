USE [BHPLAB]
GO
/****** Object:  Table [dbo].[_TCPDataRawIn]    Script Date: 06/03/2015 15:43:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_TCPDataRawIn](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[local_ip] [char](16) NULL,
	[local_port] [char](10) NULL,
	[remote_IP] [char](16) NULL,
	[remote_port] [char](10) NULL,
	[datecreated] [datetime] NOT NULL CONSTRAINT [DF__TCP_datecreated]  DEFAULT (getdate()),
	[rsequence] [varchar](3) NULL,
	[tcp_string] [varchar](8000) NULL,
	[bytesTotal] [int] NULL,
	[dateserial] [int] NULL,
	[DateParsed] [datetime] NOT NULL CONSTRAINT [DF__TCPDataRawIn_DateParsed]  DEFAULT ('09/09/9999'),
	[GUIDParsed] [uniqueidentifier] NULL,
 CONSTRAINT [PK__TCPDataRawIn] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
