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
<link href="${ctx}/static/css/feManageSystem.css" type="text/css"
	rel="stylesheet" />
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
	rel="shortcut icon">
<link
	href="${ctx}/static/component/jquery-validation/1.11.1/validate.css"
	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/jquery.classycountdown.css" type="text/css" rel="stylesheet"/>

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
<script type="text/javascript"
	src="${ctx}/static/busi/feManageSystem.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/scroll.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/canvas/jquery.classycountdown.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/canvas/jquery.knob.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/canvas/jquery.throttle.js"></script>



<title>设施设备系统</title>
<style type="text/css">
.bg_img {
	width: 1920px;
/* 	height: 1080px;  */
z-index: -1;
 	background-image: url('${ctx}/static/img/feManageSystem/bg.png');
}
.alarmSpot{
color: #FFFFFF;
font-size: 14px;
font-family: PingFangSC-Regular;
letter-spacing: 0.17px;
}
.radars {
  background: url("${ctx}/static/img/scanning.png") no-repeat center;
  position: relative;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  border-radius: 50%;
  border: 0.2rem solid #26488D;
  overflow: hidden;
}
.radar:before {
  content: ' ';
  display: block;
  position: absolute;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  animation: blips 5s infinite;
  animation-timing-function: linear;
  animation-delay: 1.4s;
}
.radar:after {
  content: ' ';
  display: block;
  background-image: linear-gradient(44deg, rgba(0,115,255,0) 50%, #0CB1E9 100%);
  width: 50%;
  height: 50%;
  position: absolute;
  top: 0;
  left: 0;
  animation: radar-beam 5s infinite;
  animation-timing-function: linear;
  transform-origin: bottom right;
  border-radius: 100% 0 0 0;
}

.normal {
  background: #156C47;
}

.abnormal {
  background: #A82912;
}

@keyframes radar-beam {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
</head>
<body class="bg_img">
<div style="position: absolute;" class="bg_img"><canvas id="space"></canvas></div>
<div style="positon:absolute;">
	<div class="left_content">
		<div style="width: 460px; height: 315px; margin-top: 30px;"
			class="boder">
			<div class="head">
				<div class="head_font">
					<span class="fire_font">当前火警</span><span class="fire_font"
						id="fires_num">0</span>
				</div>
				<div style="float: right;">
					<img style="height: 40px;"
						src="${ctx}/static/img/feManageSystem/BEI.png">
				</div>
			</div>
			<div style="width: 460px; height: 275px;">
				<div style="width: 460px; height: 244px;" id="fire_alarm_bar"></div>
				<div class="fire_deal">
					<span class="fire_deal">火警未处理最长时长：</span><span class="fire_deal"
						id="firesMaxTime">--天--小时--分钟</span>
				</div>
			</div>
		</div>
		<div style="width: 460px; height: 280px; margin-top: 25px;"
			class="boder">
			<div class="head">
				<div class="head_font">能耗趋势</div>
				<div style="float: right;">
					<img style="height: 40px;"
						src="${ctx}/static/img/feManageSystem/BEI.png">
				</div>
			</div>
			<div  id="energy_consumption_trend" style="width: 460px; height: 240px;">
				<div id="energy_consumption_Echart" style="width: 460px; height: 210px;"></div>
			</div>
		</div>

		<div style="width: 460px; height: 377px; margin-top: 25px;"
			class="boder">
			<div class="head">
				<div class="head_font">客流量分析</div>
				<div style="float: right;">
					<img style="height: 40px;"
						src="${ctx}/static/img/feManageSystem/BEI.png">
				</div>
			</div>
			<div style="width: 460px; height: 336px;">
				<div  id ="customer_flow"style="width: 460px; height: 305px;"></div>
			</div>
		</div>
	</div>

	<div class="center_content">
		<div class="title_img"
			style="background-image: url('${ctx}/static/img/feManageSystem/title.png');">
			<div class="system_title">西子国际设施设备系统</div>
		</div>

		<div style="width: 945px; height: 512px; margin-top: 15px;"
			class="boder">
			<div class="device_total">总设备数</div>
			<!-- 总设备开始 -->
			<div id="deviceNum" class="device_num1"
				style="height: 97.1px; margin-top: 5px;">
				<div id="num1" hidden="true" class="number">1</div>
				<div id="num2" hidden="true" class="number">2</div>
				<div id="num3" hidden="true" class="number">3</div>
				<div id="num4" hidden="true" class="number">4</div>
				<div id="num5" hidden="true" class="number">5</div>
				<div id="num6" hidden="true" class="number">6</div>
				<div id="num7" hidden="true" class="number">7</div>
			</div>
			<!-- 总设备结束 -->
			<div style="width: 945px; margin-top: 28.9px;">
				<div style="width: 254px; float: left;">
					<div class="item_title">消防维保进度</div>
					<div class="item_div" id="fire_main">
					
					</div>
				</div>
				<div style="width: 429px; float: left;">
					<div class="item_title" style="margin-left: 23px; width: 144px;">系统实时动态</div>
					<div class="item_center">
						<ul>
							<li class="item_text">
								<p>
									<span class="span_text">2017-12-09 07:50 排风机开启</span>
								</p>
							</li>
							<li class="item_text">
								<p>
									<span class="span_text">2017-12-08 22:42 新风机关闭</span>
								</p>
							</li>
							<li class="item_text">
								<p>
									<span class="span_text">2017-12-08 22:42  排风机开启</span>
								</p>
							</li>
							<li class="item_text">
								<p>
									<span class="span_text">2017-12-08 21:30 排风机关闭</span>
								</p>
							</li>
							<li class="item_text">
								<p>
									<span class="span_text">2017-12-08 20:30 排风机关闭</span>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div style="width: 259px; float: left;">
					<div class="item_title">设备完好</div>
					<div id="deviceChart" class="item_div"></div>
				</div>
			</div>
		</div>
		<div style="width: 945px; height: 402px;position: relative;">
			<div
				style="width: 460px; height: 377px; margin-top: 25px; position:absolute;"
				class="boder">
				<div class="head">
					<div class="head_font">系统健康等级</div>
					<div style="float: right;">
						<img style="height: 40px;"
							src="${ctx}/static/img/feManageSystem/BEI.png">
					</div>
				</div>
				<div style="width: 460px; height: 336px;">
					<div id="HEALTH_FIRE_FIGHTING" class="health_item">
						<div class="health_item_name">消防</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_ELEVATOR" class="health_item">
						<div class="health_item_name">电梯</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_POWER_SUPPLY" class="health_item">
						<div class="health_item_name">供配电</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_HVAC" class="health_item">
						<div class="health_item_name">暖通</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_SUPPLY_DRAIN" class="health_item">
						<div class="health_item_name">给排水</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_PARKING" class="health_item">
						<div class="health_item_name">停车</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_ACCESS_CONTROL" class="health_item">
						<div class="health_item_name">人行</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
					<div id="HEALTH_VIDEO_MORNITORING" class="health_item">
						<div class="health_item_name">视频</div>
						<div class="health_bar">
							<div class="health_back"></div>
							<div class="health_value"></div>
						</div>
						<div class="health_text">98分</div>
						<div class="health_level health_alarm">告警</div>
					</div>
				</div>
			</div>

			<div
				style="width: 460px; height: 377px; margin-top: 25px; left: 480px; position:absolute;"
				class="boder">
				<div class="head">
					<div class="head_font">设备数量分布图</div>
					<div style="float: right;">
						<img style="height: 40px;"
							src="${ctx}/static/img/feManageSystem/BEI.png">
					</div>
				</div>
				<div style="width: 460px; height: 336px;">
					<div id="device_num_Echart" style="width: 327.3px; height: 327.3px; margin: auto;"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="right_content">
	
		<div style="width: 400px; height: 490px; margin-top: 27px;"
			class="boder">
			<div class="head">
				<div class="head_font">设备异常实时扫描</div>
				<div style="float: right;">
					<img style="height: 40px;"
						src="${ctx}/static/img/feManageSystem/BEI.png">
				</div>
			</div>
			<div style="width: 400px; height: 336px;">
				<div class="radars" style="width: 250px; height: 250px; margin-right: auto; margin-top: 48px;">
				<div class="radar" style="width: 250px; height: 250px;margin:16px;"></div>
				</div>
				<div class="leida_text" style="margin-top: 85px;">
					共扫描到<span id="alarmDeviceCount" class="red_num"></span>异常设备
				</div>
				
				<div id="xs1" class="alarmSpot" style="margin-top: -137px;margin-left: 170px;">
					<span class="" style="color:#2AE395;letter-spacing: -2.83px;">●</span>
					<span id="xf"></span>
				</div>
				
				<div id="xs2" class="alarmSpot" style="margin-top: -50px;margin-left: 99px;">
					<span class="" style="color:#B40D60;letter-spacing: 3.17px;">●</span>
					<span id="rx"></span>
				</div>
				
				<div id="xs3" class="alarmSpot" style="margin-top: -16px;margin-left: 208px;">
					<span class="" style="color:#F7FF00;letter-spacing: 3.17px;">●</span>
					<span id="gps"></span>
				</div>
				
				<div id="xs4" class="alarmSpot" style="margin-top: -62px;margin-left: 93px;">
					<span class="" style="color:#56D6DE;letter-spacing: 3.17px;">●</span>
					<span id="gpd"></span>
				</div>
				
				<div id="xs5" class="alarmSpot" style="margin-top: -65px;margin-left: 93px;">
					<span class="" style="color:#D22AE3;letter-spacing: 3.17px;">●</span>
					<span id="ntkt"></span>
				</div>
				
				<div id="xs6" class="alarmSpot" style="margin-top: -53px;margin-left: 161px;">
					<span class="" style="color:#BC873F;letter-spacing: 3.17px;">●</span>
					<span id="dt"></span>
				</div>
				
				<div id="xs7" class="alarmSpot" style="margin-top: 88px;margin-left: 161px;">
					<span class="" style="color:#70FF08;letter-spacing: 3.17px;">●</span>
					<span id="tcc"></span>
				</div>
				
				<div id="xs8" class="alarmSpot" style="margin-top: -58px;margin-left: 192px;">
					<span class="" style="color:#0074E3;letter-spacing: 3.17px;">●</span>
					<span id="spjk"></span>
				</div>
			</div>
		</div>
		
		<div style="width: 400px; height: 506px; margin-top: 28px;"
			class="boder">
			<div class="head">
				<div class="head_font">实时</div>
				<div style="float: right;">
					<img style="height: 40px;"
						src="${ctx}/static/img/feManageSystem/BEI.png">
				</div>
			</div>
			<div style="width: 400px; height: 466px;overflow: hidden;">
				<div class="realtime_block" style="">
					<div id="monitor_fire_fighting" class="realtime_text" >正在监听消防系统心跳</div>
					<div class="realtime_img"><img id="monitor_fire_fighting_img" class="item-img" src="${ctx}/static/images/ecgcurve.png"/></div>
					<div id="monitor_fire_fighting_state" class="realtime_status normal">正常</div>
				</div>
				<div class="realtime_block">
					<div id="monitor_elevator" class="realtime_text">正在监听电梯系统心跳</div>
					<div class="realtime_img"><img id="monitor_elevator_img" class="item-img" src="${ctx}/static/images/ecgcurve.png"/></div>
					<div id="monitor_elevator_state" class="realtime_status normal">正常</div>
				</div>
				<div class="realtime_block">
					<div id="monitor_hvac" class="realtime_text">正在监听暖通系统心跳</div>
					<div class="realtime_img"><img id="monitor_hvac_img" class="item-img" src="${ctx}/static/images/ecgcurve.png"/></div>
					<div id="monitor_hvac_state" class="realtime_status normal">正常</div>
				</div>
				<div class="realtime_block">
					<div id="monitor_access_control" class="realtime_text">正在监听人行系统心跳</div>
					<div class="realtime_img"><img id="monitor_access_control_img" class="item-img" src="${ctx}/static/images/ecgcurve.png"/></div>
					<div id="monitor_access_control_state"class="realtime_status normal">正常</div>
				</div>
				<div class="realtime_block">
					<div id="monitor_supply_drain" class="realtime_text">正在监听给排水系统心跳</div>
					<div class="realtime_img"><img id="monitor_supply_drain_img" class="item-img" src="${ctx}/static/images/ecgcurve.png"/></div>
					<div id="monitor_supply_drain_state"class="realtime_status normal">正常</div>
				</div>
				<div class="realtime_block">
					<div id="monitor_power_supply" class="realtime_text">正在监听供配电系统心跳</div>
					<div class="realtime_img"><img id="monitor_power_supply_img" class="item-img" src="${ctx}/static/images/ecgcurve.png"/></div>
					<div id="monitor_power_supply_state"class="realtime_status normal">正常</div>
				</div>
			</div>
		</div>
</div>
	</div>
</body>
<script type="text/javascript">
	var isConnectedGateWay = false;
	var projectCode = "${param.projectCode}";
	var ctx = "${ctx}";
	var projectId = "${param.projectId}";
	var flushFiresTime;
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
var cameraNormal=0;
var cameraAbnormal=0;
var point1;
var point2;
var point3;
var point4;
var point5;
var point6;
var point7;
var point8;
var point9;
var point10;
var point11;
var point12;
var point13;
var point14;
var point15;
var point16;
var point17;
var point18;
var point19;
var feCategoryTime;


$(document).ready(function(){
	hiddenScroller();
	getProjectAllDeviceCount();
	getSubsystemNormalCount();
	//websocket
	setTimeout("startConn('" + ctx + "')", 3000);
	if(typeof(feCategoryTime) != "undefined"){
		//防止多次加载产生多个定时任务
		clearTimeout(feCategoryTime);
	}
	handleCategoryInfo();
	// 处理定时器
	handleSetTime();
	pointIsDisplay();
	getHeartbeatData();
	getEneryConEchart(118,"energy_consumption_Echart");
	getFireFightingProjectData();
	// 加载设备数量分布图
	getDeviceNumEchart("device_num_Echart");
	//获取设备健康状态
	getDeviceHealth();
	//客流分析
	csOrCarFlow();
	//系统实时动态
	$("div.item_center").myScroll({
		speed:10, //数值越大，速度越慢
		rowHeight:28 //li的高度
	});
});

//能耗趋势，查询报表
function getEneryConEchart(id, divId) {
	$.ajax({
	    type : "post",
	    url : ctx+"/report/" + id+"?projectCode="+projectCode,
	    async : true,
	    contentType : "application/json;charset=utf-8",
	    success : function(data) {
		var obj = echarts.init(document.getElementById(divId));
		var option = $.parseJSON(data);
		if(option.series[0].name=="用电量"){
			option.series[0].itemStyle.normal.color=new echarts.graphic.LinearGradient(
	                0, 0, 0, 1,
	                [
	                    {offset: 0, color: '#76DDFB'},
	                    {offset: 1, color: '#53A8E2'}
	                ]
	            );
			option.series[1].itemStyle.normal.color="#EF5D0B";
		}else if(option.series[0].name=="往年用电量"){
			option.series[1].itemStyle.normal.color=new echarts.graphic.LinearGradient(
	                0, 0, 0, 1,
	                [
	                    {offset: 0, color: '#76DDFB'},
	                    {offset: 1, color: '#53A8E2'}
	                ]
	            );
			option.series[0].itemStyle.normal.color="#EF5D0B";
		}
		option.yAxis[0].splitLine.color=new echarts.graphic.LinearGradient(
                0, 0, 0, 1,
                [
                    {offset: 0, color: '#F5F7F8'},
                    {offset: 1, color: '#E7EBEF'}
                ]
            );
		obj.setOption(option);
	    },
	    error : function(req, error, errObj) {
	    }
	});
}
//报警轮播
var queueArray = new Array();
var queueId = null;
var isDealing = false;
function dequeueArray(){
	if(!isDealing && queueArray.length > 0){
		$(".span_text").last().html(queueArray.shift());
	}
}
setInterval(function(){
	dequeueArray();
});
//系统实时动态
function dynamicSysData(json){
		var workStatus = json.data.workStatus==1?"开启":"关闭";
		var deviceName = json.data.deviceName;
		var text =deviceName+workStatus;
		var nowDate = json.data.nowDate.substring(0, 16);
		if(text.length >= 11){
			text = text.substring(0, 11)+ "...";
		}
		queueArray.push(nowDate+" "+text);
}

//客流量分析
function csOrCarFlow(){
	//发送三个请求查询，人行出入数量，车辆出入数量，时间轴
	var customerNum=new Array();
	var carNum=new Array();
	var time=new Array();
	$.ajax({
		type : "post",
		url : ctx+"/system/homePageOrganize/getPeopleAndCarFlow?projectCode="+projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data.code==0){
				customerNum = data.data.customerFlowVOs;
				carNum=data.data.carFlowVOs;
				time=data.data.timeCoordinateVOs;
				initCsOrCarFlow(customerNum,carNum,time);
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
						null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
//客流量分析数据echarts页面拼装
function initCsOrCarFlow(customerNum,carNum,time){
	var obj = echarts.init(document.getElementById("customer_flow"));
	var	option = {
			title: {
		        text: ''
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    color:['#00E6FF','#8D4DE8'],
		    legend: {
	        x: 'right', 
	        y:'top',
		    data:['人流量','车流量'],
		    textStyle: {
	            color: '#FFFFFF',
	            fontSize:12
	          },
		    icon:'circle'
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            axisLabel : {
		            	textStyle : {
						color: '#FFFFFF',
				        fontSize:10
			            }
		            },
		            data : [time[0].timeCoordinate,time[1].timeCoordinate,time[2].timeCoordinate,time[3].timeCoordinate,time[4].timeCoordinate,time[5].timeCoordinate]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel : {
			            textStyle:{
							color: '#FFFFFF',
					        fontSize:10
				            }
			            },
		        }
		    ],
		    series : [
		        {
		            name:'人流量',
		            type:'line',
		            smooth:true,//线条曲线化
		            areaStyle: {
						normal: {
							 color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
			                        offset: 0,
			                        color: 'rgb(11,120,152)'
			                    }, {
			                        offset: 1,
			                        color: 'rgb(0,230,255)'
			                    }])
		            	}
		        	},
		        	data:[customerNum[0].customerFlowNum,customerNum[1].customerFlowNum,customerNum[2].customerFlowNum,customerNum[3].customerFlowNum,customerNum[4].customerFlowNum,customerNum[5].customerFlowNum]
		        },
		        {
		            name:'车流量',
		            type:'line',
		            smooth:true,
		            areaStyle: {
 		            	normal: {
		            		color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
		                        offset: 1,
		                        color: 'rgb(18,72,108)'
		                    }, {
		                        offset: 0,
		                        color: 'rgb(43, 104, 166)'
		                    }])
 			            }
			        },
		          data:[carNum[0].carFlowNum, carNum[1].carFlowNum, carNum[2].carFlowNum, carNum[3].carFlowNum, carNum[4].carFlowNum, carNum[5].carFlowNum]
		        }
		    ]
		};
	obj.setOption(option);
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