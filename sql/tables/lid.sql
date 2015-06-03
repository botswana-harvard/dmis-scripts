USE [BHPLAB]
GO
/****** Object:  Table [dbo].[_LID]    Script Date: 05/25/2015 18:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_LID](
	[lid_int] [int] IDENTITY(1,1) NOT NULL,
	[LID] [varchar](16) NOT NULL,
	[TID] [varchar](6) NULL CONSTRAINT [DF__LID_TID]  DEFAULT ('-9'),
	[datecreated] [datetime] NULL CONSTRAINT [DF__LID_datecreated]  DEFAULT (getdate()),
	[datelastmodified] [datetime] NULL CONSTRAINT [DF__LID_datelastmodified]  DEFAULT (getdate()),
	[keyopcreated] [varchar](50) NULL CONSTRAINT [DF__LID_keyopcreated]  DEFAULT (suser_sname()),
	[keyoplastmodified] [varchar](50) NULL CONSTRAINT [DF__LID_keyoplastmodified]  DEFAULT (suser_sname()),
	[prefix0] [char](1) NOT NULL CONSTRAINT [DF__LID_prefix_0]  DEFAULT ('A'),
	[PID] [varchar](16) NULL CONSTRAINT [DF__LID_PID]  DEFAULT ('-9'),
	[dateallocated] [datetime] NULL CONSTRAINT [DF__LID_dateallocated]  DEFAULT ('09/09/9999'),
	[Comment] [varchar](50) NULL,
	[RID] [int] NOT NULL CONSTRAINT [DF__LID_RID]  DEFAULT ((0)),
 CONSTRAINT [PK__LID] PRIMARY KEY CLUSTERED 
(
	[LID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
