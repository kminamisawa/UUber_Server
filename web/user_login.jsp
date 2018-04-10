<%@ page language="java" import="cs5530.*" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<html>
<head>
    <title>JSP Sample</title>
    <script LANGUAGE="javascript">
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
<%
    Connector2 con = new Connector2();
    String loginID = request.getParameter("UserID");
    String password = request.getParameter("Password");

    // Initialize the attributes in case user was refereed from reservation.jsp or confirmation.jsp
    session.removeAttribute("selected_PID");
    session.removeAttribute("sql_date");
    session.removeAttribute("vin");
    session.removeAttribute("cost");

    // Initialize the attributes in case user was refereed from Record_Ride.jsp or Confirmation_Record.jsp
    session.removeAttribute("Record_Ride_From");
    session.removeAttribute("Record_Ride_To");
    session.removeAttribute("Record_Ride_count");
    session.removeAttribute("Record_Ride_VIN");
    session.removeAttribute("Record_Ride_PID");
    session.removeAttribute("Record_Ride_cost");
    session.removeAttribute("Record_Ride_date");

    UUser new_user = null;
    if(loginID != null && password != null)
    {
         new_user = (UUser) API.Login_User(true, loginID, password, con.stmt);
    } else{
         new_user = (UUser)session.getAttribute("user");
    }
    if(new_user == null){
%>
    <h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Login</strong></span></h1>
    <h3 style="text-align: center;"><span style="color: #ff0000;">User could not be found. Please check you have the correct credentials.</span></h3>

    <div style="text-align:center">
        <button onclick="goBack()">Go Back</button>
    </div>

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
    2. <a href="Rcord_Ride.jsp">Record a Ride</a><br />
    3. Add a Favorite Car<br />
    4. Give a Feedback<br />
    5. Rate a Feedback<br />
    6. Add a Trusted User<br />
    7. Browse UC<br />
    8. See Useful Feedback<br />
    <%--9. See the Most Popular UC<br />--%>
    <%--10. See the Most Expensive UC<br />--%>
    <%--11. See Highly Rated UD<br />--%>
    <%--12. Check Degrees of Separation<br />--%>
    9. Exit</h3>
<%
    }
    con.closeConnection();
%>
</body>
</html>
