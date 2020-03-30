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
</head>
<%--
1.导入css和js
2.copy div
--%>
<body class="easyui-layout">

    <div data-options="region:'north'" style="height:50px">A</div>
    <div data-options="region:'south'" style="height:50px;">B</div>
    <div data-options="region:'center'">E</div>
    <div data-options="region:'east'"  style="width:180px;">C</div>
    <div data-options="region:'west'"  style="width:100px;">

        <div class="easyui-accordion" data-options="fit:true">
            <div title="面板一">1</div>
            <div title="面板二">2</div>
            <div title="面板三">3</div>
        </div>

    </div>
</body>
</html>
