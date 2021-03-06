USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_editprofile]    Script Date: 7/2/2016 9:11:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_editprofile]
(
	@uuid uniqueidentifier,
	@company_name varchar(100),
	@owner_name varchar(100),
	@website_url varchar(150),
	@contact_number varchar(100),
	@company_address varchar(100),
	@session_id bigint = null
)

AS
BEGIN TRY
	BEGIN TRAN
	
	UPDATE t_vom_company SET company_name=@company_name, owner_name=@owner_name, website_url=@website_url, 
	contact_number=@contact_number, company_address=@company_address WHERE uuid=@uuid
	
	SELECT * FROM t_vom_company where uuid=@uuid

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

