<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
	<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet"/>
	<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
	<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet"/>
	<link href="${ctx}/static/css/modleIframeBlue.css" type="text/css" rel="stylesheet"/>
	<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
	<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/echarts/echarts.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/websocket/stomp.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
	<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemFireFighting.js"></script>
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

.fires_bg {
	width: 1920px;
	height: 1080px;
	background: url('${ctx}/static/images/operator-system/g-floor-big.png');
	position: relative;
}

.camera_point {
	cursor: pointer;
	position: absolute;
	width: 78px;
	height: 78px;
	background: url('${ctx}/static/images/operator-system/shexiangji.png');
	z-index: 2;
	position: absolute;
}

.device_point {
	position: absolute;
	width: 30px;
	height: 30px;
}

.firesInfo {
	width: 360px;
	left: 1540px;
	top: 40px;
	position: absolute;
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

.fires_font {
	font-size: 24px;
	color: #56E4FF;
	height: 50px;
	line-height: 50px;
	letter-spacing: 1.6px;
}

.num_font {
	font-size: 48px;
	color: #56E4FF;
	letter-spacing: 1.6px;
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

.right_box {
	text-align: center;
	width: 100%;
	display: table;
}

#normal_item {
	width: 175px;
	height: 78px;
	position: absolute;
	display: none;
	line-height: 30px;
	z-index: 3;
	padding: 0 0 0 79px;
}

.item_font {
	font-family: PingFangSC-Regular;
	font-size: 12px;
	color: #FFFFFF;
	width: 75px;
	height: 30px;
	float: left;
	text-align: center;
	cursor: pointer;
}

#abnormal_item {
	text-align: center;
	width: 150px;
	height: 78px;
	padding: 24px 0 0 70px;
	position: absolute;
	display: none;
	line-height: 30px;
	z-index: 3;
}

#abnormal_item_bg {
	width: 150px;
	height: 30px;
	font-family: PingFangSC-Regular;
	font-size: 12px;
	cursor: pointer;
	color: #FFFFFF;
	border-radius: 5px;
	background: #D47779;
}

.video_bg {
	background: url('${ctx}/static/images/operator-system/video.svg');
	width: 100%;
	height: 35px;
	line-height: 35px;
	padding-left: 23px;
}

.record_bg {
	background: url('${ctx}/static/images/operator-system/record.svg');
	width: 100%;
	margin-top: 8px;
	line-height: 35px;
	height: 35px;
	padding-left: 23px;
}
</style>
</head>
<title>消防区域页面</title>
<body>
	<div class="fires_bg">
		<div class="camera_point" style="left: 584px; top: 354px;"
			name="1-37-35">
			<img id="camera_1-37-35"
				src="${ctx}/static/images/operator-system/shexiangji.svg">
		</div>
		<div class="camera_point" style="left: 632px; top: 315px;"
			name="1-37-36">
			<img id="camera_1-37-36"
				src="${ctx}/static/images/operator-system/shexiangji.svg">
		</div>
		<div class="camera_point" style="left: 811px; top: 334px;"
			name="1-37-33|1-37-34">
			<img id="camera_1-37-33"
				src="${ctx}/static/images/operator-system/shexiangji.svg">
		</div>
		<div class="device_point" style="left: 629px; top: 303px;">
			<img
				src="${ctx}/static/images/operator-system/xiaofangzhengchang.svg"
				id="1-37-36" name='a'>
		</div>
		<div class="device_point" style="left: 649px; top: 401px;">
			<img
				src="${ctx}/static/images/operator-system/xiaofangzhengchang.svg"
				id="1-37-35" name="b">
		</div>
		<div class="device_point" style="left: 711px; top: 343px;">
			<img
				src="${ctx}/static/images/operator-system/xiaofangzhengchang.svg"
				id="1-37-33" name="c">
		</div>
		<div class="device_point" style="left: 763px; top: 343px;">
			<img
				src="${ctx}/static/images/operator-system/xiaofangzhengchang.svg"
				id="1-37-34" name="c">
		</div>
		<div class="chooseItem" id="normal_item">
			<div class="item_font video_bg" onclick="showVideo()">实时视频</div>
			<div class="item_font record_bg" onclick="showSnapshotPic()">抓拍记录</div>
		</div>
		<div class="chooseItem" id="abnormal_item">
			<div id="abnormal_item_bg">摄像机已离线，请尽快处理</div>
		</div>
	</div>
	<div class="firesInfo">
		<div style="width: 360px; height: 60px;" class="boder">
			<span class="title">G层今日实时数据</span>
		</div>
		<div style="width: 360px; height: 160px; margin-top: 18px;"
			class="boder">
			<div class="head">
				<div class="head_font">实时火警总数</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="height: 114px; line-height: 114px;">
				<span class="num_font" id="fires">0</span>
			</div>
		</div>

		<div style="width: 360px; height: 160px; margin-top: 10px;"
			class="boder">
			<div class="head">
				<div class="head_font">实时故障总数</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="height: 114px; line-height: 114px;">
				<span class="num_font" id="faults">0</span>
			</div>
		</div>

		<div style="width: 360px; height: 160px; margin-top: 10px;"
			class="boder">
			<div class="head">
				<div class="head_font">实时反馈总数</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="height: 114px; line-height: 114px;">
				<span class="num_font" id="feedbacks">0</span>
			</div>
		</div>

		<div style="width: 360px; height: 160px; margin-top: 10px;"
			class="boder">
			<div class="head">
				<div class="head_font">火警未处理最长时长</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="height: 114px; line-height: 114px;">
				<div class="fires_font" id="fires_day" style="line-height: 70px;">--天</div>
				<div class="fires_font" id="fires_time">--小时--分钟--秒</div>
			</div>
		</div>

		<div style="width: 360px; height: 250px; margin-top: 10px;"
			class="boder">
			<div class="head">
				<div class="head_font">维保统计</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="height: 204px; line-height: 204px;"
				id="maintenance_chart"></div>
		</div>
	</div>
	<div id="fires-alarm-video"></div>
	<div id="fires-image"></div>
</body>
<script type="text/javascript">
	var ctx = "${ctx}";
	var flushFiresTime;
	var firesMaxTime;
	var firesCameraRelMap = new HashMap();
	var cameraStatusMap = new HashMap();
	//缓存消防设备监控数组
	var firesVideoDeviceMap = new HashMap();
	var firesVideoDeviceList = new Array();
	var projectCode = "${param.projectCode}";
	var alarmUrl = '${ctx}/static/images/operator-system/xiaofangyichang.svg';
	var normalUrl = '${ctx}/static/images/operator-system/xiaofangzhengchang.svg';
	var abnormalUrl = '${ctx}/static/images/operator-system/xiaofanglixian.svg';
	var cameraOnline = '${ctx}/static/images/operator-system/shexiangji.svg';
	var cameraOffline = '${ctx}/static/images/operator-system/shexiangjilixian.svg';
	var cameraId;
	var deviceNumber;
	var deviceIds;
	var isConnectedGateWay = false;

	$(".fires_bg").on("click", function(e) {
		$('.chooseItem').each(function() {
			if ($(this).css("display") != "none") {
				$(this).hide();
			}
		})
	});
	$("#fires-image").on('shown.bs.modal', function() {
		loadPic()
	});
	$.each($(".camera_point"), function() {
		$(this).hover(function() {
			$('.chooseItem').hide();
			deviceNumber = $(this).attr("name");
			var deviceIds = deviceNumber.split("|");
			cameraId = firesVideoDeviceMap.get(deviceIds[0]);
			var top = (this.offsetTop) + 'px';
			var left = (this.offsetLeft) + 'px';
			if (deviceNumber == '1-37-35') {
				top = (this.offsetTop) + 'px';
				left = (this.offsetLeft)-175 + 'px';
			}
			var cameraStatus = cameraStatusMap.get(cameraId);
			var div = "normal_item";
			if (cameraStatus == 0) {
				div = "abnormal_item";
				top = (this.offsetTop) + 'px';
				left = (this.offsetLeft) + 'px';
			}
			$("#" + div).css("left", left);
			$("#" + div).css("top", top);
			$("#" + div).show();
		}, function() {
			$("#normal_item,#abnormal_item").hide();
		});
	});
	$("#normal_item,#abnormal_item").hover(function() {
		$(this).show();
	}, function() {
		$(this).hide();
	});

	$(document).ready(function() {
		hiddenScroller();
		getFiresAreaInfo();
		getData(129, "maintenance_chart");
		setTimeout("startConn('${ctx}')", 4000);
	});

	function callbackLoadVideo() {
		$("#fires-alarm-video-iframe")[0].contentWindow.closeVideo();
		$("#fires-alarm-video-iframe")[0].contentWindow.startPlay(cameraId);
	}
</script>
</html>