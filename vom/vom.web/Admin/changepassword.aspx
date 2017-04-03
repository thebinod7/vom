<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="changepassword.aspx.cs" Inherits="vom.web.Admin.changepassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                 <h2><strong>Change Password</strong></h2>
                <hr />
                <div id="change_password_alert"></div>
                <form role="form">
                    
                    <div class="form-group">
                        <label for="old_password" class="col-md-3 control-label">Old Password</label>
                        <div class="col-md-9">
                            <input type="password" id="old_password" class="form-control input-lg" name="old_password" placeholder="Enter old password" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="new_password" class="col-md-3 control-label">New Password</label>
                        <div class="col-md-9">
                            <input type="password" id="new_password" class="form-control input-lg" name="new_password" placeholder="Enter new password" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirm_pass" class="col-md-3 control-label">Confirm Password</label>
                        <div class="col-md-9">
                            <input type="password" id="confirm_pass" class="form-control input-lg" name="confirm_pass" placeholder="Confirm new password" />
                        </div>
                    </div>

                    <div class="form-group">
                        <!-- Button -->
                        <div class="col-md-offset-3 col-md-9">
                            <button id="btn-changepassword" type="button" onclick="UpdatePassword()" class="btn btn-lg btn-primary">&nbsp Change Password</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_js" runat="server">
</asp:Content>
