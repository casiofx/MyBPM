<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        Label2.Text = "";
        DropDownList1.Items.Clear();
        DropDownList2.Items.Clear();

        if (PlaceHolder1.Visible == true)
        {
            PlaceHolder1.Visible = false;
        }

        if (MemberUtiltiy.HasMember(TextBox1.Text))
        {
            PlaceHolder1.Visible = true;
            List<string> Depts = MemberUtiltiy.GetItemData("Department");
            foreach (string item in Depts)
            {
                DropDownList1.Items.Add(item);
            }

            List<string> JobPos = MemberUtiltiy.GetItemData("JobPosition");
            foreach (string item in JobPos)
            {
                DropDownList2.Items.Add(item);
            }

            Member members = MemberUtiltiy.FindMember(TextBox1.Text);
            Label3.Text = members.EmployeeId;
            TextBox3.Text = members.Password;
            TextBox4.Text = members.StaffName;
            DropDownList1.SelectedValue = members.Department;
            DropDownList2.SelectedValue = members.JobPosition;
        }
        else
        {
            Label2.Text = "查無資料";
            PlaceHolder1.Visible = false;
        }

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Member members = new Member()
        {
            EmployeeId = TextBox1.Text,
            Password = TextBox3.Text,
            StaffName = TextBox4.Text,
            Department = DropDownList1.SelectedValue,
            JobPosition = DropDownList2.SelectedValue
        };

        MemberUtiltiy.UpdateMember(members);

        HiddenField1.Value = "true";  //跳出成功通知
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
            <h6 class="mb-4">員工基本資料修改</h6>
            <div>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div> 
                    <label id="Label1" class="form-label">請輸入工號查詢<asp:Button ID="Button3" class="btn btn-warning btn-sm" runat="server" style="margin-left: 10px;" OnClick="Button3_Click" Text="Demo" /> </label>
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
                    <table class="table">
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
                                    <asp:TextBox ID="TextBox3" Text="" Width="100px" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox4" Text="" Width="100px" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" Width="100px" runat="server"></asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" Width="100px" runat="server"></asp:DropDownList>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <asp:Button ID="Button2" class="btn btn-success" OnClick="Button2_Click" runat="server" Text="修改" />
                    <asp:HiddenField ID="HiddenField1" Value="false" runat="server" />
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

        $(function () {
            if ($("#BodyHolder_HiddenField1").val() == "true") {
                swal({
                    title: '完成',
                    text: "修改資料成功!",
                    type: 'success',
                }).then(
                    function () {
                        window.location.href = 'UpdateStaff.aspx';
                    });
            }
        })

    </script>
</asp:Content>

