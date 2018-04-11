<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/10
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Record a Ride</title>
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

    <script LANGUAGE="javascript">
        function myEnter(){
            var myRet = confirm("Do you confirm to record this ride?");
            if (myRet === true ){
                // alert("Confirmed.");
                return true;
            }else{
                // alert("Cancelled.");
                return false;
            }
        }

        function cancel_reservation(){
            var cancel_confirmation = confirm("Are you sure you want to go back to the the main menu? You cannot undo this action.");
            if ( cancel_confirmation === true ){
                // alert("Reservation Cancelled.");
                return true;
            }else{
                // alert("Reservation Cancelled");
                return false;
            }
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>

<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Record Rides</strong></span></h1>

<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");
    ArrayList<String[]> past_reservation = API.Show_Past_Reservation(user.getLogin_ID(), con.stmt);
    request.setAttribute("past_reservation", past_reservation);
    String page_ID = request.getParameter("ID");
    if(past_reservation.size() == 0){
%>

<p style="text-align: center;"><strong>You have not made any UUber reservation before.</strong></p>

<%
    }else if (page_ID == null || page_ID.isEmpty()){
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
        <th class="tg-y3o4">ID</th>
        <th class="tg-y3o4">VIN</th>
        <th class="tg-y3o4">COST</th>
        <th class="tg-y3o4">DATE</th>
        <th class="tg-y3o4">FROM (Hour)</th>
        <th class="tg-1dhv">TO (Hour)</th>
    </tr>
<%
    int count = 1;
    for(String[] each_reservation : past_reservation){
        String VIN = each_reservation[0];
        String pid = each_reservation[1];
        String cost = each_reservation[2];
        String date = each_reservation[3];

        request.setAttribute("Record_Ride_VIN", VIN);
        request.setAttribute("Record_Ride_PID", pid);
        request.setAttribute("Record_Ride_cost", cost);
        request.setAttribute("Record_Ride_date", date);

        String[]fromTo = API.GetFromToHour(pid, con.stmt);
        request.setAttribute("Record_Ride_From", fromTo[0]);
        request.setAttribute("Record_Ride_To", fromTo[1]);

        request.setAttribute("Record_Ride_count", count);
        count++;
%>
    <tr>
        <td class="tg-drr2">${Record_Ride_count}</td>
        <td class="tg-drr2">${Record_Ride_VIN}</td>
        <td class="tg-drr2">${Record_Ride_cost}</td>
        <td class="tg-drr2">${Record_Ride_date}</td>
        <td class="tg-drr2">${Record_Ride_From}</td>
        <td class="tg-ywyf">${Record_Ride_To}</td>
    </tr>
<%

    }
%>

</table>

<form method="GET" action="Record_Ride.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">Please select one of the Reservation:</span></h3>
    <p style="text-align: center;">
    <form action="select_reservation" method="POST">
        <select name="ID" >

<%
    for (int i = 1; i < count; i++){
        request.setAttribute("Record_Ride_temp_count", i);
%>
                <option>${Record_Ride_temp_count}</option>

<%
        }
%>
        </select>
        <input type="submit"/>
    </form>
    </p>
</form>
<%
     }else{
         ArrayList<String[]> get_past_reservation = (ArrayList<String[]>) request.getAttribute("past_reservation");
         int parsed_ID = Integer.parseInt(page_ID);
         String[] selected_reservation = get_past_reservation.get(parsed_ID-1);

         String VIN = selected_reservation[0];
         String pid = selected_reservation[1];
         String cost = selected_reservation[2];
         String date = selected_reservation[3];

         String[]fromTo = API.GetFromToHour(pid, con.stmt);
         session.setAttribute("Record_Ride_From", fromTo[0]);
         session.setAttribute("Record_Ride_To", fromTo[1]);

         session.setAttribute("Record_Ride_count", page_ID);
         session.setAttribute("Record_Ride_VIN", VIN);
         session.setAttribute("Record_Ride_PID", pid);
         session.setAttribute("Record_Ride_cost", cost);
         session.setAttribute("Record_Ride_date", date);
%>

<h3 style="text-align: center;"><span style="color: #0000ff;">Below is the Reservation You Selected:</span></h3>
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
        <th class="tg-y3o4">Reservation Number</th>
        <th class="tg-y3o4">VIN</th>
        <th class="tg-y3o4">COST</th>
        <th class="tg-y3o4">DATE</th>
        <th class="tg-y3o4">FROM (Hour)</th>
        <th class="tg-1dhv">TO (Hour)</th>
    </tr>
    <tr>
        <td class="tg-drr2">${Record_Ride_count}</td>
        <td class="tg-drr2">${Record_Ride_VIN}</td>
        <td class="tg-drr2">${Record_Ride_cost}</td>
        <td class="tg-drr2">${Record_Ride_date}</td>
        <td class="tg-drr2">${Record_Ride_From}</td>
        <td class="tg-ywyf">${Record_Ride_To}</td>
    </tr>
</table>

    <div style="text-align:center">
        <form name="record" method=get onsubmit="return myEnter()" action="Confirmation_Record.jsp.jsp">
            <input type=submit value="Record" />
        </form>
    </div>

<%
    }
%>

<div style="text-align:center">
    <form name="record_cancel" method=get onsubmit="return cancel_reservation()" action="User_Login.jsp">
        <input name="cancel" type=submit value="Back to the Main Menu"/>
    </form>
</div>

<%
    con.closeConnection();
%>
</body>
</html>
