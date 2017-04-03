<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/employee.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="vom.web.Employee._default" %>

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

<asp:Content ID="Content1" ContentPlaceHolderID="content_body" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="col-md-6">
                </div>
                <div id="verify_stat" class="col-md-6">
                    
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5">
            <div class="btn-toolbar" role="toolbar">
                <div class="hide-radio" role="group" data-toggle="buttons">
                    <div>
                         <label class="btn btn-default active">
                            <input type="radio" value="0" name="options" checked="checked" id="All" />
                            All
                        </label>   
                        <label class="btn btn-default">
                            <input type="radio" value="1" name="options" id="DueToday" /> Due Today
                        </label>
                        <label class="btn btn-default">
                            <input type="radio" value="2" name="options" id="Late" />
                            Late
                        </label>
                        <label class="btn btn-default">
                            <input type="radio" value="3" name="options" id="Inprogress" />
                            In Progress
                        </label>
                    </div>
                    <div>
                        <label class="btn btn-default">
                            <input type="radio" value="4" name="options" id="Done" />
                            Done
                        </label>
                    </div>
                </div>
            </div>
        </div>
            <div class="col-md-7">
                 <div id="message"> </div>
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
                                <th>Progress</th>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_assets" runat="server">
    <script>
        $(document).ready(function(){
            //radioSelect();
        });

        function radioSelect() {
            var flag;
            var emp_uuid = user_uuid
            $('input:radio').change(function () {
                if ($(this).val() == '0') {
                    flag = 'All'
                    ListTaskBYFlag(flag,emp_uuid);
                } else if ($(this).val() == '1') {
                    flag = 'DueToday'
                    ListTaskBYFlag(flag, emp_uuid);
                } else if ($(this).val() == '2') {
                    flag = 'Late'
                    ListTaskBYFlag(flag, emp_uuid);
                } else if ($(this).val() == '3') {
                    flag = 'Inprogress'
                    ListTaskBYFlag(flag, emp_uuid);
                } else if ($(this).val() == '4') {
                    flag = 'Done'
                    ListTaskBYFlag(flag, emp_uuid);
                }
            });
        }


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
            ListAssignedTask();
            radioSelect();
        });

        function ListAssignedTask() {
            $('#tblTaskList').empty();
            rs_ajax({
                url: '../api/v1/task/' + user_uuid + '/get_assigned_task',
                type: 'GET',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#tblTaskList').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.task_name + '</td><td>' + d.due_date + '</td><td>' + d.status + '</td><td>' + d.progress + '</td><td><a class="btn btn-primary btn-sm"  href="edit_task.aspx?user_uuid= '+ user_uuid +'&task_uuid= '+ d.uuid +' "><i class="fa fa-pencil"></i> Edit</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function ListTaskBYFlag(flag,emp_uuid) {
            $('#tblTaskList').empty();
            rs_ajax({
                url: '../api/v1/task/' + flag + '/' + emp_uuid,
                type: 'GET',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#tblTaskList').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.task_name + '</td><td>' + d.due_date + '</td><td>' + d.status + '</td><td>' + d.progress + '</td><td><a class="btn btn-primary btn-sm"  href="edit_task.aspx?user_uuid= ' + user_uuid + '&task_uuid= ' + d.uuid + ' "><i class="fa fa-pencil"></i> Edit</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }
    </script>
</asp:Content>
