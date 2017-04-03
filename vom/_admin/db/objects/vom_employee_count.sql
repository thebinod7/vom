USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_employee_count]    Script Date: 8/18/2016 10:16:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

Alter PROCEDURE [dbo].[vom_employee_count]

	@company_uuid uniqueidentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(Distinct id) as TotalEmp from t_vom_employee where is_active =1 and company_uuid=@company_uuid
END
