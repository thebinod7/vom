USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_table_create]    Script Date: 7/2/2016 9:08:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[vom_table_create] (
	@tbl_name as varchar(60),
	@fields as varchar(MAX) = null
)
AS
SET NOCOUNT ON
	Declare @sql as varchar(MAX)
	declare @dbName varchar(255)
	set @dbName=DB_NAME();

	IF(@fields is not null)
			SET @fields = @fields + ','
			
	IF EXISTS(SELECT * FROM sys.objects where name=@tbl_name)
	BEGIN
		PRINT 'ERROR: ' + @tbl_name + ' already exists'
		RETURN
	END

	SET @sql=@dbName + '..sp_executesql N''CREATE TABLE [t_'+ @tbl_name +'] (
			[id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,' +
			@fields +
			'[is_active] [bit] NOT NULL CONSTRAINT [DF_t_'+ @tbl_name +'_is_active]  DEFAULT ((1)),
			[date_added] [datetime] NOT NULL CONSTRAINT [DF_t_'+ @tbl_name +'_date_added]  DEFAULT (getdate()),
			[last_tran] [bigint] NULL
		) ON [PRIMARY]'''
	exec(@sql)

	set @sql=@dbName + '..sp_executesql N''CREATE VIEW ['+ @tbl_name +']
		AS
		SELECT * FROM [t_'+ @tbl_name +'] where is_active=1
		'''
	exec(@sql)
