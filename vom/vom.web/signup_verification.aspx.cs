using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web
{
    public partial class signup_verification : System.Web.UI.Page
    {
        public string uuid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["verify_code"] != null)
            {
                string verify_code = Request.QueryString["verify_code"].ToString();
                DataTable dt = vom.logic.dal.Factory.Company.Verify(verify_code,"Not Implemented");
                uuid = dt.Rows[0]["uuid"].ToString();
                if (uuid != "")
                {
                    Response.Redirect("Admin/dashboard.aspx?user_uuid=" + uuid);
                    Response.End();
                }
                Response.Write("Not Implemented");
            }
        }
    }
}