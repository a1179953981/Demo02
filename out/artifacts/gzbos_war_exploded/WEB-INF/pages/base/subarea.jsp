<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>管理分区</title>
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
            $('#addSubareaWindow').window("open");
        }

        function doEdit() {
            alert("修改...");
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
                '${pageContext.request.contextPath}/subareaAction_delete.action',
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

        function doSearch() {
            $('#searchWindow').window("open");
        }

        function doExport() {
            //alert("导出");
            location.href = '${pageContext.request.contextPath}/subareaAction_exportExcel.action';
        }

        function doImport() {
            alert("导入");
        }

        //工具栏
        var toolbar = [{
            id: 'button-search',
            text: '查询',
            iconCls: 'icon-search',
            handler: doSearch
        }, {
            id: 'button-add',
            text: '增加',
            iconCls: 'icon-add',
            handler: doAdd
        },
            //     {
            //     id: 'button-edit',
            //     text: '修改',
            //     iconCls: 'icon-edit',
            //     handler: doEdit
            // },
            {
                id: 'button-delete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: doDelete
            },
            //     {
            //     id: 'button-import',
            //     text: '导入',
            //     iconCls: 'icon-redo',
            //     handler: doImport
            // },
            //     {
            //     id: 'button-export',
            //     text: '导出',
            //     iconCls: 'icon-undo',
            //     handler: doExport
            // }
        ];
        // 定义列
        var columns = [[{
            field: 'id',
            checkbox: true,
        }, {
            field: 'no',
            title: '编号',
            width: 133,
            align: 'center',
        }, {
            field: 'brand',
            title: '品牌',
            width: 133,
            align: 'center'
        }, {
            field: 'cpu',
            title: 'cpu',
            width: 133,
            align: 'center'
        }, {
            field: 'rom',
            title: '硬盘',
            width: 133,
            align: 'center'
        },
            {
                field: 'ram',
                title: '内存',
                width: 133,
                align: 'center',
            }, {
                field: 'type',
                title: '类型',
                width: 145,
                align: 'center',
            }, {
                field: 'mac',
                title: 'mac地址',
                width: 133,
                align: 'center',
            }, {
                field: 'status',
                title: '状态',
                width: 133,
                align: 'center',
                // formatter: function (data, row, index) {
                //     if (row.status == 0) {
                //         return "空闲";
                //     } else
                //         return "已使用"
                // }
            }, {
                field: 'procurementDate',
                title: '采购日期',
                width: 133,
                align: 'center',
            }, {
                field: 'userEntity.name',
                title: '使用人',
                width: 133,
                align: 'center',
                formatter: function (data, row, index) {
                    if (row.userEntity != null) {
                        return row.userEntity.name;
                    } else
                        return null
                }
            }, {
                field: 'notes',
                title: '备注',
                width: 145,
                align: 'center',
            },
            {
                field: 'time',
                title: '更新时间',
                width: 133,
                align: 'center',
            }
        ]
        ]

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
            // 先将body隐藏，再显示，不会出现页面刷新效果
            $("body").css({visibility: "visible"});

            // 收派标准数据表格
            $('#grid').datagrid({
                iconCls: 'icon-forward',
                fit: true,
                border: true,
                rownumbers: true,
                striped: true,
                pageSize: 2,
                pageList: [25, 30, 35],
                pagination: true,
                toolbar: toolbar,
                url: "${pageContext.request.contextPath}/subareaAction_pageQuery.action",
                idField: 'no',
                columns: columns,
                onDblClickRow: doDblClickRow
            });
            // 添加、修改分区
            $('#addSubareaWindow').window({
                title: '添加资产',
                width: 600,
                modal: true,
                shadow: true,
                closed: true,
                height: 500,
                resizable: false
            });
            $('#editsubareaWindow').window({
                title: '修改员工信息',
                width: 600,
                modal: true,
                shadow: true,
                closed: true,
                height: 500,
                resizable: false
            });
            // 查询分区
            $('#searchWindow').window({
                title: '查询分区',
                width: 400,
                modal: true,
                shadow: true,
                closed: true,
                height: 400,
                resizable: false
            });
            $("#searchBtn").click(function () {
                //alert("执行查询...");
                //1.获取表单数据

                var data = getFormData("searchSubareaForm");
                // alert(data);
                console.log(data);

                //2.调用grid的load方法
                $("#grid").datagrid('load', data);


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

            $("#save").click(function () {

                var v = $("#addSubareaForm").form('validate');
                if (v) {
                    $("#addSubareaForm").submit();
                } else {
                    $.messager.alert("提示", "表单数据不正确", "error");
                }
            });

        });


        function doDblClickRow(rowIndex, rowData) {
            $('#editsubareaWindow').window("open");
            //
            // alert(rowData.no)
            // //显示数据
            $('#editsubareaWindow').form("load", rowData);
        }

    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
<div region="center" border="false">
    <table id="grid"></table>
</div>
<!-- 添加 修改分区 -->
<div class="easyui-window" title="分区添加修改" id="addSubareaWindow" collapsible="false" minimizable="false"
     maximizable="false" style="top:20px;left:200px">
    <div style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </div>
    </div>

    <div style="overflow:auto;padding:5px;" border="false">
        <form id="addSubareaForm" action="${pageContext.request.contextPath}/subareaAction_save.action">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">电脑主机信息</td>
                </tr>
                <tr>
                    <td>编码</td>
                    <td><input type="text" name="no" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>品牌</td>
                    <%--                    <td>--%>
                    <%--                        <input class="easyui-combobox" name="brand"--%>
                    <%--                               data-options="valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/regionAction_listJson.action'"/>--%>
                    <%--                    </td>--%>
                    <td><input type="text" name="brand" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>cpu</td>
                    <td><input type="text" name="cpu" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>硬盘</td>
                    <td><input type="text" name="rom" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>内存</td>
                    <td><input type="text" name="ram" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>类型</td>
                    <td>
                        <select class="easyui-combobox" name="type" style="width:150px;">
                            <option value="0">ZJ</option>
                            <option value="1">lTJ</option>
                            <option value="2">BJB</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>mac地址</td>
                    <td><input type="text" name="mac" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>使用状态</td>
                    <td><input type="text" name="status" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>采购日期</td>
                    <td><input type="text" name="procurementDate" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>使用人</td>
                    <td><input type="text" name="name" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td><input type="text" name="notes" class="easyui-validatebox"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!-- 查询分区 -->
<div class="easyui-window" title="查询分区窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false"
     style="top:20px;left:200px">
    <div style="overflow:auto;padding:5px;" border="false">
        <form id="searchSubareaForm">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">查询条件</td>
                </tr>
                <tr>
                    <td>编号</td>
                    <td><input type="text" name="no"/></td>
                </tr>
                <tr>
                    <td>使用人</td>
                    <td><input type="text" name="userEntity.name"/></td>
                </tr>
                <tr>
                    <td>mac地址</td>
                    <td><input type="text" name="mac"/></td>
                </tr>
                <tr>
                    <td>类型</td>
                    <td><input type="text" name="type"/></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td><input type="text" name="status"/></td>
                </tr>
                <tr>
                    <td colspan="2"><a id="searchBtn" href="#" class="easyui-linkbutton"
                                       data-options="iconCls:'icon-search'">查询</a></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<%-- 修改员工信息窗口 --%>
<div class="easyui-window" title="对员工信息进行修改" id="editsubareaWindow" collapsible="false" minimizable="false"
     maximizable="false" style="top:20px;left:200px">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="update" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">更新</a>
        </div>
    </div>

    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="editStaffForm" action="${pageContext.request.contextPath}/subareaAction_update.action">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">员工信息</td>
                </tr>
                <tr>
                    <td>编号</td>
                    <td><input type="text" name="no" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>品牌</td>
                    <td><input type="text" name="brand" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>cpu</td>
                    <td><input type="text" name="cpu" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>硬盘</td>
                    <td><input type="text" name="rom" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>内存</td>
                    <td><input type="text" name="ram" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>类型</td>
                    <td><input type="text" name="type" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>mac地址</td>
                    <td><input type="text" name="mac" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td><input type="text" name="status" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>采购日期</td>
                    <td><input type="text" name="procurementDate" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td><input type="text" name="notes" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td>使用人</td>
                    <td><input type="text" name="userEntity.name" class="easyui-validatebox"/></td>
                </tr>


            </table>
        </form>
    </div>
</div>
</body>
</html>