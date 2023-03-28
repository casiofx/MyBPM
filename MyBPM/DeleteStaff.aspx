<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Label2.Text = "";
        Label3.Text = "";
        Label4.Text = "";
        Label5.Text = "";
        Label6.Text = "";
        Label7.Text = "";

        if (PlaceHolder1.Visible == true)
        {
            PlaceHolder1.Visible = false;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {


        if (MemberUtiltiy.HasMember(TextBox1.Text))
        {
            PlaceHolder1.Visible = true;

            Member members = MemberUtiltiy.FindMember(TextBox1.Text);
            Label3.Text = members.EmployeeId;
            Label4.Text = members.Password;
            Label5.Text = members.StaffName;
            Label6.Text = members.Department;
            Label7.Text = members.JobPosition;
        }
        else
        {
            Label2.Text = "查無資料";
            PlaceHolder1.Visible = false;
        }

    }

    protected void Button2_Click(object sender, EventArgs e)
    {

        MemberUtiltiy.DeleteMember(TextBox1.Text);
        Response.Write("~/DeleteStaff.aspx");
        TextBox1.Text = "";

    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "BPM016";
        RequiredFieldValidator1.IsValid = true;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
    <link href="css/sweetalert2.min.css" rel="stylesheet" />
    <style>
        table {
            table-layout: fixed;
        }

            table td:first-child {
                width: 100px; /* 設定第一個欄位的寬度 */
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="Server">
    <div class="form-group container-fluid">
        <div class="bg-light rounded h-100 p-4 ">
            <h6 class="mb-4">員工基本資料刪除</h6>
            <div>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div>
                    <label id="Label1" class="form-label">請輸入工號查詢 <asp:Button ID="Button3" class="btn btn-warning btn-sm" runat="server" style="margin-left: 10px;" OnClick="Button3_Click" Text="Demo" /> </label>
                    <%--<input type="text" class="form-control" id="InputEmployeeId"
                        aria-describedby="emailHelp">
                    <div id="emailHelp" class="form-text">
                        We'll never share your email with anyone else.
                    </div>--%>
                    <asp:TextBox ID="TextBox1" class="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox1" runat="server" ErrorMessage="工號不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                

                <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
                <asp:Button ID="Button1" class="btn btn-primary" OnClick="Button1_Click" runat="server" Text="送出" />
                <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label>
                <asp:PlaceHolder ID="PlaceHolder1" Visible="false" runat="server">
                    <h6 class="mb-2 mt-4">查詢結果</h6>
                    <table class="table ">
                        <thead>
                            <tr>
                                <th>工號</th>
                                <th>密碼</th>
                                <th>姓名</th>
                                <th>部門</th>
                                <th>職位</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                                    <%--<asp:TextBox ID="TextBox3" Text="" Width="100px" runat="server"></asp:TextBox>--%>
                                </td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                                    <%--<asp:TextBox ID="TextBox4" Text="" Width="100px" runat="server"></asp:TextBox>--%>
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
                                    <%--<asp:DropDownList ID="DropDownList1" Width="100px" runat="server"></asp:DropDownList>--%>
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
                                    <%--<asp:DropDownList ID="DropDownList2" Width="100px" runat="server"></asp:DropDownList>--%>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <%--<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />--%>
                    <asp:Button ID="Button2" class="btn btn-success" OnClick="Button2_Click" runat="server" Text="刪除" OnClientClick="return false" />
                </asp:PlaceHolder>
                <%--</ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <script>

        $(function ()
        {
            $("#BodyHolder_Button2").click(function ()
            {
                swal({
                    title: '確認',
                    text: '資料將被刪除!',
                    type: 'warning',
                    showCancelButton: true
                }).then(
                    function ()
                    {
                        $("#__EVENTTARGET").val("ctl00$BodyHolder$Button2");
                        $("#form1").submit();
                    }
                );
            });
        });

    </script>
</asp:Content>

