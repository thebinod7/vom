<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="vom.web.Admin.category" %>
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
                <h2><b>Category</b></h2>
                <p>Manage category details.</p>
            </div>
            <div class="col-md-4">
                <div id="message-alert">
                </div>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-primary btn-lg pull-right" data-toggle="modal" data-target="#modalCategory"><i class="fa fa-plus"></i> New</button>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th class="hide-col" style="display:none;">Category UUID</th>
                                <th>Category Name</th>
                                <th>Category Description</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="category_list">
                            <!-- Dynamic content goes here! -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div id="modalCategory" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Category Details</h4>
                </div>
                <div class="modal-body well">
                    <form role="form">
                        <div class="form-group">
                            <label for="catName">Category name</label>
                            <input type="text" class="form-control"
                                id="catname" placeholder="Enter category name" />
                        </div>
                        <div class="form-group">
                            <label for="catDesc">Description</label>
                            <textarea class="form-control" id="catDesc" placeholder="Category description" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-lg btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="SaveCategory()" class="btn btn-lg btn-primary" data-dismiss="modal">Save</button>
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

        function SaveCategory() {
            var data = {
                category_name: $('#catname').val(),
                category_desc: $('#catDesc').val(),
                company_uuid : '<%=user["uuid"]%>'
            };
            $.ajax({
                url: '../api/v1/category/save',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    if (!data.ErrorMessage) {
                        $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>New category created successfully.</div>');
                        $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message-alert").alert('close');
                        });
                        ListCategory();
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

        function ListCategory() {
            $('#category_list').empty();
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
                        $('#category_list').append('<tr><td style="display:none">' + d.uuid + '</td><td>' + d.category_name + '</td><td>' + d.category_desc + '</td><td><a class="btn btn-primary btn-sm" href="updatecategory.aspx?user_uuid=<%=user["uuid"]%>&category_uuid='+ d.uuid +'"><i class="fa fa-pencil"></i> Edit</a> <a class="btn btn-danger btn-sm" href="#" onClick="RemoveCategory(\'' + d.uuid + '\')"><i class="fa fa-trash"></i> Delete</a></td></tr>');
                    })
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-warning" role="alert">Some error occured.</div>');
                }
            });
        }

        function RemoveCategory(uuid) {
            var result = window.confirm('Are you sure?');
            if (result == false) {
                e.preventDefault();
            };
            rs_ajax({
                url: '../api/v1/category/' + uuid + '/remove_category',
                complete: function (response) {
                    $("#message-alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Category deleted successfully.</div>');
                    $("#message-alert").fadeTo(3000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                    ListCategory();
                },
                error: function (response) {
                    $("#message-alert").html('<div  class="alert alert-danger" role="alert"><strong>Error! </strong>Category not deleted. Please try again!!!</div>');
                    $("#message-alert").fadeTo(2000, 500).slideUp(500, function () {
                        $("#message-alert").alert('close');
                    });
                }
            })
        }

        $(function () {
            ListCategory();
        });
    </script>
</asp:Content>
