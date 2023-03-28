using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Member
{
    public int Id { get; set; }
    public string EmployeeId { get; set; }
    public string Password { get; set; }
    public string StaffName { get; set; }
    public string Department { get; set; }
    public string JobPosition { get; set; }

    //public override string ToString()
    //{
    //    return $"ID:{Id} , 帳號:{EmployeeId} , 密碼:{Password} ";
    //}
}