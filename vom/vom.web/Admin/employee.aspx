<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="employee.aspx.cs" Inherits="vom.web.Admin.employee" %>

<script runat="server">
    public string user_uuid;
    public System.Data.DataRow user;
    protected void Page_Load(object sender, EventArgs e)
    {
        user_uuid = Request.QueryString["user_uuid"];
        System.Data.DataTable dt = vom.logic.dal.Factory.Company.GetCompanyUser(new Guid(user_uuid));
        if (dt.Rows.Count > 0)
        {
            user = dt.Rows[0];
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h2><b>Employee</b></h2>
                <p>Organization employee details.</p>
            </div>
            <div class="col-md-4">
                <div id="message-alert">
                </div>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-primary btn-lg pull-right" data-toggle="modal" data-target="#modalEmp"><i class="fa fa-plus"></i> New</button>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Employee Name</th>
                                <th>Email</th>
                                <th>Department</th>
                                <th>Salary</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="employee_list">
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div id="modalEmp" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Employee Details</h4>
                </div>
                <div class="modal-body well">
                    <form role="form">
                        <div class="form-group">
                            <label for="empname">Employee name</label>
                            <input type="text" class="form-control"
                                id="empname" placeholder="Enter employee's full name" />
                        </div>
                        <div class="form-group">
                            <label for="salary">Basic salary</label>
                            <input type="text" class="form-control"
                                id="salary" placeholder="Enter salary" />
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" class="form-control"
                                id="email" placeholder="Enter email address" />
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control"
                                id="password" placeholder="Enter password" />
                        </div>
                        <div class="form-group">
                            <label for="empdept">Department</label>
                            <input type="text" class="form-control"
                                id="empdept" placeholder="Enter working department" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-lg btn-primary" onclick="AddEmployee()" data-dismiss="modal">Save</button>
                    <button type="button" class="btn btn-lg btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_js" runat="server">
    <script>
        var rs_ajax = function (config) {
            if (!config.type)
                config.type = 'POST';
            config.dataType = 'json';
            if (config.data)
                config.data = JSON.stringify(config.data);
            config.contentType = 'application/json; charset=utf-8';
            $.ajax(config)
        }

        function AddEmployee() {
            var data = {
                emp_name: $('#empname').val(),
                emp_salary: $('#salary').val(),
                email: $('#email').val(),
                password: $('#password').val(),
                emp_department: $('#empdept').val(),
                company_uuid : '<%=user["uuid"]%>'
            };
            $("#message-alert").html('<p> <b>Processing! </b> Please wait for few seconds...</p>');
            $.ajax({
                url: '../api/v1/employee/save',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    if (!data.ErrorMessage) {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>New employee added successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                        ListEmployee();
                        ResetFields();
                    }else if(data.uuid) {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>New employee added successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                        ListEmployee();
                        ResetFields();
                    }else {
                        $("#message-alert").html('<div  class="alert alert-warning" role="alert"><strong>' + data.ErrorMessage + '</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    }
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-danger" role="alert">Some error occured. Please try again!</div>');
                }
            });
            return false;
        }

        function ListEmployee() {
            $('#employee_list').empty();
            var data = {
                company_uuid: '<%=user["uuid"]%>'
             };
             $.ajax({
                 url: '../api/v1/employee/list',
                 type: 'POST',
                 dataType: 'json',
                 data: JSON.stringify(data),
                 contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#employee_list').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.emp_name + '</td><td>' + d.email + '</td><td>' + d.emp_department + '</td><td>' + d.emp_salary + '</td><td><a class="btn btn-primary btn-sm" href="update_employee.aspx?user_uuid=<%=user["uuid"]%>&emp_uuid=' + d.uuid + '"><i class="fa fa-pencil"></i> Edit</a> <a class="btn btn-danger btn-sm" href="#" onClick="RemoveEmployee(\'' + d.uuid + '\')"><i class="fa fa-trash"></i> Delete</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function RemoveEmployee(uuid) {
            var result = window.confirm('Are you sure?');
            if (result == false) {
                e.preventDefault();
            };
            rs_ajax({
                url: '../api/v1/employee/' + uuid + '/remove_employee',
                complete: function (response) {
                    $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Employee deleted successfully.</div>');
                    $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                    ListEmployee();
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-danger" role="alert"><strong>Error! </strong>Employee not deleted. Please try again!!!</div>');
                    $("#message-alert").fadeTo(2000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                }
            })
        }
      
        function ResetFields() {
                $('#fname').val() = "";
                $('#lname').val() = "";
                $('#email').val() = "";
                $('#password').val() = "";
                $('#salary').val() = "";
                $('#empdept').val() = "";
            }
            $(function () {
                ListEmployee();
            });
    </script>
</asp:Content>
