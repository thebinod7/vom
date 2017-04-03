using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using rs.data;
using System.Data;

namespace vom.logic.dal.db
{
    public class DProject
    {
        protected IDataProvider dp = DataProviderFactory.CreateDataProvider();
        public DataTable SaveProject(Project obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("project_name", obj.project_name, DbType.String);
            coll.Add("budget", obj.budget, DbType.Decimal);
            coll.Add("status", obj.status, DbType.String);
            coll.Add("project_desc", obj.project_desc, DbType.String);
            coll.Add("end_date", obj.end_date, DbType.DateTime);
            coll.Add("category_uuid", obj.category_uuid, DbType.String);
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_project_save", dp);
            return dt;
        }
        public DataTable EditProject(Project obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", obj.uuid, DbType.Guid);
            coll.Add("project_name", obj.project_name, DbType.String);
            coll.Add("budget", obj.budget, DbType.Decimal);
            coll.Add("status", obj.status, DbType.String);
            coll.Add("project_desc", obj.project_desc, DbType.String);
            coll.Add("end_date", obj.end_date, DbType.Date);
            coll.Add("category_uuid", obj.category_uuid, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_project_edit", dp);
            return dt;
        }
        public DataTable RemoveProject(string uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_project_remove", dp);
        }
        public DataTable ListProject(Project obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_project_list", dp);
        }

        public DataTable ListProjectRevenue()
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            return DbActions.GetTable(coll, "vom_project_total_revenue", dp);
        }

        public DataTable ListProjectCompleted()
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            return DbActions.GetTable(coll, "vom_project_completed", dp);
        }
        public DataTable ListProjectInProgress()
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            return DbActions.GetTable(coll, "vom_project_inprogress", dp);
        }

        public DataTable GetProject(Guid project_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@project_uuid", project_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_project_get", dp);
        }
        public DataTable GetProjectUUID(Project obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("project_name", obj.project_name, DbType.String);
            return DbActions.GetTable(coll, "vom_project_getuuid", dp);
        }
    }
}
