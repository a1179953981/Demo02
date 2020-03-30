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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ocupload-1.1.2.js"></script>
    <title>Title</title>
    <script>
        $(function () {

            $("#upload_btn").upload({
                action:'abc.action',
                name:'excelFile'
            });
        });
    </script>
</head>

<body class="easyui-layout">
普通上传<br>
   <form action="abc.action" method="post" enctype="multipart/form-data" target="myframe">
       <input type="file" name="excelFile">
       <input type="submit" value="上传">
</form>

<iframe name="myframe" width="200px" height="200px"></iframe>

<br>
一键上传<br>
<input type="button" id="upload_btn" value="点击选择文件上传">

</body>
</html>
