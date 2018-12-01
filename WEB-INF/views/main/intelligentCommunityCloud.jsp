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
<html style="height: 100%">
<title>华数智慧小区云平台</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Page-Exit" content="revealTrans(Duration=3,Transition=5)">
<metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"	name="viewport" />

<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css"	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-validation/1.11.1/validate.css"	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css"	rel="stylesheet" />
<link href="${ctx}/static/styles/theme/rib-green.css" type="text/css"	rel="stylesheet" />
<link href="${ctx}/static/css/hmap.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/intelligentCommunityCloud.css"	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/mapDeleteScroll.css" type="text/css"	rel="stylesheet" />
<link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"	type="text/css" rel="stylesheet" />
	<!-- 电梯消防视频弹窗 -->
<link href="${ctx}/static/css/cloudModleIframeBlue.css" type="text/css"	rel="stylesheet" />
<link href="${ctx}/static/css/frame.css" type="text/css"	rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"	type="text/javascript"></script>
<script	src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js"	type="text/javascript"></script>
<script	src="${ctx}/static/component/jquery-validation/1.11.1/messages_bs_zh.js"	type="text/javascript"></script>
<script	src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js"	type="text/javascript"></script>
<script src="${ctx}/static/js/public.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/js/echarts/echarts.min.js"	type="text/javascript"></script>
<script src="${ctx}/static/js/charts.js" type="text/javascript"></script>
<script type="text/javascript"	src="${ctx}/static/websocket/sockjs-1.0.0.min.js"></script>
<script type="text/javascript"	src="${ctx}/static/websocket/stomp.min.js"></script>
<script src="${ctx}/static/js/jquery.waypoints.min.js"	type="text/javascript"></script>
<script src="${ctx}/static/js/jquery.countup.min.js"	type="text/javascript"></script>
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"	type="text/javascript"></script>
<script type="text/javascript"	src="${ctx}/static/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript" src="${ctx}/static/js/HashMap.js"></script>
<script type="text/javascript"	src="${ctx}/static/video-player/js/dss-player.js"></script>
<script type="text/javascript"	src="${ctx}/static/busi/intelligentCommunityCloud/elevatorPopover.js"></script>
<script type="text/javascript"	src="${ctx}/static/busi/intelligentCommunityCloud.js"></script>
<style>
#alarm-info-div {
	width: 706px;
	height: 672px;
	position: absolute;
	top: 50%;
	left: 50%;
	background: url("${ctx}/static/img/video/alarm_back.png") no-repeat;
	z-index: 200;
	-webkit-transform: translate(-50%, -50%);
	-moz-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	-o-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}

.alarm-video-replay {
	width: 606px;
	height: 340px;
	margin-left: 48px;
	margin-top: 44px;
}

#alarm-info-desc {
	width: 606px;
	height: 226px;
	background: url("${ctx}/static/img/video/alarm_info_back.png") no-repeat;
	margin-left: 48px;
	margin-top: 20px;
	color: #FFF;
}

#alarm-info-desc-title {
	font-size: 18px;
	text-align: center;
	height: 65px;
	line-height: 60px;
}

#alarm-person-photo {
	width: 200px;
	height: 200px;
	padding-left: 205px;
	padding-top: 56px;
}

#alarm-person-info {
	font-size: 18px;
	color: #FFFFFF;
	width: 606px;
	text-align: center;
	letter-spacing: 2.14px;
	padding-top: 80px;
}

.alarm-warn {
	color: red;
}

.alarm-info {
	font-size: 14px;
	text-align: left;
	float: left;
	width: 270px;
	margin-left: 23px;
	letter-spacing: 1.67px;
	overflow: hidden;
	white-space: nowrap;
	-ms-text-overflow: ellipsis;
	text-overflow: ellipsis;
}

.content-tb {
	height: 30px;
	width: 606px;
}

.content-tb-right {
	margin-left: 40px;
}

.time-div {
	line-height: 35px;
}
</style>
</head>
<body class="bg_img">
	<!--  <div id="map" onclick="groupChartsClickEnventInit(this)"></div>-->
	<div class="alarm-image-div" id="alarmImageDiv" style="display: none;">
		<div class="img-div">
			<img src="" style="width: 100%; height: 100%;" id="alarmImg">
		</div>
		<div class="alarm-type-font" id="alarmType">火警</div>
		<div class="alarm-location-font" id="location">80＃地下二楼东区</div>
	</div>
	<div class="title">
		<span class="title-text">华数智慧小区云平台</span>  
		<div
			style="width: 250px; height: 76px; float: right; font-size: 30px; color: #367190; letter-spacing: 0; margin-top: 10px; margin-right: 30px;">
			<div style="float: right;" id="week" class="time-div"></div>
			<div style="float: right;" id="ymd" class="time-div"></div>
			<div style="float: right;" id="hms" class="time-div"></div>
		</div>
	</div>
	<div class="left-content" style="width: 450px; float: left;">
		<div class="border-one" style="">
			<div style="text-align: center; height: 46px;">
				<span class="choose-item" onclick="tabClick(this)" id="tab-safe-div"
					name="event-alarm">安全事件报警</span>
				<!-- <span
					style="margin: 0px 20px; border: 1px solid #5FAEDA; width: 1px;"></span> -->
				<!-- 	<span class="no-choose-item" onclick="tabClick(this)"
					name="device-alaram-div" id="tab-device-alaram" >设备重要报警</span> -->
			</div>
			<div id="event-alarm" style="margin-top: 45px;"></div>
			<!-- <div class="device-alaram-div" id ="device-alaram-div" style="display: none">

			</div> -->
		</div>
		<div class="border-one" style="margin-top: 24px;">
			<div class="border-title">安全事件排名</div>
			<div style="width: 100%; height: 236px;">
				<div id="security-incident-ranking"
					style="width: 100%; height: 270px; margin-top: -20px; margin-left: 8px;"></div>
			</div>
		</div>
	</div>
	<div class="center-content"
		style="width: 335px; margin-left: 24px; height: 92px; float: left;">
		<div class="center-container" style="">
			<div class="sum-div">
				项目总数：<span id="organizeCount">39</span>个
			</div>
			<div class="search-div">
				<input id="codes" type="text" style="display: none;" /> <input
					type="text" id="projectName" onkeyup="getProjectData()"
					autocomplete="off"
					style="font-family: PingFangSC-Regular; width: 234px; height: 40px; opacity: 0.8; background: rgba(229, 229, 229, 0.39); padding: 10px; border: 1px solid #288ABF; font-size: 16px; color: rgba(255, 255, 255, 1);"
					placeholder="请输入项目名称">
				<div style="margin-left: 237px; margin-top: -40px;">
					<button id="search" onclick="searchHandle(1)"
						style="font-family: PingFangSC-Regular; opacity: 0.8; background: #18AEFE; width: 80px; height: 40px; border: none; font-size: 16px; color: rgba(255, 255, 255, 1); margin-left: -4px;">搜索</button>
				</div>
				<span id="showNoProject"
					style="font-size: 16px; color: #F37B7B; letter-spacing: 0;"></span>
			</div>
		</div>
	</div>
	<div class="permanent-circle-animation"></div>
	<div class="floating-circle-animation"></div>
	<div class="houseLogin-circle-animation"></div>
	<div class="renkou-circle-div">
		<div class="permanent-circle">
			<div class="circle-value" style="color: #55C7FF;">
				<span id="resident-population" class="counter"></span><span
					style="font-size: 12px; display: none;"
					id="resident-population-unit">万</span>
			</div>
			<div class="circle-item">常住人口</div>
		</div>
		<div class="floating-circle">
			<div class="circle-value" style="color: #BCBD81;">
				<span id="floating-population" class="counter"></span><span
					style="font-size: 12px; display: none;"
					id="floating-population-unit">万</span>
			</div>
			<div class="circle-item">流动人口</div>
		</div>
		<div class="houseLogin-circle">
			<div class="circle-value" style="color: #0BE0D8;">
				<span id="house-registration" class="counter"></span><span
					style="font-size: 12px; display: none;"
					id="house-registration-unit">万</span>
			</div>
			<div class="circle-item">房屋登记</div>
		</div>
	</div>
	<div class="border-four"
		style="background-image: url(${ctx}/static/img/bjCloud/fangwuditu.png);"
		id="binjiangqu">
		<div class="border-title" style="margin-top: 21px;">滨江区房屋登记统计</div>
		<div class="house-book-item" style="left: 80px; top: 300px;"></div>
		<div class="house-pie-bg" style="left: 80px; top: 300px;"></div>
		<div id="yanfu-house-pie" class="yanfu-house-pie"
			style="left: 66px; top: 277px;"></div>
		<div class="street-name" style="left: 85px; top: 380px;">浦沿街道</div>
		<div id="yanfu-register" class="house-desc-all-num"
			style="left: 30px; top: 280px;">--</div>
		<div id="yanfu-rent" class="house-desc-rent-num"
			style="left: 130px; top: 350px;">--</div>

		<div class="house-book-item" style="left: 240px; top: 250px;"></div>
		<div class="house-pie-bg" style="left: 230px; top: 250px;"></div>
		<div id="changhe-house-pie" class="yanfu-house-pie"
			style="left: 217px; top: 226px;"></div>
		<div class="street-name" style="left: 240px; top: 330px;">长河街道</div>
		<div id="changhe-register" class="house-desc-all-num"
			style="left: 155px; top: 270px;">--</div>
		<div id="changhe-rent" class="house-desc-rent-num"
			style="left: 270px; top: 300px;">--</div>

		<div class="house-book-item" style="left: 330px; top: 155px;"></div>
		<div class="house-pie-bg" style="left: 330px; top: 155px;"></div>
		<div id="xixin-house-pie" class="yanfu-house-pie"
			style="left: 318px; top: 132px;"></div>
		<div class="street-name" style="left: 340px; top: 240px;">西兴街道</div>
		<div id="xixin-register" class="house-desc-all-num"
			style="left: 260px; top: 180px;">--</div>
		<div id="xixin-rent" class="house-desc-rent-num"
			style="left: 360px; top: 150px;">--</div>

		<div class="house-book-item2" style="left: 120px; top: 515px;">
			<div class="icon-font"
				style="position: inherit; left: 20px; top: 18px;"></div>
			<div class="font1" style="position: relative; left: 20px; top: 18px;">房屋登记</div>
			<div class="icon-font2" style="position: inherit; left: 120px;"></div>
			<div class="font2" style="position: relative; left: 120px;">房屋出租</div>

		</div>
	</div>
	<div class="border-four"
		style="background-image: url(${ctx}/static/img/bjCloud/fangwuditushangchengqu.png);"
		id="shangchengqu"></div>


	<div class="buttom-content" style="height: 256px; width: 100%;">
		<div class="border-two">
			<div class="border-title">设备完好率排名</div>
			<div id="device-village-div"
				style="width: 100%; height: 212px; padding-top: 14px;"></div>

		</div>
		<div class="border-three">
			<div style="text-align: center; height: 46px;">
				<span class="choose-item" onclick="tabClick(this)"
					name="permanent-div" id="tab-permanent-div">常住人口排名</span> <span
					style="margin: 0px 20px; border: 1px solid #5FAEDA; width: 1px;"></span>
				<span class="no-choose-item" onclick="tabClick(this)"
					name="floating-div" id="tab-floating-div">流动人口排名</span>
			</div>
			<div class="population-div" id="permanent-div"></div>
		</div>
		<div class="border-two" style="margin-left: 24px;">
			<div class="border-title">共享车位统计信息</div>
			<!-- 	<div id="important-alarm-div" style="width: 100%; height: 212px; padding-top: 16px;">
			 <div class="important-alarm-class">
					<div class="icon-class">1</div>
					<div class="font">火炬小区</div>
					<div class="alarm-value">
						<div class="fill-parent-div">
							<div class="fill-div" style="width: 100%;"></div>
						</div>
					</div>
					<span class="alarm-value-font">1565 </span>
				</div>
			</div> -->
			<div class="share-space-title-div" style="width: 100%; height: 25px;">
				<div class="share-space-title-class">
					<div class="share-space-title-name">小区名称</div>
					<div class="share-space-title-totalNum">共享车位数</div>
					<span class="share-space-title-remain">共享车位剩余数</span>
				</div>
			</div>
			<div class="share-space-title-div-hr"
				style="width: 85%; height: 1px;"></div>
			<div id="share-space-content-div" class="share-space-content-div"
				style="width: 100%; height: 180px; padding-top: 10px;">
				<div id="bd-share" class="bd-share">
					<ul id='bd-share-ul' class="bd-share-ul">
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div id="alarm-info"></div>
	<!-- 电梯困人 报警弹窗、消防火警弹窗 -->
	<div id="show-elevator-alarm-video"></div>
	<div id="fires-alarm-video"></div>
	<div id="ffm-error-div"></div>
	<div id="show-video-dss"></div>
	<div id="error-div"></div>
</body>

<div id="alarm-device-img"></div>
<script type="text/javascript">
	var dssPlayerAlarm = null;
	var alarmInfoData = {};
	var showAlarmInfoData = null;
	var projectId = "${param.projectId}";
	var ctx = "${ctx}";
	var tabFlag = 'tabA';
	var tabObjA = $("#tab-safe-div");
	var tabObjB = $("#tab-device-alaram");
	var permanentFloating = 'permanent';
	var permanentObj = $("#tab-permanent-div");
	var floatingObj = $("#tab-floating-div");
	var bindSafeStatus = false;
	var bindDeviceStatus = false;
	//安全事件报警图标
	// 消防火警
	var fireFightingAlarm = "${ctx}/static/img/bjCloud/alarmImg/fireFightingAlarm.svg";
	// 消防通道堵塞
	var fireFightingBlock = "${ctx}/static/img/bjCloud/alarmImg/fireFightingBlock.svg";
	//高空抛物
	var gaokongpaowu = "${ctx}/static/img/bjCloud/alarmImg/gaokongpaowu.svg";
	// 重点关注人员
	var importantFocus = "${ctx}/static/img/bjCloud/alarmImg/importantFocus.svg";
	// 进入危险区域
	var dangerousArea = "${ctx}/static/img/bjCloud/alarmImg/dangerousArea.svg";
	// 群体事件
	var peopleEvent = "${ctx}/static/img/bjCloud/alarmImg/peopleEvent.svg";
	// 黑名单人员
	var blackList = "${ctx}/static/img/bjCloud/alarmImg/blackList.svg";
	// 电梯困人
	var elevPeople = "${ctx}/static/img/bjCloud/alarmImg/elevPeople.svg";
	//安全事件报警展示
	//	var IncidentHtml = '';
	var HZ_DATA_GEO_CoordMap = {};
	var HSData = new Array();
	var keyName = "";
	var projectMap = {};
	var projectIcons = {};
	var projectCodeMap = {};
	var cityData = new Array();
	var alarmOut;
	var alarmQueue = new Queue();
	var isProcess = false;
	var isConnectedGateWay = false;
<%--电梯、消防视频弹窗缓存（开始） --%>
	//订阅电梯、消防websocket(默认先订阅 火炬小区)
	var huojuProjectCode = "HUOJUXIAOQU";
	// 缓存设备id数组
	var elevatorAlarmDevice = new Array();
	//电梯告警弹窗打开状态0关闭1打开
	var elevatorVideoIsOpen = 0;
	var elevatorList = new Array();
	var cameraDeviceId = null;
	var elevator = null;
	var elevatorName = null;
	var elevatorAlarmName = null;
	var elevatorFloorDisplaying = null;
	var elevatorRunningState = null;
	var cameraStatus = null;
	//判断是否产生新的电梯困人告警数据：0否1是
	var isNewElevatorAlarm = 0;
	//消防选择的摄像机id缓存
	var cameraDeviceId = null;
	//消防推送视频弹窗id
	var tempCameraId = null;
	var firesVideoDeviceMap = new HashMap();
	var firesVideoDeviceList = new Array();
	var doorBlockDeviceList = new Array();
	var isShowFiresVideo = false;

	var spaceData;//车位数据
	var millisecond = 0;//毫秒
	var pageNumber = 0;//页码

	//安全事件
	var securityData;//车位数据
	var secPageNumber = 0;//页码
<%--电梯、消防视频弹窗缓存（结束） --%>
	$(document).ready(function() {
		hiddenScroller();
		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
		fillPiontImg();
		getAllOrganizeCount();
		showTime();
		startConn(ctx);
		securityIncident(); //安全事件报警
		// 		window.setInterval("securityIncident()", 60000); //安全事件报警（一分钟刷新一次）
		getDeviceNormalRateTop();//设备完好率
		getShareSpaceInfo();

		//		getImportAlarmTop();//重要告警排行
		getSafeRanking(151, "security-incident-ranking"); //安全事件排名
		//window.setInterval('getSafeRanking(151, "security-incident-ranking")', 60000); //安全事件排名（一分钟刷新一次）
		getStreetHouseRank(); //房屋登记排行
		//setInterval("getStreetHouseRank()", 60000); //房屋登记排行（一分钟刷新一次）
		// 		setInterval("switchTab()",4000);
		//定时任务
		//setInterval("getImportantAlaramRecord()",60000);
		//setInterval("securityIncident()", 60000);

		//setInterval("getDeviceNormalRateTop()", 60000);
		//		setInterval("getImportAlarmTop()",60000); 
		getPopulationAndHouseTotal();
		getPopulationNum(1);
		//setInterval("getPopulationTable()", 60000); //常驻人口/流动人口统计排行（一分钟刷新一次）
		// setInterval("getPopulationAndHouseTotal()",60000); //人口统计排行（一分钟刷新一次）
		//setInterval("showSnapshotImage()", 500);
		//setInterval("fillPiontImg()", 60000); //区域详情数据（一分钟刷新一次）

		//setInterval("showShareSpaceInfo()", 1000 * 5);
		//setInterval("getShareSpaceInfo()", 60000);

		//setInterval("showSecurityIncident()", 1000 * 5);
		switchShowborderFour();
		
		if (typeof (hsFlushGroupPageGrid) != "undefined") {
			//防止多次加载产生多个定时任务
			clearTimeout(hsFlushGroupPageGrid);
		}
		hsFlushGroupPageGrid = setTimeout("hsflushGroupGrid()", 60000);
		
		if (typeof (hsFlushshowSecurityGrid) != "undefined") {
			//防止多次加载产生多个定时任务
			clearTimeout(hsFlushshowSecurityGrid);
		}
		hsFlushshowSecurityGrid = setTimeout("hsflushSecurityGrid()", 5000);
		
		if (typeof (hsFlushshowSnapGrid) != "undefined") {
			//防止多次加载产生多个定时任务
			clearTimeout(hsFlushshowSnapGrid);
		}
		hsFlushshowSnapGrid = setTimeout("hsflushSnapGrid()", 60000);
	});
	
	function hsflushGroupGrid() {
		if (typeof (hsFlushGroupPageGrid) != "undefined"
			&& 'undefined' != typeof ($("#security-incident-ranking").val())) {
			getSafeRanking(151, "security-incident-ranking");
			getStreetHouseRank();
			securityIncident();
			getDeviceNormalRateTop();
			getPopulationTable();
			fillPiontImg();
			getShareSpaceInfo()
			hsFlushGroupPageGrid = setTimeout("hsflushGroupGrid()", 60000);
		}
	}
	
	function hsflushSecurityGrid() {
		if (typeof (hsFlushshowSecurityGrid) != "undefined"
			&& 'undefined' != typeof ($("#security-incident-ranking").val())) {
			showSecurityIncident();
			hsFlushshowSecurityGrid = setTimeout("hsflushSecurityGrid()", 5000);
		}
	}
	
	function hsflushSnapGrid() {
		if (typeof (hsFlushshowSnapGrid) != "undefined"
			&& 'undefined' != typeof ($("#location").val())) {
			showSnapshotImage();
			hsFlushshowSnapGrid = setTimeout("hsflushSnapGrid()", 5000);
		}
	}
	function tabClick(obj) {
		if ($(obj).hasClass("no-choose-item")) {
			var showId = $(obj).attr("name");
			var hideId = $(obj).parent().find('.choose-item').attr("name");
			$(obj).parent().find('.choose-item').removeClass("choose-item").addClass("no-choose-item");
			$(obj).removeClass("no-choose-item").addClass("choose-item");
			if (showId == "permanent-div") {
				getPopulationNum(1);
			} else if (showId == "floating-div") {
				getPopulationNum(2);
			} else if (showId == "device-alaram-div") {
				getImportantAlaramRecord();//重要告警记录
			}
			if (showId != "permanent-div" && showId != "floating-div") {
				$("#" + showId).show();
				$("#" + hideId).hide();
			}
		}
	}
	function tabAlarmClick(obj) {
		if (obj == "1") {
			$("#event-alarm").show();
			$(".device-alaram-div").hide();
			securityIncident(); //安全事件报警
			$('.safe-choose-item').removeClass("no-choose-item").addClass("choose-item");
			$(".device-no-choose-item").removeClass("choose-item").addClass("no-choose-item");
		} else {
			$(".device-alaram-div").show();
			$("#event-alarm").hide();
			getImportantAlaramRecord();//重要告警记录
			$('.no-choose-item').removeClass("no-choose-item").addClass("choose-item");
			$(".choose-item").removeClass("choose-item").addClass("no-choose-item");
		}
	}

	function hiddenScroller() {
		var height = $(window).height();
		if (height > 1070) {
			document.documentElement.style.overflowY = 'hidden';
			document.documentElement.style.overflowX = 'hidden';
		} else {
			document.documentElement.style.overflowY = 'auto';
		}
	}
	$(window).resize(function() {
		hiddenScroller();
	});

	function switchShowborderFour() {
		var t1 = $(".border-four").first();
		var t2 = $(".border-four").last();
		if (t1.css("display") == "none") {
			t1.show();
			t2.hide();
		} else {
			t1.hide();
			t2.show();
		}
		setTimeout("switchShowborderFour()",4000);
	}
</script>
</html>