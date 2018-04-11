<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<html>
<head>
    <title>Give a Feedback</title>
</head>
<body>

<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Give Feedback</strong></span></h1>


<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");
    String VIN = request.getParameter("VIN_Give_Feedback");
    String score = request.getParameter("Score_Give_Feedback");
    String comment = request.getParameter("Comment_Give_Feedback");

    request.setAttribute("VIN_Give_Feedback", VIN);
    request.setAttribute("Score_Give_Feedback", score);
    request.setAttribute("Comment_Give_Feedback", comment);

    if (VIN == null || VIN.isEmpty() || score == null || score.isEmpty() || comment == null || comment.isEmpty()){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Please Fill in the Following Information</span></h2>
<div style="text-align: center;">
    <form name="VIN_INFO" method=get action="Give_Feedback.jsp">
        <p><strong>VIN Number of the Car You Would Like to Review:</strong>
            <input name="VIN_Give_Feedback" type="text" required pattern=".*\S+.*">
        </p>

        <p><strong>Please enter the score from [0 - 10]. (0 is terrible. 10 is awesome.):</strong>
            <input name="Score_Give_Feedback" type="text" required pattern="[0-9]|10">
        </p>

        <p><strong>Please leave a comment:</strong>
            <input name="Comment_Give_Feedback" type="text" required pattern=".*\S+.*">
        </p>

        <p><input type=submit value="Submit"></p>
    </form>
</div>

<%
    }else{
        Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
        System.out.println(date.toString());
        boolean is_feedback_added = API.Add_Feedback(Integer.parseInt(score), comment, date, user.getLogin_ID(), VIN, con.stmt);
        if(is_feedback_added){
%>
<h2 style="text-align: center;"><span style="color: #0000ff;">The Feedback is Successfully&nbsp;Added as Follows:</span></h2>
<p style="text-align: center;">
    <strong>VIN: ${VIN_Give_Feedback}</strong><br>
    <strong>Score: ${Score_Give_Feedback}</strong><br>
    <strong>Comment: ${Comment_Give_Feedback}</strong><br>
</p>

<%
        }else{
%>

<h2 style="text-align: center;"><span style="color: #ff0000;">VIN number does not exist or you have already given the feedback to the UC.</span></h2>

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
