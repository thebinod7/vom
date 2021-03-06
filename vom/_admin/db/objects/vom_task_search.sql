USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_task_search]    Script Date: 8/24/2016 8:30:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_task_search]
(
	@search_text varchar(200),
	@emp_uuid uniqueidentifier
)
AS
BEGIN TRY
BEGIN TRAN

		select * from t_vom_task where task_name like '%' + @search_text + '%' and is_active = 1 and employee_uuid = @emp_uuid

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

