USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB21Response]    Script Date: 05/25/2015 18:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB21Response](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [varchar](25) NOT NULL CONSTRAINT [DF_LAB21Response_pid]  DEFAULT ('-9'),
	[ORDERID] [int] NULL CONSTRAINT [DF_LAB21Response_ORDERID]  DEFAULT ((-9)),
	[ORIGINAL_LID] [varchar](25) NULL CONSTRAINT [DF_LAB21Response_ORIGINAL_LID]  DEFAULT ((-9)),
	[Q001X0] [uniqueidentifier] NOT NULL CONSTRAINT [DF_LAB21Response_Q001X0]  DEFAULT (newid()),
	[PROTOCOLNUMBER] [varchar](15) NOT NULL CONSTRAINT [DF_LAB21Response_PROTOCOLNUMBER]  DEFAULT ('BHPLAB'),
	[HEADERDATE] [datetime] NOT NULL CONSTRAINT [DF_LAB21Response_headerdate]  DEFAULT ('09/09/9999'),
	[REPORTDATE] [varchar](20) NOT NULL CONSTRAINT [DF_LAB21Response_RESULTDATE]  DEFAULT ('09/09/9999'),
	[PINITIALS] [varchar](3) NOT NULL CONSTRAINT [DF_LAB21Response_pinitials]  DEFAULT ('-9'),
	[SITEID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB21Response_siteid]  DEFAULT ('-9'),
	[VISITID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB21Response_visitid]  DEFAULT ('-9'),
	[SEQID] [int] NOT NULL CONSTRAINT [DF_LAB21Response_seqid]  DEFAULT ((1)),
	[TID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB21Response_tid]  DEFAULT ('-9'),
	[TESTPROFILE] [varchar](25) NOT NULL CONSTRAINT [DF_LAB21Response_TESTPROFILE]  DEFAULT ('-9'),
	[result_guid] [uniqueidentifier] NULL CONSTRAINT [DF_LAB21Response_result_guid]  DEFAULT (newid()),
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF_LAB21Response_QAReviewCode]  DEFAULT ((1)),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF_LAB21Response_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NOT NULL CONSTRAINT [DF_LAB21Response_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateReceived] [datetime] NOT NULL CONSTRAINT [DF_LAB21Response_dateReceived]  DEFAULT (getdate()),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF_LAB21Response_dateCreated]  DEFAULT (getdate()),
	[dateLastModified] [datetime] NOT NULL CONSTRAINT [DF_LAB21Response_dateLastModified]  DEFAULT (getdate()),
	[version] [varchar](50) NOT NULL CONSTRAINT [DF_LAB21Response_version]  DEFAULT ('1.0'),
	[RID] [varchar](50) NOT NULL CONSTRAINT [DF_LAB21Response_rid]  DEFAULT ('-9'),
	[CINITIALS] [varchar](10) NULL CONSTRAINT [DF__LAB21Resp__CINIT__51BD4B96]  DEFAULT ('-9'),
	[panel_id] [varchar](25) NULL DEFAULT ('-9'),
 CONSTRAINT [PK_LAB21Response] PRIMARY KEY CLUSTERED 
(
	[PID] ASC,
	[HEADERDATE] ASC,
	[TID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_LAB21Response_4] UNIQUE NONCLUSTERED 
(
	[Q001X0] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
