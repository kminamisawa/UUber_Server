<%--
  Created by IntelliJ IDEA.
  User: takusakikawa
  Date: 2018/04/10
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
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

<%
    Connector2 con = new Connector2();
    UD driver = (UD) session.getAttribute("driver");

    ArrayList<String[]> carList = API.ShowYourCar(driver.getLogin_ID(),con.stmt);
    request.setAttribute("carList", carList);
    //String page_ID = request.getParameter("ID");
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
        <th class="tg-y3o4">VIN</th>
        <th class="tg-y3o4">Category</th>
        <th class="tg-y3o4">MODEL</th>
        <th class="tg-y3o4">MAKE</th>
        <th class="tg-y3o4">YEAR</th>
    </tr>
    <%
        int count = 1;
        for(String[] each_reservation : carList){
            String vin = each_reservation[0];
            String category = each_reservation[1];
            String model = each_reservation[2];
            String make = each_reservation[3];
            String year = each_reservation[4];


            request.setAttribute("Record_Update_vin", vin);
            request.setAttribute("Record_Update_category", category);
            request.setAttribute("Record_Update_model", model);
            request.setAttribute("Record_Update_make", make);
            request.setAttribute("Record_Update_year", year);

            count++;
    %>
    <tr>
        <td class="tg-drr2">${Record_Update_vin}</td>
        <td class="tg-drr2">${Record_Update_category}</td>
        <td class="tg-drr2">${Record_Update_model}</td>
        <td class="tg-drr2">${Record_Update_make}</td>
        <td class="tg-drr2">${Record_Update_year}</td>
    </tr>
    <%

        }
    %>

</table>
</body>
</html>


