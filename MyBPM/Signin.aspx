<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

        Member member = MemberUtiltiy.FindMember(floatingInput.Text, floatingPassword.Text);
        if (member != null)
        {
            Session["LoginId"] = member.EmployeeId;
            Session["LoginName"] = member.StaffName;
            Session["JobPosition"] = member.JobPosition;
            Session["Department"] = member.Department;
            Response.Redirect("~/Index.aspx");
        }
        else
        {
            Label1.Text = "帳號或密碼錯誤";
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        floatingInput.Text = "BPM001";
        floatingPassword.Attributes["value"] = "123";
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        floatingInput.Text = "BPM012";
        floatingPassword.Attributes["value"] = "317";
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        floatingInput.Text = "BPM003";
        floatingPassword.Attributes["value"] = "789";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>sign in</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet" />

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-xxl position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sign In Start -->
            <div class="container-fluid">
                <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                    <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                        <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <a href="index.html" class="">

                                    <h3 class="text-primary">BPM SYSTEM</h3>
                                </a>
                                <h3>Sign In</h3>
                            </div>
                            <div>
                                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="form-floating mb-4">
                                        <asp:Button ID="Button2" class="btn btn-warning btn-sm" OnClick="Button2_Click" runat="server" Text="總經理Demo" />
                                        <asp:Button ID="Button3" class="btn btn-warning btn-sm" OnClick="Button3_Click" runat="server" Text="使用者Demo" />
                                        <asp:Button ID="Button4" class="btn btn-warning btn-sm" OnClick="Button4_Click" runat="server" Text="人資Demo" />
                                        </div>
                                        <div class="form-floating mb-3">
                                            <%--<input type="text" class="form-control" id="floatingInput" placeholder="EmployeeID" />--%>
                                            <asp:TextBox ID="floatingInput" runat="server" class="form-control" placeholder="EmployeeID"></asp:TextBox>
                                            <label for="floatingInput">EmployeeID</label>
                                        </div>
                                        <div class="form-floating mb-4">
                                            <%--<input type="password" class="form-control" id="floatingPassword" placeholder="Password" />--%>
                                            <asp:TextBox ID="floatingPassword" TextMode="Password" runat="server" class="form-control" placeholder="Password"></asp:TextBox>
                                            <label for="floatingPassword">Password</label>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                            <%--<div class="d-flex align-items-center justify-content-between mb-4">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="exampleCheck1" />
                                    <label class="form-check-label" for="exampleCheck1">記住我的工號</label>
                                </div>
                                <div class="form-check">
                                    <a class="form-check-label" href="#">忘記密碼?</a>
                                </div>
                            </div>--%>
                            <%--<button type="submit" class="btn btn-primary py-3 w-100 mb-4">登入</button>--%>
                            <asp:Button ID="Button1" runat="server" Text="登入" OnClick="Button1_Click" class="btn btn-primary py-3 w-100 mb-4" />
                            <p class="text-center mb-0">
                                <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </p>
                            <p class="text-center mb-0">沒有帳號？ 忘記密碼？ 請與人資聯絡 <%--<a href="#">Sign Up</a>--%></p>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Sign In End -->
        </div>
    </form>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/chart/chart.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>
</html>
