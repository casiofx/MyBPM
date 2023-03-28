<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Page.IsCallback == false)
        {
            List<string> Years = MemberUtiltiy.GetDateYYMMDDItem("ClockinYear");
            foreach (string item in Years)
            {
                DropDownList1.Items.Add(item);
            }

            List<string> Months = MemberUtiltiy.GetDateYYMMDDItem("ClockinMonth");
            foreach (string item in Months)
            {
                DropDownList2.Items.Add(item);
            }
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {

        string QueEmpid = Session["LoginId"].ToString();
        string QueYear = DropDownList1.SelectedValue;
        string QueyMonth = DropDownList2.SelectedValue;

        List<Worktimer> timers = MemberUtiltiy.GetTimers(QueEmpid, QueYear, QueyMonth);

        Repeater1.DataSource = timers;
        Repeater1.DataBind();

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="Server">
    <div class="form-group container-fluid">
        <div class="bg-light rounded h-100 p-4 ">
            <h6 class="mb-2">個人出勤資料查詢</h6>
            <div class="mb-2">
                <asp:Label ID="Label1" runat="server" Text="時間："></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
                <asp:Label ID="Label2" runat="server" Text="年，"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Value=""></asp:DropDownList>
                <asp:Label ID="Label10" runat="server" Text="日"></asp:Label>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="Button1" Class="btn btn-primary m-lg-2" runat="server" Text="查詢" OnClick="Button1_Click" />
                        <div>
                            <asp:Repeater ID="Repeater1" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th class="col-1 text-center">日期</th>
                                                <th class="col-1 text-center">工號</th>
                                                <th class="col-1">姓名</th>
                                                <th class="col-1">部門</th>
                                                <th class="text-center col-1">上班</th>
                                                <th class="text-center col-1">下班</th>
                                                <th class="text-center col-1">出勤</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="text-center">
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Workdate")%>'></asp:Label>
                                        </td>
                                        <td class="text-center">
                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("EmployeeId")%>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("StaffName")%>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Department")%>'></asp:Label>
                                        </td>

                                        <td class="text-center">
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("ClockIn")%>'></asp:Label>
                                        </td>
                                        <td class="text-center">
                                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("ClockOut")%>'></asp:Label>
                                        </td>
                                        <td class="text-center">
                                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("Attendstate")%>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                  </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
</asp:Content>

