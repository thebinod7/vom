<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="resetpassword.aspx.cs" Inherits="vom.web.resetpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VOM User - Reset Password</title>
    <link href="Assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="Assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Assets/css/custom.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <hr />
        <div class="container">
        <div class="row">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <h3><i class="fa fa-lock fa-4x"></i></h3>
                                <h2 class="text-center">Reset Password</h2>
                                <p>You can reset your password here.</p>
                                <div id="message"></div>
                                <div class="panel-body">
                                    <form class="form">
                                        <fieldset>
                                            <div class="form-group">
                                                    <input id="txtNewPassword" placeholder="Enter new password" class="form-control" required="" type="password">
                                            </div>
                                             <div class="form-group">
                                                    <input id="txtConfirmNewPass" placeholder="Confirm new password" class="form-control" required="" type="password">
                                            </div>
                                            <div class="form-group">
                                                <input class="btn btn-lg btn-primary btn-block" onclick="ResetPassword()" value="Reset Password" type="button">
                                                 <a id="login" href="login.html" class="btn btn-lg btn-info btn-block"> Login  </a>
                                            </div>
                                        </fieldset>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <script src="Assets/js/jquery-2.1.1.js"></script>
    <script src="Assets/js/bootstrap.min.js"></script>
    <script>
        function ResetPassword() {
            var newpassword = $('#txtNewPassword').val();
            var confirmpassword = $('#txtConfirmNewPass').val();
            if (newpassword == confirmpassword) {
                var data = {
                    new_password: $('#txtNewPassword').val(),
                    verify_code: '<%=Request.QueryString["verify_code"] %>'
                };
                $.ajax({
                    url: 'api/v1/company/reset_password',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify(data),
                    contentType: 'application/json; charset=utf-8',
                    complete: function (response) {
                        $("#message").html('<div class="alert alert-success" role="alert">You have successfully changed password</div>');
                    },
                    error: function (response) {
                        $("#message").html('<div class="alert alert-warning" role="alert">Error Occured !</div>');
                    }
                });
                return false;
            } else {
                $("#message").html('<div  class="alert alert-warning" role="alert">Password not match</div>');
            }
        }
    </script>
</body>
</html>
