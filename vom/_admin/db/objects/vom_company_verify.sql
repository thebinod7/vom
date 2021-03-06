USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_verify]    Script Date: 7/2/2016 9:09:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[vom_company_verify]
(
	@verify_code nvarchar(40),
	@ip_address nvarchar(100)
)
AS
BEGIN TRY
	BEGIN TRAN
	DECLARE @id bigint
	DECLARE @uuid uniqueidentifier
	DECLARE @verify_type varchar(20)
	DECLARE @email nvarchar(150)
	DECLARE @phone nvarchar(50)

	SELECT @uuid=user_uuid,@verify_type=verify_type,@email=email,@phone=phone 
		FROM t_vom_company_verifications where verify_code=@verify_code
	
	IF(@uuid is null)
		RAISERROR('Invalid verification code', 16,1)

	UPDATE t_vom_company_verifications SET used_date=GetDate(),ip_address=@ip_address WHERE user_uuid=@uuid
	UPDATE t_vom_company_emails SET is_verified=1,verified_date=GetDate() WHERE user_uuid=@uuid and email=@email


	SELECT @uuid AS uuid, @verify_type AS verify_type

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


