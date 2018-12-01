<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<form>
<%-- 	<iframe style="height: 386px; width: 768px;" src="${ctx}/elevatorSystem/showTrueVideo" ></iframe> --%>
	<div class="right_box"
		style="width: 790px; height: 454px;">
		<iframe src="${ctx}/videomonitoring/showVideo?height=443&width=798"
			id="video-iframe1" name="video-iframe" frameborder="0"
			style="width: 798px; height: 443px;" scrolling="no"></iframe>
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
