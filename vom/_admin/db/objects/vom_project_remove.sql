USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_remove]    Script Date: 8/4/2016 9:52:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[vom_project_remove]
(
	@uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	BEGIN
		update t_vom_project set is_active=0 WHERE uuid=@uuid 
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


