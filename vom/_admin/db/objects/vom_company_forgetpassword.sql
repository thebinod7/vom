USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_forgetpassword]    Script Date: 7/2/2016 9:11:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_forgetpassword]
(
	@email varchar(150)
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @uuid uniqueidentifier
	DECLARE @verify_code uniqueidentifier
	
	SELECT @uuid=user_uuid FROM t_vom_company_emails WHERE email=@email
	IF(@uuid is not null)
	BEGIN
		SET @verify_code=NEWID()
		INSERT INTO vom_company_verifications (user_uuid, verify_code,verify_type,email)
		VALUES (@uuid,@verify_code,'forget_pwd',@email)
		SELECT @uuid as uuid, @verify_code as verify_code
	END
	ELSE
	BEGIN
		RAISERROR('Your Email is Incorrect ! Please type correct email. ', 16,1)
	END
	COMMIT TRAN
END TRY
BEGIN CATCH
   IF @@TRANCOUNT > 0
   BEGIN
       ROLLBACK 
       
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS Errovomeverity,
			ERROR_STATE() AS Errovomtate,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
   END
END CATCH


