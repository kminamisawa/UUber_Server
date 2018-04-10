<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Record a Ride</title>
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

<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Record a Ride</strong></span></h1>

<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");
    ArrayList<String[]> past_reservation = API.Show_Past_Reservation(user.getLogin_ID(), con.stmt);
    request.setAttribute("past_reservation", past_reservation);
    if(past_reservation.size() == 0){
%>

<p style="text-align: center;"><strong>You have not made any UUber reservation before.</strong></p>

<%
    }else{
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Following is the List of the Reservation You Have Made:</span></h2>
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
<%
    int count = 1;
    for(String[] each_reservation : past_reservation){
        String VIN = each_reservation[0];
        String pid = each_reservation[1];
        String cost = each_reservation[2];
        String date = each_reservation[3];

        request.setAttribute("VIN", VIN);
        request.setAttribute("PID", pid);
        request.setAttribute("cost", cost);
        request.setAttribute("date", date);

        String[]fromTo = API.GetFromToHour(pid, con.stmt);
        request.setAttribute("From", fromTo[0]);
        request.setAttribute("To", fromTo[1]);

        request.setAttribute("count", count);
        count++;
%>
    <tr>
        <td class="tg-drr2">${count}</td>
        <td class="tg-drr2">${VIN}</td>
        <td class="tg-drr2">${PID}</td>
        <td class="tg-drr2">${date}</td>
        <td class="tg-drr2">${From}</td>
        <td class="tg-ywyf">${To}</td>
    </tr>
    <%--<tr>--%>
        <%--<td class="tg-rd2y">id2</td>--%>
        <%--<td class="tg-rd2y">vin2</td>--%>
        <%--<td class="tg-rd2y">cost2</td>--%>
        <%--<td class="tg-rd2y">date2</td>--%>
        <%--<td class="tg-rd2y">from2</td>--%>
        <%--<td class="tg-2ktp">to2</td>--%>
    <%--</tr>--%>
<%--<p style="text-align: left;">--%>
    <%--<strong>VIN: ${VIN}</strong><br>--%>
    <%--<strong>Cost: ${PID}</strong><br>--%>
    <%--<strong>Date: ${date}</strong><br>--%>
    <%--<strong>From (Hour): ${From}</strong><br>--%>
    <%--<strong>To (Hour): ${To}</strong><br>--%>
<%--</p>--%>

<%

    }
%>

</table>

<%
    }
    con.closeConnection();
%>
</body>
</html>
