USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_signup]    Script Date: 7/2/2016 8:58:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_signup]
(
	@company_name varchar(100),
	@owner_name varchar(100),
	@email varchar(100),
	@password varchar(100),
	@website_url varchar(150),
	@contact_number varchar(150),
	@company_address varchar(150),
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @uuid uniqueidentifier
	DECLARE @verify_code uniqueidentifier
	
	IF EXISTS(SELECT * FROM vom_company WHERE email=@email)
	BEGIN
		RAISERROR('Email Already Exist ! Please try new email.', 16,1)
	END

	ELSE
	BEGIN
		INSERT INTO vom_company (company_name,owner_name,email,website_url,password,contact_number,company_address)
			VALUES (@company_name,@owner_name,@email,@website_url,@password,@contact_number,@company_address)
		SET @id = SCOPE_IDENTITY()
		SELECT @uuid=uuid FROM vom_company where id=@id
		INSERT INTO vom_company_emails (user_uuid,email) VALUES (@uuid,@email)
		SET @verify_code=NEWID()
		INSERT INTO vom_company_verifications (user_uuid, verify_code,verify_type,email)
			VALUES (@uuid,@verify_code,'email',@email)
		SELECT @uuid AS uuid, @verify_code AS verify_code
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


