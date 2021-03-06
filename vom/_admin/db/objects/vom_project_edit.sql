USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_edit]    Script Date: 8/5/2016 12:33:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_project_edit]
(
	@uuid uniqueidentifier,
	@project_name varchar(100),
	@budget decimal(12,4),
	@status varchar(100),
	@project_desc varchar(500),
	@end_date date,
	@category_uuid uniqueidentifier,
	@session_id bigint = null
)

AS
BEGIN TRY
	BEGIN TRAN
	
	UPDATE t_vom_project SET project_name=@project_name,budget=@budget,status=@status,project_desc=@project_desc, 
	end_date=@end_date, category_uuid=@category_uuid WHERE uuid=@uuid
	
	SELECT * FROM t_vom_project where uuid=@uuid

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

