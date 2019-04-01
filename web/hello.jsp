<%--
  Created by IntelliJ IDEA.
  User: ahmed.marey
  Date: 3/28/2019
  Time: 3:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>
Welcome <bean:write name="userForm" property="username" />
</h1>
</body>
</html>
