USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_employee_getdetails]    Script Date: 8/1/2016 9:39:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_employee_getdetails]
(
	@email nvarchar(100),
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
DECLARE @is_verified bit
DECLARE @verify_code nvarchar(40)
	
	select @is_verified=is_verified from vom_company_emails where email=@email
	SELECT *, @is_verified as is_verified FROM t_vom_employee where email=@email

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


