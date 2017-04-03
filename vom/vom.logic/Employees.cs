using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vom.logic
{
    public class Employees
    {
        public int id { get; set; }
        public Guid uuid { get; set; }
        public string emp_name { get; set; }
        public int emp_salary { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string emp_department { get; set; }
        public int emp_phone_number { get; set; }
        public string emp_address { get; set; }
        public string verify_code { get; set; }
        public string ip_address { get; set; }
        public string new_password { get; set; }
        public string company_uuid { get; set; }
    }
}
