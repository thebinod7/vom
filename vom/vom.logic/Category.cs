using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vom.logic
{
    public class Category
    {
        public int id { get; set; }
        public Guid uuid { get; set; }
        public string category_name { get; set; }
        public string category_desc { get; set; }
        public string company_uuid { get; set; }
    }
}
