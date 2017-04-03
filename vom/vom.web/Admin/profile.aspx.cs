using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web.Admin
{
    public partial class editprofile : System.Web.UI.Page
    {
        public string user_uuid;
        public System.Data.DataRow company;
        public int lenght;
        protected void Page_Load(object sender, EventArgs e)
        {
            user_uuid = Request.QueryString["user_uuid"];
            DataTable dt = vom.logic.dal.Factory.Company.GetCompanyUser(new Guid(user_uuid));
            lenght = dt.Rows.Count;
            if (dt.Rows.Count > 0)
            {
                company = dt.Rows[0];
            }
        }
    }
}