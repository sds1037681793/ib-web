<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="height" value="${param.height==null?432:param.height}" />
<c:set var="width" value="${param.width==null?768:param.width}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
		  rel="shortcut icon">
	<link
			href="${ctx}/static/component/jquery-validation/1.11.1/validate.css"
			type="text/css" rel="stylesheet" />
	<link
			href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css"
			type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/css/frame.css" type="text/css"
		  rel="stylesheet" />
	<link href="${ctx}/static/css/modleIframeBlue.css" type="text/css" rel="stylesheet"/>
	<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"
			type="text/javascript"></script>
	<script
			src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js"
			stype="text/javascript"></script>
	<script
			src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js"
			type="text/javascript"></script>
	<script
			src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js"
			type="text/javascript"></script>
	<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/echarts/echarts.min.js"
			type="text/javascript"></script>
	<script type="text/javascript"
			src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
	<script type="text/javascript"
			src="${ctx}/static/websocket/stomp.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
	<style type="text/css">
		body{
			background-color:transparent !important;
		}
	</style>
	</head>
<form>
<%-- 	<iframe style="height: 386px; width: 768px;" src="${ctx}/elevatorSystem/showTrueVideo" ></iframe> --%>
	<div class="right_box"
		style="width: 768px; height: 432px;">
		<iframe src="${ctx}/videomonitoring/showVideo?height=${height}&width=${width}"
			id="video-iframe1" name="video-iframe" frameborder="0" scrolling="no"
			style="width: 768px; height: 432px; margin-top: 20px;margin-left: 35px;"></iframe>
	</div>
</form> 
<script>
var cameraDeviceId;
if ('' != "${param.cameraDeviceId}") {
	cameraDeviceId = "${param.cameraDeviceId}";
}
$(".modal-dialog").css("transform","none");

function callbackLoadVideo() {
	showFiresVideoMonitor1(cameraDeviceId);
}

function showFiresVideoMonitor1(deviceId) {
	$("#video-iframe1")[0].contentWindow.closeVideo();
	$("#video-iframe1")[0].contentWindow.startPlay(deviceId);
}
</script>
