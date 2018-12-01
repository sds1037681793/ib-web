<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM" />
<!DOCTYPE html>
<html>
<head>
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
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
	rel="shortcut icon">
<title>投屏展示切换</title>
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>

<style>
.display_block {
	width: 1920px;
	height: 1080px;
	position: absolute;
}

.hide {
	visibility: hidden;
	/* display: none; */
}

html {
	/* 	overflow:-moz-scrollbars-horizontal; */
	overflow: -moz-scrollbars-vertical;
}

::-webkit-scrollbar {
	display: none;
}

body {
	margin: 0;
}
</style>
</head>
<body>
	<div style="width: 1960px; overflow: hidden;">
		<div
			style="position: absolute; z-index: -1; width: 1980px; height: 1080px; overflow-y: scroll; overflow-x: hidden;">
			<iframe class="display_block hide" id="feManageDisplay"
				frameborder="no" border="0" marginwidth="0" marginheight="0"
				scrolling="no" allowtransparency="yes"
				src="${ctx}/projectPage/feManageSystem?projectCode=XIZIGUOJI&projectId=13"></iframe>
			<iframe class="display_block hide" id="groupMainDisplay"
				frameborder="no" border="0" marginwidth="0" marginheight="0"
				scrolling="no" allowtransparency="yes"
				src="${ctx}/projectPage/groupMainDisplay"></iframe>
			<iframe class="display_block" id="operateDisplay" frameborder="no"
				border="0" marginwidth="0" marginheight="0" scrolling="no"
				allowtransparency="yes"
				src="${ctx}/projectPage/operateSystem?projectCode=XIZIGUOJI&projectId=13"></iframe>
		</div>
		<div
			style="position: absolute; z-index: 999; width: 1980px; height: 1080px;"
			id="click_div"></div>
	</div>
	<script type="text/javascript">
		var operateDisplay = document.getElementById("operateDisplay");
		var feManageDisplay = document.getElementById("feManageDisplay");
		var groupMainDisplay = document.getElementById("groupMainDisplay");
		var index = 1;
		var clickDiv;

		window.addEventListener("click", function(event) {
			clickDiv = document.getElementById("click_div");
			clickDiv.style.visibility = "hidden";
			var e = event || window.event;
			var width = $(document).width() / 2;
			if (e.clientX > width) {
				addIndex();
				changeShowPage();
			} else {
				delIndex();
				changeShowPage();
			}
			clickDiv.style.visibility = "visible";
		});
		$(document).ready(function() {
			hiddenScroller();
		})

		function changeShowPage() {
			switch (index) {
			case 2:
				operateDisplay.style.visibility = "hidden";
				groupMainDisplay.style.visibility = "visible";
				feManageDisplay.style.visibility = "hidden";
				break;
			case 3:
				operateDisplay.style.visibility = "hidden";
				groupMainDisplay.style.visibility = "hidden";
				feManageDisplay.style.visibility = "visible";
				break;
			case 1:
				operateDisplay.style.visibility = "visible";
				groupMainDisplay.style.visibility = "hidden";
				feManageDisplay.style.visibility = "hidden";
				break;
			default:
				operateDisplay.style.visibility = "hidden";
				groupMainDisplay.style.visibility = "visible";
				feManageDisplay.style.visibility = "hidden";
			}
		}

		function addIndex() {
			index++;
			if (index > 3) {
				index = 1
			}
		}

		function delIndex() {
			index--;
			if (index < 1) {
				index = 3;
			}
		}

		function hiddenScroller() {
			var height = $(window).height();
			if (height > 1070) {
				document.documentElement.style.overflowY = 'hidden';
			} else {
				document.documentElement.style.overflowY = 'auto';
			}
		}

		$(window).resize(function() {
			var height = $(this).height();
			if (height > 1070) {
				document.documentElement.style.overflowY = 'hidden';
			} else {
				document.documentElement.style.overflowY = 'auto';
			}

		});
	</script>
</body>
</html>