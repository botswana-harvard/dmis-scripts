USE [BHPLAB]
GO
/****** Object:  Table [dbo].[LAB01Response]    Script Date: 05/25/2015 18:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LAB01Response](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[archived] [int] NOT NULL CONSTRAINT [DF_LAB01Response_archived]  DEFAULT ((2)),
	[protocolnumber] [varchar](7) NOT NULL CONSTRAINT [DF_LAB01Response_protocolnumber]  DEFAULT ('-9'),
	[headerdate] [datetime] NOT NULL CONSTRAINT [DF_LAB01Response_headerdate]  DEFAULT ('09/09/9999'),
	[PID] [varchar](16) NOT NULL CONSTRAINT [DF_LAB01Response_PID]  DEFAULT ('-9'),
	[TID] [varchar](6) NULL CONSTRAINT [DF_LAB01Response_TID]  DEFAULT ('-9'),
	[pinitials] [varchar](3) NULL CONSTRAINT [DF_LAB01Response_pinitials]  DEFAULT ('-9'),
	[visitid] [varchar](10) NULL CONSTRAINT [DF_LAB01Response_visitid]  DEFAULT ((-9)),
	[SiteID] [int] NULL CONSTRAINT [DF_LAB01Response_SiteID]  DEFAULT ((-9)),
	[SeqID] [int] NOT NULL CONSTRAINT [DF_LAB01Response_SeqID]  DEFAULT ('-9'),
	[PAT_ID] [varchar](25) NULL CONSTRAINT [DF_LAB01Response_PAT_ID]  DEFAULT ('-9'),
	[OTHER_PAT_REF] [varchar](50) NULL CONSTRAINT [DF_LAB01Response_OTHER_PAT_REF]  DEFAULT ((-9)),
	[OTHER_PAT_REF2] [varchar](25) NULL CONSTRAINT [DF_LAB01Response_OTHER_PAT_REF2]  DEFAULT ('-9'),
	[gender] [varchar](2) NULL CONSTRAINT [DF_LAB01Response_gender]  DEFAULT ('-9'),
	[DOB] [datetime] NULL CONSTRAINT [DF_LAB01Response_DOB]  DEFAULT ('09/09/9999'),
	[Q005X0] [int] NULL CONSTRAINT [DF_LAB01Response_Q005X0]  DEFAULT ((-9)),
	[Q006X0] [uniqueidentifier] NULL CONSTRAINT [DF_LAB01Response_QID6X0]  DEFAULT (newid()),
	[IPMS_Barcode] [int] NULL CONSTRAINT [DF_LAB01Response_IPMS_Barcode]  DEFAULT ((-9)),
	[IPMS_sample_ref] [varchar](25) NULL CONSTRAINT [DF_LAB01Response_IPMS_sample_ref]  DEFAULT ((-9)),
	[sample_time_received] [varchar](5) NULL CONSTRAINT [DF_LAB01Response_sample_time_received]  DEFAULT ((-9)),
	[sample_date_drawn] [datetime] NULL CONSTRAINT [DF_LAB01Response_sample_date_drawn]  DEFAULT ('09/09/9999'),
	[sample_time_drawn] [varchar](5) NULL CONSTRAINT [DF_LAB01Response_sample_time_drawn]  DEFAULT ((-9)),
	[sample_site_id] [varchar](10) NULL CONSTRAINT [DF_LAB01Response_sample_site_id]  DEFAULT ((-9)),
	[sample_clinician_initials] [varchar](3) NULL CONSTRAINT [DF_LAB01Response_sample_clinician_initials]  DEFAULT ((-9)),
	[sample_protocolnumber] [varchar](10) NULL CONSTRAINT [DF_LAB01Response_sample_protocolnumber]  DEFAULT ('-9'),
	[sample_billingcode] [varchar](10) NULL CONSTRAINT [DF_LAB01Response_sample_billingcode]  DEFAULT ('-9'),
	[sample_type_id] [varchar](25) NULL CONSTRAINT [DF_LAB01Response_sample_type]  DEFAULT ('-9'),
	[sample_tubes_received] [int] NULL CONSTRAINT [DF_LAB01Response_sample_tubes_received]  DEFAULT ((-9)),
	[sample_volume] [varchar](25) NULL CONSTRAINT [DF_LAB01Response_sample_volume]  DEFAULT ((-9.0)),
	[sample_condition] [int] NULL CONSTRAINT [DF_LAB01Response_sample_condition]  DEFAULT ((10)),
	[sample_priority] [int] NULL CONSTRAINT [DF_LAB01Response_sample_priority]  DEFAULT ('-9'),
	[sample_tray_id] [int] NULL CONSTRAINT [DF_LAB01Response_sample_tray_id]  DEFAULT ((-9)),
	[sample_visitid] [varchar](10) NULL CONSTRAINT [DF_LAB01Response_sample_visitid]  DEFAULT ((-9)),
	[sample_comment] [varchar](100) NULL CONSTRAINT [DF_LAB01Response_sample_comment]  DEFAULT ('-9'),
	[QAReviewCode] [int] NOT NULL CONSTRAINT [DF_LAB01Response_QAReviewCode]  DEFAULT ('1'),
	[KeyOpCreated] [varchar](50) NOT NULL CONSTRAINT [DF_LAB01Response_KeyOpCreated]  DEFAULT ('-9'),
	[KeyOpLastModified] [varchar](50) NOT NULL CONSTRAINT [DF_LAB01Response_KeyOpLastModified]  DEFAULT ('-9'),
	[dateReceived] [datetime] NULL CONSTRAINT [DF_LAB01Response_dateReceived]  DEFAULT ('09/09/9999'),
	[dateCreated] [datetime] NOT NULL CONSTRAINT [DF_LAB01Response_dateCreated]  DEFAULT ('09/09/9999'),
	[dateLastModified] [datetime] NOT NULL CONSTRAINT [DF_LAB01Response_dateLastModified]  DEFAULT ('09/09/9999'),
	[version] [varchar](50) NOT NULL CONSTRAINT [DF_LAB01Response_version]  DEFAULT ('-9'),
	[SampleAge]  AS (datediff(day,[sample_date_drawn],getdate())),
	[testing_received] [int] NULL CONSTRAINT [DF_LAB01Response_testing_received]  DEFAULT ((-9)),
	[testing_date_received] [datetime] NULL CONSTRAINT [DF_LAB01Response_testing_date_received]  DEFAULT (((9)/(9))/(9999)),
	[testing_time_received] [varchar](5) NULL CONSTRAINT [DF_LAB01Response_testing_time_received]  DEFAULT ((-9)),
	[Q001X0]  AS ([PAT_ID]),
	[testing_results_approved] [int] NULL CONSTRAINT [DF_LAB01Response_sent_for _analysis]  DEFAULT ((-9)),
	[machine_serial_number] [varchar](50) NULL,
	[record_sta] [int] NOT NULL CONSTRAINT [DF_LAB01Response_record_sta]  DEFAULT ((23)),
	[remote_cmp]  AS ([ID]),
	[time_stamp] [datetime] NULL,
	[RID] [varchar](10) NULL,
	[astm_send_batchID] [int] NOT NULL CONSTRAINT [DF_LAB01Response_astm_send_batchID]  DEFAULT ((-9)),
	[GRN] [varchar](10) NOT NULL CONSTRAINT [DF_LAB01Response_GRN]  DEFAULT ('-9'),
	[CINITIALS] [varchar](10) NULL CONSTRAINT [DF__LAB01Resp__CINIT__38F19DCC]  DEFAULT ('-9'),
	[batch_id] [int] NULL,
	[edc_specimen_identifier] [varchar](25) NULL,
	[LID]  AS ([PID]),
 CONSTRAINT [PK_LAB01Response] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_LAB01Response_7] UNIQUE NONCLUSTERED 
(
	[Q006X0] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
