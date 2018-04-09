<%--
  Created by IntelliJ IDEA.
  User: takusakikawa
  Date: 4/8/18
  Time: 11:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="cs5530.*" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    Connector2 con = new Connector2();
    String loginID = request.getParameter("RloginValue");
    String password = request.getParameter("RpwValue");
    String name = request.getParameter("RnameValue");
    String street = request.getParameter("RstreetValue");
    String city = request.getParameter("RcityValue");
    String state = request.getParameter("RstateValue");
    String zip = request.getParameter("RzipValue");
    String phone = request.getParameter("RphoneValue");
    UD new_user = new UD(loginID,password,name,street,city,state, phone);
    if(API.Registration_UDriver(new_user,con.stmt))
    {
%>
<p style="text-align: center;"><strong>Successfully Registered</strong></p>
<form name="UserRegisterInfo" method=get action="Driver_Index.jsp">
    <p style="text-align: center;"><input type="submit" value="Login" /></p>
</form>

<%
}
else
{
%>
<p style="text-align: center;"><strong>Login ID is not available</strong>&nbsp;</p>
<p style="text-align: center;"><button type="button" name="back" onclick="history.back()">back</button>
        <%
    }
    con.closeConnection();
%>
    <html>
    <head>
    </head>
    <body>
    <%--This is a test <%= password %> on yeah--%>
    </body>
    </html>