<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/09
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<html>
<head>
    <title>Reservation Confirmation</title>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;border-color:#aaa;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#333;background-color:#fff;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#fff;background-color:#f38630;}
        .tg .tg-bezv{font-weight:bold;font-size:18px;border-color:#000000;vertical-align:top}
        .tg .tg-wreh{font-weight:bold;border-color:#000000;vertical-align:top}
        .tg .tg-drr2{font-weight:bold;font-size:16px;border-color:#000000}
        .tg .tg-suq3{font-weight:bold;font-size:18px;font-family:Arial, Helvetica, sans-serif !important;;border-color:#000000}

        table {
            width: 50%;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
<h1 style="text-align: center;"><span style="color: #ff6600;">UUber&nbsp;Reservation</span></h1>
<%
    Connector2 con = new Connector2();
    String get_PID = (String) session.getAttribute("selected_PID");
    Date get_sql_date = (Date) session.getAttribute("sql_date");
    String get_vin = (String) session.getAttribute("vin");
    String get_cost = (String) session.getAttribute("cost");
    UUser user = (UUser) session.getAttribute("user");
    String[] hours = API.GetFromToHour(get_PID, con.stmt);
    boolean reservation_confirmed = API.User_Add_Reservation(user.getLogin_ID(),get_vin, get_PID,
            Double.parseDouble(get_cost),get_sql_date,con.stmt);
    if(reservation_confirmed){
        ArrayList<String[]> suggested_UC = API.Suggest_Other_UC(get_vin, user.getLogin_ID(), con.stmt);
//        request.setAttribute("suggested_UC", suggested_UC);
%>
<h2 style="text-align: center;"><span style="color: #0000ff;"><strong>Thank you for choosing UUber!<br>The reservation is confirmed as follows:</strong></span></h2>
<p style="text-align: center;">
        <strong>Date: <%=get_sql_date%></strong><br>
        <strong>PID: <%=get_PID%></strong><br>
        <strong>From (Hour): <%=hours[0]%></strong><br>
        <strong>To (Hour): <%=hours[1]%></strong><br>
        <strong>VIN: <%=get_vin%></strong><br>
        <strong>Cost: <%=get_cost%></strong><br>
</p>

<%
        if(suggested_UC.size() > 0){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;"><strong>The Following is the Suggested UC:</strong></span></h2>
<table class="tg" style="undefined;table-layout: fixed; width: 1022px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 142px">
        <col style="width: 134px">
        <col style="width: 145px">
        <col style="width: 163px">
        <col style="width: 150px">
    </colgroup>
    <tr>
        <th class="tg-suq3">VIN</th>
        <th class="tg-suq3">Category</th>
        <th class="tg-suq3">Make</th>
        <th class="tg-bezv">Model</th>
        <th class="tg-wreh">Year</th>
        <th class="tg-wreh">UC Owner</th>
        <th class="tg-wreh">Ride Count</th>
    </tr>
<%
            for(String[] each_suggested_UC : suggested_UC){
                request.setAttribute("each_VIN", each_suggested_UC[0]);
                request.setAttribute("each_Category", each_suggested_UC[1]);
                request.setAttribute("each_Make", each_suggested_UC[2]);
                request.setAttribute("each_Model", each_suggested_UC[3]);
                request.setAttribute("each_Year", each_suggested_UC[4]);
                request.setAttribute("each_owner", each_suggested_UC[5]);
                request.setAttribute("each_count", each_suggested_UC[6]);
%>

    <tr>
        <td class="tg-drr2">${each_VIN}</td>
        <td class="tg-drr2">${each_Category}</td>
        <td class="tg-drr2">${each_Make}</td>
        <td class="tg-wreh">${each_Model}</td>
        <td class="tg-wreh">${each_Year}</td>
        <td class="tg-wreh">${each_owner}</td>
        <td class="tg-wreh">${each_count}</td>
    </tr>
<%
            }
%>
</table>
<%
         }else{
%>
<strong>I'm sorry. No suggested UC is available.</strong><br>

<%
        }
    }else{

%>

There was an Error with the reservation. Please try again.
<%
    }

    con.closeConnection();
%>
<div style="text-align:center">
<form name="back_to_menu" method=get action="User_Login.jsp">
    <input type=submit value="Back to the Main Menu">
</form>
</div>

</body>
</html>
