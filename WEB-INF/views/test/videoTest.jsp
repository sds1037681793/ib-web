<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<link href="${ctx}/static/video-player/css/video-player.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/static/video-player/js/video-player.js"></script>
<script>
	$(document).ready(function() {
		var player1 = $("#test1").videoPlayer({
			url: "http://192.168.1.79:9981/",
			playbackrate: 1.2,
			controller: false,
			preventcontextmenu: false
		});
		player1.init();

		var player2 = $("#test2").videoPlayer({
			url: "http://192.168.1.79:9982/",
			playbackrate: 1.2,
			controller: false
		});
		player2.init();

		var player3 = $("#test3").videoPlayer({
			url: "http://192.168.1.79:9983/",
			playbackrate: 1.2,
			controller: false
		});
		player3.init();

		var player4 = $("#test4").videoPlayer({
			url: "http://192.168.1.79:9984/",
			playbackrate: 1.2,
			controller: false
		});
		player4.init();
	});
</script>

<body>
	<div>
		<div id="test1" style="float: left; margin-right: 5px;"></div>
		<div id="test2"></div>
		<div id="test3" style="float: left; margin-right: 5px;"></div>
		<div id="test4"></div>
	</div>
</body>