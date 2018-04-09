<%@ page language="java" import="cs5530.*" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    Connector2 con = new Connector2();
    String loginID = request.getParameter("UserID");
    String password = request.getParameter("Password");

    UD new_driver = (UD) API.Login_User(false, loginID, password, con.stmt);

%>
<html>
<head>
    <title>JSP Sample</title>
</head>
<body>
<%--This is a test <%= new_user_id %> on yeah--%>
</body>
</html>
