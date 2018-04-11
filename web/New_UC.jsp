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
<html>
<head>
    <title>Add New UC</title>
</head>
<body>
<h1 style="text-align: center;"><span style="color: #ff6600;">UUber&nbsp;New UC</span></h1>
<%
    Connector2 con = new Connector2();
    UD ud = (UD)session.getAttribute("driver");
    String login = ud.getLogin_ID();
    String vin = request.getParameter("vin");
    String category = request.getParameter("category");
    String make = request.getParameter("make");
    String model = request.getParameter("model");
    String year = request.getParameter("year");

    if(vin == null || category == null || make == null || model == null || year == null ){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Please Fill in Following Information: <%=login%></span></h2>
<h3 style="text-align: center;">
    <form name="UserIDInfo" method=get onsubmit="return check_all_fields(this)" action="New_UC.jsp">
        <%session.setAttribute("login", login);%>
        <input type=hidden name="login" value=<%=login%>>

        <p><strong>1. VIN Number:</strong>
            <input name="vin" type="text" required pattern=".*\S+.*">
        </p>

        <p><strong>2. Category:</strong>
            <input type="text" name="category" required pattern=".*\S+.*">
        </p>

        <p><strong>3. Make:</strong>
            <input type="text" name="make" required pattern=".*\S+.*">
        </p>

        <p><strong>4. Model:</strong>
            <input type="text" name="model" required pattern=".*\S+.*">
        </p>

        <p><strong>5. year:</strong>
            <input type="text" name="year" required pattern="\d\d\d\d">
        </p>

        <p><input type=submit></p>
    </form>
    <form name="UserIDInfo" method=get action="Driver_login.jsp">
        <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
    </form>

</h3>

<%
}else{

        int y = Integer.parseInt(year);
        UC uc = new UC(vin, category,make, model, y, login);
        if(API.Add_New_Car(uc,con.stmt)) {
            // if succeed
%>
<p style="text-align: center;">Successfully Added to the Database</p>
<form name="UserIDInfo" method=get onsubmit="return check_all_fields(this)" action="Driver_login.jsp">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>
<%
        }
        else
        {
%>
<p style="text-align: center;">This car already exists in the database. Please try again with a different car</p>
<form name="UserIDInfo" method=get action="New_UC.jsp">
    <p style="text-align: center;"><input type="submit" value="Register a different Car" /></p>
</form>
<form name="UserIDInfo" method=get action="Driver_login.jsp">
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