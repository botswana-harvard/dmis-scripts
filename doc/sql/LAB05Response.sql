USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB05Response]    Script Date: 05/25/2015 18:10:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB05Response](
	[result_guid] [uniqueidentifier] NOT NULL,
	[RID] [varchar](7) NULL CONSTRAINT [DF_LAB05Response_RID]  DEFAULT ((-9)),
	[LID] [varchar](7) NULL CONSTRAINT [DF_LAB05Response_LID]  DEFAULT ((-9)),
	[result_accepted] [int] NULL CONSTRAINT [DF_LAB05Response_result_accepted]  DEFAULT (0),
	[result_accepted_username] [varchar](50) NULL CONSTRAINT [DF_LAB05Response_result_accepted_username]  DEFAULT ((-9)),
	[result_accessed_date] [datetime] NULL CONSTRAINT [DF_LAB05Response_result_accessed_date]  DEFAULT ('09/09/9999'),
	[result_printed] [int] NULL CONSTRAINT [DF_LAB05Response_result_printed]  DEFAULT (0),
	[result_printed_date] [datetime] NULL CONSTRAINT [DF_LAB05Response_result_printed_date]  DEFAULT ('09/09/9999'),
	[result_image_printed] [int] NULL CONSTRAINT [DF_LAB05Response_result_image_printed]  DEFAULT ((-9)),
	[result_image_printed_date] [datetime] NULL CONSTRAINT [DF_LAB05Response_result_image_printed_date]  DEFAULT ('09/09/9999'),
	[result_print_batchID] [int] NULL CONSTRAINT [DF_LAB05Response_result_print_batchID]  DEFAULT ((-9)),
	[export_flag01_exported] [int] NULL CONSTRAINT [DF_LAB05Response_export_flag01_exported]  DEFAULT (0),
	[export_flag01_batch] [int] NULL CONSTRAINT [DF_LAB05Response_export_flag01_batch]  DEFAULT ((-9)),
	[export_flag01_destination] [varchar](25) NULL CONSTRAINT [DF_LAB05Response_export_flag01_destination]  DEFAULT ((-9)),
	[export_flag01_date] [datetime] NULL CONSTRAINT [DF_LAB05Response_export_flag01_date]  DEFAULT ('09/09/9999'),
	[flag02A] [varchar](10) NULL CONSTRAINT [DF_LAB05Response_flag02A]  DEFAULT ('-9'),
	[flag02B] [varchar](10) NULL CONSTRAINT [DF_LAB05Response_flag02B]  DEFAULT ('-9'),
	[flag02C] [varchar](10) NULL CONSTRAINT [DF_LAB05Response_flag02C]  DEFAULT ('-9'),
	[flag02D] [varchar](10) NULL CONSTRAINT [DF_LAB05Response_flag02D]  DEFAULT ('-9'),
	[flag02Z] [varchar](10) NULL CONSTRAINT [DF_LAB05Response_flag02Z]  DEFAULT ('-9'),
	[KeyOpCreated] [varchar](50) NULL CONSTRAINT [DF_LAB05Response_KeyOpCreated]  DEFAULT (suser_sname()),
	[KeyOpLastModified] [varchar](50) NULL CONSTRAINT [DF_LAB05Response_KeyOpLastModified]  DEFAULT (suser_sname()),
	[dateCreated] [datetime] NULL CONSTRAINT [DF_LAB05Response_dateCreated]  DEFAULT (getdate()),
	[dateLastModified] [datetime] NULL CONSTRAINT [DF_LAB05Response_dateLastModified]  DEFAULT (getdate()),
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[CINITIALS] [varchar](10) NULL DEFAULT ('-9'),
 CONSTRAINT [PK_LAB05Response] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
