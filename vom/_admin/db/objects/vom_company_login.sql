USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_login]    Script Date: 8/6/2016 8:05:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[vom_company_login]
(
	@email nvarchar(40),
	@password nvarchar(100)
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @uuid uniqueidentifier
	DECLARE @is_verified bit

	SELECT @uuid=uuid FROM vom_employee where email=@email and password=@password
	IF (@uuid is not null)
		Begin
					SELECT @is_verified=is_verified from vom_company_emails where email=@email
					SELECT @is_verified as is_verified, * from vom_employee where @uuid=uuid
		END
	ELSE
			   SELECT @uuid=uuid FROM vom_company where email=@email and password=@password
			   IF (@uuid is not null)
				BEGIN
					SELECT @is_verified=is_verified from vom_company_emails where email=@email
					SELECT @is_verified as is_verified, * from vom_company where @uuid=uuid
				END
			 ELSE
				BEGIN
					RAISERROR('Username or Password not match ', 16,1)
		End
	
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


