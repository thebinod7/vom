USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_resetpassword]    Script Date: 7/2/2016 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_resetpassword]
(
	@new_password varchar(100),
	@verify_code nvarchar(40),
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @uuid uniqueidentifier

	SELECT @uuid=user_uuid FROM vom_company_verifications where verify_code=@verify_code
		
	IF(@uuid is null)
		RAISERROR('Your have not access to change password', 16,1)
		UPDATE t_vom_company_verifications SET verify_type='email',used_date=GetDate() where verify_code=@verify_code
		UPDATE t_vom_company SET password=@new_password where uuid=@uuid

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

