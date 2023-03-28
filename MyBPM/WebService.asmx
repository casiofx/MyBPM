<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

public class WebService : System.Web.Services.WebService
{
    public static List<WebWorktime> webworktimes = WebService.GetTimersSerive();

    [WebMethod]
    public Result getWorktimes(int pageSize, int pageIndex)
    {
        int startIndex = (pageIndex - 1) * pageSize;
        List<WebWorktime> times = webworktimes.Skip(startIndex).Take(pageSize).ToList();

        return new Result()
        {
            TotalCount = webworktimes.Count,
            Webworktime = times
        };
    }

    //[WebMethod]
    //public void insertProdcut(Webworktime prod)
    //{
    //    System.IO.File.AppendAllText(
    //        Server.MapPath("InsertList.txt"),
    //        string.Format("Name:{0},Price:{1},DateTime:{2}\r\n",
    //        prod.Name, prod.Price, DateTime.Now));
    //}
    //[WebMethod]
    //public void updateProdcut(Product prod)
    //{
    //    System.IO.File.AppendAllText(
    //    Server.MapPath("UpdateList.txt"),
    //    string.Format("Name:{0},Price:{1},DateTime:{2}\r\n",
    //    prod.Name, prod.Price, DateTime.Now));
    //}

    //[WebMethod]
    //public void deleteProdcut(Product prod)
    //{
    //    System.IO.File.AppendAllText(
    //        Server.MapPath("deleteList.txt"),
    //        string.Format("Name:{0},Price:{1},DateTime:{2}\r\n",
    //        prod.Name, prod.Price, DateTime.Now));
    //}

    [WebMethod]
    public static List<WebWorktime> GetTimersSerive()
    {
        SqlDataAdapter da1 = new SqlDataAdapter(
            "SELECT Id, EmployeeId, StaffName, Department FROM Employees", Common.MyDBConnStr);
        DataTable dt1 = new DataTable();
        da1.Fill(dt1);

        SqlDataAdapter da2 = new SqlDataAdapter(
            "SELECT EmployeeId,ClockinYear, ClockinMonth, ClockinDay, ClockinHour, ClockinMinute, ClockoutHour, ClockoutMinute " +
            "FROM Worktimers", Common.MyDBConnStr);
        DataTable dt2 = new DataTable();

        da2.Fill(dt2);

        return (from row1 in dt1.AsEnumerable()
                join row2 in dt2.AsEnumerable()
                on row1["EmployeeId"] equals row2["EmployeeId"]
                select new WebWorktime
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
}

public class Result
{
    public int TotalCount { get; set; }
    public List<WebWorktime> Webworktime { get; set; }
}

public class WebWorktime
{
    public int Id { get; set; }
    public string EmployeeId { get; set; }
    public string StaffName { get; set; }
    public string Department { get; set; }
    public string Workdate { get; set; }
    public string Clockin { get; set; }
    public string Clockout { get; set; }
    public string Attendstate { get; set; }
}