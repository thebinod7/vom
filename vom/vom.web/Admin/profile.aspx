<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="vom.web.Admin.editprofile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h2><strong>Edit Profile</strong></h2>
                <hr />
                <div id="message_alert"></div>
                <form role="form">
                    <div class="form-group">
                        <label for="company_name" class="col-md-3 control-label">Company Name</label>
                        <div class="col-md-9">
                            <input type="text" id="txtCompany" class="form-control input-lg"  value="<%=company["company_name"]%>" name="company_name" />
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom:70px;">
                        <label for="owner_name" class="col-md-3 control-label">Owner Name</label>
                        <div class="col-md-9">
                            <input type="text" id="txtOwner" class="form-control input-lg"  value="<%=company["owner_name"]%>" name="owner_name"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="website_url" class="col-md-3 control-label">Website URL</label>
                        <div class="col-md-9">
                            <input type="text" id="txtWebsiteUrl" class="form-control input-lg"  value="<%=company["website_url"]%>" name="website_url" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="contact_num" class="col-md-3 control-label">Contact Number</label>
                        <div class="col-md-9">
                            <input type="text" id="txtContactNum" class="form-control input-lg"  value="<%=company["contact_number"]%>" name="contact_num" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="company_addr" class="col-md-3 control-label">Company Address</label>
                        <div class="col-md-9">
                            <input type="text" id="txtCompanyAddress" class="form-control input-lg"  value="<%=company["company_address"]%>" name="company_addr" />
                        </div>
                    </div>

                    <div class="form-group">
                        <!-- Button -->
                        <div class="col-md-offset-3 col-md-9">
                            <button id="btn-editprofile" type="button" onclick="UpdateProfile()" class="btn btn-lg btn-primary">&nbsp Update Profile</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_js" runat="server">
    <script>
        function UpdateProfile() {
            var data = {
                uuid: '<%=company["uuid"]%>',
                company_name: $('#txtCompany').val(),
                owner_name: $('#txtOwner').val(),
                website_url: $('#txtWebsiteUrl').val(),
                contact_number: $('#txtContactNum').val(),
                company_address: $('#txtCompanyAddress').val()
            };
            $.ajax({
                url: '../api/v1/company/Editprofile',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                complete: function (response) {
                    data = response.responseJSON[0];
                    // alert(data.uuid);
                    if (data.uuid) {
                        $("#message_alert").html('<div class="alert alert-success" role="alert">Profile updated successfully.</div>');
                    } else {
                        $("#message_alert").html('<div class="alert alert-danger" role="alert">Profile update Failed. Please try again !</div>');
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
