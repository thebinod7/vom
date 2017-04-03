USE db_VOM
GO
-- NEWID()
-- GETDATE()

vom_table_create 'vom_company','
	[uuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_vom_company_uuid] DEFAULT ((NEWID())),
	[company_name] [varchar](100) NOT NULL,
	[owner_name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[website_url] [varchar](150) NULL,
	[contact_number] [varchar](150) NULL,
	[company_address] [varchar](150) NULL
'


vom_table_create 'vom_employee','
	[uuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_vom_employee_uuid] DEFAULT ((NEWID())),
	[emp_name] [varchar](100) NOT NULL,
	[emp_salary] bigint NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[emp_department] [varchar](100) NULL,
	[emp_phone_number] [bigint]  NULL,
	[emp_address] [varchar](100) NULL,
	[company_uuid] [uniqueidentifier],
	[is_employee] [bit] DEFAULT (1)
'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_t_vom_employee] ON [dbo].[t_vom_employee]
(
	[email] ASC
)

vom_table_create 'vom_project','
	[uuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_vom_project_uuid] DEFAULT ((NEWID())),
	[project_name] [varchar](100) NOT NULL,
	[budget] decimal(12,4) NULL,
	[status] [varchar](100) NOT NULL,
	[project_desc] [varchar](200) NULL,
	[end_date] date NULL,
	[category_uuid] [uniqueidentifier] NOT NULL,
	[company_uuid] [uniqueidentifier] NOT NULL
'
--GO
--CREATE UNIQUE NONCLUSTERED INDEX [IX_t_vom_project] ON [dbo].[t_vom_project]
--(
--	[project_name] ASC
--)

vom_table_create 'vom_task','
	[uuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_vom_task_uuid] DEFAULT ((NEWID())),
	[task_name] [varchar](100) NOT NULL,
	[start_date] date DEFAULT (getdate()),
	[due_date] date NULL,
	[progress] [varchar] (100) NULL,
	[status] [varchar](100) NULL,
	[task_desc] [varchar](200) NULL,
	[project_uuid] [uniqueidentifier] NOT NULL,
	[employee_uuid] [uniqueidentifier] NOT NULL,
	[assigner_uuid] [uniqueidentifier] NOT NULL,
	[company_uuid] [uniqueidentifier] NOT NULL
'


vom_table_create 'vom_category','
	[uuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_vom_category_uuid] DEFAULT ((NEWID())),
	[category_name] [varchar](100) NOT NULL,
	[category_desc] [varchar] (500) NULL,
	[company_uuid] [uniqueidentifier] NOT NULL
'

--GO
--CREATE UNIQUE NONCLUSTERED INDEX [IX_t_vom_category] ON [dbo].[t_vom_category]
--(
--	[category_name] ASC
--)
