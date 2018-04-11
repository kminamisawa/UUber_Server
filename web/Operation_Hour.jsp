<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/08
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Time" %>
<html>
<head>
    <title>Add Operation Hour</title>
</head>
<body>
<h1 style="text-align: center;"><span style="color: #ff6600;">UUber&nbsp;Add Operation Hour</span></h1>
<%
    Connector2 con = new Connector2();
    UD ud = (UD)session.getAttribute("driver");

    String StartHour = (String) request.getParameter("StartHour");
    String StartMinute = (String) request.getParameter("StartMinute");

    String EndHour = (String) request.getParameter("EndHour");
    String EndMinute = (String) request.getParameter("EndMinute");


    if(StartHour == null)
    {
%>
<form method="GET" action="Operation_Hour.jsp">
    <h3 style="text-align: center;"><span style="color: #0000ff;">Please select the starting hour and end hour:</span></h3>
    <p style="text-align: center;">
    <form action="select_reservation" method="POST">
        <select name="StartHour" >
            <option>0</option>
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            <option>6</option>
            <option>7</option>
            <option>8</option>
            <option>9</option>
            <option>10</option>
            <option>11</option>
            <option>12</option>
            <option>13</option>
            <option>14</option>
            <option>15</option>
            <option>16</option>
            <option>17</option>
            <option>18</option>
            <option>20</option>
            <option>21</option>
            <option>22</option>
            <option>23</option>
        </select>
        :
        <select name="StartMinute" >
            <option>00</option>
            <option>5</option>
            <option>10</option>
            <option>15</option>
            <option>20</option>
            <option>25</option>
            <option>30</option>
            <option>35</option>
            <option>40</option>
            <option>45</option>
            <option>50</option>
            <option>55</option>
        </select>

        ~

        <select name="EndHour" >
            <option>0</option>
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            <option>6</option>
            <option>7</option>
            <option>8</option>
            <option>9</option>
            <option>10</option>
            <option>11</option>
            <option>12</option>
            <option>13</option>
            <option>14</option>
            <option>15</option>
            <option>16</option>
            <option>17</option>
            <option>18</option>
            <option>20</option>
            <option>21</option>
            <option>22</option>
            <option>23</option>
        </select>
        :
        <select name="EndMinute" >
            <option>00</option>
            <option>5</option>
            <option>10</option>
            <option>15</option>
            <option>20</option>
            <option>25</option>
            <option>30</option>
            <option>35</option>
            <option>40</option>
            <option>45</option>
            <option>50</option>
            <option>55</option>
        </select>

        <input type="submit" value="Enter"/>
    </form>
    </p>
</form>
<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>

<%
    }
    else
    {

        Time st = Time.valueOf(StartHour +":" + StartMinute + ":00");
        Time et = Time.valueOf(EndHour +":" + EndMinute + ":00");

        int s = Integer.parseInt(StartHour + StartMinute);
        int e = Integer.parseInt(EndHour+EndMinute);



        boolean b =  (e - s) > 0;     //s.compareTo(e)<0; // s = 800 , e = 1200


        if(b)
        {
            if(API.Update_UD_OperationHour(st,et,ud.getLogin_ID(),con.stmt))
            {
%>
<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>Successfully added your operation hour</strong></span></h3>
<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>
<%
            } else
            {
%>
<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>Sorry, your operation hour did not added to database</strong></span></h3>
<form action="Operation_Hour.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Try again" /></p>
</form>
<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>
<%
    }
        }
        else
        {
%>
<h3 style="text-align: center;"><span style="color: #ff6600;"><strong>End hour must be later than the start hour</strong></span></h3>
<form action="Operation_Hour.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Try again" /></p>
</form>
<form action="Driver_login.jsp" method="GET">
    <p style="text-align: center;"><input type="submit" value="Main Menu" /></p>
</form>
<%
        }

    }
%>



<%
    con.closeConnection();
%>
</body>
</html>