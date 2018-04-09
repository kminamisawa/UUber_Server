<%@ page language="java" import="cs5530.*" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    Connector2 con = new Connector2();
    String loginID = request.getParameter("UserID");
    String password = request.getParameter("Password");

<<<<<<< HEAD
    UUser new_user = (UUser) API.Login_User(true, loginID, password, con.stmt);
    String new_user_id = new_user.getName();
=======

//    if (!loginID.isEmpty() && loginID != null && !password.isEmpty() && password != null){
        UUser new_user = (UUser) API.Login_User(true, loginID, password, con.stmt);
        String new_user_id = new_user.getName();
//    }
>>>>>>> ecd0453ae3d51fd0aa6f3b11ab0c813e1b02ae13
%>
<html>
<head>
    <title>JSP Sample</title>
</head>
<body>
    This is a test <%= new_user_id %> on yeah
</body>
</html>
