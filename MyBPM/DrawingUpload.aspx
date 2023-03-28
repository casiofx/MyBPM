<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
        {
            return;
        }
        //FileUpload1.SaveAs(Server.MapPath(FileUpload1.FileName));
        //FileUpload1.SaveAs(Server.MapPath("~/"));
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (MemberUtiltiy.HasDrawing(FileUpload1.FileName) == false)
        {
            Drawing drawing = new Drawing()
            {
                PartNumber = TextBox1.Text,
                ProjectName = TextBox2.Text,
                DrawingName = FileUpload1.FileName
            };
            MemberUtiltiy.AddDrawing(drawing);
            FileUpload1.SaveAs(Server.MapPath($"~/Drawing/{FileUpload1.FileName}"));
            HiddenField1.Value = "true";
        }
        else
        {
            args.IsValid = false;  //驗證失敗
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "920100289";
        TextBox2.Text = "X510";
        RequiredFieldValidator1.IsValid = true;
        RequiredFieldValidator2.IsValid = true;
        RequiredFieldValidator3.IsValid = true;

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
                    <h6 class="mb-2">圖面上傳
                        <asp:Button ID="Button2" class="btn btn-warning btn-sm" runat="server" Style="margin-left: 10px;" OnClick="Button2_Click" Text="Demo" /></h6>
            <div class="row mb-2">
                        <div class="col-md-2">
                            <label id="Lebel1" class="form-label">料號</label>
                            <asp:TextBox ID="TextBox1" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox1" runat="server" ErrorMessage="料號不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                            <label id="Lebel2" class="form-label">專案名稱</label>
                            <asp:TextBox ID="TextBox2" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox2" runat="server" ErrorMessage="專案名稱不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-3 ">
                            <label id="Lebel3" class="form-label">圖檔上傳</label>
                            <div class="input-group">
                                <span class="btn btn-info">
                                    <asp:FileUpload ID="FileUpload1" runat="server" /></span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="FileUpload1" runat="server" ErrorMessage="檔案需選擇" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator1" ControlToValidate="FileUpload1" OnServerValidate="CustomValidator1_ServerValidate" runat="server" ErrorMessage="已有重複檔名" ForeColor="Red"></asp:CustomValidator>

                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <asp:HiddenField ID="HiddenField1" Value="false" runat="server" />
            <asp:Button ID="Button1" class="btn btn-primary" OnClick="Button1_Click" runat="server" Text="送出" />
        </div>
        <div id="calendar" class="mt-4 mb-4" style="position: relative; z-index: 0"></div>
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
                    text: "新增資料成功!",
                    type: 'success',
                }).then(
                    function () {
                        window.location.href = 'DrawingUpload.aspx';
                    });
            }
        })
    </script>
</asp:Content>

