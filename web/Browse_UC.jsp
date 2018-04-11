<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/11
  Time: 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Browse UC</title>
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
<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Browse UC</strong></span></h1>
<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");

    String category = request.getParameter("CATEGORY");
    String model = request.getParameter("MODEL");
    String city = request.getParameter("CITY");
    String state = request.getParameter("STATE");
    String AND_OR = request.getParameter("AND_OR");
    String SORT = request.getParameter("SORT");

    if(category == null || category.isEmpty()){
%>

<div style="text-align:center">
    <form name="trust_user" method=get action="Browse_UC.jsp">
        <p>
            <strong>Category of UC (e.g. sedan):</strong>
            <input name="CATEGORY" type="text" required pattern=".*\S+.*"><br>

            <strong>Car Model (e.g. Camery):</strong>
            <input name="MODEL" type="text" required pattern=".*\S+.*"><br>

            <strong>Name of the City (e.g. SLC):</strong>
            <input name="CITY" type="text" required pattern=".*\S+.*"><br>

            <strong>Name of the State (e.g. UT):</strong>
            <input name="STATE" type="text" required pattern=".*\S+.*"><br>

            <strong>Would you like to AND or OR these attributes? </strong>
            <select name="AND_OR" >
                <option>AND</option>
                <option>OR</option>
            </select><br><br>

            <strong>Sort the Result By: <br>(A) by the average numerical score of the feedback or (B) by the average numerical score of the trusted user feedback?</strong>
            <select name="SORT" >
                <option>A</option>
                <option>B</option>
            </select><br>

        <p><input type=submit value="Submit"></p>
    </form>
</div>

<%
    }else{
        ArrayList<String[]> UC_List = new ArrayList<>();
        if(AND_OR.compareTo("AND") == 0){
            if(SORT.compareTo("A") == 0){
                UC_List =  API.UC_Browse(true, true, user.getLogin_ID(), category, city, state, model, con.stmt);
            }else{
                UC_List =  API.UC_Browse(true, false, user.getLogin_ID(), category, city, state, model, con.stmt);
            }
        }else{
            if(SORT.compareTo("A") == 0){
                UC_List =  API.UC_Browse(false, true, user.getLogin_ID(), category, city, state, model, con.stmt);
            }else{
                UC_List =  API.UC_Browse(false, false, user.getLogin_ID(), category, city, state, model, con.stmt);
            }
        }

        if(UC_List.size() == 0){
%>
No UC is available with your specification.

<%
        }else{
%>

<table class="tg" style="undefined;table-layout: fixed; width: 1004px">
    <colgroup>
        <col style="width: 163px">
        <col style="width: 125px">
        <col style="width: 142px">
        <col style="width: 207px">
        <col style="width: 185px">
    </colgroup>
    <tr>
        <th class="tg-y3o4">VIN</th>
        <th class="tg-y3o4">MAKE</th>
        <th class="tg-y3o4">MODEL</th>
        <th class="tg-y3o4">YEAR</th>
        <th class="tg-1dhv">AVG SCORE</th>
    </tr>
<%
            for (String[] each_uc_info : UC_List){
                String each_VIN = each_uc_info[0];
                String each_make = each_uc_info[1];
                String each_model = each_uc_info[2];
                String each_year = each_uc_info[3];
                String each_avg_score = each_uc_info[4];

                request.setAttribute("temp_VIN", each_VIN);
                request.setAttribute("temp_make", each_make);
                request.setAttribute("temp_model", each_model);
                request.setAttribute("temp_year", each_year);
                request.setAttribute("temp_score", each_avg_score);
%>

    <tr>
        <td class="tg-drr2">${temp_VIN}</td>
        <td class="tg-drr2">${temp_make}</td>
        <td class="tg-drr2">${temp_model}</td>
        <td class="tg-drr2">${temp_year}</td>
        <td class="tg-ywyf">${temp_score}</td>
    </tr>
<%

            }
%>

</table>

<%
            }
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
