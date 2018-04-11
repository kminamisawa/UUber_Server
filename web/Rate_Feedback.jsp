<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 23:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Rate a Feedback</title>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;border-color:#aaa;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#333;background-color:#fff;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aaa;color:#fff;background-color:#f38630;}
        .tg .tg-1dhv{font-weight:bold;font-size:18px;font-family:Arial, Helvetica, sans-serif !important;;vertical-align:top}
        .tg .tg-y3o4{font-weight:bold;font-size:18px;font-family:Arial, Helvetica, sans-serif !important;}
        .tg .tg-drr2{font-weight:bold;font-size:16px;border-color:#000000}
        .tg .tg-ywyf{font-weight:bold;font-size:16px;border-color:#000000;vertical-align:top}

        table {
            width: 50%;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>

<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Rate Feedback</strong></span></h1>


<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");
    ArrayList<String[]> feedbacks = API.Show_Feedack(con.stmt);
    String FB_ID = request.getParameter("FB_ID");
    String RATE_ID = request.getParameter("RATE_ID");
    if (feedbacks == null || feedbacks.size() == 0){
%>

<h2 style="text-align: center;"><span style="color: #ff0000;">No Feedback for Rating Available.</span></h2>

<%
}else if(FB_ID == null || FB_ID.isEmpty() || RATE_ID == null || RATE_ID.isEmpty()){
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Following is the List of the Reservation You Have Made:</span></h2>
<table class="tg" style="undefined;table-layout: fixed; width: 1004px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 142px">
        <col style="width: 207px">
        <col style="width: 182px">
        <col style="width: 185px">
    </colgroup>
    <tr>
        <th class="tg-y3o4">FID</th>
        <th class="tg-y3o4">SCORE</th>
        <th class="tg-y3o4">COMMENT</th>
        <th class="tg-y3o4">DATE</th>
        <th class="tg-y3o4">RATED BY</th>
        <th class="tg-1dhv">VIN</th>
    </tr>
    <%
        int count = 1;
        for(String[] each_feedback : feedbacks){
            String FID = each_feedback[0];
            String score = each_feedback[1];
            String comment = each_feedback[2];
            String date = each_feedback[3];
            String rater = each_feedback[4];
            String VIN = each_feedback[5];

            if(rater.compareTo(user.getLogin_ID()) != 0){
                request.setAttribute("Rate_Feedback_FID", FID);
                request.setAttribute("Rate_Feedback_score", score);
                request.setAttribute("Rate_Feedback_comment", comment);
                request.setAttribute("Rate_Feedback_date", date);
                request.setAttribute("Rate_Feedback_rater", rater);
                request.setAttribute("Rate_Feedback_VIN", VIN);
    %>
    <tr>
        <td class="tg-drr2">${Rate_Feedback_FID}</td>
        <td class="tg-drr2">${Rate_Feedback_score}</td>
        <td class="tg-drr2">${Rate_Feedback_comment}</td>
        <td class="tg-drr2">${Rate_Feedback_date}</td>
        <td class="tg-drr2">${Rate_Feedback_rater}</td>
        <td class="tg-ywyf">${Rate_Feedback_VIN}</td>
    </tr>
    <%
            }
        }
    %>

</table>

<form method="GET" action="Rate_Feedback.jsp">
    <p style="text-align: center;">
    <form action="select_reservation" method="POST">
    <span style="color: #0000ff;"><strong>Please Select Feedback You Would Like To Rate:</strong></span>
        <select name="FB_ID" >
            <%
                for (String [] each_feedback : feedbacks){
                    request.setAttribute("Rate_Feedback_FID", each_feedback[0]);
            %>
            <option>${Rate_Feedback_FID}</option>

            <%
                }
            %>
        </select><br>

    <span style="color: #0000ff;"><strong>Please Rate the Feedback (0 is useless, 1 is useful, 2 is very useful):</strong></span>
        <select name="RATE_ID" >
            <option>0</option>
            <option>1</option>
            <option>2</option>
        </select><br>

        <input type="submit"/>
    </form>
    </p>
</form>

<%
    }else{ //USER has selected the FID and rating.
        boolean has_rated = API.ADD_Feedback_Rating(Integer.parseInt(FB_ID), user.getLogin_ID(), RATE_ID, con.stmt);
        if(has_rated){
%>
<h2 style="text-align: center;"><span style="color: #0000ff;"><strong>Thank you for Rating a Feedback!</strong></span></h2>

<%
        }else{

%>

<h2 style="text-align: center;"><span style="color: #ff0000;"><strong>You Have Already Rated This Feedback Before.</strong></span></h2>

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

