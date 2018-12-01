<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
    String systemName = StaticDataUtils.getSystemName();
%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<title><%=systemName%> 注册
</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/default.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<style type="text/css">
<!--
div {
	border-width: 1px;
	border-color: #000;
}

.div-title {
	width: 100%;
	height: 36px;
	font-size: 16px;
	line-height: 25px;
	overflow: hidden;
	padding-left: 8px;
	padding-top: 6px;
	background: #005A8C;
	color: #fff;
	border-width: 0px;
	border-style: solid;
	border-color: #ccc;
	border-top-left-radius: 6px;
	border-top-right-radius: 6px;
	box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.3);
	filter: progid:DXImageTransform.Microsoft.Shadow(color='#333333',
		Direction=135, Strength=3);
}

.div-content {
	width: 100%;
	overflow: hidden;
	padding-left: 8px;
	background: #B9DAED;
	border-width: 0px;
	border-style: solid;
	border-color: #ccc;
	border-bottom-left-radius: 6px;
	border-bottom-right-radius: 6px;
	box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.3);
	filter: progid:DXImageTransform.Microsoft.Shadow(color='#333333',
		Direction=135, Strength=3);
}
-->
</style>
</head>
<body class="page-background" style="background-color: transparent;" onload="loadTopWindow()">
	<div class="container" style="height: 100%; width: 100%;">
		<div id="login" style="position: absolute; width: 450px; height: 330x;">
			<div class="div-title">请输入授权码进行授权</div>
			<div class="div-content">
				<div>
					<form id="loginForm" action="${ctx}/register" method="post" class="form-horizontal">
						<c:choose>
							<c:when test="${success == 'N'}">
								<div style="height: 40px;">
									<div class="alert alert-error input-medium controls" style="position: relative; z-index: 1; margin-left: 80px; margin-bottom: 5px; line-height: 17px;">
										<button class="close" data-dismiss="alert">×</button>${authorizationMsg}
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div style="height: 40px;"></div>
							</c:otherwise>
						</c:choose>
						<div class="form-group has-feedback">
							<div class="col-md-11">
								<span class="glyphicon" style="color: #666; font-size: 16px;"></span>
								<textarea rows="5" cols="20" id="licenseCode" name="licenseCode" placeholder="请输入授权码" class="form-control required" style="font-size: 14px; width: 290px; border-radius: 0px; margin-left: 20px;" autofocus></textarea>
							</div>
						</div>
						<div class="form-group has-feedback">
							<div style="margin-left: 220px;">
								<label class="checkbox" for="rememberMe">
									<input type="checkbox" id="rememberMe" name="rememberMe" style="display: none" />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button id="submit_btn" class="btn btn-danger btn-lg" type="button" onclick="javascript:login();">确 认 授 权</button>
								</label>
							</div>
							<c:choose>
								<c:when test="${success == 'Y'}">
									<div style="margin-left: 120px; font-size: 17px;">
										<a href="${ctx}/login">跳到登陆页面</a>
									</div>
								</c:when>
							</c:choose>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="error-div"></div>
	<script>
		$(document).ready(function() {
			resize();
		});

		$(window).resize(function() {
			resize();
		});

		function resize() {
			$("#login").css("top", (document.body.clientHeight - 235) / 2 + "px");
			$("#login").css("left", (document.body.clientWidth - 350) / 2 + "px");
		}

		function login() {
			var licenseCode = $("#licenseCode").val();
			if (licenseCode.length == 0) {
				showAlert('loginForm', 'warning', '请输入登录名！', $("#licenseCode"), 'top');
				$("#licenseCode").focus();
				return;
			}
			$("#loginForm").submit();
		}

		$('input').bind('input propertychange', function(e) {
			var value = "";
			if ($.browser && $.browser.msie) {
				value = e.srcElement.value;
			} else {
				value = e.target.value;
			}
			if (value.length != 0) {
				removeAllAlert();
			}
		});

		$('input').keyup(function(event) {
			if (event.keyCode == "13") {
				document.getElementById("submit_btn").click();
			}
		});

		function loadTopWindow() {
			if (window.top != null && window.top.document.URL != document.URL) {
				window.top.location = "${ctx}/";
			}
		}
	</script>
</body>
</html>