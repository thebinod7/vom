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
    [RoutePrefix("api/v1/project")]
    public class projectController : ApiController
    {
        [HttpPost]
        [Route("save")]
        public DataTable SaveProject(Project obj)
        {
            return vom.logic.dal.Factory.Project.SaveProject(obj);
        }

        [HttpPost]
        [Route("edit")]
        public DataTable EditProject(Project obj)
        {
            return vom.logic.dal.Factory.Project.EditProject(obj);
        }

        [HttpPost]
        [Route("{uuid}/remove_project")]
        public DataTable RemoveProject(string uuid)
        {
            return vom.logic.dal.Factory.Project.RemoveProject(uuid);
        }

        [HttpGet]
        [Route("{project_uuid}")]
        public DataTable GetProject(Guid project_uuid)
        {
            return vom.logic.dal.Factory.Project.GetProject(project_uuid);
        }

        [HttpPost]
        [Route("list")]
        public DataTable ListProject(Project obj)
        {
            return vom.logic.dal.Factory.Project.ListProject(obj);
        }

        [HttpGet]
        [Route("list_revenue")]
        public DataTable ListProjectRevenue()
        {
            return vom.logic.dal.Factory.Project.ListProjectRevenue();
        }

        [HttpPost]
        [Route("get_project_uuid")]
        public DataTable GetProjectUUID(Project obj)
        {
            return vom.logic.dal.Factory.Project.GetProjectUUID(obj);
        }
    }
}
