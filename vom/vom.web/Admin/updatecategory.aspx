<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="updatecategory.aspx.cs" Inherits="vom.web.Admin.updatecategory" %>

<script runat="server">
    public string user_uuid;
    public System.Data.DataRow user;
    public string category_uuid;
    public System.Data.DataRow category;
    protected void Page_Load(object sender, EventArgs e)
    {
        category_uuid = Request.QueryString["category_uuid"];
        System.Data.DataTable dtc = vom.logic.dal.Factory.Category.GetCategory(new Guid(category_uuid));
        lenght = dtc.Rows.Count;
        if (dtc.Rows.Count > 0)
        {
            category = dtc.Rows[0];
        }
        
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
            <div class="col-md-12 col-sm-6">
                <h2><strong>Update category details</strong></h2>
                <hr />
                <div id="message_alert"></div>
                <div class="well">
                    <form role="form">
                        <div class="form-group">
                            <label for="txtCategory">Category name</label>
                            <input type="text" id="txtCategory"  value="<%=category["category_name"]%>" name="category_name"  class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="txtCategoryDesc">Description</label>
                            <input type="text" class="form-control" id="txtCategoryDesc" value="<%=category["category_desc"]%>" name="category_desc" />
                        </div>
                     <button type="button" onclick="UpdateCategory()" class="btn btn-lg btn-primary">Update</button>
                    <a href="category.aspx?user_uuid=<%=user["uuid"]%>" class="btn btn-lg btn-default"><i class="fa vom-green fa-backward"></i> Back to category</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_js" runat="server">
    <script>
        function UpdateCategory() {
            var data = {
                uuid: '<%=category["uuid"]%>',
                category_name: $('#txtCategory').val(),
                category_desc: $('#txtCategoryDesc').val(),
            };
            $.ajax({
                url: '../api/v1/category/edit',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    // alert(data.uuid);
                    if (data.uuid) {
                        $("#message_alert").html('<div  class="alert alert-success" role="alert"><strong>Success! </strong>Category updated successfully.</div>');
                        $("#message_alert").fadeTo(3000, 500).slideUp(500, function () {
                            $("#message_alert").alert('close');
                        });
                        ListCategory();
                    } else {
                        $("#message_alert").html('<div class="alert alert-danger" role="alert">Category update Failed. Please try again !</div>');
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
