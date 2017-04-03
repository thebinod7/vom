<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="vom.web.Admin.dashboard" %>

<script runat="server">
    public string company_uuid;
    public System.Data.DataRow revenue;
    public System.Data.DataRow proj;
    public System.Data.DataRow emp;
    public System.Data.DataRow task;
    public System.Data.DataRow salary;
    public System.Data.DataRow inpro;
    protected void Page_Load(object sender, EventArgs e)
    {
        company_uuid = Request.QueryString["user_uuid"];
        System.Data.DataTable dt = vom.logic.dal.Factory.Project.ListProjectRevenue();
        if (dt.Rows.Count > 0)
        {
            revenue = dt.Rows[0];
        }
        System.Data.DataTable dtP = vom.logic.dal.Factory.Project.ListProjectCompleted();
        if (dtP.Rows.Count > 0)
        {
            proj = dtP.Rows[0];
        }
        //System.Data.DataTable dtEmp = vom.logic.dal.Factory.Employee.ListEmployeeCount(new Guid(company_uuid));
        //if (dtEmp.Rows.Count > 0)
        //{
        //    emp = dtEmp.Rows[0];
        //}
        System.Data.DataTable dtTask = vom.logic.dal.Factory.Task.ListTaskCompleted();
        if (dtTask.Rows.Count > 0)
        {
            task = dtTask.Rows[0];
        }
        System.Data.DataTable dtSal = vom.logic.dal.Factory.Employee.SalaryPaid();
        if (dtSal.Rows.Count > 0)
        {
            salary = dtSal.Rows[0];
        }
        System.Data.DataTable dtIn = vom.logic.dal.Factory.Project.ListProjectInProgress();
        {
            inpro = dtIn.Rows[0];
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-6">
                    <h2 class="vom-green"><strong>Welcome to Dashboard</strong></h2>
                </div>
                <div id="verify_stat" class="col-md-6">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div id="message"></div>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-4">
                <div class="dbox">
                    <h3 class="text-center text-dbox"><i class="fa fa-money"></i> Revenue (Nrs.)</h3>
                    <div class="inner-dbox">
                        <div class="circle"> <% =revenue["TotalRevenue"] %> </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dbox">
                    <h3 class="text-center text-dbox"><i class="fa fa-folder-open"></i> Projects Done</h3>
                    <div class="inner-dbox">
                        <div class="circle">  <% =proj["TotalProjects"] %> </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dbox">
                    <h3 class="text-center text-dbox"><i class="fa fa-users"></i> Total Employees</h3>
                    <div class="inner-dbox">
                       <%-- <div class="circle"> <% =emp["TotalEmp"] %> </div>--%>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-4">
                <div class="dbox">
                    <h3 class="text-center text-dbox"><i class="fa fa-bars"></i> Task Completed</h3>
                    <div class="inner-dbox">
                        <div class="circle"> <% =task["TotalTask"] %> </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dbox">
                    <h3 class="text-center text-dbox"><i class="fa fa-graduation-cap"></i> Projects in progress </h3>
                    <div class="inner-dbox">
                        <div class="circle"> <% =inpro["InProgressProjects"] %>  </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dbox">
                    <h3 class="text-center text-dbox"><i class="fa fa-rupee"></i> Total Paid Salary / Month</h3>
                    <div class="inner-dbox">
                        <div class="circle">  <% =salary["PaidSalaryAmt"] %> </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="footer_js" runat="server">
    <script>
        $(document).ready(function () {
            $(".circle").each(function () {
                $(this).toLocaleString('en');
            });
        });
        //(function ($) {
        //    $.fn.countTo = function (options) {
        //        // merge the default plugin settings with the custom options
        //        options = $.extend({}, $.fn.countTo.defaults, options || {});

        //        // how many times to update the value, and how much to increment the value on each update
        //        var loops = Math.ceil(options.speed / options.refreshInterval),
        //            increment = (options.to - options.from) / loops;

        //        return $(this).each(function () {
        //            var _this = this,
        //                loopCount = 0,
        //                value = options.from,
        //                interval = setInterval(updateTimer, options.refreshInterval);

        //            function updateTimer() {
        //                value += increment;
        //                loopCount++;
        //                $(_this).html(value.toFixed(options.decimals));

        //                if (typeof (options.onUpdate) == 'function') {
        //                    options.onUpdate.call(_this, value);
        //                }

        //                if (loopCount >= loops) {
        //                    clearInterval(interval);
        //                    value = options.to;

        //                    if (typeof (options.onComplete) == 'function') {
        //                        options.onComplete.call(_this, value);
        //                    }
        //                }
        //            }
        //        });
        //    };

        //    $.fn.countTo.defaults = {
        //        from: 0,  // the number the element should start at
        //        to: 100,  // the number the element should end at
        //        speed: 1000,  // how long it should take to count between the target numbers
        //        refreshInterval: 100,  // how often the element should be updated
        //        decimals: 0,  // the number of decimal places to show
        //        onUpdate: null,  // callback method for every time the element is updated,
        //        onComplete: null,  // callback method for when the element finishes updating
        //    };
        //})(jQuery);

        //jQuery(function ($) {
        //    $('.circle').countTo({
        //        from: 50,
        //        to: 2500,
        //        speed: 1500,
        //        refreshInterval: 50,
        //        onComplete: function (value) {
        //            console.debug(this);
        //        }
        //    });
        //});
    </script>
    
</asp:Content>
