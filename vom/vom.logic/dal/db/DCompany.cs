using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using rs.data;
using System.Net.Mail;
using System.Net;
using System.Data;

namespace vom.logic.dal.db
{
    public class DCompany
    {
        protected IDataProvider dp = DataProviderFactory.CreateDataProvider();

        public DataTable Signup(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("company_name", u.company_name, DbType.String);
            coll.Add("owner_name", u.owner_name, DbType.String);
            coll.Add("email", u.email, DbType.String);
            coll.Add("password", u.password, DbType.String);
            coll.Add("website_url", u.website_url, DbType.String);          
            coll.Add("contact_number", u.contact_number, DbType.String);
            coll.Add("company_address", u.company_address, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_company_signup", dp);
            DataRow r = dt.Rows[0];
            if (dt.Columns.Contains("verify_code"))
            {
                sendEmail(u.email, "http://localhost:1156/verification.aspx?verify_code=" + r["verify_code"].ToString());
            }
            return dt;
        }
        public DataTable Login(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("email", u.email, DbType.String);
            coll.Add("password", u.password, DbType.String);
            return DbActions.GetTable(coll, "vom_company_login", dp);
        }
        public void sendEmail(string to, string body)
        {
            var fromAddress = new MailAddress("develop@rumsan.net", "VOM Development Team");
            var toAddress = new MailAddress(to);
            const string fromPassword = "T$mp9670";
            const string subject = "Please verify email";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body
            })
            {
                smtp.Send(message);
            }
        }
        public DataTable ChangePassword(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", u.uuid, DbType.Guid);
            coll.Add("old_password", u.password, DbType.String);
            coll.Add("new_password", u.new_password, DbType.String);
            return DbActions.GetTable(coll, "vom_company_changepassword", dp);
        }
        public DataTable EditProfile(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", u.uuid, DbType.Guid);
            coll.Add("company_name", u.company_name, DbType.String);
            coll.Add("owner_name", u.owner_name, DbType.String);
            coll.Add("website_url", u.website_url, DbType.String);
            coll.Add("contact_number", u.contact_number, DbType.String);
            coll.Add("company_address", u.company_address, DbType.String);
            return DbActions.GetTable(coll, "vom_company_editprofile", dp);
        }
        public DataTable Verify(string verify_code, string ip_address)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("verify_code", verify_code, DbType.String);
            coll.Add("ip_address", ip_address, DbType.String);
            return DbActions.GetTable(coll, "vom_company_verify", dp);
        }
        public DataTable ResetPassword(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("new_password", u.new_password, DbType.String);
            coll.Add("verify_code", u.verify_code, DbType.String);
            return DbActions.GetTable(coll, "vom_company_resetpassword", dp);
        }
        public DataTable ForgetPassword(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("email", u.email, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_company_forgetpassword", dp);
            DataRow r = dt.Rows[0];
            if (dt.Columns.Contains("verify_code"))
            {
                sendEmail(u.email, "http://localhost:1156/verification.aspx?verify_code=" + r["verify_code"].ToString());
            }
            return dt;
        }
        public DataTable GetCompanyUser(Guid user_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@user_uuid", user_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_company_getuser", dp);
        }
        public DataTable GetVerification(string verify_code)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@verify_code", verify_code, DbType.String);
            return DbActions.GetTable(coll, "vom_company_get_verification", dp);
        }
        public void Company_Email_Verify(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("email", u.email, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_company_email_createverification", dp);
            DataRow r = dt.Rows[0];
            if (dt.Columns.Contains("verify_code"))
            {
                sendEmail(u.email, "http://localhost:1156/verification.aspx?verify_code=" + r["verify_code"].ToString());
            }

        }
        public DataTable Create_Admin(Company u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("company_name", u.company_name, DbType.String);
            coll.Add("owner_name", u.owner_name, DbType.String);
            coll.Add("email", u.email, DbType.String);
            coll.Add("password", u.password, DbType.String);
            coll.Add("website_url", u.website_url, DbType.String);
            coll.Add("contact_number", u.contact_number, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_company_create_admin", dp);
            DataRow r = dt.Rows[0];
            if (dt.Columns.Contains("verify_code"))
            {
                sendEmail(u.email, "http://localhost:1156/verification.aspx?verify_code=" + r["verify_code"].ToString());
            }
            return dt;
        }
        public DataTable ListAdmin()
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            return DbActions.GetTable(coll, "vom_admin_list", dp);
        }
        public DataTable RemoveAdmin(string uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_admin_remove", dp);
        }
    }
}
