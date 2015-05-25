USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB23Response]    Script Date: 05/25/2015 18:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB23Response](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB23Response_pid]  DEFAULT ('-9'),
	[operator] [varchar](25) NULL CONSTRAINT [DF_LAB23Response_operator]  DEFAULT ('-9'),
	[Q001X0] [uniqueidentifier] NOT NULL CONSTRAINT [DF_LAB23Response_Q001X0]  DEFAULT (newid()),
	[UTESTID] [varchar](10) NULL CONSTRAINT [DF_LAB23Response_UTESTID]  DEFAULT ('-9'),
	[BATCHID] [varchar](20) NULL,
	[sample_assay_date] [datetime] NULL CONSTRAINT [DF_LAB23Response_sample_assay_date]  DEFAULT ('09/09/9999'),
	[sample_assay_time] [varchar](5) NULL CONSTRAINT [DF_LAB23Response_sample_assay_time]  DEFAULT ('-9'),
	[machine_id] [varchar](50) NULL CONSTRAINT [DF_LAB23Response_MID]  DEFAULT ('-9'),
	[PROTOCOLNUMBER] [varchar](15) NOT NULL,
	[HEADERDATE] [datetime] NOT NULL CONSTRAINT [DF_LAB23Response_headerdate]  DEFAULT ('09/09/9999'),
	[PINITIALS] [varchar](3) NOT NULL CONSTRAINT [DF_LAB23Response_pinitials]  DEFAULT ('-9'),
	[SITEID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB23Response_siteid]  DEFAULT ((-9)),
	[VISITID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB23Response_visitid]  DEFAULT ('-9'),
	[SEQID] [int] NOT NULL CONSTRAINT [DF_LAB23Response_seqid]  DEFAULT ((-9)),
	[TID] [varchar](10) NOT NULL CONSTRAINT [DF_LAB23Response_tid]  DEFAULT ('-9'),
	[display_rows] [int] NOT NULL CONSTRAINT [DF_LAB23Response_display_rows]  DEFAULT (5),
	[sample_count] [int] NOT NULL CONSTRAINT [DF_LAB23Response_samples_count]  DEFAULT (1),
	[results_per_sample] [int] NOT NULL CONSTRAINT [DF_LAB23Response_results_per_sample]  DEFAULT (1),
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF_LAB23Response_QAReviewCode]  DEFAULT ('1'),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF_LAB23Response_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NOT NULL CONSTRAINT [DF_LAB23Response_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateReceived] [datetime] NOT NULL CONSTRAINT [DF_LAB23Response_dateReceived]  DEFAULT (getdate()),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF_LAB23Response_dateCreated]  DEFAULT (getdate()),
	[dateLastModified] [datetime] NOT NULL CONSTRAINT [DF_LAB23Response_dateLastModified]  DEFAULT (getdate()),
	[version] [varchar](10) NOT NULL CONSTRAINT [DF_LAB23Response_version]  DEFAULT ('1.0'),
	[RID] [varchar](15) NOT NULL CONSTRAINT [DF_LAB23Response_rid]  DEFAULT ('-9'),
	[L21_GUID] [uniqueidentifier] NULL,
	[CINITIALS] [varchar](10) NULL CONSTRAINT [DF__LAB23Resp__CINIT__595E6D5E]  DEFAULT ('-9'),
 CONSTRAINT [PK_LAB23Response] PRIMARY KEY NONCLUSTERED 
(
	[PID] ASC,
	[HEADERDATE] ASC,
	[SEQID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_LAB23Response_1] UNIQUE NONCLUSTERED 
(
	[Q001X0] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
