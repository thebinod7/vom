USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_category_save]    Script Date: 8/5/2016 7:49:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[vom_category_save]
(
	@category_name varchar(100),
	@category_desc varchar(500),
	@company_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @uuid uniqueidentifier
	
	
	BEGIN
		INSERT INTO vom_category (category_name,category_desc,company_uuid)
			VALUES (@category_name,@category_desc,@company_uuid)
		SET @id = SCOPE_IDENTITY()
		SELECT * FROM vom_category where id=@id 
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


