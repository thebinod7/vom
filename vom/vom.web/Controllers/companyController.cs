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
    [RoutePrefix("api/v1/company")]
    public class companyController : ApiController
    {
        [HttpPost]
        [Route("signup")]
        public DataTable Signup(Company user)
        {
            return vom.logic.dal.Factory.Company.Signup(user);
        }

        [HttpPost]
        [Route("create_admin")]
        public DataTable Create_Admin(Company user)
        {
            return vom.logic.dal.Factory.Company.Create_Admin(user);
        }

        [HttpPost]
        [Route("editprofile")]
        public DataTable Editprofile(Company user)
        {
            return vom.logic.dal.Factory.Company.EditProfile(user);
        }

        [HttpPost]
        [Route("login")]
        public DataTable Login(Company user)
        {
            return vom.logic.dal.Factory.Company.Login(user);
        }

        [HttpPost]
        [Route("changepassword")]
        public DataTable Changepassword(Company user)
        {
            return vom.logic.dal.Factory.Company.ChangePassword(user);
        }

        [HttpGet]
        [Route("verify/{verify_code}")]
        public DataTable Verify(string verify_code, string ip_address)
        {
            return vom.logic.dal.Factory.Company.Verify(verify_code, ip_address);
        }
     

        [HttpPost]
        [Route("reset_password")]
        public DataTable Resetpassword(Company user)
        {
            return vom.logic.dal.Factory.Company.ResetPassword(user);
        }

        [HttpPost]
        [Route("forgetpassword")]
        public DataTable Forgetpassword(Company user)
        {
            return vom.logic.dal.Factory.Company.ForgetPassword(user);
        }

        [HttpGet]
        [Route("{user_uuid}")]
        public DataTable Get(Guid user_uuid)
        {
            return vom.logic.dal.Factory.Company.GetCompanyUser(user_uuid);
        }

        [HttpGet]
        [Route("verification/{verify_code}")]
        public DataTable Verificationget(string verify_code)
        {
            return vom.logic.dal.Factory.Company.GetVerification(verify_code);
        }
        [HttpPost]
        [Route("email_verify")]
        public void Company_Email_Verify(Company user)
        {
            vom.logic.dal.Factory.Company.Company_Email_Verify(user);
        }

        [HttpGet]
        [Route("list_admin")]
        public DataTable ListAdmin()
        {
            return vom.logic.dal.Factory.Company.ListAdmin();
        }

        [HttpPost]
        [Route("{uuid}/remove_admin")]
        public DataTable RemoveAdmin(string uuid)
        {
            return vom.logic.dal.Factory.Company.RemoveAdmin(uuid);
        }
    }
}
