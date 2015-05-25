USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB01ResponseQ001X0]    Script Date: 05/25/2015 18:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB01ResponseQ001X0](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QID1X0] [uniqueidentifier] NOT NULL,
	[orderID] [int] NULL CONSTRAINT [DF_LAB01ResponseQ001X0_orderID]  DEFAULT ((-9)),
	[orderPanelID] [varchar](25) NULL CONSTRAINT [DF_LAB01ResponseQ001X0_orderPanelID]  DEFAULT ('-9'),
	[orderDate] [datetime] NULL CONSTRAINT [DF_LAB01ResponseQ001X0_orderDate]  DEFAULT ('09/09/9999'),
	[orderStatus] [int] NULL CONSTRAINT [DF_LAB01ResponseQ001X0_orderStatus]  DEFAULT (0),
	[orderComment] [varchar](250) NULL CONSTRAINT [DF_LAB01ResponseQ001X0_orderComment]  DEFAULT ('-9'),
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_QAReviewCode]  DEFAULT (1),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateReceived] [datetime] NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_dateReceived]  DEFAULT (getdate()),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_dateCreated]  DEFAULT (getdate()),
	[dateLastModified] [datetime] NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_dateLastModified]  DEFAULT (getdate()),
	[version] [varchar](50) NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_version]  DEFAULT ('1.0'),
	[RID] [varchar](15) NOT NULL CONSTRAINT [DF_LAB01ResponseQ001X0_RID]  DEFAULT ('-9'),
 CONSTRAINT [IX_LAB01ResponseQ001X0] UNIQUE NONCLUSTERED 
(
	[orderID] ASC,
	[QID1X0] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_LAB01ResponseQ001X0_1] UNIQUE NONCLUSTERED 
(
	[QID1X0] ASC,
	[orderID] ASC,
	[orderPanelID] ASC,
	[orderDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_LAB01ResponseQ001X0_2] UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[LAB01ResponseQ001X0]  WITH CHECK ADD  CONSTRAINT [FK_LAB01ResponseQ001X0_LAB01Response] FOREIGN KEY([QID1X0])
REFERENCES [dbo].[LAB01Response] ([Q006X0])
GO
ALTER TABLE [dbo].[LAB01ResponseQ001X0] CHECK CONSTRAINT [FK_LAB01ResponseQ001X0_LAB01Response]
