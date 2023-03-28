<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList1.Items.Clear();
            DropDownList2.Items.Clear();

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
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //PostBack;
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (MemberUtiltiy.HasMember(args.Value) == false) //沒找到重複工號
        {
            args.IsValid = true;  //驗證通過

            Member members = new Member()
            {
                EmployeeId = TextBox1.Text,
                Password = TextBox2.Text,
                StaffName = TextBox3.Text,
                Department = DropDownList1.Text,
                JobPosition = DropDownList2.Text
            };

            MemberUtiltiy.AddEmployees(members);

            HiddenField1.Value = "true";  //跳出成功通知
        }
        else
        {
            args.IsValid = false;  //驗證失敗
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "BPM016";
        RequiredFieldValidator1.IsValid = true;
        TextBox2.Text = "999";
        RequiredFieldValidator2.IsValid = true;
        TextBox3.Text = "Mark";
        RequiredFieldValidator3.IsValid = true;
        DropDownList1.SelectedValue = "Production";
        RequiredFieldValidator4.IsValid = true;
        DropDownList2.SelectedValue = "Operator";
        RequiredFieldValidator5.IsValid = true;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
    <link href="css/sweetalert2.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="Server">
    <div class="form-group container-fluid">
        <div class="bg-light rounded h-100 p-4 ">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div>
                        <h6 class="mb-4">員工基本資料新增
                            <asp:Button ID="Button2" class="btn btn-warning btn-sm" runat="server" Style="margin-left: 10px;" OnClick="Button2_Click" Text="Demo" /></h6>
                        <div class="mb-3">
                            <label id="Lebel1" class="form-label">請輸入工號</label>
                            <%--<input type="text" class="form-control" id="InputEmployeeId"
                        aria-describedby="emailHelp">
                    <div id="emailHelp" class="form-text">
                        We'll never share your email with anyone else.
                    </div>--%>
                            <asp:CustomValidator ID="CustomValidator1" ControlToValidate="TextBox1" OnServerValidate="CustomValidator1_ServerValidate" runat="server" ErrorMessage="工號不可重複" ForeColor="Red"></asp:CustomValidator>
                            <asp:TextBox ID="TextBox1" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox1" runat="server" ErrorMessage="工號不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label id="Lebel2" class="form-label">請設定密碼</label>
                            <%--<input type="password" class="form-control" id="exampleInputPassword1">--%>
                            <asp:TextBox ID="TextBox2" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox2" runat="server" ErrorMessage="密碼不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label id="Lebel3" class="form-label">請輸入員工姓名</label>
                            <asp:TextBox ID="TextBox3" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="TextBox3" runat="server" ErrorMessage="姓名不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label id="Lebel4" class="form-label">請選擇部門</label>
                            <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="DropDownList1" InitialValue="" runat="server" ErrorMessage="部門未選擇" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                            <br />
                        </div>
                        <div class="mb-3">
                            <label id="Lebel5" class="form-label">請選擇職位</label>
                            <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="DropDownList2" InitialValue="" runat="server" ErrorMessage="職位未選擇" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:HiddenField ID="HiddenField1" Value="false" runat="server" />
            <asp:Button ID="Button1" class="btn btn-primary" OnClick="Button1_Click" runat="server" Text="送出" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <script>
        $(function ()
        {
            if ($("#BodyHolder_HiddenField1").val() == "true")
            {
                swal({
                    title: '完成',
                    text: "新增資料成功!",
                    type: 'success',
                }).then(
                    function ()
                    {
                        window.location.href = 'AddStaff.aspx';
                    });
            }
        })

    </script>
</asp:Content>

