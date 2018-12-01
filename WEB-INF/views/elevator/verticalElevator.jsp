<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<link href="${ctx}/static/css/pagination.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/js/bxslider/jquery.bxslider.min.css" />
<script src="${ctx}/static/js/jquery.pagination.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-lazyload/jquery.lazyload.min.js"></script>
<style type="text/css">
.secMenu {
	font-size: 16px;
}

.li_style {
	height: 40px;
	width: 100%;
	text-align: center;
	line-height: 40px;
	cursor: pointer;
}

.float-lf {
	float: left;
	margin-top: 30px;
	margin-left: 10px;
}

.outBag {
	float: left;
	margin-left: 160px;
	margin-top: 30px;
}

.eleSuvey {
	font-size: 14px;
	margin-top: 8px;
	margin-left: 10px;
}

.eleSuvey1 {
	font-size: 14px;
	margin-left: 80px;
}

.equip-status {
	margin-top: 20px;
	font-size: 14px;
}

.status-color {
	color: #00BFA5;
}

.equip-place {
	font-size: 14px;
	margin-top: 10px;
}

.clearfix {
	overflow: hidden;
}

.adj-position {
	margin-left: 65px;
}

.content-default {
	padding: 10px;
	margin-bottom: 20px;
	background-color: rgba(255,255,255,0);
	border: none;

}

.bottom {
	width: 254px;
	height: 36px;
	text-align: center;
	margin-top: -36px;
	background: rgba(0, 0, 0, 0.5);
}

.display {
	width: 98px;
	height: 30px;
	text-align: center;
	background-image: url('${ctx}/static/images/elevator/back.png');
	margin: 0 auto;
	top: 8px;
	position: relative;
}

.body {
	height:299px;
	width:254px; 
	box-shadow: 10px 5px 30px 0 rgba(86,86,86,0.50);
}

.camera {
	cursor: pointer;
}
.elevatorAlarm {
	cursor: pointer;
}
.cameraBack {
	height: 39px;
	width: 150px;
	margin-left: 14px;
	top: -35px;
	position: relative;
	visibility: hidden;
	display: -moz-inline-box;
	background-image: url('${ctx}/static/images/elevator/cameraBack.png');
}
.cameraBack1 {
	height: 50px;
	width: 158px;
	margin-left: 7px;
	top: -40px;
	position: relative;
	display: -moz-inline-box;
	visibility: hidden;
	background-image: url('${ctx}/static/images/elevator/lixian.png');
}
.cameraText{
	height: 17px;
    width: 75px;
    font-size: 12px;
    color: #00BFA5;
    margin-top: 14px;
    cursor: pointer;
    float: left;
    text-align: center;
}
.cameraText1{
    float: left;
    text-align: center;
    margin-left: 16px;
	margin-top: 20px;
	font-size: 12px;
	color: #ffffff;
}
.visitor-info{
	background:#4DA1FF;
	width:100px;
	height:50px;
}
.visitor-info p.first-p{
	padding-top:16px;
}
.visitor-info p.second-p{
	padding-top:8px;
}
.visitor-info p{
    margin:0;
    padding-left:8px;
    color:#fff;
    font-size:12px;
    letter-spacing:2px;
}
.only-one{
/* text-align:center; */
    position: absolute;
    left: 50%;
    margin-left: -50px;
    top: 50%;
    margin-top: 80px;
}
.only-two{
/* text-align:center; */
    position: absolute;
    left: 73%;
    margin-left: -17px;
    top: 50%;
    margin-top: 80px;
}
.only-three{
/* text-align:center; */
    position: absolute;
    left: 73%;
    margin-left: -50px;
    top: 50%;
    margin-top: -50px;
    visibility: hidden;
}
.visits li{
	display:inline-block;
}
.item-avatar{
    width: 100%;
    height: 100%;
    objec-fit: cover;
}
.item-ul{
    width: 100px;
    height: 100px;
}
</style>
</head>
<body class="main_background" style="width: 100%; height: 100%;">
	<div class="secMenu" style="width:10%;height: 800px;background-color:#FFFFFF;float:left;box-shadow: 0 4px 20px 0 rgba(27, 36, 45, 0.30);">
		<ul style="width:100%" id="ul_location_list">
			<li id="li_fristLi" style="width:100%;height:60px;">
				<div style="float:left;width:20%;height:100%;padding-left:10px;padding-top:18px">
					<div style="width:4px;height:20px;background-color:#00BFA5;"></div>
				</div>
				<div style="float:left;height:100%;width:80%;padding-top:18px">
					<div><span style="font-family: PingFangSC-Medium;font-size: 20px;color: #00BFA5;letter-spacing: 0;">垂直电梯系统</span></div>
				</div>
			</li>
		</ul>
	</div>
	<div class="content-default" style="width:90%; float:left;">
		<ul id="item-lists" class="item-list">
		</ul>
	</div>
	<div id="show-video"></div>
	<div id="show-picture"></div>
	<div id="alarm-detail"></div>
	<div id="detail-snapshot-img"></div>
	<div id="error-div"></div>
	<script type="text/javascript">
	var ctx = "${ctx}";
	var fisrtLocationId;
	var returnData;
	var cameraToElevatorMap = new HashMap();
	var eleNoToNameMap = new HashMap();
	var eleNoToEleIdMap = new HashMap();
	var t;
	var talarmNum;
	// 小图标
	var jiankongIcon = "${ctx}/static/images/elevator/jiankong.svg";
	var jiankongyichangIcon = "${ctx}/static/images/elevator/jiankongyichang.svg";
	var baojingIcon = "${ctx}/static/images/elevator/baojing.svg";
	var baojingwuIcon = "${ctx}/static/images/elevator/baojingwu.svg";
	var weixiuIcon = "${ctx}/static/images/elevator/weixiu.svg";
	var kunrenIcon = "${ctx}/static/images/elevator/kunren.svg";
	var shangshengIcon = "${ctx}/static/images/elevator/shangsheng.png";
	var xiajiangIcon = "${ctx}/static/images/elevator/xiajiang.png";
	var tingzhiIcon = "${ctx}/static/images/elevator/tingzhi.png";
	var cameraBackIcon = "${ctx}/static/images/elevator/cameraBack.png";
	var lixianIcon = "${ctx}/static/images/elevator/lixian.png";
	
	// 电梯图片
	var kaimenIcon = "${ctx}/static/images/elevator/kaimen.png";
	var guanmenIcon = "${ctx}/static/images/elevator/guanmen.png";
	var yourenIcon = "${ctx}/static/images/elevator/youren.png";
	var backIcon = "${ctx}/static/images/elevator/back.png";
	var dikuangIcon = "${ctx}/static/images/elevator/dikuang.svg"
	
	// 组装div的图片
	var jiankong;
	var baojing;
	var weixiu;
	var kunren;
	var dianti;
	var baojingshu;
	var yunxingStatus;
	var defaultUrl = "static/images/elevator/morentouxiang2.png";
	var judgment = false;
	$(document).ready(function() {
		$('#container-fluid').removeAttr("style");
 		// 初始化页面，主要是加载二级菜单(楼栋信息)
		initPage();
		// 连接websocket
		toSubscribe();
		// 默认展示第一栋楼的电梯数据
		showElevator(fisrtLocationId);
	});

	function initPage() {
		$.ajax({
			type : "post",
			url : "${ctx}/device/manage/getLocationByCategoryAndProjectId?deviceTypeCode=VERTICAL_ELEVATOR_SYSTEM&projectId=" + projectId,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			async : false,
			success : function(data) {
				if (data.code == 0 && data.data.length>0) {
					fisrtLocationId = data.data[0].id;
					var result = data.data;
					for ( var i in result) {
						var liContent = "<li onclick = 'showElevator("
								+ result[i].id
								+ ")' id=liBack"
								+ result[i].id
								+ " class='li_style'><a style=" + "'color : #666666;'>"
								+ result[i].locationName
								+ "</a></li>";
						$("#ul_location_list").append(liContent);
					}
				}else{
					$("#content-page").load("/ib-web/projectPage/noDataPage");
					return ;
				}
			},
			error : function(req, error, errObj) {
				return;
			}
		});
	}
	
	function showElevator(currlocationId) {
		$('.li_style').css("background","");
		var t_bg = $('#liBack'+currlocationId);
		t_bg.css("background", "#99E5DB");
		
		var data = {
				"projectId" : projectId,
				"locationId" : currlocationId
			};
		$.ajax({
			type : "post",
			url : "${ctx}/device/manage/getElevatorInitData",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			async : false,
			success : function(data) {
				returnData = data;
				$("#item-lists").empty();
				var html = '';
				var dataLength = data.items.length;
				var deviceNos = "";
				for (var i = 0; i < dataLength; i++) {
					eleNoToNameMap.put(data.items[i].deviceNumber, data.items[i].name);
					eleNoToEleIdMap.put(data.items[i].deviceNumber, data.items[i].id);
					if (deviceNos == "") {
						deviceNos = data.items[i].deviceNumber;
					} else {
						deviceNos = deviceNos + "," + data.items[i].deviceNumber;
					}
					html = '<li class="item" id="parent'+data.items[i].deviceNumber+'">'
							+ '<div class="outBag">'
							// 电梯概况
							+ '<div style="float: left; width: 220px; height: 300px; margin-top: 60px; background-image: url('+dikuangIcon+');">'
							+ '<h3 style="text-align: center;">电梯概况</h3>'
							+ '</div>'
							// 电梯展示图
					        + '<div class="float-lf" id="'+data.items[i].deviceNumber+'">'
							+ '<div style="width:254px; height:30px; text-align: center;">'
							+ '<img src="' + jiankongIcon +'">'
							+ '<img id="alarm'+data.items[i].deviceNumber+'" class="elevatorAlarm" src="' + baojingwuIcon + '"'
							+ 'onclick="showAlarmDetail('+data.items[i].id+',\''+data.items[i].deviceNumber+'\')" style="margin-left: 50px;">'
							+ '<div id="alarmNum'+data.items[i].deviceNumber+'" style="color: #F37B7B; margin-left: 110px; margin-top: -35px;"></div>'
							
							+ '</div><div id="body'+data.items[i].deviceNumber+'" class="body" style="background-image: url('+guanmenIcon+');"></div>'
							
							+ '<div id="bottom'+data.items[i].deviceNumber+'">'
							+ '<div class="blank">'
							+ '<img id="weixiu'+data.items[i].deviceNumber+'" src="" style="margin-top: 6px; display: none;">'
							+ '<img id="kunren'+data.items[i].deviceNumber+'" src="" style="margin-left: 50px; margin-top: 6px; display: none;">'
							+ '</div></div></div>'
							+ '</div>'
							+ '</li>'
					$("#item-lists").append(html);
				}
				// 电梯设备相关数据加载完毕后马上获取最新的电梯运行数据
				getFirstRunningData(deviceNos)
			},
			error : function(req, error, errObj) {
				return;
			}
		});
	}
	
	function getFirstRunningData(deviceNos) {
		$.ajax({
			type : "post",
			url : "${ctx}/elevator/elevatorDataService/getElevatorData?param=" + deviceNos + "&projectCode=" + projectCode,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			async : false,
			success : function(data) {
			if (data) {
				var dataLength = data.length;
				var newDiv = '';
				for (var i = 0; i < dataLength; i++) {
					var val = data[i].runningRecord;
					var survey = data[i].survey;
					var cameraDeviceNo = "";
					if (data[i].cameraDeviceNumber != null) {
						cameraDeviceNo = data[i].cameraDeviceNumber;
						cameraToElevatorMap.put(cameraDeviceNo, val.deviceId);
					} else {
						cameraDeviceNo = val.deviceNo;
					}
					
					var oldDiv = $('#'+val.deviceNo);
					if (oldDiv.attr("class") != 'float-lf') {
						continue;
					}
					
					// 判断电梯状态(是否检修)
					if (val.elevatorState == 1) {
						weixiu = "";
					} else {
						weixiu = weixiuIcon;
					}
					
					// 判断电梯门
					if (val.isAnyone == 1 && val.isDoorOpen == 1) {
						dianti = yourenIcon;
					} else if (val.isAnyone != 1 && val.isDoorOpen == 1){
						dianti = kaimenIcon;
					} else {
						dianti = guanmenIcon;
					}
					
					// 判断运行状态
					if (val.runningState == 1) {
						yunxingStatus = shangshengIcon;
					} else if (val.runningState == 2) {
						yunxingStatus = xiajiangIcon;
					} else {
						yunxingStatus = tingzhiIcon;
					}
					
					// 报警数
					if (data[i].alarmNum == 0) {
						baojing = baojingwuIcon;
						baojingshu = "";
					} else {
						baojing = baojingIcon;
						baojingshu = data[i].alarmNum;
					}
					// 判断摄像机状态
					if (data[i].cameraStatus == 1) {
						jiankong = jiankongIcon;
					} else if(data[i].cameraStatus == 0 && data[i].cameraDeviceId == null){
						jiankong = "";
					}else{
						jiankong = jiankongyichangIcon;
					}
					
					var bottom = "bottom";
					if (weixiu == "" && data[i].isTrapped != 1) {
						bottom = "blank";
					}
					
					// 如果电梯没有运行数据的特殊处理
					if (val.elevatorState == 0) {
						weixiu = "";
						val.deviceName = eleNoToNameMap.get(val.deviceNo);
						val.floorDisplaying = "";
					}
					
					if (val.elevatorState == 0 && data[i].isTrapped != 1) {
						bottom = "blank";
					}
					
					newDiv = '<div class="outBag">'
					// 电梯概况
						+ '<div style="float: left; width: 220px; height: 300px; margin-top: 60px; background-image: url('+dikuangIcon+');">'
						+ '<h3 style="text-align: center;">电梯概况</h3>'
						
						if (val.deviceNo.length >= 12) {
							newDiv = newDiv + '<div class="eleSuvey">电梯编号：'+val.deviceNo.substring(0,12)+'</div>'
							+ '<div class="eleSuvey1">'+val.deviceNo.substring(12,val.deviceNo.length)+'</div>'
						} else {
							newDiv = newDiv + '<div class="eleSuvey">电梯编号：'+val.deviceNo+'</div>'
						}
						newDiv = newDiv + '<div class="eleSuvey">电梯名称：'+val.deviceName+'</div>'
						+ '<div class="eleSuvey">位置：'+survey.location+'</div>'
						+ '<div id="currDayFlow'+val.deviceNo+'" class="eleSuvey">当日客流量：'+survey.currDayPassengerFlow+'</div>'
						+ '<div class="eleSuvey">品牌：'+survey.brand+'</div>'
						+ '<div class="eleSuvey">厂商：'+survey.manufacturer+'</div>'
						+ '<div class="eleSuvey">维保时间：'+survey.maintenanceTime+'</div>'
						+ '<div id="fixTime'+val.deviceNo+'" class="eleSuvey">下次维保：'+survey.nextMaintenanceTime+'</div></div>'
					// 电梯展示图
						+'<div class="float-lf" id="'+val.deviceNo+'">'
						+ '<div style="width:254px; height:30px; text-align: center;">'
						if(jiankong != ""){
							newDiv = newDiv +  '<img id="cIcon'+cameraDeviceNo+'" class="camera" src="'+jiankong+'" onclick="timedMsg(\''+cameraDeviceNo+'\')">'
						}
						newDiv = newDiv + '<img id="alarm'+val.deviceNo+'" class="elevatorAlarm" src="'+baojing+'"'
						+ 'onclick="showAlarmDetail('+val.deviceId+',\''+val.deviceNo+'\')" style="margin-left: 50px;">'
						+ '<div id="alarmNum'+val.deviceNo+'" style="color: #F37B7B; margin-left: 110px; margin-top: -35px;">'+baojingshu+'</div>'
						+ '</div><div id="body'+val.deviceNo+'" class="body" style="background-image: url('+dianti+');">'
						+ '<div id="display'+ val.deviceNo +'" class="display">'
						+'<ul id="ul'+val.deviceNo+'"></ul>'
						+ '<div id="floorDisplay'+val.deviceNo+'" style="height: 30px; width: 49px; font-size: 24px; color: #A44141; margin-top: 6px; float: left;">'+val.floorDisplaying+'</div>'
						+ '<div style="height: 30px; width: 49px; float: right;"><img id="run'+val.deviceNo+'" src="'+yunxingStatus+'" style="height: 30px; width: 49px;"></div></div>'
						
						+ '<div id="cPaernt'+cameraDeviceNo+'">'
						if (data[i].cameraStatus == 1) {
							newDiv = newDiv + '<div id="camera'+cameraDeviceNo+'" class="cameraBack">'
							+ '<div class="cameraText" onclick="showVideo('+data[i].cameraDeviceId+')">视频查看</div>'
							+ '<div class="cameraText" onclick="showPicture('+val.deviceId+')">抓拍照片</div></div>'
						} else {
							newDiv = newDiv + '<div id="camera'+cameraDeviceNo+'" class="cameraBack1">'
							+ '<div class="cameraText1">摄像机离线，请尽快处理</div></div>'
						}
						newDiv = newDiv + '</div></div>'
						
						+ '<div id="bottom'+val.deviceNo+'">'
						+ '<div class='+bottom+'>'
						+ '<img id="weixiu'+val.deviceNo+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
						+ '<img id="kunren'+val.deviceNo+'" src="'+kunrenIcon+'" style="margin-left: 50px; margin-top: 6px;">'
						+ '</div></div></div></div>'
							
					$("#parent"+val.deviceNo).html(newDiv);
							
					if (data[i].isTrapped != 1) {
						$('#kunren'+val.deviceNo).css('display','none');
						$('#kunren'+val.deviceNo).attr('src','');
					}
					if (val.elevatorState == 1) {
						$('#weixiu'+val.deviceNo).css('display','none');
						$('#weixiu'+val.deviceNo).attr('src','');
						$('#kunren'+val.deviceNo).css('margin-left','0px');
					}
					if (val.elevatorState == 0) {
						$('#weixiu'+val.deviceNo).css('display','none');
						$('#weixiu'+val.deviceNo).attr('src','');
						$('#run'+val.deviceNo).css('display','none');
						$('#kunren'+val.deviceNo).css('margin-left','0px');
					}
					if (survey.nextMaintenanceTime.indexOf("超期") != -1) {
						$('#fixTime'+val.deviceNo).css('color','red');
					}
				}
			}
			},
			error : function(req, error, errObj) {
				return;
			}
		});
	}
	
	//弹窗队列
	var queueArray = new Array();
	//图片消失后调用
	function dequeueArray(deviceNo){
		if(queueArray.length > 0){
			var data  = queueArray.shift();
			/* displayAlarmInfo(data); */
			generatRight(data);
		}else{
			var num = $("#ul"+deviceNo).children().length;
			if(num == 1){
				var one = document.getElementById("nameOne"+deviceNo); 
				var two = document.getElementById("nameTwo"+deviceNo); 
				if(one!=null){
				$("#liOne"+deviceNo).animate({marginLeft:"-75px"},50,function(){
					});
			}
				if(two!=null){
					$("#liTwo"+deviceNo).animate({marginLeft:"-75px"},50,function(){
						});
				}
			}
		}
	}
	
	//视频弹窗后台推送处理
	function windowPushData(json){
		var deviceNo = json.elevatorNum;
		var num = $("#ul"+deviceNo).children().length;
		if(num==0){
			generatCenter(json);
		}else if(num==1){
			generatRight(json);
		}else if(num==2){
		queueArray.push(json);
		}
		
		var currDayPassageFlow = json.currDayPassageFlow;
		// 更新当日客流量
		var currDayFlow = $('#currDayFlow'+deviceNo);
		if (currDayFlow != undefined) {
			currDayFlow.html("当日客流量："+currDayPassageFlow);
		}
	}
	
	// 定时三秒就执行
	function idByNull(liOneId,deviceNo) {
		$(liOneId).remove();
		dequeueArray(deviceNo);
	}
	
	function generatCenter(json){
		judgment = true;
		var deviceNo = json.elevatorNum;
	    html = '<li id="liOne'+deviceNo+'" class="only-one"><div class="item-ul"><img id="imgOne'+deviceNo+'" class="item-avatar"'
   		+'src=""/></div><div class="visitor-info">'
   		+'<p  id="first-p1'+deviceNo+'" class="first-p"><span id="userTypeOne'+deviceNo+'"></span><span data-toggle="tooltip" title="'+json.userName+'" id="nameOne'+deviceNo+'"></span></p></div></li>'
    $("#ul"+deviceNo).append(html);
   		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
	var url = json.faceImage;
	var name = json.userName;
	var userType = json.userType
	if(userType == "1"){
		$("#userTypeOne"+deviceNo).html("业主：");
	}else if(userType == "2"){
		$("#userTypeOne"+deviceNo).html("访客：");
	}else if(userType == "3"){
		$("#userTypeOne"+deviceNo).html("物业：");
	}else{
		$("#userTypeOne"+deviceNo).html("其他：");
	}
	if(name.length>8){
			name = name.substr(0, 8) + "...";
	}
	$("#nameOne"+deviceNo).html(name);
	if(name.length>3){
		$("#first-p1"+deviceNo).removeClass("first-p").addClass("second-p");
	}
	
	if(url != null && url != undefined){
		$("#imgOne"+deviceNo).attr('src',url);
		}else{
			$("#imgOne"+deviceNo).attr('src',defaultUrl);
		}
	       var liOneId = "#liOne"+deviceNo;
			var nameOneId = "#nameOne"+deviceNo;
			var imgOneId = "#imgOne"+deviceNo;
	// 三秒后弹窗消失
	setTimeout("idByNull('" + liOneId + "','" + deviceNo + "')", 5000);
	}
	
	function generatRight(json){
		var deviceNo = json.elevatorNum;
		var url = json.faceImage;
		var one = document.getElementById("nameOne"+deviceNo); 
		var two = document.getElementById("nameTwo"+deviceNo); 
		
		if(one!=null && two==null){
			if(judgment==true){
		$("#liOne"+deviceNo).animate({marginLeft:"-108px"},50,function(){
			});
			}else{
				$("#liOne"+deviceNo).animate({marginLeft:"-131px"},50,function(){
				});
			}
		html = '<li id="liTwo'+deviceNo+'" class="only-two"><div class="item-ul"><img id="imgTwo'+deviceNo+'" class="item-avatar"'
		+'src=""/></div><div class="visitor-info">'
		+'<p id="first-p2'+deviceNo+'" class="first-p"><span id="userTypeTwo'+deviceNo+'"></span><span data-toggle="tooltip" title="'+json.userName+'" id="nameTwo'+deviceNo+'"></span></p></div></li>'
	    $("#ul"+deviceNo).append(html);
		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
		var name = json.userName;
		var userType = json.userType
		if(userType == "1"){
			$("#userTypeTwo"+deviceNo).html("业主：");
		}else if(userType == "2"){
			$("#userTypeTwo"+deviceNo).html("访客：");
		}else if(userType == "3"){
			$("#userTypeTwo"+deviceNo).html("物业：");
		}else{
			$("#userTypeTwo"+deviceNo).html("其他：");
		}
		if(name.length>8){
			name = name.substr(0, 8) + "...";
	    }
		$("#nameTwo"+deviceNo).html(name);
		if(name.length>3){
			$("#first-p2"+deviceNo).removeClass("first-p").addClass("second-p");
		}
		if(url != null && url != undefined){
			$("#imgTwo"+deviceNo).attr('src',url);
			}else{
				$("#imgTwo"+deviceNo).attr('src',defaultUrl);
			}
		var liTwoId = "#liTwo"+deviceNo;
		var nameTwoId = "#nameTwo"+deviceNo;
		var imgTwoId = "#imgTwo"+deviceNo;
		// 三秒后弹窗消失
		setTimeout("idByNull('" + liTwoId + "','" + deviceNo + "')", 5000);
		}
		if(one==null && two!=null){
			if(judgment==true){
			$("#liTwo"+deviceNo).animate({marginLeft:"-108px"},50,function(){
			});
			}else{
				$("#liTwo"+deviceNo).animate({marginLeft:"-131px"},50,function(){
				});
			}
			html = '<li id="liOne'+deviceNo+'" class="only-two"><div class="item-ul"><img id="imgOne'+deviceNo+'" class="item-avatar"' 
	           +'src=""/></div><div class="visitor-info">'
	           +'<p id="first-p3'+deviceNo+'" class="first-p"><span data-toggle="tooltip" title="'+json.userName+'" id="userTypeOne'+deviceNo+'"></span><span  id="nameOne'+deviceNo+'">1234</span></p></div></li>'
		    $("#ul"+deviceNo).append(html);
	           $(function() {
					$("[data-toggle='tooltip']").tooltip();
				});
		    var name = json.userName;
		    var userType = json.userType
			if(userType == "1"){
				$("#userTypeOne"+deviceNo).html("业主：");
			}else if(userType == "2"){
				$("#userTypeOne"+deviceNo).html("访客：");
			}else if(userType == "3"){
				$("#userTypeOne"+deviceNo).html("物业：");
			}else{
				$("#userTypeOne"+deviceNo).html("其他：");
			}
		    if(name.length>8){
				name = name.substr(0, 8) + "...";
		    }
		   	$("#nameOne"+deviceNo).html(name);
		   	if(name.length>3){
				$("#first-p3"+deviceNo).removeClass("first-p").addClass("second-p");
			}
		   	if(url != null && url != undefined){
				$("#imgOne"+deviceNo).attr('src',url);
				}else{
					$("#imgOne"+deviceNo).attr('src',defaultUrl);
				}
			var liOneId = "#liOne"+deviceNo;
			var nameOneId = "#nameOne"+deviceNo;
			var imgOneId = "#imgOne"+deviceNo;
			// 三秒后弹窗消失
			setTimeout("idByNull('" + liOneId + "','" + deviceNo + "')", 5000);     
		}
		judgment=false;
		}

	
	function toSubscribe(){
		if (isConnectedGateWay) {
			stompClient.subscribe('/topic/elevatorData', function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				if(json.uuid==undefined) {
					// 没有uuid说明是运行数据
					updateRunningData(json);
				} else {
					updateAlarmData(json);
				}
			});
			
			stompClient.subscribe('/topic/videoMonitoring/' + projectCode, function(result) {
				var json = JSON.parse(result.body);
				console.log(json);
				updateCamera(json);
			});
			
			stompClient.subscribe('/topic/elevatorRecord',function(result) {
				// 梯控出入记录
				// 客户姓名：userName
				// 人脸图片：faceImage
				// 人员类型：1-业主，2-访客，3-物业，9-其他 userType
				// 电梯编号：elevatorNum
				// 当日客流量：currDayPassageFlow
				var json = JSON.parse(result.body);
				windowPushData(json);
				//updateCamera(json);
			});
		}
	}


	function unloadAndRelease() {
		if(stompClient != null) {
			stompClient.unsubscribe('/topic/elevatorData');
			stompClient.unsubscribe('/topic/videoMonitoring/' + projectCode);
			stompClient.unsubscribe('/topic/elevatorRecord');
		}
	}
	
	// 展示摄像头详细信息
	function showCameraDetail(cameraDeviceNumber) {
		var cId = "camera"+cameraDeviceNumber;
		$("#"+cId).css("visibility","visible");
	}
	
	function removeAll() {
		$('.cameraBack').css("visibility","hidden");
		$('.cameraBack1').css("visibility","hidden");
	}
	
	function timedMsg(cameraDeviceNumber) {
		removeAll();
		showCameraDetail(cameraDeviceNumber);
  		if(typeof(t) != "undefined"){
	    	//防止多次加载产生多个定时任务
	    	clearTimeout(t);
	    }
		t = setTimeout("removeAll()",4000);
	}
	
	function showPicture(deviceId) {
		createModalWithLoad("show-picture", 800, 650, "场景抓拍历史记录", "elevatorSystem/showPicture?deviceId="+deviceId, "", "", "");
	}
	
	function showVideo(cameraDeviceId) {
		createModalWithLoad("show-video", 832, 530, "查看视频", "elevatorSystem/showVideo?cameraDeviceId="+cameraDeviceId, "", "", "");
		$("#show-video-modal").modal('show');
	}
	
	/**
	 *加载图片
	 */
	$("#show-picture").on('shown.bs.modal', function () {
		loadPic();
	});
	
	// 展示报警详细信息
	function showAlarmDetail(deviceId, deviceNo) {
		if (deviceId == null || deviceId == undefined) {
			deviceId = eleNoToEleIdMap.get(deviceNo);
		}
		talarmNum = $('#alarmNum'+deviceNo).text();
		if(talarmNum==""){
			createModalWithLoad("alarm-detail", 1040, 590, "电梯历史报警明细", "elevatorSystem/alarmDetail?deviceId="+deviceId+"&talarmNum="+talarmNum,  "", "", "");
		}else{
			createModalWithLoad("alarm-detail", 1040, 590, "电梯报警明细", "elevatorSystem/alarmDetail?deviceId="+deviceId+"&talarmNum="+talarmNum,  "", "", "");
		}
        openModal("#alarm-detail-modal", true, true);
	}
	
	// 更新某个电梯的运行数据
	function updateRunningData(val){
		var oldBody = $('#body'+val.elevatorCode);
		if (oldBody.attr("class") != 'body') {
			return;
		}
		
		// 修改电梯门
		var t_body = $('#body'+val.elevatorCode);
		if (val.isAnyone == 1 && val.isDoorOpen == 1) {
			dianti = yourenIcon;
		} else if (val.isAnyone != 1 && val.isDoorOpen == 1){
			dianti = kaimenIcon;
		} else {
			dianti = guanmenIcon;
		}
		t_body.css("background-image", "url("+dianti+")");
		
		// 修改楼层
		var t_floorDisplay = $('#floorDisplay'+val.elevatorCode);
		if (val.floorDisplaying != undefined) {
			t_floorDisplay.html(val.floorDisplaying);
		}
		
		// 修改运行状态
		var t_runState = $('#run'+val.elevatorCode);
		if (val.runningState == 1) {
			yunxingStatus = shangshengIcon;
		} else if (val.runningState == 2) {
			yunxingStatus = xiajiangIcon;
		} else {
			yunxingStatus = tingzhiIcon;
		}
		if (val.runningState != undefined) {
			t_runState.attr('src',yunxingStatus);
		}
		
		var t_bottom = $('#bottom+'+val.elevatorCode);
		var t_kunren = $('#kunren'+val.elevatorCode);
		var t_weixiu = $('#weixiu'+val.elevatorCode);
		if (val.elevatorState == 1) {
			if((t_kunren[0].src.indexOf(".svg") != -1)) {//说明当前存在困人小图
				var newBottom = '<div class="bottom">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-top: 6px;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
			} else {
				var newBottom = '<div class="blank">'
					+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
					+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;"></div>'
					$("#bottom"+val.elevatorCode).html(newBottom);
			}
		}
		
		if (val.elevatorState != 1) {
			if((t_kunren[0].src.indexOf(".svg") != -1)) {//说明当前存在困人小图
				var newBottom = '<div class="bottom">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-left: 50px; margin-top: 6px;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
			} else {
				var newBottom = '<div class="bottom">'
					+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
					+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-left: 50px; margin-top: 6px; display: none;"></div>'
					$("#bottom"+val.elevatorCode).html(newBottom);
			}
		}
	}
	
	// 更新某个电梯的报警数据
	function updateAlarmData(val) {
		var oldBody = $('#body'+val.elevatorCode);
		if (oldBody.attr("class") != 'body') {
			return;
		}
		
		// 修改报警数
		var newAlarmNum="";
		var t_alarmNum = $('#alarmNum'+val.elevatorCode).text();
		if (t_alarmNum == "") {
			t_alarmNum = parseInt(0);
		}
		if (val.alarmType == 1) {// 告警产生
			newAlarmNum = parseInt(t_alarmNum) + parseInt(1);
		} else {// 告警恢复
			newAlarmNum = parseInt(t_alarmNum) - parseInt(1);
			if (newAlarmNum <= 0) {
				newAlarmNum = "";
			}
		}
		$('#alarmNum'+val.elevatorCode).text(newAlarmNum);
		
		// 修改报警小图标
		var t_alarmIcon = $('#alarm'+val.elevatorCode);
		if (newAlarmNum > 0) {
			baojing = baojingIcon;
		} else {
			baojing = baojingwuIcon;
		}
		t_alarmIcon.attr('src',baojing);
		
		var t_bottom = $('#bottom+'+val.elevatorCode);
		var t_kunren = $('#kunren'+val.elevatorCode);
		var t_weixiu = $('#weixiu'+val.elevatorCode);
		// 维修小图标的东西需求确定以后直接拼整个bottom
		if (val.alarmType == 1 && val.alarmCode == 37) {
			if((t_weixiu[0].src.indexOf(".svg") != -1)) {//说明当前存在维修小图
				var newBottom = '<div class="bottom">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-left: 50px; margin-top: 6px;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
			} else {
				var newBottom = '<div class="bottom">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="'+kunrenIcon+'" style="margin-top: 6px;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
			}
		}
		
		if (val.alarmType != 1 && val.alarmCode == 37) {
			if((t_weixiu[0].src.indexOf(".svg") != -1)) {//说明当前存在维修小图
				var newBottom = '<div class="bottom">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="'+weixiuIcon+'" style="margin-top: 6px;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-left: 50px; margin-top: 6px; display: none;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
			} else {
				var newBottom = '<div class="blank">'
				+ '<img id="weixiu'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;">'
				+ '<img id="kunren'+val.elevatorCode+'" src="" style="margin-top: 6px; display: none;"></div>'
				$("#bottom"+val.elevatorCode).html(newBottom);
			}
		}
	}
	
	// 更新某个电梯的摄像机状态
	function updateCamera(val) {
		if (val.deviceNumber == undefined || val.status == undefined) {
			return;
		}
		var elevatorDeviceId = cameraToElevatorMap.get(val.deviceNumber);
		var t_camera = $("#cIcon"+val.deviceNumber);
		var cParent = $("#cPaernt"+val.deviceNumber);
		if (t_camera != undefined && cParent != undefined) {
			if (val.status == 1) {
				t_camera.attr('src',jiankongIcon);
				var newDiv = '<div id="camera'+val.deviceNumber+'" class="cameraBack">'
				+ '<div class="cameraText">视频查看</div>'
				+ '<div class="cameraText" onclick="showPicture('+elevatorDeviceId+')">抓拍照片</div></div>'
				cParent.html(newDiv);
			} else {
				t_camera.attr('src',jiankongyichangIcon);
				var newDiv = '<div id="camera'+val.deviceNumber+'" class="cameraBack1">'
				+ '<div class="cameraText1">摄像机离线，请尽快处理</div></div>'
				cParent.html(newDiv);
			}
		}
	}
	
	
	</script>
</body>
</html>