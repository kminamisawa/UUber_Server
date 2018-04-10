<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/09
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.sql.Date" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
%>

Thank you for choosing UUber!<br>
The reservation is confirmed as follows:<br><br>

Date: <%=get_sql_date%><br>
PID: <%=get_PID%><br>
From (Hour): <%=hours[0]%><br>
To (Hour): <%=hours[1]%><br>
VIN: <%=get_vin%><br>
Cost: <%=get_cost%><br>

<%
    }else{

%>

There was an Error with the reservation. Please try again.
<%
    }

    con.closeConnection();
%>
<form name="back_to_menu" method=get action="user_login.jsp">
    <input type=submit value="Back to the Main Menu">
</form>

</body>
</html>
