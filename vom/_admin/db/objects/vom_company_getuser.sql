USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_company_getuser]    Script Date: 7/2/2016 9:10:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[vom_company_getuser]
(
	@uuid uniqueidentifier,
	@session_id bigint = null
)
AS
BEGIN TRY
BEGIN TRAN
DECLARE @is_verified bit
DECLARE @verify_code nvarchar(40)
	
	select @is_verified=is_verified from vom_company_emails where user_uuid=@uuid
	SELECT *, @is_verified as is_verified FROM vom_company where uuid=@uuid

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



