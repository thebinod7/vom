<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="updateproject.aspx.cs" Inherits="vom.web.Admin.updateproject" %>

<script runat="server">
    public string user_uuid;
    public System.Data.DataRow user;
    public string project_uuid;
    public System.Data.DataRow project;
    public string category_uuid;
    public System.Data.DataRow category;
    protected void Page_Load(object sender, EventArgs e)
    {
        project_uuid = Request.QueryString["project_uuid"];
        System.Data.DataTable dtc = vom.logic.dal.Factory.Project.GetProject(new Guid(project_uuid));
        if (dtc.Rows.Count > 0)
        {
            project = dtc.Rows[0];
        }

        user_uuid = Request.QueryString["user_uuid"];
        System.Data.DataTable dt = vom.logic.dal.Factory.Company.GetCompanyUser(new Guid(user_uuid));
        if (dt.Rows.Count > 0)
        {
            user = dt.Rows[0];
        }
        category_uuid = Request.QueryString["category_uuid"];
        System.Data.DataTable dtCat = vom.logic.dal.Factory.Category.GetCategory(new Guid(category_uuid));
        if (dtCat.Rows.Count > 0)
        {
            category = dt.Rows[0];
        }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="header_resource" runat="server">
    <link href="../Assets/css/plugins/datepicker3.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-6">
                <h2><strong>Update project details</strong></h2>
                <hr />
                <div id="message_alert"></div>
                <div class="well">
                    <form role="form">
                        <div class="form-group">
                            <label for="selproject_category">Project Category</label>
                            <div class="form-group">
                                <select class="form-control" id="selproject_category">
                                    <%--dynamic category list goes here--%>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtproject_name">Project name</label>
                            <input type="text" class="form-control"
                                id="txtproject_name" value="<%=project["project_name"]%>" name="project_name" />
                        </div>
                        <div class="form-group">
                            <label for="txtbudget">Budget</label>
                            <input type="text" class="form-control"
                                id="txtbudget" value="<%=project["budget"]%>" name="budget" />
                        </div>
                        <div class="form-group">
                            <label for="optstatus">Status</label>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <select class="form-control" id="optstatus">
                                            <option>Update Status</option>
                                            <option>Open</option>
                                            <option>In Progress</option>
                                            <option>Closed</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control"
                                            id="txtStatus" value="<%=project["status"]%>" name="status" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtproject_desc">Description</label>
                            <input type="text" class="form-control"
                                id="txtproject_desc" value="<%=project["project_desc"]%>" name="project_desc" />
                        </div>
                        <div class="form-group hide-me">
                            <input type="text" class="form-control"
                                id="txtCatID" value="" placeholder="cat ID" />
                        </div>
                       <div class="form-group datepick">
                            <label for="dtEndDate">End Date</label>
                            <div class="input-group date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" id="dtEndDate" class="form-control" name="end_date" value="<%=project["end_date"]%>" />
                                </div>
                        </div>
                        <button type="button" onclick="UpdateProject()" class="btn btn-lg btn-primary">Update</button>
                        <a href="project.aspx?user_uuid=<%=user["uuid"]%>" class="btn btn-lg btn-default"><i class="fa vom-green fa-backward"></i> Back to project</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer_js" runat="server">
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

        var rs_ajax = function (config) {
            if (!config.type)
                config.type = 'POST';
            config.dataType = 'json';
            if (config.data)
                config.data = JSON.stringify(config.data);
            config.contentType = 'application/json; charset=utf-8';
            $.ajax(config)
        }

        function SelectedCategory() {
            $('#selproject_category').on('change', function () {
                var selected = $(this).find("option:selected").val();
                var data = {
                    category_name: selected
                };
                $.ajax({
                    url: '../api/v1/category/get_category_uuid',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    complete: function (response) {
                        data = response.responseJSON[0];
                        catID = data.uuid;
                        $("#txtCatID").val(catID);
                    },
                    error: function (response) {
                        console.log(response.responseText);
                    }
                });
            });
        }

        function SelectedStatus() {
            $('#optstatus').on('change', function () {
                var selected = $(this).find("option:selected").val();
                $('#txtStatus').val(selected);
            });
        }

        function UpdateProject() {
            var data = {
                uuid: '<%=project["uuid"]%>',
                project_name: $('#txtproject_name').val(),
                budget: $('#txtbudget').val(),
                status: $('#txtStatus').val(),
                project_desc: $('#txtproject_desc').val(),
                end_date: $('#dtEndDate').val(),
                category_uuid: $('#txtCatID').val()
            };
            $.ajax({
                url: '../api/v1/project/edit',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    // alert(data.uuid);
                    if (!data.uuid == "") {
                        $("#message_alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Project updated successfully.</div>');
                        $("#message_alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message_alert").alert('close');
                        });
                        ListCategory();
                    } else {
                        $("#message_alert").html('<div class="alert alert-danger" role="alert">Project update Failed. Please try again !</div>');
                    }
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });
            return false;
        }

        function ListCategory() {
            $('#selproject_category').empty();
            var data = {
                company_uuid: '<%=user["uuid"]%>'
            };
            $.ajax({
                url: '../api/v1/category/list',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#selproject_category').append(' <option>' + d.category_name + '</option>');
                    })
                },
                error: function (response) {
                    $("#message").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        $(function () {
            ListCategory();
            SelectedCategory();
            SelectedStatus();
        });
    </script>
</asp:Content>
