<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/employee.Master" AutoEventWireup="true" CodeBehind="edit_task.aspx.cs" Inherits="vom.web.Employee.edit_task" %>

<script runat="server">
    public string user_uuid;
    public string task_uuid;
    public System.Data.DataRow user;
    public System.Data.DataRow task;
    protected void Page_Load(object sender, EventArgs e)
    {
        user_uuid = Request.QueryString["user_uuid"];
        System.Data.DataTable dt = vom.logic.dal.Factory.Company.GetCompanyUser(new Guid(user_uuid));
        if (dt.Rows.Count > 0)
        {
            user = dt.Rows[0];
        }

        task_uuid = Request.QueryString["task_uuid"];
        System.Data.DataTable dtTask = vom.logic.dal.Factory.Task.GetTask(new Guid(task_uuid));
        if(dtTask.Rows.Count > 0)
        {
            task = dtTask.Rows[0];
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="content_body" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h2><strong>Update task details</strong></h2>
                <hr />
                <div id="message_alert"></div>
                <div class="well">
                    <form role="form">
                        <div class="form-group">
                            <label for="txtTaskName">Task Name</label>
                            <input type="text" id="txtTaskName" value="<%=task["task_name"]%>" class="form-control" name="task_name" />
                        </div>
                        <div class="form-group">
                            <label for="optstatus">Progress</label>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <select class="form-control" id="optProgress">
                                            <option>Update Progress</option>
                                            <option>20%</option>
                                            <option>40%</option>
                                            <option>60%</option>
                                            <option>80%</option>
                                            <option>100%</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control"
                                            id="txtProgress" value="<%=task["progress"]%>" name="progress" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="optstatus">Status</label>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <select class="form-control" id="optStatus">
                                            <option>Update Status</option>
                                            <option>Ready</option>
                                            <option>In Progress</option>
                                            <option>Review</option>
                                            <option>Done</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control"
                                            id="txtStatus" value="<%=task["status"]%>" name="status" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group datepick">
                            <label for="dtDueDate">End Date</label>
                            <div class="input-group date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" id="dtDueDate" class="form-control" name="due_date" value="<%=task["due_date"]%>" />
                                </div>
                        </div>
                        <div class="form-group">
                            <label for="txtDescription">Description</label>
                            <input type="text" id="txtDescription" value="<%=task["task_desc"]%>" class="form-control" name="task_desc" />
                        </div>
                        <button type="button" onclick="UpdateTask()" class="btn btn-lg btn-primary">Update</button>
                        <a href="#" class="btn btn-lg btn-default"><i class="fa vom-green fa-backward"></i> Back to task</a>
                    </form>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_assets" runat="server">
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

        function SelectedStatus() {
            $('#optStatus').on('change', function () {
                var selected = $(this).find("option:selected").val();
                $('#txtStatus').val(selected);
            });
        }

        function SelectedProgress() {
            $('#optProgress').on('change', function () {
                var selected = $(this).find("option:selected").val();
                $('#txtProgress').val(selected);
            });
        }

        function UpdateTask() {
            var data = {
                uuid: '<%=task["uuid"]%>',
                task_name: $('#txtTaskName').val(),
                progress: $('#txtProgress').val(),
                status: $('#txtStatus').val(),
                due_date: $('#dtDueDate').val(),
                task_desc: $('#txtDescription').val()
            };
            $.ajax({
                url: '../api/v1/task/edit',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    if (!data.uuid == "") {
                        $("#message_alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Task updated successfully.</div>');
                        $("#message_alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message_alert").alert('close');
                        });
                        ListCategory();
                    } else {
                        $("#message_alert").html('<div class="alert alert-danger" role="alert">Task update Failed. Please try again !</div>');
                    }
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });
            return false;
        }

        $(function () {
            SelectedProgress();
            SelectedStatus();
        });
    </script>
</asp:Content>
