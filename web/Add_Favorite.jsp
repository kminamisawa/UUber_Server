<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>

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
%>

VIN has entered already ${Add_Favorite_VIN}.

<%
    }
    con.closeConnection();
%>

</body>
</html>
