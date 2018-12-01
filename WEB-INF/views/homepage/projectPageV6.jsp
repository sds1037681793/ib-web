<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" var="currentYear" pattern="yyyy" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>云平台首页</title>
<style type="text/css">
.block {
	background: #162D39;;
	box-shadow: 0 0 12px 0 rgba(0, 0, 0, 0.20);
	border-radius: 4px;
	margin-left: 1.67rem;
	float: left;
	padding: 1rem;
	margin-bottom: 1.67rem;
}

.font_item {
	opacity: 0.8;
	font-size: 2rem;
	color: #FFFFFF;
	letter-spacing: 0;
	float: left;
	font-family: PingFangSC-Light;
}

.ff_table {
	width: 100%;
}

.ff_table td {
	vertical-align: middle;
	display: inline-flex;
}

.alarm-describes {
	font-size: 14px;
	color: #D8DCDE;
	letter-spacing: 0;
	float: left;
	width: 126px;
}

.alarm-location {
	font-size: 14px;
	color: #D8DCDE;
	letter-spacing: 0;
	float: left;
	width: 125px;
}

.alarm-time {
	font-size: 14px;
	color: #D8DCDE;
	letter-spacing: 0;
	float: left;
	width: 134px;
}

.alarm-opreator {
	font-size: 14px;
	color: #D8DCDE;
	letter-spacing: 0;
	float: left;
	width: 98px;
}

.alarm-status {
	font-family: PingFangSC-Regular;
	color: #B1A558;
	font-size: 14px;
	letter-spacing: 0;
	float: left;
	width: 42px;
}

.alarm-span {
	float: left;
	height: 12.5px;
	/* margin-top:12px; */
	width: 53px;
}

.address-date {
	font-size: 14px;
	color: #FFFFFF;
	letter-spacing: 0;
}

.alerm-p1 {
	font-size: 42px;
	color: #FFFFFF;
	letter-spacing: 0;
	line-height: 42px;
	padding-top: 2.3rem;
}

.alerm-p2 {
	font-size: 14px;
	color: #FFFFFF;
	letter-spacing: 0;
	line-height: 14px;
	opacity: 0.6;
}

.alerm-p3 {
	font-size: 32px;
	color: #FFFFFF;
	letter-spacing: 0;
	text-align: center;
}

.alerm-p4 {
	font-size: 12px;
	color: #FFFFFF;
	letter-spacing: 0;
	text-align: center;
}

.license-div {
	text-align: center;
	line-height: 26px;
	font-size: 12px;
	color: #FFFFFF;
	letter-spacing: 0.47px;
	margin-left: 19px;
	float: left;
	width: 80px;
	height: 24px;
	background: rgba(0, 143, 255, 0.4) none repeat scroll 0% 0%;
	border-radius: 3px;
}

#projectDeviceState canvas {
	cursor: pointer;
}

#elevator canvas {
	cursor: pointer;
}

#projectPagePdsEchart canvas {
	cursor: pointer;
}

#projectParkingEchart canvas {
	cursor: pointer;
}

#project-access-control-report canvas {
	cursor: pointer;
}

.text1 {
	position: relative;
	animation: mymove 5.5s infinite;
	-webkit-animation: mymove 5.5s infinite; /*Safari and Chrome*/
}

@keyframes mymove {
	0{
		margin-top: 0px;
		opacity: 0;
	}
	10%{
		margin-top: 0px;
		opacity: 1;
	}
	70%{
		margin-top:0px;
		opacity: 1;
	}
	85%{
		margin-top:0px;		
		opacity: 0;
	}
	100%{
		margin-top:0px;		
		opacity: 0;	
	}
}
.fires-item {
	float: left;
	width: 15%;
	height: 100%;
	text-align: center;
	cursor: pointer;
}

#alarm-content {
	margin-top: 15px;
	width: 860px;
	height: 330px;
	overflow: hidden;
}

.item_text {
	font-size: 18px;
	color: #FFFFFF;
	letter-spacing: 0;
	width: 862px;
	height: 27px;
	line-height: 15px;
	list-style-type: none;
}

#item-title {
	font-family: HiraginoSansGB-W3;
	font-size: 20px;
	color: #D8DCDE;
	letter-spacing: 0;
}

#title-text {
	font-family: HiraginoSansGB-W3;
	font-size: 20px;
	color: #D8DCDE;
	letter-spacing: 0;
	margin-left: 3px;
}

#licensePlateDiv {
	z-index: 9999;
}
</style>
<script type="text/javascript"
	src="${ctx}/static/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/projectPageV6.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/echarts/echarts-liquidfill.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/scroll.js"></script>
</head>
<body>
	<!-- 设备报警模块 -->
	<div style="width: 1820px; padding-top: 5px;">
		<div id="alert_device_skip" class="block"
			style="width: 1170px; height: 225px; cursor: pointer;"
			onclick="openNewPage('alarmRecord',null);">
			<div style="width: 100%; height: 2.75rem; float: left">
				<div class="font_item" style="height: 2.75rem;">重要报警</div>

				<!-- <div style="float:right;height:1.67rem">
				  <span style="font-size: 14px;color: #999999;">今日报警总数</span>
				  <span style="font-size: 20px;color: #F37B7B;letter-spacing: 0;">10</span>
				</div> -->
			</div>

			<div
				style="width: 19.83rem; float: left; margin-top: 3.2rem; margin-left: 4rem">
				<div style="width: 26%; float: left; padding: 20px 0;">
					<i><img alt="" src="${ctx}/static/img/zhongyaobaojing.svg"></i>
				</div>
				<div style="float: left; padding: 10px 0px; text-align: center;">
					<p id="alarm-count"
						style="font-size: 48px; color: #FF7171; letter-spacing: 0; line-height: 42px;">10</p>
					<p
						style="opacity: 0.8; font-size: 14px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">今日报警总数</p>
				</div>
			</div>
			<div id=item-title>
				<img style="width: 15px; height: 15px"
					src="${ctx}/static/img/new-alrarm-title.svg"> <span
					id="title-text">最新事件</span>
			</div>

			<div id="alarm-content">
				<!-- <ul id ="item-text-ul">
						
					</ul> -->
				<div id="playStateCell"></div>
			</div>
		</div>
		<!-- 设备健康分析模块 -->
		<div class="block" style="width: 585px; height: 225px;"
			id="healthy_device_block">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div style="" class="font_item">设备系统健康状态分析</div>
			</div>
			<div style="width: 47rem; height: 20rem">
				<div
					style="float: left; width: 14.5rem; height: 7rem; margin-left: 2.5rem">
					<div id="alarmCenterStatus"
						style="float: left; width: 50%; height: 100%"></div>
					<div
						style="margin-top: 2.8rem; float: left; width: 49%; height: 100%; font-size: 14.58px; opacity: 0.64; color: #FFFFFF; letter-spacing: 0; line-height: 19.44px;">消防系统</div>
				</div>
				<div style="float: left; width: 14.5rem; height: 7rem;">
					<div id="accessControlStatus"
						style="float: left; width: 50%; height: 100%"></div>
					<div
						style="margin-top: 2.8rem; float: left; width: 49%; height: 100%; font-size: 14.58px; opacity: 0.64; color: #FFFFFF; letter-spacing: 0; line-height: 19.44px;">人行系统</div>
				</div>
				<div style="float: left; width: 14.5rem; height: 7rem;">
					<div id="parkingStatus"
						style="float: left; width: 50%; height: 100%"></div>
					<div
						style="margin-top: 2.8rem; float: left; width: 49%; height: 100%; font-size: 14.58px; opacity: 0.64; color: #FFFFFF; letter-spacing: 0; line-height: 19.44px;">车行系统</div>
				</div>
				<div
					style="float: left; width: 14.5rem; height: 7rem; margin-left: 2.5rem">
					<div id="elevatorStatus"
						style="float: left; width: 50%; height: 100%"></div>
					<div
						style="margin-top: 2.8rem; float: left; width: 49%; height: 100%; font-size: 14.58px; opacity: 0.64; color: #FFFFFF; letter-spacing: 0; line-height: 19.44px;">电梯系统</div>
				</div>
				<div style="float: left; width: 14.5rem; height: 7rem;">
					<div id="videoStatus" style="float: left; width: 50%; height: 100%"></div>
					<div
						style="margin-top: 2.2rem; float: left; width: 48%; height: 100%; font-size: 14.58px; opacity: 0.64; color: #FFFFFF; letter-spacing: 0; line-height: 19.44px;">视频监控系统</div>
				</div>
				<div style="float: left; width: 14.5rem; height: 7rem;">
					<div id="loraStatus" style="float: left; width: 50%; height: 100%"></div>
					<div
						style="margin-top: 2.2rem; float: left; width: 34%; height: 100%; font-size: 14.58px; opacity: 0.64; color: #FFFFFF; letter-spacing: 0; line-height: 19.44px;">物联网传感器</div>
				</div>
			</div>
		</div>
		<!-- 工作单模块 -->
		<div id="work_sheet_skip" class="block"
			style="width: 565px; height: 225px;cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item" style="height: 2.75rem; width: 10rem;">工单总任务</div>
				<div style="float: right; height: 1.67rem; margin-right: 44px;">
					<div
						style="float: right; width: 2.58rem; height: 1.67rem; font-size: 14px; color: #999999; letter-spacing: 0; margin-right: 0.5rem;"
						id="carryOut">- -</div>
					<div
						style="opacity: 0.8; background: #022630; width: 12.58rem; height: 1.67rem; float: right; margin-right: 0.7rem;">
						<div
							style="height: 1.67rem; width: 0%; opacity: 0.8; background: #0E6985;"
							id="carryOutRate"></div>
					</div>
					<div
						style="font-size: 14px; color: #999999; letter-spacing: -0.1px; float: right; margin-right: 0.83rem;">完成率</div>
				</div>
			</div>
			<div
				style="width: 45%; float: left; padding-left: 48px; padding-top: 3.8rem;">
				<div style="width: 20%; float: left; padding: 20px 0;">
					<i><img alt="" src="${ctx}/static/img/gongdanzongrenwu.svg"></i>
				</div>
				<div
					style="float: left; padding: 10px 25px; text-align: center; width: 150px;">
					<p id="workNum"
						style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 42px;">-
						-</p>
					<p
						style="opacity: 0.8; font-size: 14px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">今日工单总数</p>
				</div>
			</div>
			<div id="worksDiv"
				style="float: left; width: 24rem; height: 11rem; margin-top: 2.3rem; margin-left: 0.3rem">
			</div>
		</div>
		<!-- 消防模块  -->
		<div id="fire_fighting_skip" class="block"
			style="width: 1190px; height: 225px;">
			<div style="width: 100%;">
				<div style="width: 1170px; height: 2.5rem;">
					<div class="font_item" style="height: 2.75rem; width: 10rem;">消防系统</div>
					<div style="float: right; height: 1.67rem; cursor: pointer;"
						onclick="openFireFightingPage('FIRE_MAINTAIN_PAGE')">
						<div
							style="float: right; width: 2.58rem; height: 1.67rem; font-size: 14px; color: #999999; letter-spacing: 0; margin-right: 0.5rem;"
							id="maintain_number">80%</div>
						<div
							style="opacity: 0.8; background: #022630; width: 21.58rem; height: 1.67rem; float: right; margin-right: 0.7rem;">
							<div
								style="height: 1.67rem; width: 10%; opacity: 0.8; background: #0E6985;"
								id="maintain_value"></div>
						</div>
						<div
							style="font-size: 14px; color: #999999; letter-spacing: -0.1px; float: right; margin-right: 0.83rem;">维保进度</div>
					</div>
				</div>
			</div>

			<div
				style="width: 1170px; height: 14.28rem; padding-top: 2rem; float: left;">
				<div
					style="width: 25%; height: 100%; float: left; padding-top: 20px; padding-left: 48px;">
					<div style="width: 22%; float: left; padding: 20px 0;">
						<i><img alt="" src="${ctx}/static/img/xiaofangxitong.svg"></i>
					</div>
					<div
						style="float: left; padding: 10px 0px 0px 32px; text-align: center;">
						<p
							style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 42px;"
							id="fireDeviceNum">0</p>
						<p
							style="opacity: 0.6; font-size: 14px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">消防设备总数</p>
					</div>
				</div>
				
				<div class="fires-item"
					onclick="openFireFightingPage('FFM_OUTSIDE_PAGE')">
					<p class="alerm-p1" id="alarm_normal">0</p>
					<p class="alerm-p2">正常总数</p>
				</div>
				<div class="fires-item"
					onclick="openFireFightingPage('FFM_OUTSIDE_PAGE')">
					<p class="alerm-p1" id="fires" style="color: #FF7171;">0</p>
					<p class="alerm-p2">实时火警总数</p>
				</div>
				<div class="fires-item"
					onclick="openFireFightingPage('FFM_OUTSIDE_PAGE')">
					<p class="alerm-p1" id="alarm_abnormal" style="color: #FF7171;">0</p>
					<p class="alerm-p2">故障总数</p>
				</div>
				<div class="fires-item"
					onclick="openFireFightingPage('FFM_OUTSIDE_PAGE')">
					<p class="alerm-p1" id="linkage_answer">0</p>
					<p class="alerm-p2">回答总数</p>
				</div>
				<div class="fires-item"
					onclick="openFireFightingPage('FFM_OUTSIDE_PAGE')" style="padding-top:30px;">
					<p style="margin: 0px;"><span class="alerm-p3" id="fires_day">0</span><span style="font-size: 14px;color: #FFFFFF;">天</span></p>
					<p class="alerm-p4" id="fires_time" style="margin: 3px;">－－小时－－分钟－－秒</p>
					<p class="alerm-p2">火警未处理最长时长</p>
				</div>
			</div>

		</div>
		<!-- 电梯模块  -->
		<div id="elevator_skip" class="block"
			style="width: 565px; height: 225px; cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item" style="height: 2.75rem; width: 10rem;">电梯系统</div>
				<div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #999999; letter-spacing: 0; display: table-cell; vertical-align: middle;">维保超期：</span>
					<span id="overdueNum"
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">-
						-</span>
				</div>
			</div>
			<div
				style="width: 50%; float: left; margin-top: 3.8rem; padding-left: 48px;">
				<div style="width: 18%; float: left; padding: 20px 0;">
					<i><img alt="" src="${ctx}/static/img/diantixitong.svg"></i>
				</div>
				<div
					style="float: left; padding: 10px 25px; text-align: center; width: 150px;">
					<p id="alarmTotal"
						style="font-size: 48px; color: #FF7171; letter-spacing: 0; line-height: 42px;">-
						-</p>
					<p
						style="opacity: 0.8; font-size: 14px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">电梯报警</p>
				</div>
			</div>
			<div id="elevatorEcharts"
				style="float: left; width: 24rem; height: 11rem; margin-top: 2.3rem; margin-left: -1.8rem">
			</div>
		</div>
		<!-- 停车模块 -->
		<div class="block"
			style="width: 585px; height: 225px; cursor: pointer;"
			id="parking_skip">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item" style="height: 2.75rem; width: 10rem;">停车系统</div>
				<div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #999999; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
					<span id="deviceAbnormalNum"
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">-
						-</span>
				</div>
			</div>
			<div
				style="width: 50%; float: left; padding-top: 3.8rem; padding-left: 48px;">
				<div style="width: 24%; float: left; padding: 26px 0;">
					<i><img alt="" src="${ctx}/static/img/tingchexitong.svg"></i>
				</div>
				<div
					style="float: left; padding: 10px 25px; text-align: center; width: 150px;">
					<p id="carFlowNum"
						style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
						-</p>
					<p
						style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">车流量统计</p>
				</div>
			</div>
			<div id="parkingEcharts"
				style="float: left; width: 21.5rem; height: 10rem; margin-top: 2.3rem; margin-left: 1.8rem">

			</div>
			<div id="licensePlateDiv"
				style="float: left; width: 100%; height: 3rem; margin-top: -6px;">
				<!-- <div class="license-div">浙A 662QQ</div>
			     <div class="license-div">浙A 662QQ</div>
			     <div class="license-div">浙A 662QQ</div>
			     <div class="license-div">浙A 662QQ</div>
			     <div class="license-div">浙A 662QQ</div> -->
			</div>
		</div>
		<!-- 人行模块 -->
		<div id="access_control_skip" class="block"
			style="width: 585px; height: 225px; cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item" style="height: 2.75rem; width: 10rem;">人行系统</div>
				<div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #999999; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
					<span id="accessControlAbnormal"
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">-
						-</span>
				</div>
			</div>
			<div
				style="width: 50%; float: left; margin-top: 3.8rem; padding-left: 48px;">
				<div style="width: 24%; float: left; padding: 26px 0;">
					<i><img alt="" src="${ctx}/static/img/renxingxitong.svg"></i>
				</div>
				<div
					style="float: left; padding: 10px 25px; text-align: center; width: 150px;">
					<p id="accessFlowNum"
						style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
						-</p>
					<p
						style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">人流量统计</p>
				</div>
			</div>
			<div id="accessEcharts"
				style="float: left; width: 22.1rem; height: 10rem; margin-top: 2.3rem; margin-left: 1rem">

			</div>
		</div>
		<!-- LORA设备系统模块 -->
		<div id="lora_device_skip" class="block"
			style="width: 1170px; height: 225px; cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item" style="height: 2.75rem; width: 20rem;">物联网传感器</div>
			</div>
			<div style="float: left; width: 100%; height: 14.5rem" class="iot-switch-div">
				<div style="width: 380px; height: 100%; float: left;">
					<div style="float: left; padding-top: 72px; padding-left: 43px;">
						<img alt="" src="${ctx}/static/img/iot/cheweidianci.svg">
					</div>
					<div
						style="float: left; padding-top: 54px; text-align: center; width: 150px;">
						<p id="parkingGemNum"
							style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
							-</p>
						<p
							style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">车位地磁总数</p>
					</div>
					<div style="float: left; padding-top: 54px; margin-left: 12px;">
						<div style="line-height: 17px; font-size: 12px; color: #FFFFFF;">
							<span>正常：</span><span id="parkingGemNormal">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>离线：</span><span style="color: #F37B7B;"
								id="parkingGemOffline">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>欠压报警：</span><span style="color: #F37B7B;"
								id="parkingGemLowPower">--</span>
						</div>
					</div>
				</div>
				<div
					style="margin-top: 40px; width: 2px; float: left; height: 80px; background: rgba(255, 255, 255, 0.30);"></div>
				<div style="width: 380px; height: 100%; float: left;">
					<div style="float: left; padding-top: 72px; padding-left: 43px;">
						<img alt="" src="${ctx}/static/img/iot/xiaofangmeng.svg">
					</div>
					<div
						style="float: left; padding-top: 54px; text-align: center; width: 150px;">
						<p id="fireGateGemNum"
							style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
							-</p>
						<p
							style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">消防门地磁总数</p>
					</div>
					<div style="float: left; padding-top: 40px; margin-left: 12px;">
						<div style="line-height: 17px; font-size: 12px; color: #FFFFFF;">
							<span>正常：</span><span id="fireGateGemNormal">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>离线：</span><span id="fireGateGemOffline">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>通道堵塞：</span><span style="color: #F37B7B;"
								id="fireGateGemMonitor">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>欠压告警：</span><span style="color: #F37B7B;"
								id="fireGateGemLowPower">--</span>
						</div>
					</div>
				</div>
				<div
					style="margin-top: 40px; width: 2px; float: left; height: 80px; background: rgba(255, 255, 255, 0.30);"></div>
				<div style="width: 380px; height: 100%; float: left;">
					<div style="float: left; padding-top: 72px; padding-left: 43px;">
						<img alt="" src="${ctx}/static/img/iot/jinggai.svg">
					</div>
					<div
						style="float: left; padding-top: 54px; text-align: center; width: 150px;">
						<p id="iotManholeCoverNum"
							style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
							-</p>
						<p
							style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">井盖</p>
					</div>
					<div style="float: left; padding-top: 40px; margin-left: 12px;">
						<div style="line-height: 17px; font-size: 12px; color: #FFFFFF;">
							<span>正常：</span><span id="iotManholeCoverNormal">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>离线：</span><span style="" id="iotManholeCoverOffline">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>倾斜报警：</span><span style="color: #F37B7B;"
								id="iotManholeCoverMonitor">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>欠压告警：</span><span style="color: #F37B7B;"
								id="iotManholeCoverLowPower">--</span>
						</div>
					</div>
				</div>
			</div>

			<div
				style="float: left; width: 100%; height: 14.5rem; display: none;"
				class="iot-switch-div">
				<div style="width: 380px; height: 100%; float: left;">
					<div style="float: left; padding-top: 72px; padding-left: 43px;">
						<img alt="" src="${ctx}/static/img/iot/lajitong.svg">
					</div>
					<div
						style="float: left; padding-top: 54px; text-align: center; width: 150px;">
						<p id="iotTrashcanNum"
							style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
							-</p>
						<p
							style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">垃圾桶</p>
					</div>
					<div style="float: left; padding-top: 40px; margin-left: 12px;">
						<div style="line-height: 17px; font-size: 12px; color: #FFFFFF;">
							<span>正常：</span><span id="iotTrashcanNormal">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>离线：</span><span style="color: #F37B7B;"
								id="iotTrashcanOffline">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>溢满报警：</span><span style="color: #F37B7B;"
								id="iotTrashcanMonitor">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>欠压报警：</span><span style="color: #F37B7B;"
								id="iotTrashcanLowPower">--</span>
						</div>
					</div>
				</div>
				<div
					style="margin-top: 40px; width: 2px; float: left; height: 80px; background: rgba(255, 255, 255, 0.30);"></div>
				<div style="width: 380px; height: 100%; float: left;">
					<div style="float: left; padding-top: 72px; padding-left: 43px;">
						<img alt="" src="${ctx}/static/img/iot/environmen.svg">
					</div>
					<div
						style="float: left; padding-top: 54px; text-align: center; width: 150px;">
						<p id="iotEnvironmentNum"
							style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
							-</p>
						<p
							style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">环境终端</p>
					</div>
					<div style="float: left; padding-top: 40px; margin-left: 12px;">
						<div style="line-height: 17px; font-size: 12px; color: #FFFFFF;">
							<span>正常：</span><span id="iotEnvironmentNormal">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>离线：</span><span id="iotEnvironmentOffline">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>pm2.5：</span><span style="color: #F37B7B;"
								id="iotEnvironmentMonitor">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>污染等级：</span><span style="color: #F37B7B;" id="pm25State">--</span>
						</div>
					</div>
				</div>
				<div
					style="margin-top: 40px; width: 2px; float: left; height: 80px; background: rgba(255, 255, 255, 0.30);"></div>
				<div style="width: 380px; height: 100%; float: left;">
					<div style="float: left; padding-top: 72px; padding-left: 43px;">
						<img alt="" src="${ctx}/static/img/iot/dianbiao.png">
					</div>
					<div
						style="float: left; padding-top: 54px; text-align: center; width: 150px;">
						<p id="iotElectricityMeterNum"
							style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">-
							-</p>
						<p
							style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">电表</p>
					</div>
					<div style="float: left; padding-top: 54px; margin-left: 12px;">
						<div style="line-height: 17px; font-size: 12px; color: #FFFFFF;">
							<span>正常：</span><span id="iotElectricityMeterNormal">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>离线：</span><span style="" id="iotElectricityMeterOffline">--</span>
						</div>
						<div
							style="line-height: 17px; font-size: 12px; color: #FFFFFF; margin-top: 6px;">
							<span>读数：</span><span id="iotElectricityMeterMonitor">--</span><span>kwh</span>
						</div>
					</div>
				</div>
			</div>



		</div>
	</div>

	</div>
	<!-- 视频监控系统模块 -->
	<div id="vedio_skip" class="block"
		style="width: 585px; height: 225px; cursor: pointer;">
		<div style="width: 100%; height: 2.5rem; float: left;">
			<div class="font_item" style="height: 2.75rem; width: 20rem;">视频监控系统</div>

		</div>
		<div
			style="width: 50%; float: left; margin-top: 3.8rem; padding-left: 48px;">
			<div style="width: 24%; float: left; padding: 26px 0;">
				<i><img alt="" src="${ctx}/static/img/shipinjiankong.svg"></i>
			</div>
			<div
				style="float: left; text-align: center; padding: 10px 25px; width: 121px;">
				<p id="videoDeviceCount"
					style="font-size: 40.32px; color: #FFFFFF; letter-spacing: 0; line-height: 42px; height: 38px;">160</p>
				<p
					style="opacity: 0.8; font-size: 13.44px; color: #FFFFFF; letter-spacing: 0; line-height: 14px;">总数</p>
			</div>
		</div>

		<div
			style="width: 50%; height: 10rem; float: left; padding-top: 5rem; padding-left: 7.5rem">
			<p>
				<i><img alt="" src="${ctx}/static/img/zaixian.svg"
					style="margin-top: -5px;"></i> <span
					style="font-size: 18px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8; padding: 0.5rem">在线</span>
				<span id="videoDeviceNormal"
					style="font-size: 20px; color: #FFFFFF; letter-spacing: 0; opacity: 0.9;">142</span>
			</p>
			<p style="padding-top: 0.5rem">
				<i><img alt="" src="${ctx}/static/img/lixian.svg"
					style="margin-top: -5px;"></i> <span
					style="font-size: 18px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8; padding: 0.5rem">离线</span>
				<span id="videoDeviceUnnormal"
					style="font-size: 20px; color: #FFFFFF; letter-spacing: 0; opacity: 0.9;">18</span>
			</p>
		</div>
	</div>

	</div>
	<div id="alarm-device-img"></div>
	<div id="ffm_page"></div>
	<div id="error-div"></div>
	<div id="parking-img"></div>
</body>
<script type="text/javascript">
	var ctx = '${ctx}';
	var time = 60 * 1000;
	//最新报警事件
	var newestAlarmData;
	var secPageNumber = 0;//页码
	var flushFiresTime;
	$(document).ready(function() {
		//电梯模块初始化
		getElevatorAlarmData();
		//停车场模块数据初始化
		getParkingSystemData();
		//人行模块数据初始化
		getAccessControlData();
		//视频监控模块初始化
		getVideoMonitorData();
		//设备系统健康状况分析
		getDeviceHealthStatus();
		//获取设备健康状态
		getDeviceHealthStatus();
		//获取工作单数据
		workOrderDate();
		//LORA设备系统初始化
		//loraDeviceData();
		getAllSensorAlarmShowData();
		getAlarmRecordList();
		//获取消防设备总数
		queryFiresDeviceTotal();
		setTimeout(getFiresData(), time);
		//轮播物联网div
		switchIotDeviceInfo();
		toSubscribe();
		hsFlushProjectPageGrid = setTimeout("hsflushGovernmentGrid()", 60000);
		alarmDatahsFlushProjectPageGrid = setTimeout("alarmHsflushGovernmentGrid()", 5000);

	});

	function hsflushGovernmentGrid() {
		if (typeof (hsFlushProjectPageGrid) != "undefined") {
			getElevatorAlarmData();
			getAccessControlData();
			getParkingSystemData();
			getAllSensorAlarmShowData();
			getAlarmRecordList();
			workOrderDate();
			hsFlushProjectPageGrid = setTimeout("hsflushGovernmentGrid()", 60000);
		}
	}

	function alarmHsflushGovernmentGrid() {
		if (typeof (alarmDatahsFlushProjectPageGrid) != "undefined") {
			buildAlarmData();
			alarmDatahsFlushProjectPageGrid = setTimeout("alarmHsflushGovernmentGrid()", 5000);
		}
	}

	function switchIotDeviceInfo() {
		if (typeof (flushSwitchIotDeviceInfoObj) != "undefined") {
			clearTimeout(flushSwitchIotDeviceInfoObj);
		}
		var display1 = $(".iot-switch-div").first().css('display');
		if (display1 == "none") {
			$(".iot-switch-div").last().fadeOut(500, function() {
				$(".iot-switch-div").first().show();
			});
		} else {
			$(".iot-switch-div").first().fadeOut(500, function() {
				$(".iot-switch-div").last().show();
			});
		}
		flushSwitchIotDeviceInfoObj = setTimeout("switchIotDeviceInfo()", 4 * 1000);
	}
</script>
</html>