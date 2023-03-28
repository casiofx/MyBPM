<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        List<Drawing> drawings = MemberUtiltiy.GetDrawings();
        Repeater1.DataSource = drawings;
        Repeater1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender; // 取得按下的按鈕
        RepeaterItem item = (RepeaterItem)btn.NamingContainer; // 取得所在的Repeater項目
        string fileName = ((Label)item.FindControl("Label5")).Text; // 取得檔案名稱

        // 設定檔案的內容型別
        Response.ContentType = "application/octet-stream";
        // 設定下載的檔案名稱
        Response.AddHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        // 讀取檔案並寫入Response
        string filePath = Server.MapPath($"~/Drawing/{fileName}");
        Response.TransmitFile(filePath);
        Response.End();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="Server">
    <div class="form-group container-fluid">
        <div class="bg-light rounded h-100 p-4 ">
            <h6 class="mb-2">圖面列表</h6>
            <div>
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th class="col-2 text-center">料號</th>
                                    <th class="col-2 text-center">專案</th>
                                    <th class="text-center">檔名</th>
                                    <th class="col-2 text-center">功能</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-center">
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("PartNumber")%>'></asp:Label>
                            </td>
                            <td class="text-center">
                                <asp:Label ID="Label4" class="text-center" runat="server" Text='<%# Eval("ProjectName")%>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("DrawingName")%>'></asp:Label>
                            </td>
                            <td  class="text-center">
                                <asp:Button ID="Button1" runat="server" Text="下載" OnClick="Button1_Click" src='/Drawing<%# Eval("DrawingName")%>' />
                                <%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "Drawing/" + Eval("DrawingName") %>' Text="下載" />--%>
                            </td>

                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
</asp:Content>

