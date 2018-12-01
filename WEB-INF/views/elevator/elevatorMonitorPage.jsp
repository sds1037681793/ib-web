<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="${ctx}/static/css/elevatorMonitorPage.css" rel="stylesheet" />
<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
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
<script type="text/javascript" src="${ctx}/static/busi/main.js"></script>
<script type="text/javascript" src="${ctx}/static/busi/operator-system/operateSystemElevator.js"></script>
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/css/modleIframeBlue.css" type="text/css" rel="stylesheet" />

<title>电梯运行监控界面</title>
<style>
 .elevatorAlarm{
     animation: twinkling 1s infinite ease-in-out ;
     -webkit-animation: twinkling 1s infinite ease-in-out ; 
      -moz-animation: twinkling 1s infinite ease-in-out ; 
 }
 #elevator-detail-modal .modal-content{
	background: none;
 }
 #elevator-detail-iframe {
 	border: none;
 }
 .modal-header .close {
    margin-top: 2px;
}
 .animated{  
  -moz-animation-duration: 1s; 
  -webkit-animation-duration: 1s;  
  animation-duration: 1s;  
  -moz-animation-fill-mode: both; 
  -webkit-animation-fill-mode: both;  
  animation-fill-mode: both  
 }  
 @-webkit-keyframes twinkling{  
     0%{  
         opacity: 0.2;  
     }  
     100%{  
         opacity: 1;  
     }  
 }  
 @keyframes twinkling{  
     0%{  
         opacity: 0.2;  
     }  
     100%{  
         opacity: 1;  
     }  
 } 
  @-moz-keyframes twinkling{  
     0%{  
         opacity: 0.2;  
     }  
     100%{  
         opacity: 1;  
     }  
 } 
 .elevator-real-time-data {
position: absolute;
border: 1px solid rgba(151, 255, 250, 0.4);
background: rgba(0, 7, 49, 0.6);
height: 60px;
text-align: center;
line-height: 61px;
font-size: 39px;
color: #56E4FF;
letter-spacing: 1.67px;
margin-top: -1px;
width: 360px;
}
.head_elevator {
	height: 46px;
	width: 100%;
	border-bottom: 1px solid rgba(151, 255, 250, 0.2);
}
.head_elevator_font {
	font-size: 20px;
	color: #56E4FF;
	letter-spacing: 0.67px;
	line-height: 46px;
}
.elevator_boder {
	border: 1px solid rgba(151, 255, 250, 0.4);
	background: rgba(0, 7, 49, 0.6);
}
.alarm_num{
	height:20px;
	margin-left:10px;
	font-family: PingFangSC-Regular;
	font-size: 14px;
	color: #FFFFFF;
	letter-spacing: 0.47px;
	float:left;
}
.alarm_name{
	height:20px;
	font-family: PingFangSC-Regular;
	font-size: 14px;
	color: #FFFFFF;
	letter-spacing: 0.47px;
	width:73px;
	float:left;
}
</style>
</head>
<body>
	<div id="bgs" class="elevatorMonitor">

		<!--第一个电梯-->
		<div id="elevatorOne" class="elevator" style="display:none;cursor: pointer;">
		<div class="floorsOne" id="elevatorOne-floorsWindow">
		<p>
			<span id="elevatorOne-floorSpan"></span>
		</p>
		</div>
			<div id="elevatorOne-dialog" style="display:none;">
				<div class="arrow"></div>
				<div class="windows" id="elevatorOne-word">
					<div>
						<img id="elevatorOne-face"  src="${ctx}/static/images/elevator/portrait.png">
					</div>
					<p>
						<span id="elevatorOne-span"></span>
					</p>
				</div>
			</div>
			<div id="elevatorOne-run" style="position:absolute; top:129px;">
				<p>
					<img id="elevatorOne-image"  src="${ctx}/static/images/elevator/diantiicon.png">
                    <img id="elevatorOne-images" src="${ctx}/static/images/elevator/weibaoicon.png" style="display:none; position: absolute; left:13px;">
				</p>
			</div>
		</div>


		<!--第二个电梯-->

		<div id="elevatorTwo" class="elevators" style="display:none;cursor: pointer;">
		<div class="floorsTwo" id="elevatorTwo-floorsWindow">
		<p>
			<span  id="elevatorTwo-floorSpan"></span>
		</p>
		</div>
			<div id="elevatorTwo-dialog" style="display:none;">
				<div class="arrow"></div>
				<div class="windows" id="elevatorTwo-word">
					<div>
						<img id="elevatorTwo-face"  src="${ctx}/static/images/elevator/portrait.png">
					</div>
					<p>
						<span  id="elevatorTwo-span"></span>
					</p>
				</div>
			</div>
			<div id="elevatorTwo-run" style="position:absolute; top:129px;">
				<p>
					<img id="elevatorTwo-image"  src="${ctx}/static/images/elevator/diantiicon.png">
                    <img id="elevatorTwo-images" src="${ctx}/static/images/elevator/weibaoicon.png" style="display:none; position: absolute; left:13px;">
				</p>
			</div>
		</div>
		<!--第三个电梯-->
		<div id="elevatorThree" class="elevatorthree" style="display:none;cursor: pointer;">
		<div class="floorsThree" id="elevatorThree-floorsWindow">
		<p>
			<span id="elevatorThree-floorSpan"></span>
		</p>
		</div>
			<div id="elevatorThree-dialog"  style="display:none;">
				<div class="arrow"></div>
				<div class="windowThree" id="elevatorThree-word">
					<div>
						<img id="elevatorThree-face"  src="${ctx}/static/images/elevator/portrait.png">
					</div>
					<p>
						<span id="elevatorThree-span"></span>
					</p>
				</div>
			</div>
			<div id="elevatorThree-run" style="position:absolute; top:129px;">
				<p>
					<img id="elevatorThree-image" src="${ctx}/static/images/elevator/diantiicon.png">
                    <img id="elevatorThree-images" src="${ctx}/static/images/elevator/weibaoicon.png" style="display:none; position: absolute; left:13px;">
				</p>
			</div>
		</div>
	</div>
 <div id="elevator-detail"></div>
 <div class="elevatorright" style="width: 360px; left: 1530px; top: 10px; position: absolute; z-index: 2;">
 <div class="elevator-real-time-data" >D座电梯实时数据</div>
 <div style="width: 360px; height: 391px; margin-top: 77px;" class="elevator_boder">
		<div class="head_elevator" style="margin: 0px 0px -24px 2px;">
			<div class="head_elevator_font" style="	margin: 0px 0px -47px 10px;float: left;">电梯当前健康状态评估</div>
			<div style="float: right;">
				<img alt="" src="${ctx}/static/images/operator-system/xiexian.svg">
			</div>
		</div>
	</div>
	<img style="margin: -365px 0px 0px 44px;" src="${ctx}/static/images/elevator/elevator_health.png">
  <div style="width: 360px; height: 250px; margin-top:0px;" class="elevator_boder">
		<div class="head_elevator" style="margin: 0px 0px -24px 2px;">
			<div class="head_elevator_font" style="margin:0px 0px 0px 8px;">电梯今年维保超期次数统计</div>
			<div style="float: right;">
				<img alt="" style="margin: -70px 0px 0px 44px;" src="${ctx}/static/images/operator-system/xiexian.svg">
			</div>
		</div>
		<div id="pie" class="pie">
		</div>
				<!-- 维保超期分析报表 -->
		<div style="width: 360px; height: 205px;margin-top: 21px;">
			<!--此处为饼图报表 -->
		   <div id="maintenance_reportForms" style="width: 360px; height: 205px;margin: -30px 0px 0px -9px; "></div>
		</div>
	</div>
	 <div style="width: 360px; height: 250px; margin-top:18px;" class="elevator_boder">
			<div class="head_elevator" style="margin: 0px 0px -24px 2px;">
				<div class="head_elevator_font" style="margin:0px 0px 0px 8px;">电梯历史报警类型排名</div>
				<div style="float: right;">
					<img alt="" style="margin: -70px 0px 0px 44px;" src="${ctx}/static/images/operator-system/xiexian.svg">
				</div>
			</div>
			<div style="width: 360px; height: 205px;margin-top: 20px; ">
				<!--此处为饼图报表 -->
			  <div  id='alaram_top_list_content'  style='padding-top:20px;width: 95%; height: 205px;margin:0 auto;position: absolute;'>
			  
			  </div>
			</div>
		</div>
 </div>
</body>
<script>
	var alermTimer=null; 
	var projectCode =parent.projectCode;
	var ctx = "${ctx}";
	var floorMap = new Map();
	$(document).ready(function() {
	
		var elevatorOne = {
			elevatorId : "elevatorOne",
			elevatorNo : "31103301032014125006",
			timer : null,
			listenerTimer : null,
			status : 0,  			//0 电梯停止运行状态 1电梯运行状态
			alarmStatus : 0,		//0 电梯报警恢复状态 1电梯报警状态
			maintenanceStatus : 0,	//0 电梯维保未超时  1电梯维保超时 
			height : 0,
			currentFloor : 0,
			targetFloors : [],
			pushMessage : []
		};
		var elevatorTwo = {
			elevatorId : "elevatorTwo",
			elevatorNo : "156565613212121322223",
			timer : null,
			listenerTimer : null,
			status : 0,
			alarmStatus : 0,
			maintenanceStatus : 0,
			height : 0,
			currentFloor : 0,
			targetFloors : [],
			pushMessage : []

		};
		var elevatorThree = {
			elevatorId : "elevatorThree",
			elevatorNo : "31103301042014095060",
			timer : null,
			listenerTimer : null,
			status : 0,
			alarmStatus : 0,	
			maintenanceStatus : 0,
			height : 0,
			currentFloor : 0,
			targetFloors : [],
			pushMessage : []

		};

		var elevatorObjs = [
				elevatorOne, elevatorTwo, elevatorThree
		];
		var maxheight = 870;
		var minheight = -80;
		var countHeight = 972; //楼层总高度
		var countfloor = 36;//楼层总层数
		var floorHight = Number(Number(countHeight) / Number(countfloor));//单层楼层高度
		for(var i =-3;i<=33;i++){
			floorMap.set(floorHight * i,i);
		}
		setTimeout(startConn, 1000);
		setTimeout(getEvelatorData, 2000);
		setTimeout(elevatorListener(0), 3000);
		setTimeout(elevatorListener(1), 3000);
		setTimeout(elevatorListener(2), 3000);
		init();
		findCurrentFloor();
		//今年维保超期
		var date = new Date();
		var thisYear = date.getFullYear();
		getElevatorBingEchart(139,"maintenance_reportForms",thisYear);
		alarmTopList();
		function init(){
			$.ajax({
				type : "post",
				url : ctx + "/elevator/elevatorDataService/getElevatorStatusList?projectCode="+projectCode, 
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				async : false,
				success:function(data){
					if (data && data.code == 0 && data.data) {
						var elevatorList = data.data.elevatorDataList;
						$.each(elevatorList, function(index, element) {
							var index = getIndex(element.deviceNo);
							if( index >= 0){
								if(element.elevatorState == 0){
									$("#" + elevatorObjs[index].elevatorId + "-image").attr("src", "${ctx}/static/images/elevator/elevatorkunrenicon.png");
									$("#" + elevatorObjs[index].elevatorId + "-image").addClass("elevatorAlarm");
                 					elevatorObjs[index].alarmStatus = 1;
								}
									
								if(element.maintenanceState == 0){
									$("#" + elevatorObjs[index].elevatorId+ "-images").css({
									    "display":"block",
								    });
                 					elevatorObjs[index].maintenanceStatus = 1;
								}
								
							}
						});
					
					}
		        },
		        error : function(req, error, errObj) {
					return;
				}
			});
		}
		function findCurrentFloor(){
			var deviceNos = "31103301032014125006,156565613212121322223,31103301042014095060";
			$.ajax({
				type : "post",
				url : ctx + "/elevator/elevatorDataService/getElevatorMovingData?deviceNos="+deviceNos, 
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				async : false,
				success:function(data){
					if (data && data.code == 0 && data.data){
						var elevators = data.data;
						$.each(elevators, function(index, element) {
							var index = getIndex(element.deviceNo);
							var floor = element.floorDisplaying;
							if(floor == "G"){
								floor = "0";
							}
							if( index >= 0){
								goTargetFloor(index,floor);
							}
						});
					
					}
		        },
		        error : function(req, error, errObj) {
					return;
				}
			});
		}
		function getIndex(deviceNo){
			var index = -1;
			if (deviceNo == "31103301032014125006") {
				index = 0;
			} else if (deviceNo == "156565613212121322223") {
				index = 1;
			} else if (deviceNo == "31103301042014095060") {
				index = 2;
			}
			return index;
		}
		
		function getEvelatorData() {
			if (isConnectedGateWay) {
				stompClient.subscribe('/topic/elevatorMovingData', function(result) {
					console.log("电梯接收到数据：" + result.body);
					var data = JSON.parse(result.body);
					var index =getIndex(data.deviceNo);
					if(index >= 0){
						if (data.dataType == "1") {//电梯目标楼层
							if(data.currentFloor == "G"){
								data.currentFloor = "0";
							}
							elevatorObjs[index].targetFloors.push(data.currentFloor);
						} else if (data.dataType == "2") {//人脸弹窗信息
							elevatorObjs[index].pushMessage.push(data);
							console.log("电梯刷卡数据：" + result.body);
						} else if (data.dataType == "3") {//电梯告警
							elevatorObjs[index].alarmStatus = 1;
						} else if (data.dataType == "4") {//电梯告警恢复
							elevatorObjs[index].alarmStatus = 0;
						}
					}
				});
			}
		}

		function cancelGetEvelatorData() {
			if (stompClient != null) {
				stompClient.unsubscribe('/topic/elevatorMovingData');
			}
		}
		function elevatorListener(index) {

			elevatorObjs[index].listenerTimer = setInterval(function() {
				if (elevatorObjs[index].status == 0) {
					var data = elevatorObjs[index].targetFloors.shift();
					if (data) {
						var targetNum = data;
						var currentFloor = elevatorObjs[index].currentFloor;
						// 判断目标楼层是否大于当前楼层
						if(targetNum <= 33 && targetNum>=-3 && targetNum != currentFloor){
							if (Number(targetNum) > Number(currentFloor)) {
								goFloor("up", targetNum, index);
							} else if (Number(targetNum) < Number(currentFloor)) {
								goFloor("down", targetNum, index);
							}
						}
					}
				}
				//人脸弹窗
				if ($("#" + elevatorObjs[index].elevatorId + "-dialog").css("display") == "none") {
					var pushData = elevatorObjs[index].pushMessage.shift();
					if (pushData) {
						var text = pushData.userName;
						if(text.length > 6){
							$("#" + elevatorObjs[index].elevatorId + "-word").css({
							    "height":"150px",
							    }); 
						}else{
							$("#" + elevatorObjs[index].elevatorId + "-word").css({
							    "height":"127px",
							    }); 
						}
						if(text.length > 12){
							text = text.substring(0,11)+"...";
						}
						$("#" + elevatorObjs[index].elevatorId + "-face").attr("src", pushData.faceImage);
						$("#" + elevatorObjs[index].elevatorId + "-span").text(text);
						$("#" + elevatorObjs[index].elevatorId + "-dialog").show();
						setTimeout("$('#" + elevatorObjs[index].elevatorId + "-dialog').css('display','none')", 5000);
					}
					
				}
				
				//电梯告警图标处理
				if (elevatorObjs[index].maintenanceStatus == 1) {//电梯维保超时报警 
					$("#" + elevatorObjs[index].elevatorId+ "-images").css({
					    "display":"block",
				    });
				}
				if (elevatorObjs[index].alarmStatus == 1) {//电梯报警 
					$("#" + elevatorObjs[index].elevatorId + "-image").attr("src", "${ctx}/static/images/elevator/elevatorkunrenicon.png")
					$("#" + elevatorObjs[index].elevatorId + "-image").addClass("elevatorAlarm");
				} else{
					$("#" + elevatorObjs[index].elevatorId + "-image").removeClass("elevatorAlarm");
					$("#" + elevatorObjs[index].elevatorId + "-image").attr("src", "${ctx}/static/images/elevator/diantiicon.png"); 
					
				}
				floorShow(index);
			}, 30);
		}
		
		function floorShow(index){
			//电梯楼层显示
			if(elevatorObjs[index].currentFloor <= Number(33) && elevatorObjs[index].currentFloor>=Number(-3)){
				if(elevatorObjs[index].currentFloor == "0"){
					$("#" + elevatorObjs[index].elevatorId + "-floorSpan").text("GF");
				}else{
					$("#" + elevatorObjs[index].elevatorId + "-floorSpan").text(elevatorObjs[index].currentFloor + "F");
				}
			}
			if(elevatorObjs[index].currentFloor >= Number(33)){	
				$("#" + elevatorObjs[index].elevatorId + "-floorSpan").text("33F");
				
			}else if(elevatorObjs[index].currentFloor <= Number(-3)){
				$("#" + elevatorObjs[index].elevatorId + "-floorSpan").text("-3F");
			}
			
			if(elevatorObjs[index].currentFloor>=Number(33)){
				$("#" + elevatorObjs[index].elevatorId + "-floorsWindow").css({
				    "top":"200px"
				    }); 
			}else{
				$("#" + elevatorObjs[index].elevatorId + "-floorsWindow").css({
				    "top":"80px"
				    }); 
			}
		}
		
		function goTargetFloor(index,florNum){
			elevatorObjs[index].currentFloor = florNum;
			//电梯样式
			var height = floorHight * florNum;
			$("#" + elevatorObjs[index].elevatorId).css("marginTop", -height + 'px');
			elevatorObjs[index].height = height;
			//电梯楼层显示
			floorShow(index);
			$("#" + elevatorObjs[index].elevatorId).css({
			    "display":"block"
		    }); 
		}

		// 获取饼图echart(今年维保超期统计)
		function getElevatorBingEchart(reportId, divId, thisYear) {
			$.ajax({
				type : "post",
				url : ctx + "/report/" + reportId + "?projectCode=" + projectCode + "&thisYear=" + thisYear,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					debugger;
					var obj = echarts.init(document.getElementById(divId));
					obj.setOption($.parseJSON(data));
				},
				error : function(req, error, errObj) {
				}
			});
		}
		
		function goFloor(dirciton, florNum, index) {
			var height = floorHight * florNum;
			var i = elevatorObjs[index].height;
			var elevatorId = elevatorObjs[index].elevatorId;
			//电梯正在运行
			elevatorObjs[index].status = 1;
			if (dirciton == "up") {
				elevatorObjs[index].timer = setInterval(function() {		
					$("#" + elevatorId).css("marginTop", -i + 'px');
					elevatorObjs[index].height = i;
					i++;
					if(floorMap.has(i)){
						elevatorObjs[index].currentFloor = floorMap.get(i);
						floorShow(index);
					}
					if (i >= height || i >= Number(maxheight)) {
						clearInterval(elevatorObjs[index].timer);
						//电梯停止运行
						elevatorObjs[index].status = 0;
						elevatorObjs[index].currentFloor = florNum;
					}
				},30);
			} else if (dirciton == "down") {
				elevatorObjs[index].timer = setInterval(function() {
					$("#" + elevatorId).css("marginTop", -i + 'px');
					elevatorObjs[index].height = i;
					i--;
					if(floorMap.has(i)){
						elevatorObjs[index].currentFloor = floorMap.get(i);
						floorShow(index);
					}
					if (i <= height || i <= Number(minheight)) {
						clearInterval(elevatorObjs[index].timer);
						//电梯停止运行
						elevatorObjs[index].status = 0;
						elevatorObjs[index].currentFloor = florNum;
					}
				}, 30);
			}
		}
		
		$("#elevatorOne-image").bind("click",function(){
			getCertainElevator(elevatorObjs[0].elevatorNo, projectCode);
		});
		
		$("#elevatorTwo-image").bind("click",function(){
			getCertainElevator(elevatorObjs[1].elevatorNo, projectCode);
		});
		$("#elevatorThree-image").bind("click",function(){
			getCertainElevator(elevatorObjs[2].elevatorNo, projectCode);
		});
	
	});
	
	
	
	function alarmTopList(){
		debugger;
		$.ajax({
			type : "post",
			url : ctx + "/elevator/elevatorProjectPage/queryAlarmTopList?projectCode="+projectCode, 
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			async : false,
			success:function(data){
				debugger;
				if (data && data.CODE == "SUCCESS"){
					
					var result = data.RETURN_PARAM;
					for(var i in result){
						groupAlarm(result[i]);
					}
				}
	        },
	        error : function(req, error, errObj) {
				return;
			}
		});
		
		
	}
	
	function groupAlarm(alarmData){
		debugger;
		var alarmName= alarmCodeChange(alarmData.alarmName);
		var alarmNum= alarmData.alarmNum+"次";
		var widthRate = alarmData.rate*150+1 +"px";
		var trContent =  "<div style='height:20px;width:360px;position: ralative; margin-top:10px;padding-left:20px'><div class='alarm_name'>"+alarmName
		+"</div><div style='margin-left:12px;height:20px;background: #4EDEFF;float:left;width:"+ widthRate +";'></div><div class='alarm_num'>"+ alarmNum +"</div></div>";
		$("#alaram_top_list_content").append(trContent);
	}
	
	function alarmCodeChange(codeNum){
		if(codeNum=="37"){
			return "困人"
		}else if(codeNum=="38"){
			return "运行中开门";
		}else if(codeNum=="39"){
			return "门区外停梯";
		}else if(codeNum=="42"){
			return "冲顶";
		}else if(codeNum=="43"){
			return "蹲底";
		}else if(codeNum=="40"){
			return "开门不到位";
		}else if(codeNum=="41"){
			return "关门不到位";
		}else if(codeNum=="45"){
			return "长时间开门";
		}else if(codeNum=="44"){
			return "设备断电";
		}else if(codeNum=="136"){
			return "数据异常";
		}
	}
</script>
</html>
