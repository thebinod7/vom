using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace vom.web
{
    public partial class verification : System.Web.UI.Page
    {
        public string verify_type;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["verify_code"] != null)
            {
                string verify_code = Request.QueryString["verify_code"].ToString();
                DataTable dt = vom.logic.dal.Factory.Company.GetVerification(verify_code);
                verify_type = dt.Rows[0]["verify_type"].ToString();
                if (verify_type == "email")
                {
                    Response.Redirect("signup_verification.aspx?verify_code=" + verify_code);
                    Response.End();
                }
                if (verify_type == "added")
                {
                    Response.Redirect("employee_verification.aspx?verify_code=" + verify_code);
                    Response.End();
                }
                if (verify_type == "forget_pwd")
                {
                    Response.Redirect("resetpassword.aspx?verify_code=" + verify_code);
                    Response.End();
                }
                Response.Write("Not Implemented");
            }
        }
    }
}