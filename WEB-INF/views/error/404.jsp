<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
    response.setStatus(200);
%>
<!DOCTYPE html>
<html>
<head>
<title>404 - 页面不存在</title>
<link href="${ctx}/static/styles/default.css" type="text/css" rel="stylesheet" />
<%-- <script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script> --%>
</head>
<body>
	<div style="width: 100%; height: 100%;">
		<div style="float: left; width: 400px; height: 100%">
			<div class="page-error-pin"></div>
			<div class="page-error-hanger">
				<div class="page-error-text">
					error
					<span>404</span>
				</div>
			</div>
		</div>
		<div style="">
			<div style="float: left; padding-left: 40px; padding-top: 60px;">
				<h1 style="font: 32px 'Helvetica Neue', Arial, Helvetica, sans-serif;">抱歉，页面找不到。。。</h1>
				<div style="font-size: 14px;">
					<div>也许：</div>
					<div>1、你输入的地址不太正确。。。</div>
					<div>2、粗心的程序猿写错代码了。。。</div>
					<div>3、今天服务器的心情不是太好。。。</div>
					<div>4、服务器被喵星人占领了。。。</div>
					<div>5、服务器被汪星人占领了。。。</div>
					<div>
						6、
						<font color="red">能</font>
						再给
						<font color="red">点</font>
						理由吗？
					</div>
					<div id="easter-eggs"></div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			var date = new Date();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			if (month == 4 && day == 1) {
				$("#easter-eggs").text("7、今天是愚人节。。。");
			}
		});
	</script>
</body>
</html>