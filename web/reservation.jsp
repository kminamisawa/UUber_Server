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
    String selected_PID = request.getParameter("PID");

    if (selected_PID != null){
%>
OMG it's working man <%=selected_PID%>

<%
    }
    if(vin == null || date == null){
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

        <p><input type=submit value="Check Availability"></p>
    </form>
</h3>

<%
    }else{
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsed = format.parse(date);
        java.sql.Date sql_date = new java.sql.Date(parsed.getTime());
        Date dd = new Date(Calendar.getInstance().getTime().getTime());
        ArrayList<String> availablePid;

        if (dd.compareTo(sql_date)>0) // past
        {
//            System.out.println("The date you enter is in the past");


%>
The reserved date is in the past.

<%
        }else{
            availablePid = API.Show_Avaliable(vin, sql_date, con.stmt);
            request.setAttribute("pids", availablePid);
//            request.setAttribute("pids", availablePid);
            if(availablePid.isEmpty())
            {
//                System.out.println("This car is not available on this date \nPlease choose a different car");

%>
The car is not available on the date you selected.

<%
            }else{
                ArrayList<String> pid_list = (ArrayList<String>)request.getAttribute("pids");

%>

<form method="POST" action="reservation.jsp">
    The following is the available PID:<br />
    <p>
    <form action="Damn" method="POST">
        <select name="PID" >
            <c:forEach var="item" items="${pids}">
            <option>${item}</option>
            </c:forEach>
        </select>
        <input type="submit"/>
    </form>
    <%--<select name=”PID_Dropdown”　id="select_pid"　required>--%>
        <%--<c:forEach var="item" items="${pids}">--%>
            <%--<option value=”${item}”>${item}</option>--%>
        <%--</c:forEach>--%>
    <%--</select>--%>
    </p>
</form>


<%--<c:forEach var="item" items="${pids}">--%>

    <%--&lt;%&ndash;<c:out value="${item}" /><br />&ndash;%&gt;--%>
    <%--&lt;%&ndash;request.setAttribute("selected_pid", availablePid);&ndash;%&gt;--%>
    <%--<a href="reservation.jsp?id=${item}">${item}</a><br />--%>

    <%--&lt;%&ndash;<a href="reservation.jsp?id=${item}">${item}</a><br />&ndash;%&gt;--%>
<%--</c:forEach>--%>

<%

//                selected_PID = (String) request.getParameter("PID");

            }
        }
    }
    con.closeConnection();
%>
</body>
</html>