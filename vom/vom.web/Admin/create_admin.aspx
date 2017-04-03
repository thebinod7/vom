<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="create_admin.aspx.cs" Inherits="vom.web.Admin.create_admin" %>

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

<asp:Content ID="Content1" ContentPlaceHolderID="header_resource" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h2><b>Create Admin</b></h2>
                <p>Manage admin details.</p>
            </div>
            <div class="col-md-4">
                <div id="message-alert">
                </div>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-primary btn-lg pull-right" data-toggle="modal" data-target="#modal_admin"><i class="fa fa-plus"></i> New</button>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Admin Name</th>
                                <th>Email</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="admin_list">
                            <!-- Dynamic content goes here! -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="modal_admin" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Admin Details</h4>
                </div>
                <div class="modal-body well">
                    <form role="form">
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
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-lg btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="CreateAdmin()" class="btn btn-lg btn-primary" data-dismiss="modal">Create</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer_js" runat="server">
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

        var company_name = '<%= user["company_name"] %>';
        var owner = '<% = user["owner_name"] %>';
        var website = '<% = user["website_url"] %>';
        var contact = '<% = user["contact_number"] %>';

        function CreateAdmin() {
            var data = {
                company_name: company_name,
                owner_name: owner,
                email: $('#email').val(),
                password: $('#password').val(),
                website_url: website,
                contact_number:'98********'
            };
            $("#message-alert").html('<p> <b>Processing! </b> Please wait for few seconds...</p>');
            $.ajax({
                url: '../api/v1/company/create_admin',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    if (!data.ErrorMessage || !data.uuid == "") {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>New admin created successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                        ListAdmin();
                    } else {
                        $("#message-alert").html('<div  class="alert alert-warning" role="alert"><strong>' + data.ErrorMessage + '</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                    }
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });
            return false;
        }

        function ListAdmin() {
            $('#admin_list').empty();
            rs_ajax({
                url: '../api/v1/company/list_admin',
                type: 'GET',
                complete: function (response) {
                    data = response.responseJSON;
                    $.each(data, function (i, d) {
                        $('#admin_list').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.owner_name + '</td><td>' + d.email + '</td><td><a class="btn btn-danger btn-sm" href="#" onClick="RemoveAdmin(\'' + d.uuid + '\')"><i class="fa fa-trash"></i> Delete</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function RemoveAdmin(uuid) {
            var result = window.confirm('Are you sure?');
            if (result == false) {
                e.preventDefault();
            };
            rs_ajax({
                url: '../api/v1/company/' + uuid + '/remove_admin',
                complete: function (response) {
                    $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Admin removed successfully.</div>');
                    $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                    ListAdmin();
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-danger" role="alert"><strong>Error! </strong>Operation failed. Please try again!!!</div>');
                    $("#message-alert").fadeTo(2000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                }
            })
        }

        $(function () {
            ListAdmin();
        });
    </script>
</asp:Content>
