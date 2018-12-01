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
	background: #262D36;
	box-shadow: 0 0 12px 0 rgba(0, 0, 0, 0.20);
	border-radius: 4px;
	margin-left: 1.67rem;
	float: left;
	padding: 1.67rem;
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

.ccde td {
	
}

#projectDeviceState canvas{
    cursor: pointer;
}

#elevator canvas{
    cursor: pointer;
}

#projectPagePdsEchart canvas{
    cursor: pointer;
}

#projectParkingEchart canvas{
    cursor: pointer;
}

#project-access-control-report canvas{
    cursor: pointer;
}
</style>
<script type="text/javascript" src="${ctx}/static/busi/projectPageV4.js"></script>
<script type="text/javascript"
	src="${ctx}/static/busi/projectDeviceStateData.js"></script>

</head>
<body>
	<div style="width: 140rem; padding-top: 15px; padding-left: 10px;">
		<div class="block" style="width: 50rem; height: 24.17rem;cursor: pointer;" onclick="openNewPage('alarmRecord',null);">
			<div style="width: 50%; height: 100%; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem;">监管设备</div>
				<div
					style="height: 17.92rem; letter-spacing: 0; width: 80%; margin: 7rem auto; text-align: center;">
					<span id="deviceProjectCount"
						style="font-size: 4rem; color: #00BFA5; height: 9.57rem; line-height: 5.58rem; width: 100%; padding-top: 4.17rem;">0
					</span><span id="deviceWan"
						style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;"></span>
					<div
						style="font-size: 16px; opacity: 0.8; color: #FFFFFF; letter-spacing: 0; width: 100%;">设备总数</div>
					<div
						style="height: 1.67rem; margin-top: 4.6rem; position: absolute;">
						<table style="width: 100%; height: 1.67rem" class="ccde">
							<tr>
								<td style="width: 0.83rem;">
									<div
										style="width: 0.83rem; height: 0.83rem; background: #00BFA5;"></div>
								</td>
								<td align="right"
									style="width: 40px; font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">正常
								</td>
								<td id="supervise_device_normal"
									style="font-size: 18px; color: #FFFFFF; letter-spacing: 0; width: 80px;">0
								</td>
								<td style="width: 0.83rem;">
									<div
										style="width: 0.83rem; height: 0.83rem; background: #F37B7B;"></div>
								</td>
								<td align="right"
									style="width: 40px; font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">异常
								</td>
								<td id="supervise_device_abnormal"
									style="font-size: 18px; color: #F37B7B; letter-spacing: 0; width: 80px;">0
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div style="float: left; width: 21.66rem; height: 18.07rem;">
				<div style="height: 90%; width: 100%; margin-top: 18px;"
					id="projectDeviceState"></div>
				<div
					style="height: 10%; cursor: pointer; width: 100%; text-align: center; margin-top: 12px; opacity: 0.8; font-family: PingFangSC-Light; font-size: 16px; color: #FFFFFF; letter-spacing: 0;">总设备完好率</div>
			</div>

		</div>
		<div class="block" style="width: 83.3rem; height: 24.17rem;"
			id="fire_fighting_block">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">消防系统</div>
				<div style="float: right; height: 1.67rem;cursor: pointer;" onclick="openFireFightingPage('FIRE_MAINTAIN_PAGE',null)">
					<div
						style="float: right; width: 2.58rem; height: 1.67rem; font-size: 14px; color: #FFFFFF; letter-spacing: 0;"
						id="maintain_number">0%</div>
					<div
						style="background: rgba(255, 255, 255, 1); width: 21.58rem; height: 1.67rem; float: right; margin-right: 1.67rem;">
						<div style="height: 1.67rem; width: 0%; background: #4DA1FF;"
							id="maintain_value"></div>
					</div>
					<div
						style="font-size: 14px; color: #FFFFFF; letter-spacing: -0.1px; float: right; margin-right: 0.83rem;">维保进度</div>
				</div>
			</div>
			<div style="float: left; width: 21.66rem; height: 18.07rem;">
				<div style="height: 90%; width: 100%" id="ffm_master"></div>
				<div
					style="height: 10%; cursor: pointer; width: 100%; text-align: center; font-size: 16px; opacity: 0.8; color: #FFFFFF; letter-spacing: 0;"
					onclick="newPage(1);">主机在线率</div>
			</div>
			<div
				style="float: left; width: 58rem; height: 18.08rem; padding-top: 5rem;">
				<div style="width: 25%; height: 100%; float: left;">
					<div onclick="openFireFightingPage('FIRE_ALERT_NOW_PAGE',0)"
						style="cursor: pointer; font-size: 12px; color: #FFFFFF; height: 25px; letter-spacing: 0; width: 100%; padding-left: 35px; opacity: 0.8;">
						正常:&nbsp;&nbsp; <span
							style="font-size: 18px; color: #FFFFFF; letter-spacing: 0; width: 5rem;"
							id="alarm_normal">--</span>
						<!-- 								<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> -->
					</div>
					<div
						onclick="openFireFightingPage('FIRE_ALERT_NOW_PAGE',2)"
						style="cursor: pointer; font-size: 12px; color: #FFFFFF; letter-spacing: 0; width: 100%; padding-left: 35px; opacity: 0.8;">
						故障:&nbsp;&nbsp; <span
							style="font-size: 18px; color: #F37B7B; letter-spacing: 0; width: 5rem;"
							id="alarm_abnormal">--</span>
						<!-- 							<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> -->
					</div>
					<div
						onclick="openFireFightingPage('FIRE_ALERT_NOW_PAGE',3)"
						style="cursor: pointer; font-size: 12px; color: #FFFFFF; letter-spacing: 0; width: 100%; padding-left: 35px; opacity: 0.8;">
						回答:&nbsp;&nbsp; <span
							style="font-size: 18px; color: #F37B7B; letter-spacing: 0; width: 5rem;"
							id="linkage_answer">--</span>
						<!-- 							<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> -->
					</div>
					<div
						style="display: table-cell; padding-top: 22px; text-align: center; width: 174px; height: 25px;">
						<img src="${ctx}/static/icon/index/baojingxitong.svg"
							style="float: left;"> <span
							style="font-family: PingFangSC-Light; font-size: 16px; display: block; float: left; color: #FFFFFF; letter-spacing: 0; margin-left: 6px; opacity: 0.8;">报警系统监测设备</span>
					</div>
				</div>
				<div style="width: 25%; height: 100%; float: left;">
					<div
						onclick="openFireFightingPage('FIRE_ALERT_NOW_PAGE',1)"
						style="cursor: pointer; width: 100%; font-size: 48px; color: #F37B7B; height: 45px; line-height: 45px; letter-spacing: 0; text-align: center;"
						id="fires">--</div>
					<div
						onclick="openFireFightingPage('FIRE_ALERT_NOW_PAGE',1)"
						style="cursor: pointer; display: table-cell; padding-top: 46px; text-align: center; width: 174px; height: 25px; padding-right: 30px;">
						<span
							style="font-family: PingFangSC-Light; display: block; float: right; font-size: 16px; color: #FFFFFF; letter-spacing: 0; margin-left: 6px; opacity: 0.8;">实时火警总数</span>
						<img src="${ctx}/static/icon/index/shishihuojing.svg"
							style="float: right;">
					</div>
				</div>
				<div style="width: 30%; height: 100%; float: left;">
					<div onclick="newPage(2)"
						style="cursor: pointer; font-size: 24px; color: #F37B7B; letter-spacing: 0; height: 33px; text-align: center; line-height: 33px;"
						id="fires_day">--天</div>
					<div onclick="newPage(2)"
						style="cursor: pointer; font-size: 12px; color: #F37B7B; letter-spacing: 0; text-align: center;"
						id="fires_time">--小时--分--秒</div>
					<div
						style="cursor: pointer; display: table-cell; padding-top: 38px; text-align: center; width: 174px; height: 25px;">
						<span onclick="newPage(2)"
							style="font-family: PingFangSC-Light; display: block; float: right; font-size: 16px; color: #FFFFFF; letter-spacing: 0; margin-left: 6px; opacity: 0.8;">火警未处理最长时长</span>
						<img src="${ctx}/static/icon/index/shichang.svg"
							onclick="newPage(2)" style="float: right;">
					</div>
				</div>
				<div style="width: 20%; height: 100%; float: left;">
					<div onclick="openFireFightingPage('WATER_TEST_NOW_PAGE','online')"
						style="cursor: pointer; width: 100%; font-size: 12px; color: #FFFFFF; letter-spacing: 0; height: 25px; padding-left: 40%; line-height: 25px; opacity: 0.8;">
						在线： <span
							style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;"
							id="water_online">--</span>
						<!-- 							<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> -->
					</div>
					<div onclick="openFireFightingPage('WATER_TEST_NOW_PAGE','offline')"
						style="cursor: pointer; width: 100%; font-size: 12px; color: #FFFFFF; letter-spacing: 0; height: 25px; padding-left: 40%; line-height: 25px; opacity: 0.8;">
						离线： <span
							style="font-size: 18px; color: #F37B7B; letter-spacing: 0;"
							id="water_offline">--</span>
						<!-- 							<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> -->
					</div>
					<div onclick="openFireFightingPage('WATER_TEST_NOW_PAGE','alarm')"
						style="cursor: pointer; width: 100%; font-size: 12px; color: #FFFFFF; letter-spacing: 0; height: 25px; padding-left: 40%; line-height: 25px; opacity: 0.8;">
						报警： <span
							style="font-size: 18px; color: #F37B7B; letter-spacing: 0;"
							id="water_alarm">--</span>
						<!-- 							<span style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span> -->
					</div>
					<div
						style="display: table-cell; padding-top: 16px; text-align: center; width: 174px; height: 25px;">
						<span
							style="font-family: PingFangSC-Light; display: block; float: right; font-size: 16px; color: #FFFFFF; letter-spacing: 0; margin-left: 6px; opacity: 0.8;">水系统监测设备</span>
						<img src="${ctx}/static/icon/index/shuixitong.svg"
							style="float: right;">
					</div>
				</div>
			</div>
		</div>
		<div id="supply_elevator_skip" class="block"
			style="width: 50rem; height: 15.83rem;cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">电梯监控</div>
				<div id="kunren" style="float: right; height: 1.64rem;">
					<img id="imgkunren">
				</div>
				<!-- 此处为报表 -->
			</div>
			<div
				style="width: 10rem; margin-top: 1.67rem; margin-left: 5.58rem; float: left; text-align: center;">
				<span id="allElevators"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;"></span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">总数</span>
			</div>
			<div
				style="height: 7rem; float: left; text-align: center; width: 40%; margin-top: 1.67rem;">
				<div id="elevator"
					style="height: 7rem; float: left; text-align: center; width: 60%;"></div>
				<div style="height: 7rem; padding-top: 5px;">
					<table style="height: 6rem;">
						<tr style="height: 34px;">
							<td align="right"
								style="width: 30px; font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">运行</td>
							<td id="elevator_running"
								style="font-size: 18px; color: #FFFFFF; letter-spacing: 0; width: 80px;"></td>
						</tr>
						<tr>
							<td align="right"
								style="width: 40px; font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">检修</td>
							<td id="elevator_overhaul"
								style="font-size: 18px; color: #FFFFFF; letter-spacing: 0; width: 80px;"></td>
						</tr>
					</table>
				</div>
			</div>
			<div
				style="height: 7rem; float: left; text-align: center; width: 12rem; margin-top: 1.67rem; padding-left: 1rem;">
				<span id="totalOfAlarm"
					style="font-size: 48px; color: #F37B7B; letter-spacing: 0; line-height: 5.58rem; display: block;"></span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">报警总数</span>
			</div>
		</div>
		<!-- 能耗模块  -->
		<div id="power_supply_skip" class="block"
			style="width: 83.3rem; height: 15.83rem; cursor: pointer;">
			<div style="width: 100%;">
				<div style="width: 48.33rem; height: 2.5rem;">
					<div class="font_item"
						style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">能耗统计</div>
					<div style="float: right; height: 2.33rem;">
						<span
							style="font-family: PingFangSC-Light; font-size: 14px; color: #FFFFFF; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
						<span id="id_pdsAlarmNum"
							style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">--</span>
					</div>
				</div>
			</div>
			<div style="width: 100%; height: 117px;">
				<div
					style="width: 10rem; height: 100%; float: left; margin-left: -8rem; margin-top: 1.67rem;">
					<table style="width: 100%;">
						<tr>
							<td align="right"><span id="id_currentTodayDlp"
								style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 67px; display: block;">--&nbsp;</span>
							</td>
							<td style="width: 3rem; padding-top: 1.8rem;"><span
								style="font-size: 18px; color: #999999; letter-spacing: 0;">kwh</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center"
								style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">当天能耗累积</td>
						</tr>
					</table>
				</div>

				<div
					style="width: 25rem; height: 100%; float: left; margin-left: 14rem; margin-top: 1.67rem;">
					<div>
						<span
							style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">当月能耗累积：</span>
						<span id="id_currentMonthDlp"
							style="font-size: 20px; color: #FFFFFF; letter-spacing: 0;">--</span>
						<span style="font-size: 12px; color: #999999; letter-spacing: 0;">kwh</span>
					</div>
					<div style="margin-top: 18px;">
						<span
							style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">当年能耗累积：</span>
						<span id="id_currentYearDlp"
							style="font-size: 20px; color: #FFFFFF; letter-spacing: 0;">--</span>
						<span style="font-size: 12px; color: #999999; letter-spacing: 0;">kwh</span>
					</div>
				</div>
				<div id="projectPagePdsEchart"
					style="width: 28.5rem; height: 170px; margin-top: -2.75rem; float: left;">
				</div>
			</div>
		</div>
		<!-- 能耗模块  -->
		<div id="div_parking" class="block"
			style="width: 50rem; height: 15.83rem; cursor: pointer;"
			onclick="goParkingMonitoring()">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">停车</div>
				<div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
					<span id="parking_deviceFalutNum"
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">--</span>
				</div>
			</div>
			<div
				style="width: 10rem; margin-top: 1.67rem; margin-left: 4rem; float: left; text-align: center;">
				<span id="parking_inPassageCarNum"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">--</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">车流统计</span>
			</div>
			<div
				style="width: 35%; margin-top: 1.67rem; float: left; text-align: center;">
				<span id="parking_spaceUsedRate"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">--</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">车位使用率</span>
			</div>
			<div id="projectParkingEchart"
				style="height: 110px;float: left; text-align: left; width:195px; padding-left: 1rem;">
			
			
			<!-- 
				<div>
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">入口流量：</span>
					<span id="parking_inPassageCarNum"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">--</span>
				</div>
				<div style="margin-top: 12px;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">出口流量：</span>
					<span id="parking_outPassageCarNum"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">--</span>
				</div>
				-->
			</div>
		</div>
		<div class="block" style="width: 50rem; height: 15.83rem;cursor: pointer;"
			id="project-access-control" onclick="goAccessControl()">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">人行</div>
				<div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
					<span id="project-access-control-abnormal"
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">0</span>
				</div>
			</div>
			<div
				style="width: 30%; margin-top: 1.67rem; float: left; text-align: center;">
				<span id="project-access-control-in"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem;">0</span>
				<span
					style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">客流统计</span>
			</div>
			<div
				style="width: 30%; margin-top: 1.67rem; float: left; text-align: center;">
				<span id="project-access-control-visitor"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem;">0</span>
				<span
					style="font-size: 14px; color: #FFFFFF; padding-top: 30px; padding-left: 4px; text-align: left; width: 30px;">万</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">访客人流量</span>
			</div>
			<div 
				style="height:12rem; float: left; text-align: left; width: 18rem; padding-left: 0rem;">
				<div style="height: 90%; width: 100%" id="project-access-control-report"></div>

			</div>
		</div>
		<div id="video-monitoring-skip" class="block"
			style="width: 31.67rem; height: 15.83rem;cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">视频监控</div>
			</div>
			<div
				style="width: 15rem; margin-top: 1.67rem; float: left; text-align: center;">
				<span id="vm-device-count"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">8</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8">总数</span>
			</div>
			<div
				style="height: 7rem; float: left; text-align: left; width: 13rem; margin-top: 40px; padding-left: 1rem;">
				<div>
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">在线：</span>
					<span id="vm-device-normal"
						style="font-size: 20px; color: #FFFFFF; letter-spacing: 0;">6</span>
				</div>
				<div style="margin-top: 12px;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">离线：</span>
					<span id="vm-device-unnormal"
						style="font-size: 20px; color: #FFFFFF; letter-spacing: 0;">2</span>
				</div>
			</div>
		</div>
		<div id="projectHvacDivId" class="block"
			style="width: 50rem; height: 15.83rem;cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">暖通空调</div>
				<!-- <div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #999999; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
					<span
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">10</span>
				</div> -->
			</div>
			<div
				style="width: 10rem; margin-top: 1.67rem; margin-left: 5.58rem; float: left; text-align: center;">
				<span id="openCount"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">-</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8">开启</span>
			</div>
			<div
				style="height: 7rem; float: left; text-align: left; width: 15rem; margin-top: 1.42rem; padding-left: 1rem;">
				<div style="text-align: center;">
					<img src="${ctx}/static/icon/index/lengji.svg"> <span
						style="font-family: PingFangSC-Regular; font-size: 16px; color: #FFFFFF; letter-spacing: 0; margin-left: 0.83rem; opacity: 0.8">冷机</span>
				</div>
				<div style="margin-top: 0.83rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">出水：</span>
					<!-- <span style="font-size: 18px; color: #999999; letter-spacing: 0;">22℃ 121mpa</span> -->
					<span id="refOutPerssure"
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-</span>
					<!-- <span
						style="font-size: 14px; color: #999999; letter-spacing: 0;">22.5℃
						121.35mpa</span> -->
				</div>
				<div style="margin-top: 0.83rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">回水：</span>
					<!-- <span style="font-size: 18px; color: #999999; letter-spacing: 0;">21℃ 121mpa</span> -->
					<span id="refInPressure"
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-</span>
					<!-- <span
						style="font-size: 14px; color: #999999; letter-spacing: 0;">21.5℃
						121.35mpa</span> -->
				</div>
			</div>
			<div
				style="height: 7rem; float: left; text-align: left; width: 15rem; margin-top: 1.42rem; padding-left: 1rem;">
				<div style="text-align: center;">
					<img src="${ctx}/static/icon/index/nuanlu.svg"> <span
						style="font-family: PingFangSC-Regular; font-size: 16px; color: #FFFFFF; letter-spacing: 0; margin-left: 0.83rem; opacity: 0.8">暖炉</span>
				</div>
				<div style="margin-top: 0.83rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">出水：</span>
					<!-- <span style="font-size: 18px; color: #999999; letter-spacing: 0;">22℃ 121mpa</span> -->
					<span id="boiOutPerssure"
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-</span>
					<!-- <span
						style="font-size: 14px; color: #999999; letter-spacing: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-
					</span> -->
				</div>
				<div style="margin-top: 0.83rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">回水：</span>
					<!-- <span style="font-size: 18px; color: #999999; letter-spacing: 0;">21℃ 121mpa</span> -->
					<span id="boiInPressure"
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-</span>
					<!-- <span
						style="font-size: 14px; color: #999999; letter-spacing: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-
					</span> -->
				</div>
			</div>
		</div>
		<div id="supply_drain_skip" class="block"
			style="width: 50rem; height: 15.83rem; cursor: pointer;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">给排水</div>
				<div style="float: right; height: 1.64rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; display: table-cell; vertical-align: middle;">设备异常：</span>
					<span id="supply_drain_fault"
						style="font-size: 20px; color: #F37B7B; letter-spacing: 0; display: table-cell;">1</span>
				</div>
			</div>
			<div
				style="width: 10rem; margin-top: 1.67rem; margin-left: 5.58rem; float: left; text-align: center;">
				<span id="booster_pump"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">21</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8">增压泵</span>
			</div>
			<div
				style="margin-top: 2.41rem; float: left; width: 8rem; margin-left: 2rem;">
				<div>
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">开启：</span>
					<span id="bp_open"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">6</span>
				</div>
				<div style="margin-top: 1.25rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">关闭：</span>
					<span id="bp_close"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">2</span>
				</div>
			</div>
			<div
				style="width: 10rem; margin-top: 1.67rem; float: left; text-align: center;">
				<span id="submersible_pump"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">21</span>
				<span
					style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8;">潜水泵</span>
			</div>
			<div style="margin-top: 2.41rem; float: left; width: 10rem;">
				<div>
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">开启：</span>
					<span id="sp_open"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">6</span>
				</div>
				<div style="margin-top: 1.25rem;">
					<span
						style="font-size: 14px; color: #FFFFFF; letter-spacing: 0; opacity: 0.8;">关闭：</span>
					<span id="sp_close"
						style="font-size: 18px; color: #FFFFFF; letter-spacing: 0;">2</span>
				</div>
			</div>
		</div>
		<div class="block" style="width: 31.67rem; height: 15.83rem;">
			<div style="width: 100%; height: 2.5rem; float: left;">
				<div class="font_item"
					style="height: 2.75rem; line-height: 2.75rem; width: 10rem;">照明</div>
			</div>
			<div
				style="width: 15rem; margin-top: 1.67rem; float: left; text-align: center;">
				<span id="lighting_num"
					style="font-size: 48px; color: #FFFFFF; letter-spacing: 0; line-height: 5.58rem; display: block;">8</span>
				<span
					style="font-size: 16px; color: #FFFFFF; letter-spacing: 0; display: block; height: 1.67rem; opacity: 0.8">照明设备</span>
			</div>
		</div>
	</div>
	<div id="ffm_page"></div>
	<div id="error-div"></div>
</body>
<script type="text/javascript">
	var normal = 0;
	var abnormal = 0;
	// 正常主机数量（即主机未离线数量）与非正常数量
	var hostFlag = false;
	var hostNormal = 0;
	var hostAbnormal = 0;

	// 正常电表数量（无故障）与非正常数量
	var electricFlag = false;
	var electricNormal = 0;
	var electricAbnormal = 0;

	// 正常电梯数量（无报警）与非正常数量
	var elevatorFlag = false;
	var elevatorNormal = 0;
	var elevatorAbnormal = 0;

	// 停车场正常设备（未离线）总数与非正常数量
	var vehicleFlag = false;
	var vehicleNormal = 0;
	var vehicleAbnormal = 0;

	// 人行出入正常设备（未离线）与非正常数量
	var peopleFlag = false;
	var peopleNormal = 0;
	var peopleAbnormal = 0;

	// 暖通正常设备总数（无故障）与非正常数量
	var havcFlag = false;
	var havcNormal = 0;
	var havcAbnormal = 0;

	// 给排水正常总数（无故障）与非正常数量
	var waterFlag = false;
	var waterNormal = 0;
	var waterAbnormal = 0;

	// 监控相机正常总数与非正常数量
	var cameraFlag = false;
	var cameraNormal = 0;
	var cameraAbnormal = 0;

	var projectAccessControlDeviceNo;
	var flushFiresTime;
	var flushProjectAccessControl;
	var g_gatewayAddr;
	var ctx = '${ctx}';
	var firesMaxTime = 0;
	$(document).ready(
			function() {
				hiddenScroller();
				//项目统计
				getProjectAllDeviceCount();
				projectDeviceStateDatas(normal, abnormal);
				//showTime();
				//电梯模块
				getElevatorData(100, "elevator");
				elevatorStatusData();
				getProjectAccessControlData(1);//初始化
				getParkingProjectData();
				getElevatorAndAlarmData();
				if (typeof (flushProjectAccessControl) != "undefined") {
					//防止多次加载产生多个定时任务
					clearTimeout(flushProjectAccessControl);
				}
				flushProjectAccessControl = setTimeout(
						"flushProjectAccessControlData()", 60000);

				if (typeof (flushProjectParking) != "undefined") {
					//防止多次加载产生多个定时任务
					clearTimeout(flushProjectParking);
				}
				flushProjectParking = setTimeout("flushProjectParkingData()",
						60000);
				//能耗模块
				getPdsData();
				getPdsEchart(106, "projectPagePdsEchart");
				//视频监控
				getVideoMonitoringData();
				//消防模块
				getData(114, "ffm_master");
				getFireFightingProjectData();

				if (typeof (flushProjectPageGrid) != "undefined") {
					//防止多次加载产生多个定时任务
					clearTimeout(flushProjectPageGrid);
				}
				flushProjectPageGrid = setTimeout("flushGrid()", 60000);

				hvac();
				getSupplyDrain();

				toSubscribe();
				//查询当期项目下照明设备总数
				lightingDeviceNum();
				
				//停车场饼图
				getBingEchart(123,"projectParkingEchart");

			});

	function getData(id, divId) {
		$.ajax({
			type : "post",
			url : ctx + "/report/" + id + "?projectCode=" + projectCode,
			async : true,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				var obj = echarts.init(document.getElementById(divId));
				obj.setOption($.parseJSON(data));
				clickEvent(id, obj);
			},
			error : function(req, error, errObj) {
			}
		});
	}

	//项目首页电梯监控报表
	function getElevatorData(id, divId) {
		$.ajax({
			type : "post",
			url : ctx + "/report/" + id + "?projectCode=" + projectCode,
			async : true,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				var objs = JSON.parse(data);
				var running = objs.series[0].data[0].value;
				var runningName = objs.series[0].data[0].name;
				if (runningName.trim() == "运行") {
					$("#elevator_running").html(running);
				} else {
					$("#elevator_overhaul").html(running);
				}
				var overhaul = objs.series[0].data[1].value;
				var overhaulName = objs.series[0].data[1].name;
				if (overhaulName.trim() == "检修") {
					$("#elevator_overhaul").html(overhaul);
				} else {
					$("#elevator_running").html(overhaul);
				}
				var obj = echarts.init(document.getElementById(divId));
				obj.setOption($.parseJSON(data));
				clickEvent(id, obj);
			},
			error : function(req, error, errObj) {
			}
		});
	}

	function flushGrid() {
		if (typeof (flushProjectPageGrid) != "undefined"
				&& 'undefined' != typeof ($("#supply_elevator_skip").val())) {
			getData(106, "projectPagePdsEchart");
			getElevatorData(100, "elevator");
			flushProjectPageGrid = setTimeout("flushGrid()", 60000);
		}
	}

	function getPdsEchart(id, divId) {
		var currentYear = '${currentYear}';
		$.ajax({
			type : "post",
			url : ctx + "/report/" + id + "?projectCode=" + projectCode
					+ "&yearNum=" + currentYear,
			async : true,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				var obj = echarts.init(document.getElementById(divId));
				obj.setOption($.parseJSON(data));
				clickEvent(id, obj);
			},
			error : function(req, error, errObj) {
			}
		});
	}
	
	function hiddenScroller() {
		var height = $(window).height();
		if (height > 1060) {
			document.documentElement.style.overflowY = 'hidden';
			$(".modal-open .modal").css("overflow-y", "hidden");
			document.documentElement.style.overflowX = 'hidden';
			$(".modal-open .modal").css("overflow-x", "hidden");
		}else if(height == 943 || height == 926){
			document.documentElement.style.overflowY = 'auto';
			$(".modal-open .modal").css("overflow-y", "auto");
			document.documentElement.style.overflowX = 'hidden';
			$(".modal-open .modal").css("overflow-x", "hidden");
		}else {
			document.documentElement.style.overflowY = 'auto';
			$(".modal-open .modal").css("overflow-y", "auto");
			document.documentElement.style.overflowX = 'auto';
			$(".modal-open .modal").css("overflow-x", "auto");
		}
		
	}

	$(window).resize(function() {
		hiddenScroller();
	});
</script>
</html>