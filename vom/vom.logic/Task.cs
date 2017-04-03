using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vom.logic
{
    public class Task
    {
        public int id { get; set; }
        public Guid uuid { get; set; }
        public string task_name { get; set; }
        public DateTime start_date { get; set; }
        public DateTime due_date { get; set; }
        public string progress { get; set; }
        public string status { get; set; }
        public string task_desc { get; set; }
        public string project_uuid { get; set; }
        public string employee_uuid { get; set; }
        public string assigner_uuid { get; set; }
        public string flag { get; set; }
        public string search_text { get; set; }
        public string company_uuid { get; set; }
    }
}
