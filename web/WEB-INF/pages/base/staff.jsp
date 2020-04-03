<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	function doAdd(){
		//alert("增加...");
		$('#addStaffWindow').window("open");
	}
	
	function doView(){
		alert("查看...");
	}
	
	function doDelete(){
		//alert("删除...");
		//1.获取所有删除的ID
		//获取所有选中的行
		var selectedRows = $("#grid").datagrid('getSelections');

		if(selectedRows.length == 0){
		    $.messager.alert('提示','未选中要作废的取派员','error');
		    return;
		}
		//alert(selectedRows.length)
		//var ids = '';
		var ids = new Array();//创建数组
		for(var i=0;i<selectedRows.length;i++){
		    //获取每一行数据[json对象]
            var rowData = selectedRows[i];
            //ids += rowData.id + ',';
            ids.push(rowData.id);//添加id
		}

		var idsStr = ids.join(',');//连接字符串
		alert(idsStr);


		//2.访问staffAction_delete.action?ids=A01,A02,A03
		$.post(
		    '${pageContext.request.contextPath}/staffAction_delete.action',
			{ids:idsStr},
			function (data) {
		        if(data == 'success'){
                    $.messager.alert('提示','作废更新成功','info');
                    //重新刷新当前页数据【自己找】
                    $('#grid').datagrid('reload');
				}else{
                    $.messager.alert('提示','作废更新失败','error');
				}

            }
		);

	}
	
	function doRestore(){
		alert("将取派员还原...");
	}
	//工具栏
	var toolbar = [ {
		id : 'button-view',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '作废',
		iconCls : 'icon-cancel',
		handler : doDelete
	},{
		id : 'button-save',
		text : '还原',
		iconCls : 'icon-save',
		handler : doRestore
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		checkbox : true,
	},{
		field : 'name',
		title : '姓名',
		width : 400,
		align : 'center'
	}, {
		field : 'position',
		title : '职位',
		width : 400,
		align : 'center'
	}, {
		field : 'departments',
		title : '所属部门',
		width : 400,
		align : 'center',
	}, {
		field : 'dateOfEntry',
		title : '入职日期',
		width : 400,
		align : 'center',
		// formatter : function(data,row, index){
		// 	if(data=="0"){
		// 		return "正常使用"
		// 	}else{
		// 		return "已作废";
		// 	}
		// }
	}] ];
	
	$(function(){
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
		$("body").css({visibility:"visible"});
		
		// 取派员信息表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageSize:5,
			pageList: [25,30,35],
			pagination : true,
			toolbar : toolbar,
			url : "${pageContext.request.contextPath}/staffAction_pageQuery.action",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加取派员窗口
		$('#addStaffWindow').window({
	        title: '添加新员工',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });

        $('#editStaffWindow').window({
            title: '修改取派员',
            width: 400,
            modal: true,
            shadow: true,
            closed: true,
            height: 400,
            resizable:false
        });

		//监听保存按钮
		$("#save").click(function () {
		    //表单检验
            var v =  $("#addStaffForm").form('validate');
            if(v){
                //提交表单
                $("#addStaffForm").submit();
			}else{
                $.messager.alert('提示','表单数据格式不正确','error');
			}

        });

		//更新数据
        $("#update").click(function () {
            //表单检验
            var v =  $("#editStaffForm").form('validate');
            if(v){
                //提交表单
                $("#editStaffForm").submit();
            }else{
                $.messager.alert('提示','表单数据格式不正确','error');
            }
        });
		
	});

	function doDblClickRow(rowIndex, rowData){
	    //{"deltag":"0","haspda":"1","id":"50282b8151q42ed2015c242ffe8b0008","name":"郭9","standard":"标准一","station":"单位一","telephone":"13532323434"}
		//alert("双击表格数据..." + rowIndex + ":" + rowData.name);
		//显示一个修改窗口
        $('#editStaffWindow').window("open");

        //显示数据
        $('#editStaffForm').form("load",rowData);
	}
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>

	<%-- 添加取派员窗口--%>
	<div class="easyui-window" title="对收派员进行添加或者修改" id="addStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
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


	<%-- 修改取派员窗口 --%>
	<div class="easyui-window" title="对收派员进行修改" id="editStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="update" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >更新</a>
			</div>
		</div>

		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editStaffForm" action="${pageContext.request.contextPath}/staffAction_update.action">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">收派员信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					<tr>
						<td>取派员编号</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true" readonly="true"/></td>
					</tr>
					<tr>
						<td>姓名</td>
						<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>手机</td>
						<td><input type="text" name="telephone" class="easyui-validatebox" required="true" data-options="validType:'phoneNumber'"/></td>
					</tr>
					<tr>
						<td>单位</td>
						<td><input type="text" name="station" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="checkbox" name="haspda" value="1" />
							是否有PDA</td>
					</tr>
					<tr>
						<td>取派标准</td>
						<td>
							<input type="text" name="standard" class="easyui-validatebox" required="true"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>	