using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using rs.data;
using System.Net;
using System.Net.Mail;

namespace vom.logic.dal.db
{
    public class DEmployee
    {
        protected IDataProvider dp = DataProviderFactory.CreateDataProvider();
        public DataTable AddEmployee(Employees obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("emp_name", obj.emp_name, DbType.String);
            coll.Add("emp_salary", obj.emp_salary, DbType.Int64);
            coll.Add("email", obj.email, DbType.String);
            coll.Add("password", obj.password, DbType.String);
            coll.Add("emp_department", obj.emp_department, DbType.String);
            coll.Add("emp_phone_number", obj.emp_phone_number, DbType.Int64);
            coll.Add("emp_address", obj.emp_address, DbType.String);
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            DataTable dt = DbActions.GetTable(coll, "vom_employee_add", dp);
            DataRow r = dt.Rows[0];
            if (dt.Columns.Contains("verify_code"))
            {
                sendEmail(obj.email, "http://localhost:1156/verification.aspx?verify_code=" + r["verify_code"].ToString());
            }
            return dt;
        }
        //public DataTable EditEmployee(Employees obj)
        //{
        //    QueryParameterCollection coll = new QueryParameterCollection();
        //    coll.Add("uuid", obj.uuid, DbType.Guid);
        //    coll.Add("emp_name", obj.emp_name, DbType.String);
        //    coll.Add("emp_salary", obj.emp_salary, DbType.Int64);
        //    coll.Add("email", obj.email, DbType.String);
        //    coll.Add("password", obj.password, DbType.String);
        //    coll.Add("emp_department", obj.emp_department, DbType.String);
        //    coll.Add("emp_phone_number", obj.emp_phone_number, DbType.Int64);
        //    coll.Add("emp_address", obj.emp_address, DbType.String);
        //    DataTable dt = DbActions.GetTable(coll, "vom_employee_editprofile", dp);
        //    return dt;
        //}
        public DataTable ListEmployee(Employees obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("company_uuid", obj.company_uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_list", dp);
        }

        public DataTable ListEmployeeCount(Guid company_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@company_uuid", company_uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_count", dp);
        }

        public DataTable SalaryPaid()
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            return DbActions.GetTable(coll, "vom_employee_paid_salary", dp);
        }

        public DataTable GetEmployee(Guid user_uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("@user_uuid", user_uuid, DbType.Guid);
            return DbActions.GetTable(coll, "vom_employee_get", dp);
        }
        public DataTable GetEmployeeDetails(Employees obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("email", obj.email, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_getdetails", dp);
        }
        public DataTable RemoveEmployee(string uuid)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", uuid, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_remove", dp);
        }
        public void sendEmail(string to, string body)
        {
            var fromAddress = new MailAddress("develop@rumsan.net", "VOM Development Team");
            var toAddress = new MailAddress(to);
            const string fromPassword = "T$mp9670";
            const string subject = "Verify email & Change Password";

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
        public DataTable ChangeEmpPassword(Employees u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", u.uuid, DbType.Guid);
            coll.Add("old_password", u.password, DbType.String);
            coll.Add("new_password", u.new_password, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_changepassword", dp);
        }
        public DataTable EditEmpProfile(Employees u)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("uuid", u.uuid, DbType.Guid);
            coll.Add("emp_name", u.emp_name, DbType.String);
            coll.Add("emp_salary", u.emp_salary, DbType.Int64);
            coll.Add("emp_department", u.emp_department, DbType.String);
            coll.Add("emp_phone_number", u.emp_phone_number, DbType.Int64);
            coll.Add("emp_address", u.emp_address, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_editprofile", dp);
        }
        public DataTable GetEmployeeUUID(Employees obj)
        {
            QueryParameterCollection coll = new QueryParameterCollection();
            coll.Add("emp_name", obj.emp_name, DbType.String);
            return DbActions.GetTable(coll, "vom_employee_getuuid", dp);
        }
    }
}
