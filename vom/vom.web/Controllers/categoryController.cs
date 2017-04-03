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
    [RoutePrefix("api/v1/category")]
    public class categoryController : ApiController
    {
        [HttpPost]
        [Route("save")]
        public DataTable SaveCategory(Category obj)
        {
            return vom.logic.dal.Factory.Category.SaveCategory(obj);
        }

        [HttpPost]
        [Route("edit")]
        public DataTable EditCategory(Category obj)
        {
            return vom.logic.dal.Factory.Category.EditCategory(obj);
        }

        [HttpPost]
        [Route("{uuid}/remove_category")]
        public DataTable RemoveCategory(string uuid)
        {
            return vom.logic.dal.Factory.Category.RemoveCategory(uuid);
        }

        [HttpPost]
        [Route("get_category_uuid")]
        public DataTable GetCategoryUUID(Category obj)
        {
            return vom.logic.dal.Factory.Category.GetCategoryUUID(obj);
        }

        [HttpGet]
        [Route("{category_uuid}")]
        public DataTable GetCategory(Guid category_uuid)
        {
            return vom.logic.dal.Factory.Category.GetCategory(category_uuid);
        }

        [HttpPost]
        [Route("list")]
        public DataTable ListCategory(Category obj)
        {
            return vom.logic.dal.Factory.Category.ListCategory(obj);
        }
    }
}
