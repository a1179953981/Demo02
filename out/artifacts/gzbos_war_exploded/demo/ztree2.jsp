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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/ztree/zTreeStyle.css" >

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/ztree/jquery.ztree.all-3.5.js"></script>
    <title>Title</title>
</head>
<%--
1.导入css和js
2.copy div
--%>
<body class="easyui-layout">

    <div data-options="region:'north'" style="height:50px">A</div>
    <div data-options="region:'south'" style="height:50px;">B</div>
    <div data-options="region:'center'">
        <%-- 选项卡--%>
        <div id="tt" class="easyui-tabs" data-options="fit:true">
            <div title="快递列表一" data-options="closable:true"></div>
            <div title="快递列表二" data-options="closable:true"></div>
            <div title="快递列表三" data-options="closable:true"></div>
        </div>

        </div>
    <div data-options="region:'east'"  style="width:180px;">C</div>
    <div data-options="region:'west'"  style="width:200px;">

        <div class="easyui-accordion" data-options="fit:true">
            <script>
                function add(title) {
                    $('#tt').tabs('add',{
                        title: title,
                        content: '<div>Content'+title+'</div>',
                        closable: true
                    });
                }
            </script>
            <div title="面板一" >
                <a href="#" onclick="add('收单列表')">收单列表</a><br>
                <a href="#" onclick="add('派单列表')">派单列表</a>
            </div>
            <div title="面板二">

                <%--使用ztree来显示功能列表
                    1.导入ztree的js/css/image到项目中
                    2.js导入ztree的css/js
                    3.提供ul标签
                    4.在文档加载完成后给ul初始化数据

                --%>
                <script>
                    //1.创建一个setting
                    var setting = {
                        data: {
                            simpleData: {
                                enable:true,
                                idKey: "id",
                                pIdKey: "pId",
                                rootPId: ""
                            }
                        },
                        callback:{
                            /**
                             * event:事件
                             * treeId:树的ID
                             * treeNode:节点-里面包括数据
                             * */
                            onClick:function (event, treeId, treeNode, clickFlag)  {
                                //父标签不需要添加tab
                                if(treeNode.isParent) return;

                                //获取是否有当前点击的选项卡
                                var tab = $('#tt').tabs('exists',treeNode.name);
                                if(tab){//代表存在
                                    //如果存在设置为选中状态
                                    $('#tt').tabs('select',treeNode.name);
                                }else{
                                    //显示新的tab
                                    $('#tt').tabs('add',{
                                        title: treeNode.name,
                                        content: '<div>Content'+treeNode.name+'</div>',
                                        closable: true
                                    });
                                }

                            }
                        }
                    };

                    //2.创建标准json数据
                    /*var nodes = [
                        {name: "用户功能", children: [
                            {name: "添加用户"},
                            {name: "删除用户"}
                        ]},
                        {name: "定单功能", children: [
                            {name: "添加定单"},
                            {name: "删除定单"}
                        ]},
                        {name:"权限功能"}
                    ];*/

                    //创建简单的json数据
                    /*var nodes = [
                        {id:1, pId:0, name: "用户功能"},
                        {id:11, pId:1, name: "删除用户"},
                        {id:111, pId:11, name: "AA"},
                        {id:112, pId:11, name: "BB"},
                        {id:12, pId:1, name: "添加用户"},
                        {id:2, pId:0, name: "定单功能"},
                        {id:21, pId:2, name: "删除定单"},
                        {id:22, pId:2, name: "添加定单"}
                    ];*/

                    //3.给ul标签填上数据

                    $(document).ready(function(){
                        //1.获取菜单数据
                        var url = "${pageContext.request.contextPath}/json/menu.json"
                        $.get(url,function (data) {
                            //console.log(data);
                            $.fn.zTree.init($("#treeDemo"), setting, data);
                        })
                        //
                    });
                </script>
                <ul id="treeDemo" class="ztree"></ul>
            </div>
            <div title="面板三">3</div>
        </div>

    </div>
</body>
</html>
