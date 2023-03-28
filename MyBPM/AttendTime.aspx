<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="System.Data" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (HiddenField2.Value != "")
        {
            Worktimer Updatedworktimer = new Worktimer()
            {
                EmployeeId = HiddenField2.Value,
                Workdate = HiddenField1.Value,
                Clockin = HiddenField3.Value,
                Clockout = HiddenField4.Value
            };

            MemberUtiltiy.UpdateTimer(Updatedworktimer);
        }

    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-table.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/x-editable@1.5.1/dist/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="Server">
    <div class="form-group container-fluid">
        <div class="bg-light rounded h-100 p-4 ">
            <h6 class="mb-2">員工出勤資料管理</h6>
            <asp:HiddenField ID="HiddenField1" Value="" runat="server" />
            <asp:HiddenField ID="HiddenField2" Value="" runat="server" />
            <asp:HiddenField ID="HiddenField3" Value="" runat="server" />
            <asp:HiddenField ID="HiddenField4" Value="" runat="server" />
            <div>
                <table class="table table-striped" id="table"
                    data-toggle="table"
                    data-url="JsonData.aspx"
                    data-pagination="true"
                    data-page-list="[5, 10, 15]"
                    data-search="true"
                    data-editable="true">
                    <thead>
                        <tr>
                            <th data-field="Workdate" data-sortable="true">日期</th>
                            <th data-field="EmployeeId" data-toggle="editable" data-sortable="true">工號</th>
                            <th data-field="StaffName" data-toggle="editable" data-sortable="true">姓名</th>
                            <th data-field="Department" data-sortable="true">部門</th>
                            <th data-field="Clockin" data-sortable="true" data-editable="true">上班</th>
                            <th data-field="Clockout" data-sortable="true" data-editable="true">下班</th>
                            <th data-field="Attendstate" data-sortable="true" data-formatter="attendStateFormatter">出勤</th>
                        </tr>
                    </thead>
                </table>
                <asp:Button ID="Button1" class="btn btn-success" OnClick="Button1_Click" runat="server" Text="存檔" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
    <script src="js/jquery-3.6.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-table.min.js"></script>
    <script src="js/bootstrap-editable.min.js"></script>
    <script src="js/bootstrap-table-editable.min.js"></script>
    <script>
        $(function ()
        {
            $('#table').bootstrapTable()
        })
        $(function ()
        {
            $('#table').editable();
        });
        $(function ()
        {
            $.fn.editable.defaults.mode = 'inline';
            $.fn.editable.defaults.showbuttons = false;
            $('[data-toggle="editable"]').editable();
        });
        $(function ()
        {
            $('#table').on('editable-save.bs.table', function (e, field, row, oldValue, $el)
            {
                //console.log(field); // => Clockin 欄位名稱
                //console.log(row); // => 那一行的資料

                console.log(row.Workdate);   //日期
                console.log(row.EmployeeId); //工號
                console.log(row.Clockin);    //上班
                console.log(row.Clockout);   //下班

                $('#BodyHolder_HiddenField1').val(row.Workdate);
                $('#BodyHolder_HiddenField2').val(row.EmployeeId);
                $('#BodyHolder_HiddenField3').val(row.Clockin);
                $('#BodyHolder_HiddenField4').val(row.Clockout);

            });
        });

        function attendStateFormatter(value, row, index)
        {
            if (value === '異常')
            {
                return '<span style="color: red">' + value + '</span>';
            }
            else if (value === '正常')
            {
                return '<span style="color: blue">' + value + '</span>';
            }
            else
            {
                return value;
            }
        }

    </script>
</asp:Content>
