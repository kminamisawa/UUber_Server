<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/09
  Time: 4:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    ArrayList<String> hantei = (ArrayList<String>)session.getAttribute("pids");
%>

The first pid is <%= hantei.get(0)%>
</body>
</html>
