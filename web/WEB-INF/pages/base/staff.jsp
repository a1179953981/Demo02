<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- 导入jquery核心类库 -->
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
    <!-- 导入easyui类库 -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/css/default.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
    <script
            src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
            type="text/javascript"></script>
    <script type="text/javascript">
        function doAdd() {
            //alert("增加...");
            $('#addStaffWindow').window("open");
        }

        function doView() {
            // alert("查看...");
            $('#searchWindow').window("open")
        }

        function doDelete() {
            //alert("删除...");
            //1.获取所有删除的ID
            //获取所有选中的行
            var selectedRows = $("#grid").datagrid('getSelections');

            if (selectedRows.length == 0) {
                $.messager.alert('提示', '未选中要删除的员工', 'error');
                return;
            }
            //alert(selectedRows.length)
            //var ids = '';
            var ids = new Array();//创建数组
            for (var i = 0; i < selectedRows.length; i++) {
                //获取每一行数据[json对象]
                var rowData = selectedRows[i];
                //ids += rowData.id + ',';
                ids.push(rowData.name);//添加id
            }

            var idsStr = ids.join(',');//连接字符串
            alert("idsStr=" + idsStr);


            //2.访问staffAction_delete.action?ids=A01,A02,A03
            $.post(
                '${pageContext.request.contextPath}/staffAction_delete.action',
                {ids: idsStr},
                function (data) {
                    if (data == 'success') {
                        $.messager.alert('提示', '删除成功', 'info');
                        //重新刷新当前页数据【自己找】
                        $('#grid').datagrid('reload');
                    } else {
                        $.messager.alert('提示', '删除失败', 'error');
                    }

                }
            );

        }

        function doRestore() {
            alert("将员工还原...");
        }

        //工具栏
        var toolbar = [{
            id: 'button-view',
            text: '查询',
            iconCls: 'icon-search',
            handler: doView
        }, {
            id: 'button-add',
            text: '增加',
            iconCls: 'icon-add',
            handler: doAdd
        }, {
            id: 'button-delete',
            text: '删除',
            iconCls: 'icon-cancel',
            handler: doDelete
        }
            // ,{
            // 	id : 'button-save',
            // 	text : '还原',
            // 	iconCls : 'icon-save',
            // 	handler : doRestore
            // }
        ];
        // 定义列
        var columns = [[{
            field: 'id',
            checkbox: true,
        }, {
            field: 'name',
            title: '姓名',
            width: 400,
            align: 'center'
        }, {
            field: 'position',
            title: '职位',
            width: 400,
            align: 'center'
        }, {
            field: 'departments',
            title: '所属部门',
            width: 400,
            align: 'center',
        }, {
            field: 'dateOfEntry',
            title: '入职日期',
            width: 400,
            align: 'center',
            // formatter : function(data,row, index){
            // 	if(data=="0"){
            // 		return "正常使用"
            // 	}else{
            // 		return "已作废";
            // 	}
            // }
        }]];

        //获取表彰的数据
        function getFormData(formId) {
            var form = document.getElementById(formId);
            var data = {};
            var tagElements = form.getElementsByTagName('input');

            for (var j = 0; j < tagElements.length; j++) {
                var input = tagElements[j];
                var n = input.name;
                var v = input.value;
                data[n] = v;
            }
            return data;
        }

        $(function () {
            //添加一个表单的手机校验的规则
            $.extend($.fn.validatebox.defaults.rules, {
                phoneNumber: {
                    validator: function (value, param) {
                        return /^1[3|4|5|7|8][0-9]{9}$/.test(value);
                    },
                    message: '请输入正确的手机号码!'
                }
            });

            // 先将body隐藏，再显示，不会出现页面刷新效果
            $("body").css({visibility: "visible"});

            // 取派员信息表格
            $('#grid').datagrid({
                iconCls: 'icon-forward',
                fit: true,
                border: false,
                rownumbers: true,
                striped: true,
                pageSize: 5,
                pageList: [25, 30, 35],
                pagination: true,
                toolbar: toolbar,
                url: "${pageContext.request.contextPath}/staffAction_pageQuery.action",
                idField: 'name',
                columns: columns,
                onDblClickRow: doDblClickRow
            });
            //搜索
            $('#searchWindow').window({
                title: '查询',
                width: 400,
                modal: true,
                shadow: true,
                closed: true,
                height: 400,
                resizable: false
            });

            // 添加
            $('#addStaffWindow').window({
                title: '添加新员工',
                width: 400,
                modal: true,
                shadow: true,
                closed: true,
                height: 400,
                resizable: false
            });

            $('#editStaffWindow').window({
                title: '修改员工信息',
                width: 400,
                modal: true,
                shadow: true,
                closed: true,
                height: 400,
                resizable: false
            });
            $("#searchBtn").click(function () {

                //1.获取表单数据
                var data = getFormData("searchStaffForm");

                // alert(data);
                console.log(data);

                //2.调用grid的load方法
                $("#grid").datagrid('load', data);


            });

            //监听保存按钮
            $("#save").click(function () {
                //表单检验
                var v = $("#addStaffForm").form('validate');
                if (v) {
                    //提交表单
                    $("#addStaffForm").submit();
                } else {
                    $.messager.alert('提示', '表单数据格式不正确', 'error');
                }

            });

            //更新数据
            $("#update").click(function () {
                //表单检验
                var v = $("#editStaffForm").form('validate');
                if (v) {
                    //提交表单
                    $("#editStaffForm").submit();
                } else {
                    $.messager.alert('提示', '表单数据格式不正确', 'error');
                }
            });

        });

        function doDblClickRow(rowIndex, rowData) {
            $('#editStaffWindow').window("open");

            //显示数据
            $('#editStaffForm').form("load", rowData);
        }
    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
<div region="center" border="false">
    <table id="grid"></table>
</div>

<%-- 添加取派员窗口--%>
<div class="easyui-window" title="对收派员进行添加或者修改" id="addStaffWindow" collapsible="false" minimizable="false"
     maximizable="false" style="top:20px;left:200px">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </div>
    </div>

    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="addStaffForm" action="${pageContext.request.contextPath}/staffAction_save.action">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">新员工信息</td>
                </tr>
                <!-- TODO 这里完善收派员添加 table -->
                <tr>
                    <td>姓名</td>
                    <td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>职位</td>
                    <td><input type="text" name="position" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>所属部门</td>
                    <td><input type="text" name="departments" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>入职日期</td>
                    <td><input type="date" name="dateOfEntry" class="easyui-validatebox" required="true"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>


<%-- 修改员工信息窗口 --%>
<div class="easyui-window" title="对员工信息进行修改" id="editStaffWindow" collapsible="false" minimizable="false"
     maximizable="false" style="top:20px;left:200px">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="update" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">更新</a>
        </div>
    </div>

    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="editStaffForm" action="${pageContext.request.contextPath}/staffAction_update.action">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">员工信息</td>
                </tr>
                <tr>
                    <td>员工姓名</td>
                    <td><input type="text" name="name" class="easyui-validatebox" required="true" readonly="true"/></td>
                </tr>
                <tr>
                    <td>职位</td>
                    <td><input type="text" name="position" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>所属部门</td>
                    <td><input type="text" name="departments" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>入职日期</td>
                    <td><input type="text" name="dateOfEntry" class="easyui-validatebox" required="true"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!-- 查询花名册 -->
<div class="easyui-window" title="查询花名册窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false"
     style="top:20px;left:200px">
    <div style="overflow:auto;padding:5px;" border="false">
        <form id="searchStaffForm">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">查询条件</td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td><input type="text" name="name"/></td>
                </tr>
                <tr>
                    <td>职位</td>
                    <td><input type="text" name="position"/></td>
                </tr>
                <tr>
                    <td>所属部门</td>
                    <td><input type="text" name="departments"/></td>
                </tr>
                <tr>
                    <td>入职日期</td>
                    <td><input type="text" name="dateOfEntry"/></td>
                </tr>
                <tr>
                    <td colspan="2"><a id="searchBtn" href="#" class="easyui-linkbutton"
                                       data-options="iconCls:'icon-search'">查询</a></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>	