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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/locale/easyui-lang-zh_CN.js"></script>
    <title>Title</title>
</head>
<body>

<%-- datagrid的使用:js来实现排版--%>
<script>
    $(function () {
        //抽取配置
        //1.抽取列的配置
        var columns = [[
            {field:'id',title:'编号',width:100,checkbox:true},
            {field:'name',title:'姓名',width:100},
            {field:'age',title:'年龄',width:100}
        ]];

        //2.抽取工具条配置
        var toolbar = [
            {
                iconCls: 'icon-edit',
                text:'Edit',
                handler: function(){
                    alert('编辑按钮')}
            },
            {
                text:'删除',
                handler: function(){
                    alert('编辑按钮')}
            }
        ];

        $("#grid").datagrid({
            url:'${pageContext.request.contextPath}/json/stafftest.json',
            rownumbers:true,//显示序号
            singleSelect:true,//单选
            pagination:true,//显示分页的工具条
            pageSize:3,//每页显示的条数
            pageList:[3,6,9], //分页条数选择
            columns:columns,
            toolbar:toolbar
        });

    });
</script>
<table id="grid"  class="easyui-datagrid"></table>


</body>
</html>
