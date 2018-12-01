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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
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
<link href="${ctx}/static/css/operateSystem.css" type="text/css"
	rel="stylesheet" />
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
	rel="shortcut icon">
<link
	href="${ctx}/static/component/jquery-validation/1.11.1/validate.css"
	type="text/css" rel="stylesheet" />
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
<script src="${ctx}/static/js/echarts/echarts.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/websocket/stomp.min.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operateSystem.js"></script>
<script type="text/javascript" src="${ctx}/static/js/canvas/faceRecognize.js"></script>
<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
<title>设施运营系统</title>
<style type="text/css">
.all {
	width: 1920px;
	height: 1080px;
	background-image:
		url('${ctx}/static/img/operateSystem/xizibackground.png');
}

.compass_div {
	animation: radar-beam 5s infinite;
	animation-timing-function: linear;
	transform-origin: center;
	background-image: url('${ctx}/static/img/canvas/huan.svg');
	width: 100px;
	height: 100px;
	left: 52px;
	top: 25%;
	position: absolute;
}

@keyframes radar-beam { 
	0% {
		transform: rotate(0deg);
	}
	100% {
		transform: rotate(360deg);
	}
}

@keyframes open-door { 
	0% {
		transform: rotate(0deg);
	}
	25%{
		transform:rotate(-24deg);
	}
	75%{
		transform:rotate(-24deg);  
	}
	100%{
		transform:rotate(0deg);
	}
}
/*****开闸*****/
.open_door {
	animation: open-door 5s forwards;
	animation-timing-function: linear;
	transform-origin: 0 0;
/* 	animation-iteration-count: 1;  */
}

@keyframes car-in { 
	0% {
		margin-left: 100px;
		opacity: 1;
		transform: scale(1);
	}
	50%{
		margin-left:20px;	
		transform:scale(1);
		opacity:1;
	}
	100%{
		margin-left:0px;
		transform:scale(0);
		opacity:0;
	}
}

/****车出入场****/
.car_in {
	animation: car-in 5s forwards;
	animation-timing-function: linear;
	transform-origin: 0 0;
/*  	animation-iteration-count: 1;  */
}
.face_regonized{
	animation: radar-beam 2s infinite;
	animation-timing-function: linear;
	transform-origin: center;
	background-image: url('${ctx}/static/img/canvas/yuanhuan.svg');
	width: 100px;
	height: 100px;
	margin-top: 125px;
}
.tangan{
 	animation: recognize-face 2s forwards; 
	animation-timing-function: linear;
	transform-origin: center;
	margin-top: -207px;
	left: 78px;
	position: absolute;
	background: url('${ctx}/static/img/canvas/tangan.svg') no-repeat 0 0;
	width: 229px;
	height: 140px;
}
@keyframes recognize-face { 
	0% {
		background-position:229px;
		margin-left:-229px;
	}
	50%{
		background-position:115px;
		margin-left:-115px;
	}
	
	100%{
		background-position:0 0;
		margin-left:0px;
	}
}


</style>
</head>
<body class="all">
	<div class="system_title">西子国际设施运营系统</div>
	<div class="system_canvas">
		<div class="zhuangshi">
			<img src="${ctx}/static/img/canvas/hengtiao.svg">
		</div>
		<div class="compass"
			style="background-image: url('${ctx}/static/img/canvas/zhen.svg')">
			<div class="compass_div" ></div>
		</div>

		<div class="car_move">
			<div class="car_monitor"
				style="background-image:url('${ctx}/static/img/canvas/car/chexingshexiangtou.svg')">
				<div>
					<img class="huandun" src="${ctx}/static/img/canvas/car/huandun.svg">
				</div>
				<div class="ganzi" id="ganziIn" 
					style="background-image:url('${ctx}/static/img/canvas/car/ganzi.svg')"></div>
				<div class="car" id="car_in"
					style="background-image:url('${ctx}/static/img/canvas/car/car.svg')"></div>
			</div>
			<div class="car_monitor"
				style="background-image:url('${ctx}/static/img/canvas/car/chexingshexiangtou.svg');margin-left:118px;margin-top:-32px;">
				<div>
					<img class="huandun" src="${ctx}/static/img/canvas/car/huandun.svg">
				</div>
				<div class="ganzi" id="ganziOut"
					style="background-image:url('${ctx}/static/img/canvas/car/ganzi.svg')"></div>
				<div class="car" id="car_out"
					style="background-image:url('${ctx}/static/img/canvas/car/car.svg')"></div>
			</div>
		</div>

		<div class="elevator_show">
			<div class="dianti_status">
				<img src="${ctx}/static/img/canvas/diantizhengchang.svg">
			</div>
			<div class="dianti_status" style="margin-top: 30px;">
				<img src="${ctx}/static/img/canvas/diantiguzhang.svg">
			</div>
			<div class="dianti_status" style="margin-top: 60px;">
				<img src="${ctx}/static/img/canvas/diantizhengchang.svg">
			</div>
		</div>

		<div class="face_monitor" onclick="startFaceRecoginaze('${ctx}/static/img/canvas/face.jpg')">
			<img style="vertical-align: middle;"
				src="${ctx}/static/img/canvas/39.svg">
			<div style="margin-top: -65px; margin-left: 5px;">
				<img alt="" src="${ctx}/static/img/canvas/shexiangtou.svg">
			</div>
		</div>

		<div class="focus_face" >
			<div id="face_start"></div>
			<div style="margin-top: -65px; margin-left: 30px;">
				<img alt="" src="${ctx}/static/img/canvas/shexiangtou.svg">
			</div>
			<div class="" id="tangan"></div>
			<canvas id="faceCvs" ></canvas>
		</div>

	</div>



	<div style="width: 360px; left: 1535px; position: absolute;">
		<div style="width: 360px; height: 180px; margin-top: 30px;"
			class="boder">
			<div class="head">
				<div class="head_font">本月能耗</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
				</div>
			</div>
			<div class="right_box">
				<div
					style="height: 50px; width: 100%; text-align: center; margin-top: 19px; display: inline-block;">
					<span id="pds_currentMonthDlp"
						style="font-size: 36px; color: #56E4FF; letter-spacing: 1.2px;">--</span>
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0.47px;">kwh</span>
				</div>
				<div style="height: 20px; width: 100%; margin-top: 14px;">
					<span class="power_font" style="margin-left: 17px;">日均<span
						id="pds_dailyAverageDlp">-</span>kwh
					</span> <span class="power_font" style="margin-left: 197px;"><span>去年</span><span
						id="pds_lastMonthStr">-</span>月<span id="pds_lastMonthDlp">--</span>kwh</span>
				</div>
			</div>
		</div>

		<div style="width: 360px; height: 260px; margin-top: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">最新报警</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
				</div>
			</div>
			<div id="alarmLimit" class="right_box"
				style="padding-left: 30px; width: 360px;"></div>
		</div>

		<div style="width: 360px; height: 260px; margin-top: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">环境监测</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="width: 360px; height: 214px;">
				<div style="width: 100%; height: 50%;">
					<table style="width: 100%;">
						<tr>
							<td rowspan="4" style="width: 100px; text-align: center;"><img
								src="${ctx}/static/img/operateSystem/shinei.svg"></td>
							<td class="env_head">CO2</td>
							<td class="env_head">PM2.5</td>
						</tr>
						<tr>
							<td style="width: 120px;"><span class="env_real">实时：</span><span
								id="co2NowInDoor" class="env_real">--ppm</span></td>
							<td style="width: 120px;"><span class="env_real">实时：</span><span
								id="pm25NowInDoor" class="env_real">--μg/m³</span></td>
						</tr>
						<tr>
							<td style="width: 120px;"><span class="env_m">最高：</span><span
								id="co2MaxInDoor" class="env_m">--ppm</span></td>
							<td style="width: 120px;"><span class="env_m">最高：</span><span
								id="pm25MaxInDoor" class="env_m">--μg/m³</span></td>
						</tr>
						<tr>
							<td style="width: 120px; height: 17px;"><span class="env_m">最低：</span><span
								id="co2MinInDoor" class="env_m">--ppm</span></td>
							<td style="width: 120px; height: 17px;"><span class="env_m">最低：</span><span
								id="pm25MinInDoor" class="env_m">--μg/m³</span></td>
						</tr>
					</table>
				</div>
				<div style="width: 100%; height: 50%;">
					<table style="width: 100%;">
						<tr>
							<td rowspan="4" style="width: 100px; text-align: center;"><img
								src="${ctx}/static/img/operateSystem/shiwai.svg"></td>
							<td class="env_head">CO2</td>
							<td class="env_head">PM2.5</td>
						</tr>
						<tr>
							<td style="width: 120px;"><span class="env_real">实时：</span><span
								id="co2NowOutDoor" class="env_real">--ppm</span></td>
							<td style="width: 120px;"><span class="env_real">实时：</span><span
								id="pm25NowOutDoor" class="env_real">--μg/m³</span></td>
						</tr>
						<tr>
							<td style="width: 120px;"><span class="env_m">最高：</span><span
								id="co2MaxOutDoor" class="env_m">--ppm</span></td>
							<td style="width: 120px;"><span class="env_m">最高：</span><span
								id="pm25MaxOutDoor" class="env_m">--μg/m³</span></td>
						</tr>
						<tr>
							<td style="width: 120px;"><span class="env_m">最低：</span><span
								id="co2MinOutDoor" class="env_m">--ppm</span></td>
							<td style="width: 120px;"><span class="env_m">最低：</span><span
								id="pm25MinOutDoor" class="env_m">--μg/m³</span></td>
						</tr>
					</table>

				</div>
			</div>
		</div>

		<div style="width: 360px; height: 260px; margin-top: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">监控视频</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
					<div id="video_name" class="video_place"></div>
				</div>
			</div>
			<div id="video-show" class="right_box"
				style="width: 360px; height: 214px;">
				<iframe src="${ctx}/videomonitoring/showVideo?height=211&width=360"
					id="video-iframe" name="video-iframe" frameborder="0"
					style="width: 360px; height: 214px;"></iframe>
			</div>
		</div>
	</div>
	<div
		style="height: 260px; top: 797px; position: absolute; width: 100%; margin-left: 30px;">
		<div style="width: 480px; height: 260px; float: left;" class="boder">
			<div class="head">
				<div class="head_font">车行流量</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="width: 100%; height: 214px;">
				<div
					style="width: 280px; height: 55px; margin-top: 47px; float: left;">
					<table>
						<tr>
							<td style="width: 85px; text-align: right;" rowspan="2"><img
								src="${ctx}/static/img/operateSystem/chexing.svg"></td>
							<td id="parking_inPassageCarNum" class="chexing_font2">-</td>
							<td id="parking_remainParkingSpace" class="chexing_font2">-</td>
						</tr>
						<tr>
							<td class="chexing_font1">总流量</td>
							<td class="chexing_font1">空余车位</td>
						</tr>
					</table>

				</div>
				<div id="parkingEchart"
					style="float: left; width: 200px; height: 100px; margin-top: 15px;"></div>
				<div id="parking_licenceDiv"
					style="width: 480px; float: left; margin-top: 30px; padding-left: 6.7px;">
				</div>
			</div>
		</div>

		<div
			style="width: 480px; height: 260px; float: left; margin-left: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">人行流量</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
				</div>
			</div>
			<div class="right_box" style="width: 100%; height: 214px;">
				<div
					style="width: 180px; height: 55px; margin-top: 47px; float: left;">
					<table>
						<tr>
							<td style="width: 85px; text-align: right;" rowspan="2"><img
								src="${ctx}/static/img/operateSystem/renxing.svg"></td>
							<td id="access-totalNum" class="chexing_font2">--</td>
						</tr>
						<tr>
							<td class="chexing_font1">总流量</td>
						</tr>
					</table>
				</div>
				<div
					style="float: left; width: 300px; height: 100px; margin-top: 10px;">
					<table>
						<tr id="access-gender" class="scroll">
							<td align="right" valign="bottom">男</td>
							<td><div style="margin: 0 5px;">
									<span class="left-percent">50%</span>
									<div style="float: right;">
										<span class="right-percent">50%</span>
									</div>
								</div>
								<div class="bar">
									<div class="mask"></div>
								</div></td>
							<td align="left" valign="bottom">女</td>
						</tr>
						<tr id="access-age" class="scroll">
							<td align="right" valign="bottom">30岁以下</td>
							<td><div style="margin: 0 5px;">
									<span class="left-percent">50%</span>
									<div style="float: right;">
										<span class="right-percent">50%</span>
									</div>
								</div>
								<div class="bar">
									<div class="mask"></div>
								</div></td>
							<td align="left" valign="bottom">30岁以上</td>
						</tr>
						<tr id="access-owner" class="scroll">
							<td align="right" valign="bottom">陌生人</td>
							<td><div style="margin: 0 5px;">
									<span class="left-percent">50%</span>
									<div style="float: right;">
										<span class="right-percent">50%</span>
									</div>
								</div>
								<div class="bar">
									<div class="mask"></div>
								</div></td>
							<td align="left" valign="bottom">业主</td>
						</tr>
					</table>
				</div>
				<div id="access-face"
					style="width: 480px; float: left; margin-top: 30px; padding-left: 10px;">
				</div>
			</div>
		</div>

		<div
			style="width: 480px; height: 260px; float: left; margin-left: 20px;"
			class="boder">
			<div class="head">
				<div class="head_font">电梯监控</div>
				<div style="float: right;">
					<img alt="" src="${ctx}/static/img/operateSystem/xiexian.svg">
				</div>
			</div>
			<div id="elevatorBox" class="right_box"
				style="width: 100%; height: 214px;"></div>
		</div>


	</div>

</body>
<script>
	var projectCode = "${param.projectCode}";
	var projectId = "${param.projectId}";
	var ctx = "${ctx}";
	var displayElevatorList = "";
	var elevatorAlarmMap = new HashMap();
	var elevatorRunningMap = new HashMap();
	var yunxingStatus;
	var yunxingStatusText;
	var diantishangImage = "${ctx}/static/img/operateSystem/diantishang.svg";
	var diantixiaImage = "${ctx}/static/img/operateSystem/diantixia.svg";
	var diantikongxianImage = "${ctx}/static/img/operateSystem/diantikongxian.svg";
	var diantiguzhangImage = "${ctx}/static/img/operateSystem/diantiguzhang.svg";
	var diantijianxiuImage = "${ctx}/static/img/operateSystem/diantijianxiu.svg";
	var diantizhutingImage = "${ctx}/static/img/operateSystem/diantizhuting.svg";
	var diantizhengchangPic = "${ctx}/static/img/canvas/diantizhengchang.svg";
	var diantiguzhangPic = "${ctx}/static/img/canvas/diantiguzhang.svg";
	var faceImageQueue = new Queue();
	var newestAlarm;
	var isConnectedGateWay = false;
	var street = 4;

	var faceCanvas = document.getElementById('faceCvs');
	var flushImage;
	var flushImageOut;
	var faceImage = new  Image();
	faceImage.width = 80;
	faceImage.height = 80;
	faceCanvas.width = 100;
	faceCanvas.height = 100;
	faceCtx = faceCanvas.getContext('2d');
	
	document.getElementById('car_in').addEventListener("animationend", function () { //动画结束时事件 
		 console.log("car_in");
        $(this).removeClass("car_in");
    }, false);
	document.getElementById('ganziIn').addEventListener("animationend", function () { //动画结束时事件 
		 console.log("open_door");
		$(this).removeClass("open_door");
    }, false);
	
	document.getElementById('tangan').addEventListener("animationend", function () { //动画结束时事件 
        console.log("人脸识别图片显示。。。");
        initFace();
    }, false);
	$(document).ready(function() {
		hiddenScroller();
		getEnvMonitorData();
		getPdsOperateSysData();
		getNewestAlarmData();
		setTimeout(function() {
			startConn('${ctx}')
		}, 6000);
		setTimeout("flushEnvNowData()", 60000);
		setTimeout("flushPdsData()", 60000);
		parkingCountEchart();
		getProjectFaceWall();//人行流量首次加载
		// 查询并加载当前已投屏的电梯
		getDisplayElevator();
	});

	function getPdsOperateSysData() {
		//停车场模块数据初始化
		$
				.ajax({
					type : "post",
					url : ctx
							+ "/power-supply/supplyPowerMain/getPdsOperationSystemPageData?projectCode="
							+ projectCode,
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						if (data.code == 0 && data.data != null) {
							var result = data.data;

							if (result.currentMonthDlp != null) {
								$("#pds_currentMonthDlp").html(
										result.currentMonthDlp); //当月耗电
							} else {
								$("#pds_currentMonthDlp").html("--"); //当月耗电
							}

							if (result.dailyAverageDlp != null) {
								$("#pds_dailyAverageDlp").html(
										result.dailyAverageDlp); //月均
							} else {
								$("#pds_dailyAverageDlp").html("--"); //月均
							}
							if (result.lastMonthStr != null) {
								$("#pds_lastMonthStr")
										.html(result.lastMonthStr); //去年月份
							} else {
								$("#pds_lastMonthStr").html("--"); //去年月份
							}
							if (result.lastMonthDlp != null) {
								$("#pds_lastMonthDlp")
										.html(result.lastMonthDlp); //去年月均
							} else {
								$("#pds_lastMonthDlp").html("--"); //去年月均
							}

						} else {
							$("#pds_currentMonthDlp").html("--"); //当月耗电
							$("#pds_dailyAverageDlp").html("--"); //月均
							$("#pds_lastMonthStr").html("--"); //去年月份
							$("#pds_lastMonthDlp").html("--"); //去年月均
						}
					},
					error : function(req, error, errObj) {
						return;
					}
				});
	}
	
	function hiddenScroller(){
		var height = $(window).height();
    	if(height>1070){
    		document.documentElement.style.overflowY = 'hidden';
    		document.documentElement.style.overflowX = 'hidden';
    	}else{
    		document.documentElement.style.overflowY = 'auto';
    		document.documentElement.style.overflowX = 'auto';
    	}
	}
	
	function hiddenScrollerPage() {
		var height = $(window).height();
		if (height > 1060) {
			document.documentElement.style.overflowY = 'hidden';
			document.documentElement.style.overflowX = 'hidden';
		}else if(height == 943 || height == 926){
			document.documentElement.style.overflowY = 'auto';
			document.documentElement.style.overflowX = 'hidden';
		}else {
			document.documentElement.style.overflowY = 'auto';
			document.documentElement.style.overflowX = 'auto';
		}
		
	}

	$(window).resize(function() {
		hiddenScrollerPage();
	});
	
</script>
</html>