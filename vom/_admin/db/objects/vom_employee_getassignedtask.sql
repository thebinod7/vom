USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_employee_getassignedtask]    Script Date: 8/15/2016 7:39:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[vom_employee_getassignedtask]
(
	@emp_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
BEGIN TRAN
	
	Select * from vom_task where employee_uuid=@emp_uuid and is_active=1 and status != 'Done'

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

