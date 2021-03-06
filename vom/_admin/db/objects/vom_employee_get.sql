USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_employee_get]    Script Date: 8/6/2016 10:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_employee_get]
(
	@emp_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
DECLARE @is_verified bit
DECLARE @verify_code nvarchar(40)
	
	select @is_verified=is_verified from vom_company_emails where user_uuid=@emp_uuid
	SELECT *, @is_verified as is_verified FROM t_vom_employee where uuid=@emp_uuid

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


