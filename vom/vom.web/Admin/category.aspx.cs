using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web.Admin
{
    public partial class category : System.Web.UI.Page
    {
        public string user_uuid;
        public System.Data.DataRow user;
        public int length;
        protected void Page_Load(object sender, EventArgs e)
        {
            //user_uuid = Request.QueryString["user_uuid"];
            //DataTable dt = vom.logic.dal.Factory.Category.ListCategory(user_uuid);
            //length = dt.Rows.Count;
            //if (dt.Rows.Count > 0)
            //{
            //    user = dt.Rows[0];
            //}
        }
    }
}