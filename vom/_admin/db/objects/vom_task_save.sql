USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_task_save]    Script Date: 8/16/2016 9:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_task_save]
(
	@task_name varchar(100),
	@start_date date,
	@due_date date,
	@progress varchar(100),
	@status varchar(100),
	@task_desc varchar(200),
	@project_uuid uniqueidentifier,
	@employee_uuid uniqueidentifier,
	@assigner_uuid uniqueidentifier,
	@company_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @uuid uniqueidentifier
	
	BEGIN
		INSERT INTO vom_task (task_name,start_date,due_date,progress,status,task_desc,project_uuid,employee_uuid,assigner_uuid,company_uuid)
			VALUES (@task_name,@start_date,@due_date,@progress,@status,@task_desc,@project_uuid,@employee_uuid,@assigner_uuid,@company_uuid)
		SET @id = SCOPE_IDENTITY()
		SELECT * FROM vom_task where id=@id 
	END
	COMMIT TRAN
END TRY
BEGIN CATCH
   IF @@TRANCOUNT > 0
   BEGIN
       ROLLBACK 
       
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
   END
END CATCH


