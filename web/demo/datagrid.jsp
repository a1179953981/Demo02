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
<body>

<%-- datagrid的使用--%>
<table class="easyui-datagrid" title="Basic DataGrid"
       data-options="url:'${pageContext.request.contextPath}/json/stafftest.json'">
    <thead>
        <tr>
            <th data-options="field:'id',width:80">编号</th>
            <th data-options="field:'name',width:100">姓名</th>
            <th data-options="field:'age',width:80,align:'right'">年龄</th>
        </tr>
    </thead>
    <%--<tr>
        <td>A001</td>
        <td>zs</td>
        <td>10</td>
    </tr>
    <tr>
        <td>A002</td>
        <td>zs1</td>
        <td>20</td>
    </tr>--%>
</table>


</body>
</html>
