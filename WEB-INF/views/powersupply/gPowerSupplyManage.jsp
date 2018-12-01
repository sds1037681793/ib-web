<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script	src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" stype="text/javascript"></script>
<script	src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
<script	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemPowerSupply.js"></script>
<style type="text/css">
html {
	font-family: SimHei;
	/* 		overflow:-moz-scrollbars-horizontal;   */
	overflow: -moz-scrollbars-vertical;
	overflow: hidden;
}

body {
	margin: 0;
	padding: 0;
}

.hight_power_bg {
	width: 1920px;
	height: 1080px;
	background: url('${ctx}/static/images/operator-system/hightPowerBg.png');
	position: relative;
}

.boder {
	border: 1px solid rgba(151, 255, 250, 0.4);
	background: rgba(0, 7, 49, 0.6);
}

.head {
	height: 46px;
	width: 100%;
	border-bottom: 1px solid rgba(151, 255, 250, 0.2);
}

.head_font {
	color: #56E4FF;
	letter-spacing: 0.67px;
	line-height: 46px;
	margin-left: 10px;
	float: left;
	font-size: 19px;
	color: #56E4FF;
	letter-spacing: 0.67px;
}

.title {
	font-size: 40px;
	color: #56E4FF;
	letter-spacing: 1.33px;
	text-align: center;
	display: table;
	width: 100%;
	line-height: 60px;
}

</style>
</head>
<title>高配电页面</title>
<body>
	<div class="hight_power_bg" onclick="showPowerDetail()">
	</div>
	<div id="powerSupply-detail-div"></div>
</body>
<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {
		setTimeout("startConn('${ctx}')",4000);
	});


	
</script>
</html>