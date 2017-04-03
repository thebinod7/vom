using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using RestSharp;
using vom.logic;
using Newtonsoft.Json.Linq;

namespace vom.web.Controllers
{
    [RoutePrefix("api/v1/task")]
    public class taskController : ApiController
    {
        [HttpPost]
        [Route("add")]
        public DataTable AddTask(Task obj)
        {
            return vom.logic.dal.Factory.Task.AddTask(obj);
        }

        [HttpPost]
        [Route("edit")]
        public DataTable EditTask(Task obj)
        {
            return vom.logic.dal.Factory.Task.EditTask(obj);
        }

        [HttpPost]
        [Route("{uuid}/remove_task")]
        public DataTable RemoveTask(string uuid)
        {
            return vom.logic.dal.Factory.Task.RemoveTask(uuid);
        }

        [HttpGet]
        [Route("{task_uuid}")]
        public DataTable GetTask(Guid task_uuid)
        {
            return vom.logic.dal.Factory.Task.GetTask(task_uuid);
        }

        [HttpGet]
        [Route("{emp_uuid}/get_assigned_task")]
        public DataTable GetAssignedTask(Guid emp_uuid)
        {
            return vom.logic.dal.Factory.Task.GetAssignedTask(emp_uuid);
        }

        [HttpGet]
        [Route("search/{search_text}/{emp_uuid}")]
        public DataTable SearchTask(string search_text, Guid emp_uuid)
        {
            return vom.logic.dal.Factory.Task.SearchTask(search_text,emp_uuid);
        }

        [HttpPost]
        [Route("list")]
        public DataTable ListTask(Task obj)
        {
            return vom.logic.dal.Factory.Task.ListTask(obj);
        }

        [HttpGet]
        [Route("{flag}/{emp_uuid}")]
        public DataTable GetTaskByFlag(string flag, Guid emp_uuid)
        {
            return vom.logic.dal.Factory.Task.GetTaskByFlag(flag,emp_uuid);
        }
    }
}
