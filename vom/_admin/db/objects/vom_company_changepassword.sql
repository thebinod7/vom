USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_changepassword]    Script Date: 7/2/2016 9:12:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_changepassword]
(
	@uuid uniqueidentifier,
	@old_password varchar(100),
	@new_password varchar(100),
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN

	IF EXISTS(SELECT * FROM vom_company where uuid=@uuid and password=@old_password)
		BEGIN
		UPDATE t_vom_company SET password=@new_password where uuid=@uuid
		SELECT @uuid as uuid
		END
		
	ELSE
		BEGIN
		RAISERROR('Your old password is Incorrect', 16,1)
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

