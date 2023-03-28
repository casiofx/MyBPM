using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Data.SqlClient;
using System.Data;

public class MemberUtiltiy
{
    //幫忙從資料來源(txt),讀取資料並轉成物件集合(List<Member>)

    public static List<Member> GetMembers()
    {
        //1.用LINQ方式處理
        SqlDataAdapter da = new SqlDataAdapter(
           "select * from Employees",
           Common.MyDBConnStr);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return dt.AsEnumerable().Select(
            row => new Member()
            {
                Id = Convert.ToInt32(row["Id"]),
                EmployeeId = row["EmployeeId"].ToString(),
                Password = row["Password"].ToString(),
                StaffName = row["StaffName"].ToString(),
                Department = row["Department"].ToString(),
                JobPosition = row["JobPosition"].ToString()
            }).ToList();

        //2.
        //SqlDataAdapter da = new SqlDataAdapter(
        //   "select * from Members",
        //   Common.MyDBConnStr);

        //DataTable dt = new DataTable();

        //da.Fill(dt);

        //List<Member> members = new List<Member>();

        //foreach (DataRow row in dt.Rows)
        //{
        //    Member m = new Member() { 
        //        UserName= row["UserName"].ToString(),
        //        Password= row["Password"].ToString()
        //    };

        //    members.Add(m);
        //}

        //return members;
    }



    public static List<Worktimer> GetTimers()
    {
        SqlDataAdapter da1 = new SqlDataAdapter(
            "SELECT Id, EmployeeId, StaffName, Department FROM Employees", Common.MyDBConnStr);
        DataTable dt1 = new DataTable();
        da1.Fill(dt1);

        SqlDataAdapter da2 = new SqlDataAdapter(
            "SELECT EmployeeId,ClockinYear, ClockinMonth, ClockinDay, ClockinHour, ClockinMinute, ClockoutHour, ClockoutMinute " +
            "FROM Worktimers ", Common.MyDBConnStr);
        DataTable dt2 = new DataTable();

        da2.Fill(dt2);

        return (from row1 in dt1.AsEnumerable()
                join row2 in dt2.AsEnumerable()
                on row1["EmployeeId"] equals row2["EmployeeId"]
                select new Worktimer
                {
                    Id = Convert.ToInt32(row1["Id"]),
                    EmployeeId = row1["EmployeeId"].ToString(),
                    StaffName = row1["StaffName"].ToString(),
                    Department = row1["Department"].ToString(),
                    Workdate = row2["ClockinYear"].ToString() + "/" + row2["ClockinMonth"].ToString() + "/" + row2["ClockinDay"].ToString(),
                    Clockin = row2["ClockinHour"].ToString() + ":" + row2["ClockinMinute"].ToString(),
                    Clockout = row2["ClockoutHour"].ToString() + ":" + row2["ClockoutMinute"].ToString(),
                    Attendstate = ""
                }).ToList().OrderByDescending(w => DateTime.Parse(w.Workdate))
                .Select(s =>
                {
                    DateTime clockin = DateTime.Parse(s.Clockin);
                    DateTime clockout = DateTime.Parse(s.Clockout);
                    TimeSpan duration = clockout - clockin;

                    if (duration.TotalHours >= 9)
                    {
                        s.Attendstate = "正常";
                    }
                    else s.Attendstate = "異常";

                    return s;
                }).ToList();
    }

    public static List<Worktimer> GetTimers(string EmpId, string Year, string Month)
    {
        SqlDataAdapter da1 = new SqlDataAdapter(
            "SELECT Id, EmployeeId, StaffName, Department FROM Employees WHERE EmployeeId=@EmployeeId ", Common.MyDBConnStr);
        da1.SelectCommand.Parameters.AddWithValue("@EmployeeId", EmpId);
        DataTable dt1 = new DataTable();
        da1.Fill(dt1);

        SqlDataAdapter da2 = new SqlDataAdapter(
            "SELECT EmployeeId,ClockinYear, ClockinMonth, ClockinDay, ClockinHour, ClockinMinute, ClockoutHour, ClockoutMinute " +
            "FROM Worktimers " +
            "WHERE EmployeeId=@EmployeeId AND ClockinYear=@Year AND ClockinMonth=@Month"
            , Common.MyDBConnStr);
        da2.SelectCommand.Parameters.AddWithValue("@EmployeeId", EmpId);
        da2.SelectCommand.Parameters.AddWithValue("@Year", Year);
        da2.SelectCommand.Parameters.AddWithValue("@Month", Month);
        DataTable dt2 = new DataTable();

        da2.Fill(dt2);

        return (from row1 in dt1.AsEnumerable()
                join row2 in dt2.AsEnumerable()
                on row1["EmployeeId"] equals row2["EmployeeId"]
                select new Worktimer
                {
                    Id = Convert.ToInt32(row1["Id"]),
                    EmployeeId = row1["EmployeeId"].ToString(),
                    StaffName = row1["StaffName"].ToString(),
                    Department = row1["Department"].ToString(),
                    Workdate = row2["ClockinYear"].ToString() + "/" + row2["ClockinMonth"].ToString() + "/" + row2["ClockinDay"].ToString(),
                    Clockin = row2["ClockinHour"].ToString() + ":" + row2["ClockinMinute"].ToString(),
                    Clockout = row2["ClockoutHour"].ToString() + ":" + row2["ClockoutMinute"].ToString(),
                    Attendstate = ""
                }).ToList().OrderByDescending(w => DateTime.Parse(w.Workdate))
                .Select(s =>
                {
                    DateTime clockin = DateTime.Parse(s.Clockin);
                    DateTime clockout = DateTime.Parse(s.Clockout);
                    TimeSpan duration = clockout - clockin;

                    if (duration.TotalHours >= 9)
                    {
                        s.Attendstate = "正常";
                    }
                    else s.Attendstate = "異常";

                    return s;
                }).ToList();
    }



    public static bool HasMember(string name)
    {
        List<Member> members = GetMembers();

        //SingleOrDefault => 找"唯一"的一筆資料用,當結果可能超過一筆,請改用where
        Member member = members.Where(m => m.EmployeeId == name).FirstOrDefault();

        if (member == null)
        {
            //沒找到
            return false;
        }
        else
        {
            //有找到
            return true;
        }
    }

    public static Member FindMember(string name)
    {
        List<Member> members = GetMembers();

        //SingleOrDefault => 找"唯一"的一筆資料用,當結果可能超過一筆,請改用where
        Member member =
            members.SingleOrDefault(m => m.EmployeeId == name);

        return member;
    }

    public static Member FindMember(string name, string pwd)
    {
        List<Member> members = GetMembers();

        //SingleOrDefault => 找"唯一"的一筆資料用,當結果可能超過一筆,請改用where
        Member member =
            members.SingleOrDefault(m => m.EmployeeId == name && m.Password == pwd);

        return member;
    }


    public static void AddEmployees(Member member)
    {
        //查資料 SqlDataAdapter + DataTable

        //新增、修改、刪除 SqlConnection + SqlCommand

        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);

        SqlCommand cmd = new SqlCommand(
            "insert into Employees values(@UserName, @Password, @StaffName, @Department, @JobPosition)",
            cn);

        cmd.Parameters.AddWithValue("@UserName", member.EmployeeId);
        cmd.Parameters.AddWithValue("@Password", member.Password);
        cmd.Parameters.AddWithValue("@StaffName", member.StaffName);
        cmd.Parameters.AddWithValue("@Department", member.Department);
        cmd.Parameters.AddWithValue("@JobPosition", member.JobPosition);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void DeleteMember(string EmpId)
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);

        SqlCommand cmd = new SqlCommand("Delete From Employees Where EmployeeId=@EmployeeId", cn);

        cmd.Parameters.AddWithValue("@EmployeeId", EmpId);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }


    public static void UpdateMember(Member member)
    {

        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);

        SqlCommand cmd = new SqlCommand(
            "update Employees set Password=@Password, " +
            "StaffName=@StaffName, Department=@Department, JobPosition=@JobPosition " +
            "WHERE EmployeeId=@EmployeeId", cn);

        cmd.Parameters.AddWithValue("@EmployeeId", member.EmployeeId);
        cmd.Parameters.AddWithValue("@Password", member.Password);
        cmd.Parameters.AddWithValue("@StaffName", member.StaffName);
        cmd.Parameters.AddWithValue("@Department", member.Department);
        cmd.Parameters.AddWithValue("@JobPosition", member.JobPosition);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }


    public static List<string> GetItemData(string ItemName)
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);
        String StrQuery = $"SELECT DISTINCT {ItemName} FROM Employees";
        SqlDataAdapter da = new SqlDataAdapter(StrQuery, cn);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<string> DropListItems = new List<string>() {""};

        foreach (DataRow item in dt.Rows)
        {
            string EachItem = item[0].ToString();
            DropListItems.Add(EachItem);
        }
        return DropListItems;

    }

    public static List<string> GetDateYYMMDDItem(string DateSTR)
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);
        String StrQuery = $"SELECT DISTINCT {DateSTR} FROM Worktimers";
        SqlDataAdapter da = new SqlDataAdapter(StrQuery, cn);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<string> DropListItems = new List<string>();

        foreach (DataRow item in dt.Rows)
        {
            string EachItem = item[0].ToString();
            DropListItems.Add(EachItem);
        }
        return DropListItems;

    }
    public static List<Vehicle> GetVehicleItem()
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);
        SqlDataAdapter da = new SqlDataAdapter("SELECT VehicleNumber,Model FROM Vehicles", cn);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<Vehicle> DropListItems = new List<Vehicle>
        {
            new Vehicle { VehicleNumber="", Model = ""},
        };

        foreach (DataRow item in dt.Rows)
        {
            Vehicle vehicle = new Vehicle
            {
                VehicleNumber = item["VehicleNumber"].ToString(),
                Model = item["Model"].ToString()
            };

            DropListItems.Add(vehicle);
        }
        return DropListItems;

    }

    public static List<Carcalendar> GetCarbookingData()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT SN,EmployeeId,ExNumber,CellPhone,VehicleNumber," +
            "UseYear,UseMonth,UseDay,UseHour,UseMinute," +
            "ReturnHour,ReturnMinute,Color FROM Carbookings", Common.MyDBConnStr);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return dt.AsEnumerable().Select(row => new Carcalendar()
        {
            id = Convert.ToInt32(row["SN"]),
            title = $"車號:{row["VehicleNumber"]}, 使用者:{row["EmployeeId"]}, 分機:{row["ExNumber"]}, 手機{row["CellPhone"]}",
            start = $"{row["UseYear"]}-{row["UseMonth"]}-{row["UseDay"]}T{row["UseHour"]}:{row["UseMinute"]}:00",
            end = $"{row["UseYear"]}-{row["UseMonth"]}-{row["UseDay"]}T{row["ReturnHour"]}:{row["ReturnMinute"]}:00",
            color = row["Color"].ToString()
        }).ToList();

    }

    public static string Getcalendarcolor(string VehicleNumber)
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);
        SqlCommand cmd = new SqlCommand(
            "SELECT Distinct Color FROM Carbookings WHERE VehicleNumber=@VehicleNiumber", cn);
        cmd.Parameters.AddWithValue("@VehicleNiumber", VehicleNumber);

        cn.Open();
        string result = cmd.ExecuteScalar().ToString();
        cn.Close();
        return result;
    }
    public static void Addvehiclecalendar(Carbooking carbooking)
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into Carbookings values(" +
            "@EmployeeId, @ExNumber, @CellPhone, @VehicleNumber," +
            " @UseYear, @UseMonth, @UseDay, @UseHour, @UseMinute, @ReturnHour, @ReturnMinute, @color)",
            cn);

        cmd.Parameters.AddWithValue("@EmployeeId", carbooking.EmployeeId);
        cmd.Parameters.AddWithValue("@ExNumber", carbooking.ExNumber);
        cmd.Parameters.AddWithValue("@CellPhone", carbooking.CellPhone);
        cmd.Parameters.AddWithValue("@VehicleNumber", carbooking.VehicleNumber);
        cmd.Parameters.AddWithValue("@UseYear", carbooking.UseYear);
        cmd.Parameters.AddWithValue("@UseMonth", carbooking.UseMonth);
        cmd.Parameters.AddWithValue("@UseDay", carbooking.UseDay);
        cmd.Parameters.AddWithValue("@UseHour", carbooking.UseHour);
        cmd.Parameters.AddWithValue("@UseMinute", carbooking.UseMinute);
        cmd.Parameters.AddWithValue("@ReturnHour", carbooking.ReturnHour);
        cmd.Parameters.AddWithValue("@ReturnMinute", carbooking.ReturnMinute);
        cmd.Parameters.AddWithValue("@color", carbooking.color);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void UpdateTimer(Worktimer worktimer)
    {

        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);
        SqlCommand cmd = new SqlCommand(
            "UPDATE Worktimers SET ClockinHour=@ClockinHour, " +
            "ClockinMinute=@ClockinMinute, ClockoutHour=@ClockoutHour, " +
            "ClockoutMinute=@ClockoutMinute " +
            "WHERE EmployeeId=@EmployeeId AND ClockinYear=@ClockinYear " +
            "AND ClockinMonth=@ClockinMonth AND ClockinDay=@ClockinDay", cn);

        cmd.Parameters.AddWithValue("@EmployeeId", worktimer.EmployeeId);
        cmd.Parameters.AddWithValue("@ClockinHour", worktimer.Clockin.Split(':')[0]);
        cmd.Parameters.AddWithValue("@ClockinMinute", worktimer.Clockin.Split(':')[1]);
        cmd.Parameters.AddWithValue("@ClockoutHour", worktimer.Clockout.Split(':')[0]);
        cmd.Parameters.AddWithValue("@ClockoutMinute", worktimer.Clockout.Split(':')[1]);
        cmd.Parameters.AddWithValue("@ClockinYear", worktimer.Workdate.Split('/')[0]);
        cmd.Parameters.AddWithValue("@ClockinMonth", worktimer.Workdate.Split('/')[1]);
        cmd.Parameters.AddWithValue("@ClockinDay", worktimer.Workdate.Split('/')[2]);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void AddDrawing(Drawing drawing)
    {
        SqlConnection cn = new SqlConnection(Common.MyDBConnStr);

        SqlCommand cmd = new SqlCommand(
            "insert into Drawings values(@PartNumber, @ProjectName, @DrawingName)",
            cn);

        cmd.Parameters.AddWithValue("@PartNumber", drawing.PartNumber);
        cmd.Parameters.AddWithValue("@ProjectName", drawing.ProjectName);
        cmd.Parameters.AddWithValue("@DrawingName", drawing.DrawingName);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static List<Drawing> GetDrawings()
    {
        //1.用LINQ方式處理
        SqlDataAdapter da = new SqlDataAdapter(
           "select * from Drawings",
           Common.MyDBConnStr);
        DataTable dt = new DataTable();
        da.Fill(dt);

        return dt.AsEnumerable().Select(
            row => new Drawing()
            {
                SN = Convert.ToInt32(row["SN"]),
                PartNumber = row["PartNumber"].ToString(),
                ProjectName = row["ProjectName"].ToString(),
                DrawingName = row["DrawingName"].ToString(),
            }).ToList();
    }

        public static bool HasDrawing(string name)
    {
        List<Drawing> drawing = GetDrawings();

        //SingleOrDefault => 找"唯一"的一筆資料用,當結果可能超過一筆,請改用where
        Drawing drawings = drawing.Where(m => m.DrawingName == name).FirstOrDefault();

        if (drawings == null)
        {
            //沒找到
            return false;
        }
        else
        {
            //有找到
            return true;
        }
    }
}