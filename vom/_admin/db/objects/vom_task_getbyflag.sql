USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_task_getbyflag]    Script Date: 8/21/2016 10:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_task_getbyflag]
(
	@flag varchar(100),
	@emp_uuid uniqueidentifier
)
AS
BEGIN TRY
BEGIN TRAN
	
	if(@flag = 'Done')
	Begin
		 select * from t_vom_task where employee_uuid=@emp_uuid and status = 'Done' and is_active = 1
	End

	else if (@flag = 'Inprogress')
	Begin
	     select * from t_vom_task where employee_uuid=@emp_uuid and status = 'In Progress' and status != 'Ready' and is_active = 1
	End

		else if (@flag = 'Late')
	Begin
	     select * from t_vom_task where employee_uuid=@emp_uuid and due_date < GETDATE() and status != 'Done' and is_active = 1
	End

			else if (@flag = 'DueToday')
	Begin
	     select * from t_vom_task where employee_uuid=@emp_uuid and due_date = GETDATE() and status != 'Done' and is_active = 1
	End

	else 

	Begin
	 select * from t_vom_task where employee_uuid=@emp_uuid and is_active = 1 and status != 'Done'
	End


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

