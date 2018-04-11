<%@ page language="java" import="cs5530.*" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<html>
<head>
    <title>JSP Sample</title>
</head>
<body>
<%
    //////// Remove session attribute made in Modify_UC.jsp////////////
    session.removeAttribute("Record_Update_year");
    session.removeAttribute("Record_Update_count");
    session.removeAttribute("Record_Update_make");
    session.removeAttribute("Record_Update_vin");
    session.removeAttribute("Record_Update_category");
    session.removeAttribute("UC");
    session.removeAttribute("Record_Update_model");
    //////// Remove session attribute made in Modify_UC.jsp////////////

    /////// Remove session attribute made in New_UC.jsp////////////////
    session.removeAttribute("login");
    /////// Remove session attribute made in New_UC.jsp////////////////

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

<h1 style="text-align: center;"><span style="color: #2100ff;"><strong>UUber Driver Login</strong></span></h1>
<h3 style="text-align: center;"><span style="color: #ff0000;">Driver could not be found. Please check you have the correct credentials.</span></h3>

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

    1. <a href="New_UC.jsp">Add New UC</a><br />
    2. <a href="Modify_UC.jsp">Modifying Existing UC</a><br />
    3. <a href="Operation_Hour.jsp">Add Operation Hour</a><br />
    4. <a href="Driver_Index.jsp">Exit</a><br />
    driver1
</h3>
<%
    }
    con.closeConnection();
%>
</body>
</html>
