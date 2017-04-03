<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="update_employee.aspx.cs" Inherits="vom.web.Admin.update_employee" %>

<script runat="server">
    public string user_uuid;
    public System.Data.DataRow user;
    public string emp_uuid;
    public System.Data.DataRow employee;
    protected void Page_Load(object sender, EventArgs e)
    {
        emp_uuid = Request.QueryString["emp_uuid"];
        System.Data.DataTable dt_emp = vom.logic.dal.Factory.Employee.GetEmployee(new Guid(emp_uuid));
        if (dt_emp.Rows.Count > 0)
        {
            employee = dt_emp.Rows[0];
        }
        
        user_uuid = Request.QueryString["user_uuid"];
        System.Data.DataTable dt = vom.logic.dal.Factory.Company.GetCompanyUser(new Guid(user_uuid));
        if (dt.Rows.Count > 0)
        {
            user = dt.Rows[0];
        }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="header_resource" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-6">
                <h2><strong>Update employee details</strong></h2>
                <hr />
                <div id="message_alert"></div>
                <div class="well">
                    <form role="form">
                        <div class="form-group">
                            <label for="txtEmpName">Employee name</label>
                            <input type="text" id="txtEmpName" class="form-control" name="emp_name"  value="<%=employee["emp_name"]%>" />
                        </div>
                        <div class="form-group">
                            <label for="txtEmpSalary">Basic salary</label>
                            <input type="text" id="txtEmpSalary" class="form-control" name="emp_salary"  value="<%=employee["emp_salary"]%>" />
                        </div>
                        <div class="form-group hide-me">
                            <label for="txtEmail">Email</label>
                            <input type="text" id="txtEmail" class="form-control" name="email"  value="<%=employee["email"]%>"  />
                        </div>
                        <div class="form-group hide-me">
                                <label for="txtPassword">Password</label>
                                <input type="text" id="txtPassword" disabled="disabled" class="form-control" name="password"  value="<%=employee["password"]%>"  />
                            </div>
                        <div class="form-group">
                            <label for="txtDepartment">Department</label>
                            <input type="text" id="txtDepartment" class="form-control" name="emp_department"  value="<%=employee["emp_department"]%>" />
                        </div>
                     <div class="form-group">
                            <label for="txtPhoneNum">Phone Number</label>
                            <input type="text" id="txtPhoneNum" class="form-control" name="emp_phone_number"  value="<%=employee["emp_phone_number"]%>" />
                        </div>
                     <div class="form-group">
                            <label for="txtAddress">Address</label>
                            <input type="text" id="txtAddress" class="form-control" name="emp_address"  value="<%=employee["emp_address"]%>"  />
                        </div>
                      <button type="button" onclick="UpdateEmployee()" class="btn btn-lg btn-primary">Update</button>
                    <a href="employee.aspx?user_uuid=<%=user["uuid"]%>" class="btn btn-lg btn-default"><i class="fa vom-green fa-backward"></i> Back to employee</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer_js" runat="server">
    <script>
        function UpdateEmployee() {
            var data = {
                uuid: '<%=employee["uuid"]%>',
                emp_name: $('#txtEmpName').val(),
                emp_salary: $('#txtEmpSalary').val(),
                email: $('#txtEmail').val(),
                password: $('#txtPassword').val(),
                emp_department: $('#txtDepartment').val(),
                emp_phone_number: $('#txtPhoneNum').val(),
                emp_address: $('#txtAddress').val()

            };
            $.ajax({
                url: '../api/v1/employee/edit',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    // alert(data.uuid);
                    if (data.uuid) {
                        $("#message_alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Employee updated successfully.</div>');
                        $("#message_alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message_alert").alert('close');
                        });
                    } else {
                        $("#message_alert").html('<div class="alert alert-danger" role="alert">Employee update Failed. Please try again !</div>');
                    }
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });
            return false;
        }
    </script>
</asp:Content>
