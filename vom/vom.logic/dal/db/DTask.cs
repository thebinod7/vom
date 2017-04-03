using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using rs.data;

namespace vom.logic.dal.db
{
    public class DTask
    {
        protected IDataProvider dp = DataProviderFactory.CreateDataProvider();
        public DataTable AddTask(Task obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("task_name", obj.task_name, DbType.String);
            coll.Add("start_date", obj.start_date, DbType.Date);
            coll.Add("due_date", obj.due_date, DbType.Date);
            coll.Add("progress", obj.progress, DbType.String);
            coll.Add("status", obj.status, DbType.String);
            coll.Add("task_desc", obj.task_desc, DbType.String);
            coll.Add("project_uuid", obj.project_uuid, DbType.String);
            coll.Add("employee_uuid", obj.employee_uuid, DbType.String);
            coll.Add("assigner_uuid", obj.assigner_uuid, DbType.String);
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_task_save", dp);
            return dt;
        }

        public DataTable EditTask(Task obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", obj.uuid, DbType.Guid);
            coll.Add("task_name", obj.task_name, DbType.String);
            coll.Add("progress", obj.progress, DbType.String);
            coll.Add("status", obj.status, DbType.String);
            coll.Add("due_date", obj.due_date, DbType.Date);
            coll.Add("task_desc", obj.task_desc, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_task_edit", dp);
            return dt;
        }
        public DataTable RemoveTask(string uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_task_remove", dp);
        }
        public DataTable ListTask(Task obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_task_list", dp);
        }

        public DataTable ListTaskCompleted()
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            return DbActions.GetTable(coll, "vom_task_completed_count", dp);
        }

        public DataTable GetTask(Guid task_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@task_uuid", task_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_task_get", dp);
        }
        public DataTable SearchTask(string search_text, Guid emp_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@search_text", search_text, DbType.String);
            coll.Add("@emp_uuid", emp_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_task_search", dp);
        }
        public DataTable GetAssignedTask(Guid emp_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@emp_uuid", emp_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_employee_getassignedtask", dp);
        }
        public DataTable GetTaskByFlag(string flag, Guid emp_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@emp_uuid", emp_uuid, DbType.Guid);
            coll.Add("@flag", flag, DbType.String);
            return DbActions.GetTable(coll, "vom_task_getbyflag", dp);
        }
    }
}
