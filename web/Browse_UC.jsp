<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/11
  Time: 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<html>
<head>
    <title>Browse UC</title>
</head>
<body>
<h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Browse UC</strong></span></h1>
<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");

    String category = request.getParameter("CATEGORY");
    String model = request.getParameter("MODEL");
    String citu = request.getParameter("CITY");
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
        
    }
%>

<%
    con.closeConnection();
%>
</body>
</html>
