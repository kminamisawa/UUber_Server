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

    UUser new_user = null;
    if(loginID != null && password != null)
    {
         new_user = (UUser) API.Login_User(true, loginID, password, con.stmt);
    } else{
         new_user = session.getAttribute(user);
    }
    if(new_user == null){
%>

    Invalid user man.

<%
    }else{
        String user_name = new_user.getName();

        if(session.getAttribute("user") != null)
            session.removeAttribute("user");
        session.setAttribute("user", new_user);
%>
<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>Welcome Back to the UUber, <%= user_name %>!</strong></span></h1>
<h2 style="text-align: center;"><span style="color: #0000ff;">Please Select Your Option:</span></h2>
<h3 style="text-align: center;">
    1. <a href="reservation.jsp">Make Reservation</a><br />
    2. Record a Ride<br />
    3. Add a Favorite Car<br />
    4. Give a Feedback<br />
    5. Rate a Feedback<br />
    6. Add a Trusted User<br />
    7. Browse UC<br />
    8. See Useful Feedback<br />
    9. See the Most Popular UC<br />
    10. See the Most Expensive UC<br />
    11. See Highly Rated UD<br />
    12. Check Degrees of Separation<br />
    13. Exit</h3>
<%
        con.closeConnection();
    }
%>
</body>
</html>
