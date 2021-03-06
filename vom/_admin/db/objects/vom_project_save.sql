USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_save]    Script Date: 8/5/2016 1:00:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_project_save]
(
	@project_name varchar(100),
	@budget decimal(12,4),
	@status varchar(100),
	@project_desc varchar(500),
	@end_date date,
	@category_uuid uniqueidentifier,
	@company_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @uuid uniqueidentifier
	
	IF EXISTS(SELECT * FROM vom_project WHERE project_name=@project_name)
	BEGIN
		RAISERROR('Project Already Exist ! Please try new project.', 16,1)
	END

	ELSE
	BEGIN
		INSERT INTO vom_project (project_name,budget,status,project_desc,end_date,category_uuid,company_uuid)
			VALUES (@project_name,@budget,@status,@project_desc,@end_date,@category_uuid,@company_uuid)
		SET @id = SCOPE_IDENTITY()
		SELECT * FROM vom_project where id=@id 
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


