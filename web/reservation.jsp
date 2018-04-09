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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<h1 style="text-align: center;"><span style="color: #ff6600;">UUber&nbsp;Reservation</span></h1>
<%
    Connector2 con = new Connector2();
    String vin = request.getParameter("VIN");
    String date = request.getParameter("date");
    String cost = request.getParameter("cost");
    String selected_PID = request.getParameter("PID");
    if((vin == null || date == null || cost == null) && selected_PID == null){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Please Fill in Following Information:</span></h2>
<h3 style="text-align: center;">
    <form name="UserIDInfo" method=get onsubmit="return check_all_fields(this)" action="reservation.jsp">
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

The reserved date is in the past.

<%
        }else{
            availablePid = API.Show_Avaliable(vin, sql_date, con.stmt);

            if(availablePid.isEmpty())
            {
%>
The car is not available on the date you selected.

<%
            }else{
                request.setAttribute("pids", availablePid);
                session.setAttribute("vin", vin);
                session.setAttribute("date", date);
                session.setAttribute("cost", cost);
                ArrayList<String> pid_list = (ArrayList<String>)request.getAttribute("pids");
%>

The following is the available PID.<br>

<%
                for (String each_pid : pid_list){
%>

PID: <%=each_pid%> <br>

<%
                    String[] hour = API.GetFromToHour(each_pid, con.stmt);
%>

From: <%=hour[0]%><br>
To: <%=hour[1]%><br>
<br>
<br>
<%
    }
%>

<form method="GET" action="reservation.jsp">
    Please select the available PID:<br />
    <p>
    <form action="Damn" method="POST">
        <select name="PID" >
            <c:forEach var="item" items="${pids}">
            <option>${item}</option>
            </c:forEach>
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
        String get_PID = (String) session.getAttribute("selected_PID");
        String get_date = (String) session.getAttribute("date");
        String get_vin = (String) session.getAttribute("vin");
        String get_cost = (String) session.getAttribute("cost");
        String[] reserved_hour = API.GetFromToHour(get_PID, con.stmt);
%>

    Please Confirm Your Reservation:<br>
    Date: <%=get_date%><br>
    VIN: <%=get_vin%><br>
    From: <%=reserved_hour[0]%><br>
    To: <%=reserved_hour[1]%><br>
    Cost: <%=get_cost%><br>

<%
    }
    con.closeConnection();
%>
</body>
</html>