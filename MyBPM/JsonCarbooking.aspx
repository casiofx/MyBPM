﻿<%@ Page Language="C#" %>
<%@ Import Namespace="Newtonsoft.Json" %>


<script runat="server">

 protected void Page_Load(object sender, EventArgs e)
    {        // 從資料庫中取得資料，並轉換成List<MyData>物件
        List<Carcalendar> carbookings = MemberUtiltiy.GetCarbookingData();

        // 將List<MyData>轉換成JSON格式的字串
        string jsondata = JsonConvert.SerializeObject(carbookings);

        Response.Clear();
        Response.Write(jsondata);
        Response.End();
    }

</script>


