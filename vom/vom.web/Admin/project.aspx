<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="project.aspx.cs" Inherits="vom.web.Admin.project" %>

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
                <h2><b>Project</b></h2>
                <p>Manage project details.</p>
            </div>
            <div class="col-md-4">
                <div id="message-alert">
                </div>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-primary btn-lg pull-right" data-toggle="modal" data-target="#modalProject"><i class="fa fa-plus"></i> New</button>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover data">
                        <thead>
                            <tr>
                                <th>Project Name</th>
                                <th>Budget</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="tblproject_list">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div id="modalProject" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Project Details</h4>
                </div>
                <div class="modal-body well">
                    <form role="form">
                        <div class="form-group">
                            <label for="selproject_category">Project Category</label>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select class="form-control" id="selproject_category">
                                            <%--dynamic category list goes here--%>
                                        </select>
                                    </div>
                                    <%--<div class="col-md-6">
                                        <input type="text" class="form-control"
                                            id="selectedProject" placeholder="Select project name" />
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtproject_name">Project name</label>
                            <input type="text" class="form-control"
                                id="txtproject_name" placeholder="Enter project name" />
                        </div>
                        <div class="form-group">
                            <label for="txtbudget">Budget</label>
                            <input type="text" class="form-control"
                                id="txtbudget" placeholder="Enter estimated budget" />
                        </div>
                        <div class="form-group">
                            <label for="optstatus">Status</label>
                            <div class="form-group">
                                <select class="form-control" id="optstatus">
                                    <option>Open</option>
                                    <option>In Progress</option>
                                    <option>Closed</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group datepick">
                            <label for="dtEndDate">End Date</label>
                            <div class="input-group date">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" id="dtEndDate" class="form-control" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtproject_desc">Description</label>
                            <input type="text" class="form-control"
                                id="txtproject_desc" placeholder="Enter project description" />
                        </div>
                        <div class="form-group hide-me">
                            <input type="text" class="form-control"
                                id="txtCatID" value="" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-lg btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="SaveProject()" class="btn btn-lg btn-primary" data-dismiss="modal">Save</button>
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
                $('#selectedProject').text = selected;
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
                        cat_name = data.uuid;
                        //$("#catname").html("");
                        $("#txtCatID").val(cat_name);
                        //$('#catname').append('<label>' + cat_name + '</label>');
                    },
                    error: function (response) {
                        console.log(response.responseText);
                    }
                });
            });
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
            ListProject();
            SelectedCategory();
        });
        function SaveProject() {
            //Selected_CategoryName();
            var model = {
                project_name: $('#txtproject_name').val(),
                budget: $('#txtbudget').val(),
                status: $('#optstatus').val(),
                project_desc: $('#txtproject_desc').val(),
                end_date: $('#dtEndDate').val(),
                category_uuid: $('#txtCatID').val(),
                company_uuid : '<%=user["uuid"]%>'
            };
            $.ajax({
                url: '../api/v1/project/save',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(model),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    if (data.uuid) {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>New project created successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    } else {
                        $("#message-alert").html('<div  class="alert alert-warning" role="alert"><strong>' + data.ErrorMessage + '</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    }
                    ListProject();
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });
            return false;
        }

        function ListProject() {
            $('#tblproject_list').empty();
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
                        $('#tblproject_list').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.project_name + '</td><td>' + d.budget + '</td><td>' + d.status + '</td><td><a class="btn btn-primary btn-sm" href="updateproject.aspx?user_uuid=<%=user["uuid"]%>&project_uuid=' + d.uuid + '&category_uuid=' + d.category_uuid + '"><i class="fa fa-pencil"></i> Edit</a> <a class="btn btn-danger btn-sm" href="#" onClick="RemoveProject(\'' + d.uuid + '\')"> <i class="fa fa-trash"></i> Delete</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
            }

            function RemoveProject(uuid) {
                var result = window.confirm('Are you sure?');
                if (result == false) {
                    e.preventDefault();
                };
                rs_ajax({
                    url: '../api/v1/project/' + uuid + '/remove_project',
                    complete: function (response) {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Project deleted successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                        ListProject();
                    },
                    error: function (response) {
                        $("#message-alert").html('<div  class="alert alert-danger" role="alert"><strong>Error! </strong>Project not deleted. Please try again!!!</div>');
                        $("#message-alert").fadeTo(2000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    }
                })
            }
    </script>
</asp:Content>

