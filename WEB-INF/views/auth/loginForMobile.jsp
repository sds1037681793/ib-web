<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<% String systemName = StaticDataUtils.getSystemName(); %>

<!DOCTYPE html>
<html style="height: 100%">
<head>
  <title><%=systemName %> Login</title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
  <meta http-equiv="Cache-Control" content="no-store" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="0" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta http-equiv="Page-Exit" content="revealTrans(Duration=3,Transition=5)">

  <link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
  <link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
  <link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
  <link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
  <script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
  <script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
  <script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
  <script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
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
	    background: -webkit-radial-gradient(circle, #67DDBD, #009A8E) !important;
	    background: -moz-radial-gradient(circle, #67DDBD, #009A8E) !important;
	    background: -ms-radial-gradient(circle, #67DDBD, #009A8E) !important;
	    filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0, startColorstr='#67DDBD', endColorstr='#009A8E');
	    -ms-filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0, startColorstr='#67DDBD', endColorstr='#009A8E');
	    background: -ms-linear-gradient(top, #bbc, #558);
	    background-color: transparent !important;
    }

    div {
        border-width: 1px;
    	border-color: #000;
    }

    .div-title {
    	width: 100%;
    	height: 36px;
    	font-size: 16px;
    	line-height: 25px;  
    	overflow:hidden;
    	padding-left: 8px;
    	padding-top: 6px;
    	background: #444;
    	color: #fff;
    	border-width: 0px;
    	border-style: solid;
    	border-color: #ccc;
    	border-top-left-radius: 6px;
    	border-top-right-radius: 6px;
    	box-shadow: 0px 1px 5px rgba(0,0,0,0.3);
    	filter: progid:DXImageTransform.Microsoft.Shadow(color='#333333', Direction=135, Strength=3);
    }
    
    .div-content {
    	width: 100%;
    	height: 200px;
    	line-height: 25px;  
    	overflow:hidden;
    	padding-left: 8px;
    	background: #eee;
    	border-width: 0px;
    	border-style: solid;
    	border-color: #ccc;
    	border-bottom-left-radius: 6px;
    	border-bottom-right-radius: 6px;
    	box-shadow: 0px 1px 5px rgba(0,0,0,0.3);
    	filter: progid:DXImageTransform.Microsoft.Shadow(color='#333333', Direction=135, Strength=3);
    }
    
    #submit-btn {
    	border-radius: 0px;
    	background-color: #555;
    	border-color: #555;
    }
    
    .background-div {
    	background-color: #ccc;
    	width: 350px;
    	height: 236px;
    	position:absolute;
    	box-shadow: 0px 1px 5px rgba(0,0,0,0.3);
    	opacity: 0.6;
    	border-radius: 8px;
    }
    
  -->
  </style>
</head>

<body class="login-background" onload="loadTopWindow()">
	<div id="main" style="height: 100%; width: 100%;">
		<!-- <div class="background-div" style="z-index: 2; transform: rotate(10deg); left: 762px; top: 405px; opacity: 0.5;"></div>
		<div class="background-div" style="z-index: 1; transform: rotate(20deg); left: 736px; top: 428px; opacity: 0.3;"></div> -->
		<div id="login" style="position:absolute; width:350px; height:230x; z-index: 100;">
			<div class="div-title"><%=systemName %></div>
			<div class="div-content">
				<div>
					<form id="loginForm" action="${ctx}/login" method="post" class="form-horizontal">
					<%
						String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
						if(error != null){
					%>
						<div style="height: 40px;">
							<div class="alert alert-error input-medium controls" style="position: relative; z-index: 1; margin-left: 80px; margin-bottom: 5px; line-height: 17px;">
								<button class="close" data-dismiss="alert">×</button>登录失败，请重试.
							</div>
						</div>
					<%
						} else {
					%>
						<div style="height: 40px;"></div>
					<%
						}
					%>
						<div class="form-group has-feedback">
							<div class="col-md-11">
								<span class="glyphicon glyphicon-user form-control-feedback" style="color: #666; font-size: 16px;"></span>
								<input type="text" id="username" name="username" placeholder="登录名" value="${username}" class="form-control required" style="font-size: 14px; height: 31px; width: 290px; border-radius: 0px; margin-left: 20px;" autofocus/>
							</div>
						</div>
						<div class="form-group has-feedback">
							<div class="col-md-11">
								<span class="glyphicon glyphicon-lock form-control-feedback" style="color: #666; font-size: 16px;"></span>
								<input type="password" id="password" name="password" placeholder="密码"  class="form-control required" style="font-size: 14px; height: 31px; width: 290px; border-radius: 0px; margin-left: 20px;"/>
							</div>
						</div>

						<div class="form-group has-feedback">
							<div style="margin-left: 220px;">
								<label class="checkbox" for="rememberMe"><input type="checkbox" id="rememberMe" name="rememberMe" style="display: none"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input id="submit-btn" class="btn btn-primary" type="button" value="登录" onclick="javascript:login();"/></label>
							</div>
						</div>
					</form>
				</div>
			</div>
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
		
		var rotateDivHtml = "";
		rotateDivHtml += createRotateDiv(350, 236, 6, 0.5, 3, "#ccc", "topleft");
		rotateDivHtml += createRotateDiv(350, 236, 12, 0.4, 2, "#ccc", "topleft");
		rotateDivHtml += createRotateDiv(350, 236, 18, 0.3, 1, "#ccc", "topleft");
		$("#main").append(rotateDivHtml);

		resize();
		var sysMsg = "${sysMsg}";
		if (sysMsg != null && sysMsg != "" && sysMsg != "null") {
			showDialogModal("error-div", "错误提示", sysMsg);
		}
		
		$.ajax({
            type: "post",
            url: "${ctx}/network/index?CHECK_AUTHENTICATION=false&locationUrl=" + locationUrl,
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success:function(data) {
            },
            error: function(req,error,errObj) {
                return false;       
            }
        });
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
		var top = (document.body.clientHeight - 230)/2.5;
		var left = (document.body.clientWidth - 350)/2;
		$("#login").css("top", top + "px");
		$("#login").css("left", left + "px");

		$.each(shiftArrayX, function(n, shift) {
			$("#rotate-div-" + n).css("top", (top + shiftArrayY[n]) + "px");
			$("#rotate-div-" + n).css("left", (left + shift) + "px");
		});
	}

	function login() {
		var username = $("#username").val();
		if (username.length == 0) {
			showAlert('loginForm', 'warning', '请输入登录名！', $("#username"), 'top');
			$("#username").focus();
			return;
		}
		var password = $("#password").val();
		if (password.length == 0) {
			showAlert('loginForm', 'warning', '请输入密码！', $("#password"), 'top');
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
	</script>
</body>
</html>