<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
    String systemName = StaticDataUtils.getSystemName();
%>
<%
    if (org.apache.shiro.SecurityUtils.getSubject().getPrincipal() != null) {
				response.sendRedirect(request.getContextPath() + "/main");
			}
%>

<!DOCTYPE html>
<html style="height: 100%">
<head>
<title><%=systemName%> Login</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Page-Exit"
	content="revealTrans(Duration=3,Transition=5)">
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"
	name="viewport" />
<meta name="viewport" content="initial-scale=1.0" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
	rel="shortcut icon">
<link
	href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />
<link
	href="${ctx}/static/component/jquery-validation/1.11.1/validate.css"
	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css"
	rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>

<!--[if lte IE 9]>
  <script src="${ctx}/static/compatible/respond.min.js"></script>
  <script src="${ctx}/static/compatible/html5shiv.min.js"></script>
  <![endif]-->

<style type="text/css">
<!--
.login-background {
	margin: 0;
	padding: 0;
	background-image: url("${ctx}/static/img/login/loginBg.png");
	position: absolute;
	top: 0;
	left: 0;
	height: 100%;
	width: 100%;
	background-position: center 0;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
	-webkit-background-size: cover; /* 兼容Webkit内核浏览器如Chrome和Safari */
	-o-background-size: cover; /* 兼容Opera */
	zoom: 1;
}

#login {
	background-image: url("${ctx}/static/img/login/login-form-bg.png");
	position: absolute;
	width: 470px;
	height: 503px;
	z-index: 100;
	/*left: 1270px !important;*/
	/*top: 274px !important;*/
	background-size: contain;
}


.div-title {
	width: 100%;
	height: 36px;
	font-size: 16px;
	line-height: 25px;
	overflow: hidden;
	padding-left: 8px;
	padding-top: 6px;
	background: #444;
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

.loginName {
	width: 300px;
	height: 40px;
	margin: 0 auto;
	border: 1px solid rgba(0,188,212,0.6);

}

.passWord {
	width: 300px;
	height: 40px;
	margin: auto;
	/*margin-top: 30px;*/
	position: relative;

	border: 1px solid rgba(0,188,212,0.6);
}

.confirm {
	border-radius: 4px;
	position: relative;
	width: 300px;
	height: 40px;
	margin-left: auto;
	margin-right:auto;
	margin-top:20px;
}

.div-content {
	width: 100%;
	height: 200px;
	line-height: 25px;
	overflow: hidden;
	padding-left: 8px;
	background: #eee;
	border-width: 0px;
	border-style: solid;
	border-color: #ccc;
	border-bottom-left-radius: 6px;
	border-bottom-right-radius: 6px;
	box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.3);
	filter: progid:DXImageTransform.Microsoft.Shadow(color='#333333',
		Direction=135, Strength=3);
}

#submit-btn {
	background: rgba(0,188,212,0.80);
    border-radius: 4px;
	border-radius: 4px;
	width: 300px;
	height: 40px;
}

.background-div {
	background-color: #ccc;
	width: 350px;
	height: 236px;
	position: absolute;
	box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.3);
	opacity: 0.6;
	border-radius: 8px;
}

.form-input {
	padding: 6px 12px;
	font-family: SimHei;
	font-size: 14px;
	color: #FFFFFF;
	height: 100%;
	width: 245px;
	border-radius: 4px;
	border: none;
	background-color: transparent;
}
.form-input:focus{
	border: 0;
	outline: none;
}
.form-input::-webkit-input-placeholder {
	color: #94BFFF;
	  }
.icon {
	height: 40px;
	vertical-align: middle;
	line-height: 35px;
	text-align: center;
	padding-left: 10px;
	padding-right: 4px;
	display: inline-table;
}

.close:hover {
	color: #FFF !important;
}
.checkbox{
margin-top:20px;

}
.alert{
    padding: 0 10px;
}
</style>
</head>

<body class="login-background" onload="loadTopWindow()">
	<div id="main" style="height: 100%; width: 100%;position: absolute;">
		    <div style="position: absolute;  top:40%; transform:translateY(-50%);left: 15%"><img  src="${ctx}/static/img/login/userLoginLogo.png" style="width: 130%" /></div>
			<div id="login">
				<div style="margin-top:88px;margin-left:auto;margin-right:auto; width:174px;"><%--<img  src="${ctx}/static/img/login/newPage/logo.svg" />--%></div>
				<form id="loginForm" action="${ctx}/login" method="post"
					style="margin-top: 10px; width: 100%;padding-top: 40px;">

					<%
						String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
						if (error != null) {
					%>
					<div style="height: 26px;">
						<div class="alert alert-error input-medium controls"
							 style="position: relative; z-index: 1; margin-left: 70px; width: 300px; line-height: 10px; color: #FFF; height: 100%; margin:0 auto;">
							<button class="close" data-dismiss="alert"
									style="line-height: 10px;color:#fff;opacity: 1">×</button>
							登录失败，请重试.
						</div>
					</div>
					<%
					} else {
					%>
					<div style="height: 26px;"></div>
					<%
						}
					%>

					<div class="loginName">
						<span class="icon"><img alt=""
							src="${ctx}/static/img/login/icon-header.png" style="width: 60%;margin-top: 2px;"></span> <span style="color:#1FDFF4;">|</span><input
							type="text" id="username" autocomplete="off" name="username" placeholder="请输入用户名"
							value="${username}" class="form-input required" autofocus />
					</div>

					<div class="passWord" style="margin-top: 20px;">
						<span class="icon"><img alt=""
							src="${ctx}/static/img/login/icon-password.png" style="width: 60%;margin-top: 2px;"></span> <span style="color:#1FDFF4;">|</span> <input
							type="password" id="password" name="password" placeholder="请输入密码"
							class="form-input required" />
					</div>
					<div class="confirm">
						<div style="">
							 <input id="submit-btn"
								class="btn btn-primary" type="button" value="登录"
								onclick="javascript:login();" />
								<label class="checkbox" for="rememberMe"><input
								type="checkbox" id="rememberMe" name="rememberMe" checked="checked"
								style="display:none;" />
								<img id="checkimg" src="${ctx}/static/img/login/newPage/jizhumimaxuanzhong.svg"  onclick="checkclick()"/>
								<span
								style="font-size: 12px; color: #FFFFFF;margin-left: 20px; opacity: 0.6">记住密码</span>
							</label>
						</div>

					</div>


				</form>
			</div>
	</div>
	<div id="error-div"></div>

	<script>
	var shiftArrayX = new Array();
	var shiftArrayY = new Array();
	var locationUrl = window.location.host;
	
	$(document).ready(function() {
		$("body").css("display","none");
		$("body").fadeIn("fast");
		$("a[target],a[href*='javascript'],a.lightbox-processed,a[href*='#']").addClass("speciallinks");
		$("a:not(.speciallinks)").click(function(){
			$("body").fadeOut("fast");
			$("object,embed").css("visibility","hidden");
		});
// 		var rotateDivHtml = "";
// 		rotateDivHtml += createRotateDiv(350, 236, 6, 0.5, 3, "#ccc", "topleft");
// 		rotateDivHtml += createRotateDiv(350, 236, 12, 0.4, 2, "#ccc", "topleft");
// 		rotateDivHtml += createRotateDiv(350, 236, 18, 0.3, 1, "#ccc", "topleft");
// 		$("#main").append(rotateDivHtml);

		resize();
		var sysMsg = "${sysMsg}";
		if (sysMsg != null && sysMsg != "" && sysMsg != "null") {
			showDialogModal("error-div", "错误提示", sysMsg);
		}
		
		/* $.ajax({
	        type: "post",
	        url: "{ctx}/network/index?CHECK_AUTHENTICATION=false&locationUrl=" + locationUrl,
	        dataType: "json",
	        contentType: "application/json;charset=utf-8",
	        success:function(data) {
	        },
	        error: function(req,error,errObj) {
	            return false;       
	        }
	    }); */
		
		
	});

	function createRotateDiv(width, height, degree, opacity, zIndex, bgColor, style) {
		var shiftX = 0;
		var shiftY = 0;
		if (style && style == "topleft") {
			var deg = degree * 0.017453293;
			var a = Math.sqrt(width * width + height * height) / 2;
			var b = a * Math.sin(deg) / Math.sin((180 - deg) / 2);
			var shift = b * Math.sqrt(2) / 2 - 3;
			shiftX = 0 - shift;
			shiftY = shift;
		}
		var html = '<div id="rotate-div-' + shiftArrayX.length + '" class="background-div" style="z-index: ' + zIndex + '; transform: rotate(' + degree + 'deg); left: 762px; top: 405px; opacity: ' + opacity + '; background-color: ' + bgColor + ';"></div>';
		shiftArrayX[shiftArrayX.length] = shiftX;
		shiftArrayY[shiftArrayY.length] = shiftY;
		return html;
	}

	$(window).resize(function() {
		resize();
	});

	function resize() {
		/*var top = (document.body.clientHeight - 240)/2.3;*/
		var left = (document.body.clientWidth - 350)/1.2;
		/*$("#login").css("top", top + "px");*/
        $("#login").css("top",  "15%");
		$("#login").css("left", left + "px");

		$.each(shiftArrayX, function(n, shift) {
			$("#rotate-div-" + n).css("top", (top + shiftArrayY[n]) + "px");
			$("#rotate-div-" + n).css("left", (left + shift) + "px");
		});
	}

	function login() {
		var username = $("#username").val();
		
		if (username.length == 0) {
			showAlert('warning', '请输入登录名！', "username", 'top');
			$("#username").focus();
			return;
		}
		var password = $("#password").val();
		if (password.length == 0) {
			showAlert('warning', '请输入密码！', "password", 'top');
			$("#password").focus();
			return;
		}

		$("#loginForm").submit();
	}

	$('input').bind('input propertychange', function(e) {
		var value = "";
		if($.browser && $.browser.msie) {
			value = e.srcElement.value;
		} else {
			value = e.target.value;
		}
		if (value.length != 0) {
			removeAllAlert();
		}
	});

	$('input').keyup(function (event) {
		if (event.keyCode == "13") {
			document.getElementById("submit-btn").click();
		}
	});
	
	function loadTopWindow() {
		if (window.top!=null && window.top.document.URL!=document.URL) {
			window.top.location= "${ctx}/";
		}
	}
	
	 function checkclick(){
         var checkimg = document.getElementById("checkimg");
         if($("#rememberMe").is(':checked') ){
             $("#rememberMe").attr("checked","unchecked");
             checkimg.src="${ctx}/static/img/login/newPage/jizhumimaweixuanzhong.svg";
         } else{
             $("#rememberMe").attr("checked","checked");
             checkimg.src="${ctx}/static/img/login/newPage/jizhumimaxuanzhong.svg";
         }
     }
	
	</script>
</body>
</html>