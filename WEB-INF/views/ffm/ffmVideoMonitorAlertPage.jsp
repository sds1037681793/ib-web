<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消防报警视频监控</title>
<style type="text/css">
#cameraName-ul {
	margin-right: -32px;
	margin-top: -5px;
	width: 178px;
}

#video-imgae {
	background: url('${ctx}/static/img/alarm/videoOffLine.png');
	width: 790px;
	height: 454px;
	display: none;
}
</style>
</head>
<body>
	<div id="video-show" class="right_box"
		style="width: 790px; height: 454px;">
		<iframe src="${ctx}/videomonitoring/showVideo?height=451&width=790"
			id="video-iframes" name="video-iframe" frameborder="0"
			style="width: 790px; height: 454px; margin: 0px; padding: 0px; overflow: hidden;"
			scrolling="no"></iframe>
	</div>
	<div id="video-imgae"></div>
	<script type="text/javascript">
		var deviceId = "${param.deviceId}";
		var deviceStatus = "${param.deviceStatus}";
		$(".modal-dialog").css("transform", "none");
		function callbackLoadVideo() {
			if (deviceStatus == 1) {
				$("#video-imgae").hide();
				$("#video-show").show();
				$("#video-iframes")[0].contentWindow.closeVideo();
				$("#video-iframes")[0].contentWindow.startPlay(deviceId);
			} else {
				$("#video-imgae").show();
				$("#video-show").hide();
			}
		}
	</script>
</body>
</html>