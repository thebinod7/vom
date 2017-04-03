using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vom.logic
{
    public class Project
    {
        public int id { get; set; }
        public Guid uuid { get; set; }
        public string project_name { get; set; }
        public decimal budget { get; set; }
        public string status { get; set; }
        public string project_desc { get; set; }
        public DateTime end_date { get; set; }
        public string category_uuid { get; set; }
        public string company_uuid { get; set; }
    }
}
