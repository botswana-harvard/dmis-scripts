USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB21ResponseQ001X0]    Script Date: 05/25/2015 18:08:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB21ResponseQ001X0](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QID1X0] [uniqueidentifier] NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_QID1X0]  DEFAULT (newid()),
	[LID] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_LID]  DEFAULT ('-9'),
	[sample_assay_date] [varchar](30) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_sample_assay_date]  DEFAULT ('09/09/9999'),
	[UTESTID] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_UTESTID]  DEFAULT ('-9'),
	[RESULT] [varchar](100) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_RESULT]  DEFAULT ('-9'),
	[RESULT_QUANTIFIER] [varchar](2) NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_RESULT_QUANTIFIER]  DEFAULT ('='),
	[RESULT_FLAG_CALC] [varchar](5) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_RESULT_FLAG_CALC]  DEFAULT ('-9'),
	[RSEQUENCE] [int] NULL CONSTRAINT [DF_LAB21ResponseQ001X0_RSEQUENCE]  DEFAULT ((-9)),
	[flag] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_flag]  DEFAULT ('-9'),
	[STATUS] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_STATUS]  DEFAULT ('F'),
	[MID] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_MID]  DEFAULT ((-9)),
	[Comment] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_Comment]  DEFAULT ('-3'),
	[export_BatchID] [varchar](25) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_export_BatchID]  DEFAULT ((-9)),
	[validation_ref] [varchar](50) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_validation_ref]  DEFAULT ((-9)),
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_QAReviewCode]  DEFAULT ('1'),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NULL CONSTRAINT [DF_LAB21ResponseQ001X0_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateReceived] [datetime] NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_dateReceived]  DEFAULT (getdate()),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_dateCreated]  DEFAULT (getdate()),
	[dateLastModified] [datetime] NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_dateLastModified]  DEFAULT (getdate()),
	[version] [varchar](50) NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_version]  DEFAULT ('1.0'),
	[RID] [varchar](15) NOT NULL CONSTRAINT [DF_LAB21ResponseQ001X0_rid]  DEFAULT ('-9'),
	[ABS_RESULT] [varchar](25) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[LAB21ResponseQ001X0]  WITH NOCHECK ADD  CONSTRAINT [FK_LAB21ResponseQ001X0_LAB21Response] FOREIGN KEY([QID1X0])
REFERENCES [dbo].[LAB21Response] ([Q001X0])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LAB21ResponseQ001X0] CHECK CONSTRAINT [FK_LAB21ResponseQ001X0_LAB21Response]
