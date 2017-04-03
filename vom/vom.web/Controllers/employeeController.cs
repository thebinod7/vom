using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using RestSharp;
using Newtonsoft.Json.Linq;
using vom.logic;

namespace vom.web.Controllers
{
    [RoutePrefix("api/v1/employee")]
    public class employeeController : ApiController
    {
        [HttpPost]
        [Route("save")]
        public DataTable AddEmployee(Employees obj)
        {
            return vom.logic.dal.Factory.Employee.AddEmployee(obj);
        }

        [HttpPost]
        [Route("edit")]
        public DataTable EditEmpProfile(Employees obj)
        {
            return vom.logic.dal.Factory.Employee.EditEmpProfile(obj);
        }

        [HttpPost]
        [Route("getempdetails")]
        public DataTable GetEmployeeDetails(Employees obj)
        {
            return vom.logic.dal.Factory.Employee.GetEmployeeDetails(obj);
        }

        [HttpPost]
        [Route("{uuid}/remove_employee")]
        public DataTable RemoveEmployee(string uuid)
        {
            return vom.logic.dal.Factory.Employee.RemoveEmployee(uuid);
        }

        [HttpGet]
        [Route("{uuid}")]
        public DataTable GetEmployee(Guid user_uuid)
        {
            return vom.logic.dal.Factory.Employee.GetEmployee(user_uuid);
        }

        [HttpPost]
        [Route("list")]
        public DataTable ListEmployee(Employees obj)
        {
            return vom.logic.dal.Factory.Employee.ListEmployee(obj);
        }

        [HttpPost]
        [Route("change_emp_password")]
        public DataTable ChangeEmpPassword(Employees emp)
        {
            return vom.logic.dal.Factory.Employee.ChangeEmpPassword(emp);
        }

        [HttpPost]
        [Route("get_employee_uuid")]
        public DataTable GetEmployeeUUID(Employees obj)
        {
            return vom.logic.dal.Factory.Employee.GetEmployeeUUID(obj);
        }
    }
}
