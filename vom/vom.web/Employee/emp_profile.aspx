<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/employee.Master" AutoEventWireup="true" CodeBehind="emp_profile.aspx.cs" Inherits="vom.web.Employee.emp_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content_body" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2><strong>Edit Profile</strong></h2>
                <hr />
                <div id="message_alert"></div>
                <form role="form">
                    <div class="form-group">
                        <label for="txtFullName" class="col-md-3 control-label">Full Name</label>
                        <div class="col-md-9">
                            <input type="text" id="txtFullName" class="form-control input-lg" value="<%=user["emp_name"]%>"   name="emp_name" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="txtDepartment" class="col-md-3 control-label">Department</label>
                        <div class="col-md-9">
                            <input type="text" id="txtDepartment" class="form-control input-lg" value="<%=user["emp_department"]%>"  name="emp_department"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="txtPhNum" class="col-md-3 control-label">Phone Number</label>
                        <div class="col-md-9">
                            <input type="text" id="txtPhNum" class="form-control input-lg" value="<%=user["emp_phone_number"]%>"  name="emp_phone_number" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="txtAddress" class="col-md-3 control-label">Address</label>
                        <div class="col-md-9">
                            <input type="text" id="txtAddress" class="form-control input-lg" value="<%=user["emp_address"]%>"  name="emp_address" />
                        </div>
                    </div>
                    <div class="form-group" style="margin-top:70px;">
                        <!-- Button -->
                        <div class="col-md-offset-3 col-md-9">
                            <button id="btn-editprofile" type="button" onclick="UpdateProfile()" class="btn btn-lg btn-primary">&nbsp Update Profile</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_assets" runat="server">
      <script>
          function UpdateProfile() {
              var data = {
                uuid: '<%=user["uuid"]%>',
                emp_name: $('#txtFullName').val(),
                emp_department: $('#txtDepartment').val(),
                emp_phone_number: $('#txtPhNum').val(),
                emp_address: $('#txtAddress').val()
            };
            $.ajax({
                url: '../api/v1/employee/edit',
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
