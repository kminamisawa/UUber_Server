<%@ page language="java" import="cs5530.*" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<html>
<head>
    <title>JSP Sample</title>
</head>
<body>
<%
    Connector2 con = new Connector2();
    String loginID = request.getParameter("UserID");
    String password = request.getParameter("Password");

    UD new_user = null;
    if(loginID!=null && password != null) {
         new_user = (UD) API.Login_User(false, loginID, password, con.stmt);
    } else {
         new_user = (UD)session.getAttribute("driver");
    }
    if(new_user == null){
%>

Invalid user man.

<%
}else{
    String user_name = new_user.getName();
    if(session.getAttribute("driver") != null)
        session.removeAttribute("driver");
    session.setAttribute("driver", new_user);
%>
<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>Welcome Back to the UUber, <%= user_name %>!</strong></span></h1>
<h2 style="text-align: center;"><span style="color: #0000ff;">Please Select Your Option:</span></h2>
<h3 style="text-align: center;">
    <form action="New_UC.jsp">
        <%session.setAttribute("login", new_user.getLogin_ID());%>
        <%--<input type=hidden name="login" value="<%=loginID%>">--%>
        1. <a href="New_UC.jsp">Add New UC</a><br />
    </form>
    2. Modifying Existing UC<br />
    3. Add Operation Hour<br />

    <form action="Driver_Index.jsp">
        <%session.removeAttribute("driver");%>
        4. <a href="Driver_Index.jsp">Exit</a><br />
    </form>
</h3>
<%
        con.closeConnection();
    }
%>
</body>
</html>
