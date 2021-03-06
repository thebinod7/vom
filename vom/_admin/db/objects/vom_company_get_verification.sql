USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_get_verification]    Script Date: 7/2/2016 9:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_get_verification]
(
	@verify_code varchar(150)
	
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @uuid uniqueidentifier
	
	SELECT * FROM vom_company_verifications where verify_code=@verify_code

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


