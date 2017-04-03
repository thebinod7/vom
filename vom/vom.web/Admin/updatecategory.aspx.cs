using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web.Admin
{
    public partial class updatecategory : System.Web.UI.Page
    {
        public string category_uuid;
        public System.Data.DataRow category;
        public int lenght;
        protected void Page_Load(object sender, EventArgs e)
        {
            //category_uuid = Request.QueryString["category_uuid"];
            //DataTable dt = vom.logic.dal.Factory.Category.GetCategory(new Guid(category_uuid));
            //lenght = dt.Rows.Count;
            //if (dt.Rows.Count > 0)
            //{
            //    category = dt.Rows[0];
            //}
        }
    }
}