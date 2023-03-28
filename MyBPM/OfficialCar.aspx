<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    public string Today;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            DropDownList1.Items.Clear();
            List<Vehicle> VehicleItem = MemberUtiltiy.GetVehicleItem();

            foreach (Vehicle item in VehicleItem)
            {
                DropDownList1.Items.Add(item.VehicleNumber.ToString());
            }
        }

        Today = DateTime.Now.ToString("yyyy-MM-dd");
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (!Page.IsValid)
        {
            return;
        }


        Carbooking carbooking = new Carbooking()
        {
            EmployeeId = TextBox1.Text,
            ExNumber = Convert.ToInt32(TextBox2.Text),
            CellPhone = TextBox3.Text,
            VehicleNumber = DropDownList1.SelectedValue,
            UseYear = datepicker.Text.Split('/')[0],
            UseMonth = datepicker.Text.Split('/')[1],
            UseDay = datepicker.Text.Split('/')[2],
            UseHour = timepicker1.Text.Split(':')[0],
            UseMinute = timepicker1.Text.Split(':')[1],
            ReturnHour = timepicker2.Text.Split(':')[0],
            ReturnMinute = timepicker2.Text.Split(':')[1],
            color = MemberUtiltiy.Getcalendarcolor(DropDownList1.SelectedValue)
        };
        MemberUtiltiy.Addvehiclecalendar(carbooking);

        Response.Redirect("~/OfficialCar.aspx");
    }


    protected void DropDownList1_TextChanged(object sender, EventArgs e)
    {

        string selectedValue = DropDownList1.SelectedValue; // 取得選取的值
        Vehicle vehicle = MemberUtiltiy.GetVehicleItem().FirstOrDefault(v => v.VehicleNumber == selectedValue); // 根據值找到對應的 Vehicle 物件
        Label1.Text = vehicle.Model.ToString(); // 如果有找到 Vehicle 物件，則取得 VehicleType 設定給 Label1，否則設定為預設值
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "BPM012";
        RequiredFieldValidator1.IsValid = true;
        TextBox2.Text = "777";
        TextBox3.Text = "0934-951357";
        RequiredFieldValidator2.IsValid = true;
        DropDownList1.SelectedValue = "HPH-6297";
        RequiredFieldValidator3.IsValid = true;
        Label1.Text = "SKODA FABIA 1.0";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
    <link href="Content/themes/base/jquery-ui.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <link href="css/jquery.timepicker.min.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="Server">
    <div class="form-group container-fluid">
        <div class="bg-light rounded h-100 p-4 ">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <h6 class="mb-2">公務車預約<asp:Button ID="Button2" class="btn btn-warning btn-sm" runat="server" style="margin-left: 10px;"  OnClick= "Button2_Click" Text="Demo" /></h6>
                    <div class="row mb-2">
                        <div class="col-md-2">
                            <label id="Lebel1" class="form-label">申請人工號</label>
                            <asp:TextBox ID="TextBox1" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox1" runat="server" ErrorMessage="工號不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                            <label id="Lebel2" class="form-label">分機號碼</label>
                            <asp:TextBox ID="TextBox2" class="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label id="Lebel3" class="form-label">個人手機：09XX-XXXXXX</label>
                            <asp:TextBox ID="TextBox3" class="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox3" runat="server" ErrorMessage="手機不可空白" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-2">
                            <label id="Lebel4" class="form-label">預約車號</label><br />
                            <asp:DropDownList ID="DropDownList1" OnTextChanged="DropDownList1_TextChanged" AutoPostBack="True" runat="server">
                            </asp:DropDownList><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="DropDownList1" runat="server" ErrorMessage="需要選取車號" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                            <label id="Lebel5" class="form-label">車型</label><br />
                            <asp:Label ID="Label1" runat="server" Text="(自動代入)"></asp:Label>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
            <div class="row mb-2" style="position: relative; z-index: 999">
                <div class="col-md-2 mb-2">
                    <label id="Lebel6" class="form-label">用車日期</label><br />
                    <asp:TextBox ID="datepicker" class="form-control" PlaceHolder="點選用車日期" runat="server" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="datepicker" runat="server" ErrorMessage="需要選取日期" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2 mb-2">
                    <label id="Lebel7" class="form-label">取車時間</label><br />
                    <asp:TextBox ID="timepicker1" class="form-control" PlaceHolder="點選取車時間" runat="server" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="timepicker1" runat="server" ErrorMessage="需要選取日期" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2 mb-2">
                    <label id="Lebel8" class="form-label">還車時間</label><br />
                    <asp:TextBox ID="timepicker2" class="form-control" PlaceHolder="點選還車時間" runat="server" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="timepicker2" runat="server" ErrorMessage="需要選取日期" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
            <asp:Button ID="Button1" class="btn btn-primary" OnClick="Button1_Click" runat="server" Text="送出" />
        </div>
        <div id="calendar" class="mt-4 mb-4" style="position: relative; z-index: 0"></div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="Scripts/jquery-ui-1.13.2.min.js"></script>
    <script src="js/jquery.timepicker.min.js"></script>
    <script src="js/index.global.min.js"></script>
    <script src="js/locales-all.global.min.js"></script>
    <script>
        $(function ()
        {
            $("#BodyHolder_datepicker").datepicker({ //指向網頁ID為BodyHolder_datepicker
                showAnim: "slideDown",  //動畫效果:
                dateFormat: "yy/mm/dd",  //呈現的格式
                firstDay: 1, //每週的第一天是星期一
                monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"]
            });

            $("#BodyHolder_timepicker1").timepicker({
                timeFormat: "HH:mm", // 時間格式
                interval: 30, // 時間間隔，單位為分鐘
                minTime: "9:00", // 最小時間
                maxTime: "18:00", // 最大時間
                dropdown: true, // 是否顯示下拉選單
                scrollbar: true, // 是否顯示滾動條
                dynamic: false, //動態顯示下拉選單 false->重新點選擇從預設值開始
            });

            $("#BodyHolder_timepicker2").timepicker({
                timeFormat: "HH:mm", // 時間格式
                interval: 30, // 時間間隔，單位為分鐘
                minTime: "9:00", // 最小時間
                maxTime: "18:00", // 最大時間
                dropdown: true, // 是否顯示下拉選單
                scrollbar: true, // 是否顯示滾動條
                dynamic: false, //動態顯示下拉選單 false->重新點選擇從預設值開始
            });
        });

        document.addEventListener('DOMContentLoaded', function ()
        {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'timeGridWeek',
                allDaySlot: false, //不顯示全天窗格
                headerToolbar: {
                    left: 'prev,next, today',
                    center: 'title',
                    right: 'timeGridWeek,timeGridDay,listWeek' // user can switch between the two
                },

                locale: 'zh-tw', // 設定語言為繁體中文
                editable: false,
                navLinks: true, // can click day/week names to navigate views
                MaxEvents: true, // allow "more" link when too many events
                slotEventOverlap: false, //事件不重疊
                slotLabelFormat: { hour: '2-digit', minute: '2-digit', hour12: false }, // 24 小時制，例如 14:30
                slotMinTime: '09:00',  //最小顯示時間
                slotMaxTime: '18:00',   //最大顯示時間
                height: 'auto', // 自動調整高度
                firstDay: 1, //每周的第一天為星期幾  1->星期一, 0->星期日
                hiddenDays: [0, 6],
                initialDate: '<%=Today%>',
                events: {
                    url: 'JsonCarbooking.aspx',
                }

            });



            calendar.render();
            calendar.setOption('locale', "zh-TW");

        });
    </script>
</asp:Content>

