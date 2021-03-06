USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_employee_editprofile]    Script Date: 8/10/2016 9:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_employee_editprofile]
(
	@uuid uniqueidentifier,
	@emp_name varchar(100),
	@emp_salary bigint,
	@emp_department varchar(100),
	@emp_phone_number bigint,
	@emp_address varchar(100),
	@session_id bigint = null
)

AS
BEGIN TRY
	BEGIN TRAN
	
	UPDATE t_vom_employee SET emp_name=@emp_name, emp_salary=@emp_salary, emp_department=@emp_department, 
	emp_phone_number=@emp_phone_number, emp_address=@emp_address WHERE uuid=@uuid
	
	SELECT * FROM t_vom_employee where uuid=@uuid

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

