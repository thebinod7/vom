using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vom.logic.dal
{
    public class Factory
    {
        public static db.DCompany Company
        {
            get { return new db.DCompany(); }
        }
        public static db.DCategory Category
        {
            get { return new db.DCategory(); }
        }
        public static db.DEmployee Employee
        {
            get { return new db.DEmployee(); }
        }
        public static db.DProject Project
        {
            get { return new db.DProject(); }
        }
        public static db.DTask Task
        {
            get { return new db.DTask(); }
        }
    }
}
