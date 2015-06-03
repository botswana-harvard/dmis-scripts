USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB23ResponseQ001X0]    Script Date: 05/25/2015 18:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB23ResponseQ001X0](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QID1X0] [uniqueidentifier] NOT NULL,
	[BHHRL_REF] [varchar](25) NULL CONSTRAINT [DF_LAB23ResponseQ001X0_BHHRL_REF]  DEFAULT ('-9'),
	[RESULT] [varchar](15) NULL CONSTRAINT [DF_LAB23ResponseQ001X0_RESULT]  DEFAULT ('-9'),
	[RESULT_QUANTIFIER] [varchar](2) NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_RESULT_QUANTIFIER]  DEFAULT ('='),
	[result_guid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_result_guid]  DEFAULT (newid()),
	[RESULT_UNITS] [varchar](15) NULL CONSTRAINT [DF_LAB23ResponseQ001X0_RESULT_UNITS]  DEFAULT ('-9'),
	[RESULT_UTESTID] [varchar](15) NULL CONSTRAINT [DF_LAB23ResponseQ001X0_RESULT_UTESTID]  DEFAULT ('-9'),
	[result_accepted] [int] NULL CONSTRAINT [DF_LAB23ResponseQ001X0_result_accepted]  DEFAULT ((-9)),
	[checkbatch_user] [varchar](50) NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_checkbatch_user]  DEFAULT ((-9)),
	[datesent] [datetime] NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_datesent]  DEFAULT ('09/09/9999'),
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_QAReviewCode]  DEFAULT ('1'),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateReceived] [datetime] NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_dateReceived]  DEFAULT (getdate()),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_dateCreated]  DEFAULT (getdate()),
	[dateLastModified] [datetime] NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_dateLastModified]  DEFAULT (getdate()),
	[version] [varchar](10) NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_version]  DEFAULT ('1.0'),
	[RID] [varchar](15) NOT NULL CONSTRAINT [DF_LAB23ResponseQ001X0_rid]  DEFAULT ('-9')
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[LAB23ResponseQ001X0]  WITH NOCHECK ADD  CONSTRAINT [FK_LAB23ResponseQ001X0_LAB23Response] FOREIGN KEY([QID1X0])
REFERENCES [dbo].[LAB23Response] ([Q001X0])
GO
ALTER TABLE [dbo].[LAB23ResponseQ001X0] CHECK CONSTRAINT [FK_LAB23ResponseQ001X0_LAB23Response]
