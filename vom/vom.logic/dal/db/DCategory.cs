using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using rs.data;
using System.Data;

namespace vom.logic.dal.db
{
    public class DCategory
    {
        protected IDataProvider dp = DataProviderFactory.CreateDataProvider();
        public DataTable SaveCategory(Category obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("category_name", obj.category_name, DbType.String);
            coll.Add("category_desc", obj.category_desc, DbType.String);
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_category_save", dp);
            return dt;
        }
        public DataTable EditCategory(Category obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", obj.uuid, DbType.Guid);
            coll.Add("category_name", obj.category_name, DbType.String);
            coll.Add("category_desc", obj.category_desc, DbType.String);
            return DbActions.GetTable(coll, "vom_category_edit", dp);
        }
        public DataTable RemoveCategory(string uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_category_remove", dp);
        }
        public DataTable ListCategory(Category obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_category_list", dp);
        }
        public DataTable GetCategory(Guid category_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@category_uuid", category_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_category_get", dp);
        }
        public DataTable GetCategoryUUID(Category obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("category_name", obj.category_name, DbType.String);
            return DbActions.GetTable(coll, "vom_category_getuuid", dp);
        }
    }
}
