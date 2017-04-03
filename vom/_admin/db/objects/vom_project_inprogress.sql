USE [db_VOM]
GO
/****** Object:  StoredProcedure [dbo].[vom_project_inprogress]    Script Date: 8/20/2016 5:12:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

Create PROCEDURE [dbo].[vom_project_inprogress]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(Distinct id) as InProgressProjects from t_vom_project where status='In Progress' and is_active =1 
END
