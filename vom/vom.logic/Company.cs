using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vom.logic
{
    public class Company
    {
        public int id { get; set; }
        public Guid uuid { get; set; }
        public string company_name { get; set; }
        public string owner_name { get; set; }
        public string website_url { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string contact_number { get; set; }
        public string company_address { get; set; }
        public string new_password { get; set; }
        public string verify_code { get; set; }
        public string ip_address { get; set; }
    }
}
