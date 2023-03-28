using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
    public static string MyDBConnStr
    {
        get
        {
            return System.Web.Configuration.WebConfigurationManager.
                ConnectionStrings["MyDBConnectionString1"].ConnectionString;
        }
    }
}