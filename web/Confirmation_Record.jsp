<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 3:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Time" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Record Confirmation</title>
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
<h1 style="text-align: center;"><span style="color: #ff6600;">UUber&nbsp;Record Rides</span></h1>
<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");

    String VIN = (String) session.getAttribute("Record_Ride_VIN");
    String cost = (String) session.getAttribute("Record_Ride_cost");
    String date = (String) session.getAttribute("Record_Ride_date");

    String from = (String) session.getAttribute("Record_Ride_From");
    String to = (String) session.getAttribute("Record_Ride_To");

    Date sql_date = Date.valueOf(date);
    Time from_time = Time.valueOf(from);
    Time to_time = Time.valueOf(to);
    boolean record_confirmed = API.User_Record_Ride(cost, sql_date, VIN, user.getLogin_ID(), from_time, to_time, con.stmt);
    if(record_confirmed){
%>
<h2 style="text-align: center;"><span style="color: #0000ff;"><strong>You have successfully recorded a ride!<br>The record is confirmed as follows:</strong></span></h2>
<table class="tg" style="undefined;table-layout: fixed; width: 1004px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 142px">
        <col style="width: 207px">
        <col style="width: 182px">
        <col style="width: 185px">
    </colgroup>
    <tr>
        <th class="tg-y3o4">ID</th>
        <th class="tg-y3o4">VIN</th>
        <th class="tg-y3o4">COST</th>
        <th class="tg-y3o4">DATE</th>
        <th class="tg-y3o4">FROM (Hour)</th>
        <th class="tg-1dhv">TO (Hour)</th>
    </tr>
    <tr>
        <td class="tg-drr2">${Record_Ride_count}</td>
        <td class="tg-drr2">${Record_Ride_VIN}</td>
        <td class="tg-drr2">${Record_Ride_cost}</td>
        <td class="tg-drr2">${Record_Ride_date}</td>
        <td class="tg-drr2">${Record_Ride_From}</td>
        <td class="tg-ywyf">${Record_Ride_To}</td>
    </tr>
</table>
<%

}else{

%>

There was an Error with the record. <br>
It looks like you have already recorded this ride in the past.<br>
(We are afraid that modifying the DB structure would mess up Phase 2.)<br>
Please try again.
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
