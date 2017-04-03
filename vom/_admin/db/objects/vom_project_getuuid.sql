USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_getuuid]    Script Date: 8/13/2016 7:24:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[vom_project_getuuid]
(
	@project_name varchar(100),
	@session_id bigint = null
)
AS
BEGIN TRY
BEGIN TRAN
	
	SELECT uuid FROM vom_project where project_name=@project_name

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

