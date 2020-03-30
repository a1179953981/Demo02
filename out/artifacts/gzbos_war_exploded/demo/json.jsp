<%--
  Created by IntelliJ IDEA.
  User: gyf
  Date: 2018/5/4
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/easyui/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery.easyui.min.js"></script>
    <title>Title</title>
    <script>
        var jsonStr = '{"username":"gyf","password":"123"}';
       console.log(jsonStr);

        //JSON.parse() 字符串转json对象
        var jsonObj = JSON.parse(jsonStr);
        console.log(jsonObj);
        console.log(jsonObj.username);

        var v1 = {username:'aaa',passowrd:'321'};
        var v2 = JSON.stringify(v1)//json对象转字符串
        console.log(v2);

    </script>
</head>
<body>

</body>
</html>
