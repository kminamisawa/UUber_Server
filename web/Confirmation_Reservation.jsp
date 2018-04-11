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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
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
        request.setAttribute("suggested_UC", suggested_UC);
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
<c:forEach items="${suggested_UC}" var="item">
    <p style="text-align: center;">
        <strong>VIN: ${item[0]}</strong><br>
        <strong>Category: ${item[1]}</strong><br>
        <strong>Make: ${item[2]}</strong><br>
        <strong>Model: ${item[3]}</strong><br>
        <strong>Year: ${item[4]}</strong><br>
        <strong>UC Owner: ${item[5]}</strong><br>
        <strong>Ride Count: ${item[6]}</strong><br>
    </p>
</c:forEach>

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
