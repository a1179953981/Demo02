<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>区域设置</title>
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
    <script
            src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"
            type="text/javascript"></script>
    <script type="text/javascript">
        function doAdd() {
            $('#addRegionWindow').window("open");
        }

        function doView() {
            $('#searchWindow').window("open")
        }

        function doDelete() {
            // alert("删除...");
            //alert("删除...");
            //1.获取所有删除的ID
            //获取所有选中的行
            var selectedRows = $("#grid").datagrid('getSelections');

            if (selectedRows.length == 0) {
                $.messager.alert('提示', '未选中要删除的数据', 'error');
                return;
            }
            // alert(selectedRows.length)
            //var ids = '';
            var ids = new Array();//创建数组
            for (var i = 0; i < selectedRows.length; i++) {
                //获取每一行数据[json对象]
                var rowData = selectedRows[i];
                //ids += rowData.id + ',';
                ids.push(rowData.no);//添加id
            }

            var idsStr = ids.join(',');//连接字符串
            // alert("选中的id为"+idsStr);


            //2.访问staffAction_delete.action?ids=A01,A02,A03
            $.post(
                '${pageContext.request.contextPath}/regionAction_delete.action',
                {ids: idsStr},
                function (data) {
                    // alert("data======"+data)
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


        //工具栏
        var toolbar = [{
            id: 'button-view',
            text: '查询',
            iconCls: 'icon-search',
            handler: doView
        },
            {
                id: 'button-add',
                text: '增加',
                iconCls: 'icon-add',
                handler: doAdd
            }, {
                id: 'button-delete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: doDelete
            },
            // 	{
            // 	id : 'button-import',
            // 	text : '导入',
            // 	iconCls : 'icon-redo'
            // }
        ];
        // 定义列
        var columns = [[{
            field: 'id',
            checkbox: true,
        }, {
            field: 'no',
            title: 'No',
            width: 228,
            align: 'center'
        }, {
            field: 'brand',
            title: '品牌',
            width: 228,
            align: 'center'
        }, {
            field: 'size',
            title: '尺寸',
            width: 228,
            align: 'center'
        }, {
            field: 'userEntity.name',
            title: '使用人',
            width: 228,
            align: 'center',
            formatter: function (data, row, index) {
                if (row.userEntity != null) {
                    return row.userEntity.name;
                } else
                    return null

            }
            // formatter : function(data,row ,index){
            // 	return userEntity.name;
            // }
        }, {
            field: 'starus',
            title: '状态',
            width: 150,
            align: 'center'
        }, {
            field: 'note',
            title: '备注',
            width: 228,
            align: 'center'
        },{
            field: 'time',
            title: '更新时间',
            width: 278,
            align: 'center'
        }
        ]];

        $(function () {
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

            // 先将body隐藏，再显示，不会出现页面刷新效果
            $("body").css({visibility: "visible"});

            // 收派标准数据表格
            $('#grid').datagrid({
                iconCls: 'icon-forward',
                fit: true,
                border: false,
                rownumbers: true,
                striped: true,
                pageList: [25, 30, 35],
                pagination: true,
                toolbar: toolbar,
                url: "${pageContext.request.contextPath}/regionAction_pageQuery.action",
                idField: 'id',
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
            $("#searchBtn").click(function () {

                //1.获取表单数据
                var data = getFormData("searchregionForm");

                // alert(data);
                console.log(data);

                //2.调用grid的load方法
                $("#grid").datagrid('load', data);


            });

            // 添加、修改区域窗口
            $('#addRegionWindow').window({
                title: '添加修改区域',
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
            //监听保存按钮
            $("#save").click(function () {
                //表单检验
                var v = $("#addregionForm").form('validate');
                if (v) {
                    //提交表单
                    $("#addregionForm").submit();
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


            //绑定一键上传
            $('#button-import').upload({
                action: '${pageContext.request.contextPath}/regionAction_importExcel.action',
                name: 'excelFile',
                onComplete: function (data) {
                    //alert(data);
                    $("#grid").datagrid('reload');
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
<div class="easyui-window" title="区域添加修改" id="addRegionWindow" collapsible="false" minimizable="false"
     maximizable="false" style="top:20px;left:200px">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </div>
    </div>

    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="addregionForm" action="${pageContext.request.contextPath}/regionAction_save.action">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">显示器资产信息</td>
                </tr>
                <tr>
                    <td>编号</td>
                    <td><input type="text" name="no" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>品牌</td>
                    <td><input type="text" name="brand" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>尺寸</td>
                    <td><input type="text" name="size" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>使用人</td>
                    <td><input type="text" name="userEntity.name" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td><input type="text" name="starus" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td><input type="text" name="note" class="easyui-validatebox"/></td>
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
        <form id="editStaffForm" action="${pageContext.request.contextPath}/regionAction_update.action">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">员工信息</td>
                </tr>
                <tr>
                    <td>编号</td>
                    <td><input type="text" name="no"/></td>
                </tr>
                <tr>
                    <td>品牌</td>
                    <td><input type="text" name="brand"/></td>
                </tr>
                <tr>
                    <td>尺寸</td>
                    <td><input type="text" name="size"/></td>
                </tr>
                <tr>
                    <td>使用人</td>
                    <td><input type="text" name="userEntity.name"/></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td><input type="text" name="starus"/></td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td><input type="text" name="note"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!-- 查询显示器资产-->
<div class="easyui-window" title="查询显示器资产" id="searchWindow" collapsible="false" minimizable="false" maximizable="false"
     style="top:20px;left:200px">
    <div style="overflow:auto;padding:5px;" border="false">
        <form id="searchregionForm">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">查询条件</td>
                </tr>
                <tr>
                    <td>编号</td>
                    <td><input type="text" name="no"/></td>
                </tr>
                <tr>
                    <td>品牌</td>
                    <td><input type="text" name="brand"/></td>
                </tr>
                <tr>
                    <td>尺寸</td>
                    <td><input type="text" name="size"/></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td><input type="text" name="starus"/></td>
                </tr>
                <tr>
                    <td>使用人</td>
                    <td><input type="text" name="userEntity.name"/></td>
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