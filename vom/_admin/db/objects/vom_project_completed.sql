USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_completed]    Script Date: 8/18/2016 10:16:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

ALTER PROCEDURE [dbo].[vom_project_completed]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(Distinct id) as TotalProjects from t_vom_project where status='Closed' and is_active =1 
END
