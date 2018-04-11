<%--
  Created by IntelliJ IDEA.
  User: takusakikawa
  Date: 2018/04/10
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;border-color:#aaa;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#333;background-color:#fff;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#fff;background-color:#f38630;}
        .tg .tg-1dhv{font-weight:bold;font-size:18px;font-family:Arial, Helvetica, sans-serif !important;;vertical-align:top}
        .tg .tg-y3o4{font-weight:bold;font-size:18px;font-family:Arial, Helvetica, sans-serif !important;}
        .tg .tg-drr2{font-weight:bold;font-size:16px;border-color:#000000}
        .tg .tg-ywyf{font-weight:bold;font-size:16px;border-color:#000000;vertical-align:top}

        table {
            width: 50%;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>

<%
    Connector2 con = new Connector2();
//    UD driver = (UD) session.getAttribute("driver");

    ArrayList<String[]> driverlist = API.ShowDrivers(con.stmt);
    request.setAttribute("driverlist", driverlist);

    String chosenDriver = request.getParameter("ID");
    //String page_ID = request.getParameter("ID");
    String modify = (String)request.getParameter("Modify");
    String quantity = (String)request.getParameter("Feedback_Quantity");

    UUser user = (UUser)session.getAttribute("user");

    if(chosenDriver == null && modify == null && quantity == null)
    {
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Following is the List of the Drivers:</span></h2>
<table class="tg" style="undefined;table-layout: fixed; width: 1004px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 185px">
    </colgroup>
    <tr>
        <th class="tg-y3o4">ID</th>
        <th class="tg-y3o4">LOGIN</th>
        <th class="tg-1dhv">NAME</th>

    </tr>
    <%
        int count = 1;
        for(String[] each_reservation : driverlist){
            String login = each_reservation[0];
            String name = each_reservation[1];

            request.setAttribute("Feedback_login", login);
            request.setAttribute("Feedback_name", name);
            request.setAttribute("Record_Update_count", count);

            count++;
    %>
    <tr>
        <td class="tg-drr2">${Record_Update_count}</td>
        <td class="tg-drr2">${Feedback_login}</td>
        <td class="tg-drr2">${Feedback_name}</td>

    </tr>
    <%

        }
    %>

</table>
<form method="GET" action="Useful_Feedback.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">Please select one of the Driver:</span></h3>
    <p style="text-align: center;">
    <form action="select_reservation" method="POST">
        <select name="ID" >

            <%
                for (int i = 1; i < count; i++){
                    request.setAttribute("Feedback_count", i);
            %>
            <option>${Feedback_count}</option>

            <%
                }
            %>
        </select>
        <input type="submit"/>
    </form>
    <form action="Useful_Feedback.jsp" method="GET">
        <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
    </form>
    </p>
</form>

<%
}
else if(modify == null && quantity == null)// after choosing the car // chosenCar is available
{
    driverlist = (ArrayList<String[]>) request.getAttribute("driverlist");
    int id = Integer.parseInt(chosenDriver);
    String[] driverInfo = driverlist.get(id-1);

    String login = driverInfo[0];
    String name = driverInfo[1];


   // int y = Integer.parseInt(year);
//    UC uc = new UC(vin, category, make, model, y, driver.getLogin_ID() ); //String vin, String category, String make, String model, int year, String login
//    session.setAttribute("UC", uc);

    //String[]fromTo = API.GetFromToHour(pid, con.stmt);
//        session.setAttribute("Record_Ride_From", fromTo[0]);
//        session.setAttribute("Record_Ride_To", fromTo[1]);

    session.setAttribute("Feedback_login", login);
    session.setAttribute("Feedback_name", name);
    session.setAttribute("Feedback_count", id);

%>
<h3 style="text-align: center;"><span style="color: #0000ff;">Below is the Driver You Selected:</span></h3>
<table class="tg" style="undefined;table-layout: fixed; width: 1004px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 185px">
    </colgroup>
    <tr>
        <th class="tg-y3o4">DRIVER NUMBER</th>
        <th class="tg-y3o4">LOGIN</th>
        <th class="tg-1dhv">NAME</th>

    </tr>
    <tr>
        <td class="tg-drr2">${Feedback_count}</td>
        <td class="tg-drr2">${Feedback_login}</td>
        <td class="tg-drr2">${Feedback_name}</td>

    </tr>
</table>


<form method="GET" action="Useful_Feedback.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">How many Feedback do you want to see?</span></h3>
    <p style="text-align: center;"><input name="Feedback_Quantity" pattern="\d+" required="" type="text" /></p>
    <p style="text-align: center;"><input type="submit" /></p>
</form>



<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>


<%
} // end of if // after choosing the car // chosenCar is available

else //modify text is filled
{
    int q = Integer.parseInt(quantity);
    String login = (String) session.getAttribute("Feedback_login");

    ArrayList<String[]> list = API.Show_Useful_Feedback(login,q,con.stmt);
    if(list.size() > 0)
    {



%>
<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>Useful Feedback</strong></span></h3>

<table class="tg" style="undefined;table-layout: fixed; width: 1004px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 142px">
        <col style="width: 207px">
        <col style="width: 185px">
    </colgroup>
    <tr>
        <th class="tg-y3o4">SCORE</th>
        <th class="tg-y3o4">TEXT</th>
        <th class="tg-y3o4">FEEDBACK DATE</th>
        <th class="tg-y3o4">LOGIN</th>
        <th class="tg-1dhv">VIN</th>

    </tr>
    <%
        int count = 1;
        for(String[] each_reservation : list){
            String score = each_reservation[1];
            String text = each_reservation[2];
            String date = each_reservation[3];
            String l = each_reservation[4];
            String vin = each_reservation[5];

            request.setAttribute("score", score);
            request.setAttribute("text", text);
            request.setAttribute("date", date);
            request.setAttribute("login", l);
            request.setAttribute("vin", vin);


            count++;
    %>
    <tr>
        <td class="tg-drr2">${score}</td>
        <td class="tg-drr2">${text}</td>
        <td class="tg-drr2">${date}</td>
        <td class="tg-drr2">${login}</td>
        <td class="tg-drr2">${vin}</td>

    </tr>
    <%

        }
    %>

</table>


<form action="User_Login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>

<%
    } else
    {
%>
<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>Useful Feedback</strong></span></h3>
<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>There is no Feedback for this driver</strong></span></h3>


<form action="User_Login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>

<%
    }
}
%>



<%

    con.closeConnection();
%>
</body>
</html>