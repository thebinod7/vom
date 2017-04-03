USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_category_getuuid]    Script Date: 8/5/2016 8:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[vom_category_getuuid]
(
	@category_name varchar(100),
	@session_id bigint = null
)
AS
BEGIN TRY
BEGIN TRAN
	
	SELECT uuid FROM vom_category where category_name=@category_name

COMMIT TRAN
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH

