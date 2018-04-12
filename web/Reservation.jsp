<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/08
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.ArrayList" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<html>
<head>
    <title>Title</title>
    <script LANGUAGE="javascript">
        function myEnter(){
            var myRet = confirm("Do you confirm this reservation?");
            if ( myRet === true ){
                alert("Confirmed");
                return true;
            }else{
                alert("Reservation is not confirmed");
                return false;
            }
        }

        function cancel_reservation(){
            var cancel_confirmation = confirm("Are you sure you want to go back to the the main menu? You cannot undo this action.");
            if ( cancel_confirmation === true ){
                alert("Reservation Cancelled.");
                return true;
            }else{
                // alert("Reservation Cancelled");
                return false;
            }
        }

        function goBack() {
            window.history.back();
        }
    </script>

    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;border-color:#aaa;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#333;background-color:#fff;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#fff;background-color:#f38630;}
        .tg .tg-8p71{font-weight:bold;font-size:18px;font-family:Arial, Helvetica, sans-serif !important;;border-color:inherit}
        .tg .tg-drr2{font-weight:bold;font-size:16px;border-color:#000000}

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
    String vin = request.getParameter("VIN");
    String date = request.getParameter("date");
    String cost = request.getParameter("cost");
    String selected_PID = request.getParameter("PID");

    String get_PID = (String) session.getAttribute("selected_PID");
    String get_date = (String) session.getAttribute("date");
    String get_vin = (String) session.getAttribute("vin");
    String get_cost = (String) session.getAttribute("cost");

    if((vin == null || date == null || cost == null) && selected_PID == null){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Please Fill in Following Information:</span></h2>
<h3 style="text-align: center;">
    <form name="UserIDInfo" method=get onsubmit="return check_all_fields(this)" action="Reservation.jsp">
        <p><strong>1. VIN Number:</strong>
            <input name="VIN" type="text" required pattern=".*\S+.*">
        </p>

        <p><strong>2. Select the Date:</strong>
            <input type="date" name="date" required>
        </p>

        <p><strong>3. Type the Cost:</strong>
            <input type="text" name="cost" pattern=".*\d+.*" required>
        </p>

        <p><input type=submit value="Check Availability"></p>
    </form>

    <form name="back_to_menu" method=get action="User_Login.jsp">
        <input type=submit value="Back to the Main Menu">
    </form>

</h3>

<%
}else if (selected_PID == null){
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date parsed = format.parse(date);
    java.sql.Date sql_date = new java.sql.Date(parsed.getTime());
    Date dd = new Date(Calendar.getInstance().getTime().getTime());
    ArrayList<String> availablePid;

    if (dd.compareTo(sql_date)>0) // past
    {
%>

<h3 style="text-align: center;"><span style="color: #ff0000;">The reserved date is in the past!</span></h3>

<div style="text-align:center">
<button onclick="goBack()">Go Back</button>
</div>


<%
}else{
    availablePid = API.Show_Avaliable(vin, sql_date, con.stmt);

    if(availablePid.isEmpty())
    {
%>
<h3 style="text-align: center;"><span style="color: #ff0000;">The car is not available on the date you selected!</span></h3>

<div style="text-align:center">
    <button onclick="goBack()">Go Back</button>
</div>


<%
}else{
    request.setAttribute("pids", availablePid);
    session.setAttribute("vin", vin);
    session.setAttribute("date", date);
    session.setAttribute("sql_date", sql_date);
    session.setAttribute("cost", cost);
    ArrayList<String> pid_list = (ArrayList<String>)request.getAttribute("pids");
%>

<h2 style="text-align: center;"><span style="color: #0000ff;"><strong>The following is the available PID.</strong></span></h2><br>
<table class="tg" style="undefined;table-layout: fixed; width: 430px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 142px">
    </colgroup>
    <tr>
        <th class="tg-8p71">PID</th>
        <th class="tg-8p71">From (Hour)</th>
        <th class="tg-8p71">To (Hour)</th>
    </tr>
<%
    for (String each_pid : pid_list){
        String[] hour = API.GetFromToHour(each_pid, con.stmt);
        request.setAttribute("each_pid", each_pid);
        request.setAttribute("each_from", hour[0]);
        request.setAttribute("each_to", hour[1]);
%>

    <tr>
        <td class="tg-drr2">${each_pid}</td>
        <td class="tg-drr2">${each_from}</td>
        <td class="tg-drr2">${each_to}</td>
    </tr>
<%
    }
%>
</table>
<form method="GET" action="Reservation.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">Please select the available PID:</span></h3>
    <p style="text-align: center;">
    <form action="select_pid" method="POST">
        <select name="PID" >
            <%
                for(String each_available_pid : availablePid){
                    request.setAttribute("each_available_pid", each_available_pid);
            %>

            <option>${each_available_pid}</option>

            <%
                }
            %>
        </select>
        <input type="submit"/>
    </form>
    </p>
</form>


<%
        }
    }
}else {
    session.setAttribute("selected_PID", selected_PID);
    get_PID = (String) session.getAttribute("selected_PID");
    get_date = (String) session.getAttribute("date");
    get_vin = (String) session.getAttribute("vin");
    get_cost = (String) session.getAttribute("cost");
    String[] reserved_hour = API.GetFromToHour(get_PID, con.stmt);
%>

<h2 style="text-align: center;"><span style="color: #0000ff;"><strong>Please Confirm Your Reservation:</strong></span></h2>
<h3 style="text-align: center;">
    Date: <%=get_date%><br />
    VIN: <%=get_vin%><br />
    From: <%=reserved_hour[0]%><br />
    To: <%=reserved_hour[1]%><br />
    Cost: $<%=get_cost%></h3>

<div style="text-align:center">
<form name="reservation" method=get onsubmit="return myEnter()" action="Confirmation_Reservation.jsp">
    <input type=submit value="Reserve" />
</form>
</div>

<div style="text-align:center">
<form name="reservation_cancel" method=get onsubmit="return cancel_reservation()" action="User_Login.jsp">
    <input name="test" type=submit value="Cancel the Reservation"/>
</form>
</div>

<%
    }
    con.closeConnection();
%>
</body>
</html>