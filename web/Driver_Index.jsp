<%@ page import="cs5530.API" %>
<%@ page import="cs5530.Connector2" %><%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/02
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Connector2 con = new Connector2();
%>
<html>
<head>
    <%--<script LANGUAGE="javascript">--%>

    <%--function check_all_fields(form_obj){--%>
    <%--// alert(form_obj.searchAttribute.value+"='"+form_obj.attributeValue.value+"'");--%>
    <%--if( form_obj.UserID.value == ""){--%>
    <%--alert("Login field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.Password.value == ""){--%>
    <%--alert("Password field should be nonempty");--%>
    <%--return false;--%>
    <%--}--%>
    <%--return true;--%>
    <%--}--%>

    <%--function check_all_register_info(form_obj) {--%>
    <%--if( form_obj.RloginValue.value == ""){--%>
    <%--alert("Login field should be nonempty");--%>
    <%--return false;a--%>
    <%--}else if( form_obj.RpwValue.value == ""){--%>
    <%--alert("Password field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.RnameValue.value == ""){--%>
    <%--alert("Name field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.RstreetValue.value == ""){--%>
    <%--alert("Street field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.RcityValue.value == ""){--%>
    <%--alert("City field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.RstateValue.value == ""){--%>
    <%--alert("State field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.RzipValue.value == ""){--%>
    <%--alert("Zip field should be nonempty");--%>
    <%--return false;--%>
    <%--}else if( form_obj.RphoneValue.value == ""){--%>
    <%--alert("Phone field should be nonempty");--%>
    <%--return false;--%>
    <%--}--%>
    <%--return true;--%>
    <%--}--%>

    <%--</script>--%>
</head>
<body>

<div>
    <h1 style="text-align: center;"><span style="color: #ff6600;"><img src="https://html-online.com/editor/tinymce4_6_5/plugins/emoticons/img/smiley-cool.gif" alt="cool" /> Welcome to U-UBER<img src="https://html-online.com/editor/tinymce4_6_5/plugins/emoticons/img/smiley-cool.gif" alt="cool" /></span></h1>
</div>
<div style="text-align: center;">
    <%--<form name="UserIDInfo" method=get onsubmit="return check_all_fields(this)" action="login.jsp">--%>
    <form name="UserIDInfo" method=get action="login.jsp">

        <p><strong>Login ID:</strong>
            <input name="UserID" type="text" required pattern=".*\S+.*">
        </p>

        <p><strong>Password:</strong>
            <input name="Password" type="password" required pattern=".*\S+.*"></p>
        <p><input type=submit value="Login"></p>
    </form>
</div>
<div>
    <p style="text-align: center;">&nbsp;</p>
</div>
<div>
    <h4 style="text-align: center;"><span style="color: #ff6600;">Create a New Account</span></h4>
</div>


<div style="text-align: center;">
    <form name="UserRegisterInfo" method=get action="User_Regisger.jsp">
        <p><strong>Login ID:</strong>
            <input name="RloginValue" type="text" required pattern=".*\S+.*">
        </p>

        <p><strong>Password:</strong>
            <input name="RpwValue" type="password" required pattern=".*\S+.*"></p>

        <p><strong>Name:</strong>
            <input name="RnameValue" type="text" required pattern=".*\S+.*">
        </p>
        <p><strong>Street:</strong>
            <input name="RstreetValue" type="text" required pattern=".*\S+.*">
        </p>
        <p><strong>City:</strong>
            <input name="RcityValue" type="text" required pattern=".*\S+.*">
        </p>
        <p><strong>State:</strong>
            <input name="RstateValue" type="text" required pattern=".*\S+.*">
        </p>
        <p><strong>Zip:</strong>
            <input name="RzipValue" type="text" required pattern=".*\S+.*">
        </p>
        <p><strong>Phone:</strong>
            <input name="RphoneValue" type="text" required pattern=".*\S+.*">
        </p>

        <p><input type=submit value="Register"></p>
    </form>
</div>

<div style="text-align: center;">
    <form name="UserIDInfo" method=get action="index.jsp">
        <a href="index.jsp">Are you an User?</a><br />
    </form>
</div>
<%
    con.closeConnection();
%>
</body>
