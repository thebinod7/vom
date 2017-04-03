USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_get]    Script Date: 8/4/2016 9:41:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[vom_project_get]
(
	@project_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
BEGIN TRAN
	
	SELECT * FROM vom_project where uuid=@project_uuid and is_active=1

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
