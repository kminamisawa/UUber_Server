<%--
  Created by IntelliJ IDEA.
  User: takusakikawa
  Date: 2018/04/10
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.util.ArrayList" %>

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

    String chosenCar = request.getParameter("ID");
    //String page_ID = request.getParameter("ID");
    String modify = (String)request.getParameter("Modify");

    if(chosenCar == null && modify == null)
    {
%>

<h2 style="text-align: center;"><span style="color: #0000ff;">Following is the List of car you own:</span></h2>
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
            request.setAttribute("Record_Update_count", count);


            count++;
    %>
    <tr>
        <td class="tg-drr2">${Record_Update_count}</td>
        <td class="tg-drr2">${Record_Update_vin}</td>
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
<form method="GET" action="Modify_UC.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">Please select one of the Car:</span></h3>
    <p style="text-align: center;">
    <form action="select_reservation" method="POST">
        <select name="ID" >

            <%
                for (int i = 1; i < count; i++){
                    request.setAttribute("Record_Update_count", i);
            %>
            <option>${Record_Update_count}</option>

            <%
                }
            %>
        </select>
        <input type="submit"/>
    </form>
    <form action="Driver_login.jsp" method="GET">
        <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
    </form>
    </p>
</form>

<%
    }
    else if(modify == null)// after choosing the car // chosenCar is available
    {
        carList = (ArrayList<String[]>) request.getAttribute("carList");
        int id = Integer.parseInt(chosenCar);
        String[] carinfo = carList.get(id-1);

        String vin = carinfo[0];
        String category = carinfo[1];
        String make = carinfo[2];
        String model = carinfo[3];
        String year = carinfo[4];

        int y = Integer.parseInt(year);
        UC uc = new UC(vin, category, make, model, y, driver.getLogin_ID() ); //String vin, String category, String make, String model, int year, String login
        session.setAttribute("UC", uc);

        //String[]fromTo = API.GetFromToHour(pid, con.stmt);
//        session.setAttribute("Record_Ride_From", fromTo[0]);
//        session.setAttribute("Record_Ride_To", fromTo[1]);

        session.setAttribute("Record_Update_vin", vin);
        session.setAttribute("Record_Update_category", category);
        session.setAttribute("Record_Update_model", model);
        session.setAttribute("Record_Update_make", make);
        session.setAttribute("Record_Update_year", year);
        session.setAttribute("Record_Update_count", id);

%>
<h3 style="text-align: center;"><span style="color: #0000ff;">Below is the Car You Selected:</span></h3>
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
        <th class="tg-y3o4">CAR NUMBER</th>
        <th class="tg-y3o4">VIN</th>
        <th class="tg-y3o4">CATEGORY</th>
        <th class="tg-y3o4">MAKE</th>
        <th class="tg-y3o4">MODEL</th>
        <th class="tg-1dhv">YEAR</th>
    </tr>
    <tr>
        <td class="tg-drr2">${Record_Update_count}</td>
        <td class="tg-drr2">${Record_Update_vin}</td>
        <td class="tg-drr2">${Record_Update_category}</td>
        <td class="tg-drr2">${Record_Update_make}</td>
        <td class="tg-drr2">${Record_Update_model}</td>
        <td class="tg-ywyf">${Record_Update_year}</td>
    </tr>
</table>


<form method="GET" action="Modify_UC.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">Please select one of the Column:</span></h3>
    <p style="text-align: center;">
    <form action="select_reservation" method="POST">
        <select name="col" >
            <option>Category</option>
            <option>Make</option>
            <option>Model</option>
            <option>Year</option>
        </select>

    <input name="Modify" type="text" required pattern=".*\S+.*">
        <input type="submit" value="Modify"/>
    </form>
    </p>
</form>
<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>


<%
    } // end of if // after choosing the car // chosenCar is available

    else //modify text is filled
    {

        String col = (String)request.getParameter("col");
        UC uc = (UC) session.getAttribute("UC");
        API.Update_UC_Info(uc, con.stmt, col, modify); //UC car, Statement stmt, String col, String new_value

%>

<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>Successfully modified your car information</strong></span></h3>
<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>

<%
    }
%>



<%

    con.closeConnection();
%>
</body>
</html>