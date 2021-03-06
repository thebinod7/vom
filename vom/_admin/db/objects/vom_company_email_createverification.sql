USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_email_createverification]    Script Date: 7/2/2016 9:11:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_email_createverification]
(
	@email varchar(150),

	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @user_uuid uniqueidentifier
	DECLARE @verify_code uniqueidentifier
	
	SELECT @user_uuid=user_uuid FROM vom_company_emails WHERE email=@email

	IF (@user_uuid is null)
	BEGIN
		RAISERROR('Email does not exisit.', 16,1)
		RETURN
	END

	SET @verify_code=NEWID()
	INSERT INTO vom_company_verifications (user_uuid, verify_code,verify_type,email)
		VALUES (@user_uuid,@verify_code,'email',@email)
	SELECT @user_uuid AS uuid, @verify_code AS verify_code

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


