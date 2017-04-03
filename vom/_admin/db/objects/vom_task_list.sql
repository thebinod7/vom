USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_task_list]    Script Date: 9/1/2016 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_task_list]
(
	@company_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
BEGIN TRAN
	
	SELECT * FROM vom_task where company_uuid=@company_uuid and is_active=1

COMMIT TRAN
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH

