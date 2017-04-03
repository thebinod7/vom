<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeFile="task.aspx.cs" Inherits="vom.web.Admin.task" %>

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

<asp:Content ID="Content3" ContentPlaceHolderID="header_resource" runat="server">
    <link href="../Assets/css/plugins/datepicker3.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h2><b>Task</b></h2>
                <p>Employee task details.</p>
            </div>
            <div class="col-md-4">
                <div id="message-alert">

                </div>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-primary btn-lg pull-right" data-toggle="modal" data-target="#modalTask">Add New</button>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Task Name</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="tblTaskList">
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div id="modalTask" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Task Details</h4>
                </div>
                <div class="modal-body well">
                    <form role="form">
                        <div class="form-group">
                            <label for="optProject">Select Project</label>
                            <select class="form-control" id="optProject">
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="optAssignee">Assign to</label>
                            <select class="form-control" id="optAssignee">
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="task_name">Task Name</label>
                            <input type="text" class="form-control"
                                id="task_name" placeholder="Enter task name" />
                        </div>
                        <div class="form-group datepick">
                            <label for="dtDue">Due Date</label>
                            <div class="input-group date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" id="dtDue" class="form-control" value="" />
                                </div>
                        </div>
                        <div class="form-group">
                            <label for="txtDesc">Description</label>
                            <input type="text" class="form-control"
                                id="txtDesc" placeholder="Description text" />
                        </div>
                        <div class="form-group hide-me">
                            <input type="text" class="form-control"
                                id="txtProject_UUID" />
                        </div>
                        <div class="form-group hide-me">
                            <input type="text" class="form-control"
                                id="txtEmployee_UUID" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-lg btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="AddTask()" class="btn btn-lg btn-primary" data-dismiss="modal">Save</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_js" runat="server">
    <script src="../Assets/js/plugins/bootstrap-datepicker.js"></script>
    <script>
        $(document).ready(function () {
            $('.datepick .input-group.date').datepicker({
                todayBtn: "linked",
                keyboardNavigation: false,
                forceParse: false,
                calendarWeeks: true,
                autoclose: true
            });
        });

        var assigner_uuid = '<%=user_uuid%>';

        var rs_ajax = function (config) {
            if (!config.type)
                config.type = 'POST';
            config.dataType = 'json';
            if (config.data)
                config.data = JSON.stringify(config.data);
            config.contentType = 'application/json; charset=utf-8';
            $.ajax(config)
        }

        $(function () {
            ListTask();
            ListProject();
            ListAssignee();
            SelectedProject();
            SelectedEmployee();
        });

        function SelectedProject() {
            $('#optProject').on('change', function () {
                var selected = $(this).find("option:selected").val();
                var data = {
                    project_name: selected
                };
                $.ajax({
                    url: '../api/v1/project/get_project_uuid',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    complete: function (response) {
                        data = response.responseJSON[0];
                        projectUUID = data.uuid;
                        //$("#catname").html("");
                        $("#txtProject_UUID").val(projectUUID);
                        //$('#catname').append('<label>' + cat_name + '</label>');
                    },
                    error: function (response) {
                        console.log(response.responseText);
                    }
                });
            });
        }

        function SelectedEmployee() {
            $('#optAssignee').on('change', function () {
                var selected = $(this).find("option:selected").val();
                var data = {
                    emp_name: selected
                };
                $.ajax({
                    url: '../api/v1/employee/get_employee_uuid',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    complete: function (response) {
                        data = response.responseJSON[0];
                        empUUID = data.uuid;
                        //$("#catname").html("");
                        $("#txtEmployee_UUID").val(empUUID);
                        //$('#catname').append('<label>' + cat_name + '</label>');
                    },
                    error: function (response) {
                        console.log(response.responseText);
                    }
                });
            });
        }

        function AddTask() {
            var model = {
                task_name: $('#task_name').val(),
                start_date: $('#dtDue').val(),
                due_date: $('#dtDue').val(),
                progress: 'Just Started',
                status: 'Ready',
                task_desc: $('#txtDesc').val(),
                project_uuid: $('#txtProject_UUID').val(),
                employee_uuid: $('#txtEmployee_UUID').val(),
                assigner_uuid: assigner_uuid,
                company_uuid: '<%=user["uuid"]%>'
            };
            $.ajax({
                url: '../api/v1/task/add',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(model),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    if (data.uuid) {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Task assigned successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    } else {
                        $("#message-alert").html('<div  class="alert alert-warning" role="alert"><strong>' + data.ErrorMessage + '</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    }
                    ListTask();
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });
            return false;
        }

        function ListProject() {
            $('#optProject').empty();
            var data = {
                company_uuid: '<%=user["uuid"]%>'
            };
            $.ajax({
                url: '../api/v1/project/list',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#optProject').append('<option>' + d.project_name + '</option>');
                    })
                },
                error: function (response) {
                    $("#message").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function ListAssignee() {
            $('#optAssignee').empty();
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
                        $('#optAssignee').append('<option>' + d.emp_name + '</option>');
                    })
                },
                error: function (response) {
                    $("#message").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function ListTask() {
            $('#tblTaskList').empty();
            var data = {
                company_uuid: '<%=user["uuid"]%>'
           };
           $.ajax({
               url: '../api/v1/task/list',
               type: 'POST',
               dataType: 'json',
               data: JSON.stringify(data),
               contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#tblTaskList').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.task_name + '</td><td>' + d.due_date + '</td><td>' + d.status + '</td><td><a class="btn btn-primary btn-sm" href="updatetask.aspx?user_uuid=<%=user["uuid"]%>&task_uuid='+ d.uuid +'"><i class="fa fa-pencil"></i> Edit</a> <a class="btn btn-danger btn-sm" href="#" onClick="RemoveTask(\'' + d.uuid + '\')"> <i class="fa fa-trash"></i> Delete</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function RemoveTask(uuid) {
            var result = window.confirm('Are you sure?');
            if (result == false) {
                e.preventDefault();
            };
            rs_ajax({
                url: '../api/v1/task/' + uuid + '/remove_task',
                complete: function (response) {
                    $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Task deleted successfully.</div>');
                    $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                    ListTask();
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-danger" role="alert"><strong>Error! </strong>Task not deleted. Please try again!!!</div>');
                    $("#message-alert").fadeTo(2000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                }
            })
        }

    </script>
</asp:Content>

