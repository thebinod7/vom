USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_employee_add]    Script Date: 7/31/2016 12:08:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_employee_add]
(
	@emp_name varchar(100),
	@emp_salary varchar(100),
	@email varchar(150),
	@password varchar(100),
	@emp_department varchar(100),
	@emp_phone_number bigint,
	@emp_address varchar(100),
	@company_uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @uuid uniqueidentifier
	DECLARE @verify_code uniqueidentifier
	
	IF EXISTS(SELECT * FROM vom_company WHERE email=@email)
	BEGIN
		RAISERROR('Email Already Exist ! Please try new email.', 16,1)
	END

	IF EXISTS(SELECT * FROM vom_employee WHERE email=@email)
	BEGIN
		RAISERROR('Email Already Exist ! Please try new email.', 16,1)
	END

	ELSE
	BEGIN
		INSERT INTO vom_employee(emp_name,emp_salary,email,password,emp_department,emp_phone_number,emp_address,company_uuid)
			VALUES (@emp_name,@emp_salary,@email,@password,@emp_department,@emp_phone_number,@emp_address,@company_uuid)
		SET @id = SCOPE_IDENTITY()
		SELECT @uuid=uuid FROM vom_employee where id=@id
		INSERT INTO vom_company_emails(user_uuid,email) VALUES (@uuid,@email)
		SET @verify_code=NEWID()
		INSERT INTO vom_company_verifications(user_uuid, verify_code,verify_type,email)
			VALUES (@uuid,@verify_code,'added',@email)
		SELECT @uuid AS uuid, @verify_code AS verify_code
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


