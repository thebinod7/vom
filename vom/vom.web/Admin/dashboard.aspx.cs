using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web.Admin
{
    public partial class dashboard : System.Web.UI.Page
    {
        //public string user_uuid;
        //public System.Data.DataRow user;
        protected void Page_Load(object sender, EventArgs e)
        {
            //user_uuid = Request.QueryString["user_uuid"];
            //System.Data.DataTable dt = vom.logic.dal.Factory.Employee.GetEmployee(new Guid(user_uuid));
            //if (dt.Rows.Count > 0)
            //{
            //    user = dt.Rows[0];
            //    if (Convert.ToBoolean(user["is_employee"]) == true)
            //    {
            //        Response.Redirect("~/Employee/default.aspx?user_uuid=" + user_uuid);
            //    }
            //    else
            //    {
            //        return;
            //    }
            //}
        }
    }
}