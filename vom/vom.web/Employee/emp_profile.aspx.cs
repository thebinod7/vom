using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web.Employee
{
    public partial class emp_profile : System.Web.UI.Page
    {
        public string user_uuid;
        public System.Data.DataRow user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user_uuid = Request.QueryString["user_uuid"];
            System.Data.DataTable dt = vom.logic.dal.Factory.Employee.GetEmployee(new Guid(user_uuid));
            if (dt.Rows.Count > 0)
            {
                user = dt.Rows[0];
            }
        }
    }
}