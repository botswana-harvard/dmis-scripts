USE [BHPLAB]
GO
/****** Object:  Table [dbo].[_lab_log]    Script Date: 05/25/2015 18:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_lab_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[log_object] [varchar](50) NULL,
	[log_comment] [varchar](100) NULL,
	[datecreated] [datetime] NULL CONSTRAINT [DF__lab_log_datecreated]  DEFAULT (getdate()),
	[keyopcreated] [varchar](50) NULL CONSTRAINT [DF__lab_log_keyopcreated]  DEFAULT (suser_sname()),
 CONSTRAINT [PK__lab_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
