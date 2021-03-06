USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_category_edit]    Script Date: 7/30/2016 9:31:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_category_edit]
(
	@uuid uniqueidentifier,
	@category_name varchar(100),
	@category_desc varchar(500),
	@session_id bigint = null
)

AS
BEGIN TRY
	BEGIN TRAN
	
	UPDATE t_vom_category SET category_name=@category_name, category_desc=@category_desc WHERE uuid=@uuid
	
	SELECT * FROM t_vom_category where uuid=@uuid

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

