<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>

<html>
<head>
    <title>Favorite Car</title>
</head>
<body>

<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Record Rides</strong></span></h1>

<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");
    String VIN = request.getParameter("VIN");
    request.setAttribute("Add_Favorite_VIN", VIN);
    if (VIN == null || VIN.isEmpty()){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Please Enter the VIN Number of Your Favorite Car:</span></h2>
<div style="text-align: center;">
    <%--<form name="UserIDInfo" method=get onsubmit="return check_all_fields(this)" action="login.jsp">--%>
    <form name="VIN_INFO" method=get action="Add_Favorite.jsp">
        <p><strong>VIN:</strong>
            <input name="VIN" type="text" required pattern=".*\S+.*">
        </p>
        <p><input type=submit value="Submit"></p>
    </form>
</div>

<%
    }else{
        Date date = new Date(Calendar.getInstance().getTime().getTime());
        boolean is_favorited = API.Add_User_Favorite_Car(VIN, user.getLogin_ID(), date, con.stmt);
        if (is_favorited){
%>

<h2 style="text-align: center;"><span style="color: #2100ff;">The car with VIN: ${Add_Favorite_VIN} is added to your favorites.</span></h2>
<%
    }else {
%>

<h2 style="text-align: center;"><span style="color: #ff0000;">The car with VIN: ${Add_Favorite_VIN} is already your favorites.</span></h2>
<%
        }
    }
%>

<div style="text-align:center">
    <form name="back_to_menu" method=get action="User_Login.jsp">
        <input type=submit value="Back to the Main Menu">
    </form>
</div>

<%
    con.closeConnection();
%>

</body>
</html>
