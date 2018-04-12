<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/11
  Time: 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log Out</title>

    <SCRIPT LANGUAGE="javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </SCRIPT>
</head>


<body onload="noBack();"
      onpageshow="if (event.persisted) noBack();" onunload="">
You have successfully logged out.
<%
    session.removeAttribute("user");
    session.removeAttribute("driver");
//    request.getSession().invalidate();
//    response.setHeader("Cache-Control", "no-cache");
//    response.setHeader("Pragma", "no-cache");
//    response.setDateHeader("Expires", 0);
//    session.invalidate();
////    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>


<div style="text-align:center">
    <form name="back_to_menu" method=get action="index.jsp">
        <input type=submit value="Back to the Main">
    </form>
</div>

</body>

</html>
