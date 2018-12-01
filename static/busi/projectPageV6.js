function toSubscribe() {
	if (isConnectedGateWay) {
		// 首页信息识别结果
		stompClient.subscribe('/topic/projectData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			websocketCallBack(json);
		});
		stompClient.subscribe('/topic/feManageSystemData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			websocketCallBack(json);
		});
		stompClient.subscribe('/topic/waSuSystemData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			websocketCallBack(json);
		});
	}
}

function websocketCallBack(json) {
	if (json.type == 'HVAC') {
	} else if (json.type == 'TEST') {
	} else if (json.type == 'ELEVATOR') {
		displayElevatorInfo(json.data);
	} else if (json.type == 'ACCESS_CONTROL') {
		setProjectAccessControlAbnormal(json.data)
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'FIRE_FIGHTING') {
		displayFireFighting(json.data);
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MONITORING') {
		displayVideoInfo(json.data);
	} else if (json.type == 'PARKING') {
		updateParkingData(json.data);
	} else if (json.type == 'HEALTH_RATING') {
		updateHealthStatusValue(JSON.parse(json.data.healthRating));
	} else if (json.type == 'ALARM') {
		dynamicSysData(json.data);
	}

}

// 人行系统消息推送
function setProjectAccessControlAbnormal(data) {
	$("#accessControlAbnormal").html(data.num);
}

// 停车系统消息推送
function updateParkingData(result) {
	var dvErrorNum = result.deviceFalutNum;
	if (dvErrorNum == null) {
		$("#deviceAbnormalNum").html("-   -"); // 设备异常数
		dvErrorNum = 0;
	} else {
		$("#deviceAbnormalNum").html(result.deviceFalutNum); // 设备异常数
	}
	$("#carFlowNum").html(result.inPassageCarNum); // 入口车流量
	getEchartsData(149, "parkingEcharts");

	if($("#licensePlateDiv").children().length>4){
		$("#licensePlateDiv").children().eq(4).remove();
	}
	var snapshot = result.snapshot;
	var divLicence ='<div class="license-div"  name = "'+snapshot+'" onclick="createParkingSnapModal(this,event)">'
		+ licenceStrDeal(result.licensePlate)
		+'</div>';

	$("#licensePlateDiv").prepend(divLicence);
}

// 推送显示梯控首页
function displayElevatorInfo(json) {
	var alarm = $("#alarmTotal").text();
	if (json.alarmType == "1") {
		$("#alarmTotal").html(parseInt(alarm) + 1);
	} else if (json.alarmType == "2" && parseInt(alarm) > 0) {
		$("#alarmTotal").html(parseInt(alarm) - 1);
	}
}

// 项目首页首次打开查询电梯数据
function getElevatorAlarmData() {
	var typeCode = "ELEVATOR"
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorProjectPage/getElevatorAndAlarmProjectData?typeCode=" + typeCode + "&projectId=" + projectId + "&projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var returnVal = data.RETURN_PARAM;
				$("#alarmTotal").html(returnVal.alarms);
				$("#overdueNum").html(returnVal.maintenanceOverdue);
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
	// 电梯模块报表
	getEchartsData(148, "elevatorEcharts");
}

// 获取报警数据
function getAlarmRecordList() {
	$.ajax({
		type : "post",
		url : ctx + "/alarm-center/alarmRecord/limitAlarmList?projectCode=" + projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null) {
				newestAlarmData = data.resultAllList;
				$("#alarm-count").html(data.totalCount);
				buildAlarmData();
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
// 项目首页电梯监控报表
function getEchartsData(id, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + id + "?projectCode=" + projectCode,
		async : true,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var objs = JSON.parse(data);
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption(objs);
		},
		error : function(req, error, errObj) {
		}
	});
}

// 停车场模块数据初始化
function getParkingSystemData() {
	$.ajax({
		type : "post",
		url : ctx + "/parking/parkingMain/getParkingProjectData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				var result = data.data;
				var parkingDeviceFalutNum = result.deviceFalutNum;
				if (parkingDeviceFalutNum == null) {
					$("#deviceAbnormalNum").html("-   -"); // 设备异常数
					parkingDeviceFalutNum = 0;
				} else {
					$("#deviceAbnormalNum").html(parkingDeviceFalutNum); // 设备异常数
				}
				$("#carFlowNum").html(result.inPassageCarNum); // 入口车流量
			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});

	getEchartsData(149, "parkingEcharts");

	$.ajax({
		type : "post",
		url : ctx + "/parking/parkingMain/getLicensePlateProjectData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				var result = data.data;
				$("#licensePlateDiv").empty();
				for(var i in result){
					var licence = result[i].licensePlate;
					var snapshot =  result[i].snapshot+"";
        			var divLicence ='<div class="license-div" name = "'+snapshot+'" onclick="createParkingSnapModal(this,event)">'
        				+ licenceStrDeal(licence)
        				+'</div>';

        			$("#licensePlateDiv").append(divLicence);

        		}

			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});
}

//车牌切割-中间加空格
function licenceStrDeal(strData){
	if(strData!=null && strData.length>2){
		return strData.substring(0,2) + "&nbsp"+ strData.substring(2,strData.length);
	}
}

// 人行模块数据初始化
function getAccessControlData() {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/accessStatistics/projectData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(result) {
			if (result && typeof (result.code) != undefined && result.code == 0) {
				var returnVal = result.data;
				$("#accessControlAbnormal").html(returnVal.deviceAbnormalNum);
				var visitor = returnVal.pgInRecordNum
				/*
				 * if (visitor >= 10000) { visitor =
				 * Math.floor(visitor*100/10000) / 100;
				 * $("#project-access-control-visitor").next().show(); } else {
				 * $("#project-access-control-visitor").next().hide(); }
				 */
				$("#accessFlowNum").html(visitor);
				/*
				 * var pgInRecordNum = returnVal.pgInRecordNum; if
				 * (pgInRecordNum >= 10000) { pgInRecordNum =
				 * Math.floor(pgInRecordNum *100/10000) / 100;
				 * $("#project-access-control-in").next().show(); } else {
				 * $("#project-access-control-in").next().hide(); }
				 * $("#project-access-control-in").html(pgInRecordNum);
				 *
				 * projectAccessControlDeviceNo = returnVal.deviceNum;
				 */
				/*
				 * if(type==1){
				 * projectDeviceStateData("ACCESS_CONTROL",returnVal.deviceNum-returnVal.deviceAbnormalNum,returnVal.deviceAbnormalNum); }
				 */
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
	getEchartsData(150, "accessEcharts");
}

// 打开页面请求视频监控设备数量
function getVideoMonitorData() {
	$.ajax({
		type : "post",
		url : ctx + "/video-monitoring/vmDeviceStatus/getVmProjectData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				displayVideoInfo(data);
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}

// 展示视频监控信息
function displayVideoInfo(data) {
	$("#videoDeviceCount").html(data.projectTotalNum);
	$("#videoDeviceNormal").html(data.projectNormalNum);
	$("#videoDeviceUnnormal").html(data.projectAbnormalNum);
}

// 设备系统健康状况分析
function analysisHealthStatus(divId, color, val) {
	var obj = echarts.init(document.getElementById(divId));
	obj.clear();
	var option = {
		series : [
			{
				type : 'liquidFill',
				animation : true,
				waveAnimation : true,
				data : [
					val / 100
				],
				color : [
					color
				],
				center : [
						'41%', '52%'
				],
				waveLength : '70%',
				amplitude : 2,
				radius : '75%',
				label : {
					fontSize : 11.64,
					fontWeight:100,
					color : '#FFFFFF',
					normal : {
						formatter : function() {
							return val;
						},
						position : [
								'50%', '30%'
						]
					}
				},
				outline : {
					itemStyle : {
						borderColor : color,
						borderWidth : 5,
						opacity : 0.3
					},
					borderDistance : 0
				},
				backgroundStyle : {// 背景
					borderWidth : 1,
					borderColor : color,
					color : '#162D39',
					opacity : 0.9
				},
				itemStyle : {
					normal : {
						backgroundColor : '#fff'
					}
				}
			}
		]
	};
	obj.setOption(option);
}

// 获取设备健康状态
function getDeviceHealthStatus() {
	$.ajax({
		type : "post",
		url : ctx + "/device/deviceInfo/getDeviceHealthRating?projectCode=" + projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null) {
				updateHealthStatusValue(data);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 设备健康状态
function updateHealthStatusValue(value) {
	analysisHealthStatus("alarmCenterStatus", "#FF8482", 0);
	analysisHealthStatus("accessControlStatus", "#FF8482", 0);
	analysisHealthStatus("parkingStatus", "#FF8482", 0);
	analysisHealthStatus("elevatorStatus", "#FF8482", 0);
	analysisHealthStatus("videoStatus", "#FF8482", 0);
	analysisHealthStatus("loraStatus", "#4DA1FF", 0);
	jQuery.each(value, function(i, val) {
		val = parseInt(val);
		var color = "#00BFA5";
		if(val < 30){
			color = "#FF8482";
		}else if(30 <= val && val < 60){
			color = "#FFB489";
		}else if(60 <= val && val < 85){
			color = "#4DA1FF";
		}else if(val >= 85){
			color = "#00BFA5";
		}
		if (i == "FIRE_FIGHTING") {
			analysisHealthStatus("alarmCenterStatus", color, val);
		} else if (i == "ACCESS_CONTROL") {
			analysisHealthStatus("accessControlStatus", color, val);
		} else if (i == "PARKING") {
			analysisHealthStatus("parkingStatus", color, val);
		} else if (i == "ELEVATOR") {
			analysisHealthStatus("elevatorStatus", color, val);
		} else if (i == "VIDEO_MONITORING") {
			analysisHealthStatus("videoStatus", color, val);
		} else if (i == "INTERNET_OF_THINGS_SYSTEM") {
			analysisHealthStatus("loraStatus", color, val);
		}
	});
}
// 获取火警设备总数
function queryFiresDeviceTotal() {
	$.ajax({
		type : "post",
		url : ctx + "/device/manage/getCountBySystemCodeAndProjectCode?projectCode=" + projectCode + "&systemCode=FIRE_FIGHTING",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.code == 0) {
				$("#fireDeviceNum").html(data.data);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 获取消防报警数据
function getFiresData() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingManage/getProjectPageData?projectCode=" + projectCode,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.code == 0 && data.data) {
				displayFireFighting(data.data);
				setTimeout("getFiresData()", time);
			}
		},
		error : function(req, error, errObj) {
			setTimeout("getFiresData()", time);
		}
	});
}

function timeChange() {
	if(typeof(flushFiresTime) != "undefined" && 'undefined' != typeof($("#fire_fighting_skip").val())){
		firesMaxTime = firesMaxTime + 1000;
		var days = parseInt(firesMaxTime / (1000 * 60 * 60 * 24));
		var hours = parseInt((firesMaxTime % (1000 * 60 * 60 * 24))
				/ (1000 * 60 * 60));
		var minutes = parseInt((firesMaxTime % (1000 * 60 * 60)) / (1000 * 60));
		var seconds =(firesMaxTime % (1000 * 60)) / 1000;
		$("#fires_day").html(days);
		$("#fires_time").html(hours + "小时" + minutes + "分钟" + parseInt(seconds) + "秒");
		flushFiresTime=setTimeout("timeChange()", 1000);
		}
	}

// 展示消防系统数据
function displayFireFighting(data) {
		if(data.timeChanged){
			if(typeof(flushFiresTime) != "undefined"){
				// 防止多次加载产生多个定时任务
				clearTimeout(flushFiresTime);
			}
			firesMaxTime = data.firesMaxTime;
			if (firesMaxTime > 0) {
				flushFiresTime=setTimeout("timeChange()", 1000);
			}else{
				$("#fires_day").html("--");
				$("#fires_time").html("--小时" + "--分钟" + "--秒");
			}
		}
		$("#maintain_number").html(data.maintainNumber + "%");
		$("#maintain_value").css("width", data.maintainNumber + "%");
		$("#alarm_normal").html(data.firesNormal);
		$("#alarm_abnormal").html(data.firesAbnormal);
		$("#fires").html(data.fires);
		$("#linkage_answer").html(data.linkageAnswer);
}



// 跳转电梯系统主界面
$("#elevator_skip").click(function() {
	unloadAndRelease();
	openPage("电梯子系统主界面", " ", "/elevatorSystem/verticalElevator");
});

function createParkingSnapModal(data,event){
	event.stopPropagation();
	var url = $(data).attr("name");
	if(data=="undefined"){
		return;
	}
	createModalWithLoad("alarm-device-img", 730, 500, "车辆场景抓拍",
			"alarmEventDefines/snapshotImage?snapshotImages=" +url , "", "", "");
	openModal("#alarm-device-img-modal", true, false);
}
// 跳转报警中心
$("#alert_device_skip").click(function() {
	unloadAndRelease();
	openPage("报警中心主界面", " ", "/alarmRecords/alarmRecordPage");
});

// 视频监控页面
$("#vedio_skip").click(function() {
	var key = "VIDEO-MONITORING-MENU-2";
	var menuValue = menuMap.get(key);
	if (menuValue) {
		createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
	}
});

// 人行系统页面
$("#access_control_skip").click(function() {
	var key = "ACCESS-INOUT-RECORD";
	var menuValue = menuMap.get(key);
	if (menuValue) {
		createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
	}
});

// 车行系统页面
$("#parking_skip").click(function() {
	var key = "MONITOR-PAGE";
	var menuValue = menuMap.get(key);
	if (menuValue) {
		createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
	}
});
// 告警
function buildAlarmData() {

	var alarmData = $.extend(true,[],newestAlarmData);

	var length = alarmData.length;
	var pageSize =  Math.ceil(length /5);//页数
	var end = 5 * secPageNumber + 5;
	var  secData = null;
	if(end <  length){
		secData  = alarmData.slice(5 * secPageNumber,end);
		secPageNumber++;
	}else{
		secData  = alarmData.slice(5 * secPageNumber);
		secPageNumber=0;
	}

	$("#alarm-content").empty();
	$("#alarm-content").append("<ul id='item-text-ul' class='text1' style='margin-top:45px'></ul>");
	$.each(secData, function(i, val) {
		var status = "处理中";
		var opreator = "- -";
		var alarmTime = "";
		var location = "- -";
		var describe = "";
		if (typeof (val.firstAlarmTime) != "undefined") {
			alarmTime = val.firstAlarmTime;
		}
		if (typeof (val.devicePosition) != "undefined" && val.devicePosition!="") {
			location = val.devicePosition;
			if (location.length > 8) {
				location = location.substring(0, 5) + "...";
			}
		}
		if (typeof (val.describe) != "undefined") {
			describe = val.describe;
		}
		var importAlarmDeviceImg =  ctx + "/static/img/alarm/importAlarmDeviceImg.svg";
		var imgHtml =  '';
		if(val.snapImages){
			imgHtml =  '<div style="float: left;height: 12.5px;width:25px;" ><img class = "device-snapImage" src="' + importAlarmDeviceImg + '"/></div>';
		}
		var div = '<li  class="item_text" onclick="createSnapModal(\''+ val.snapImages+ '\',event)">'+
				  '<span class="alarm-describes">' + describe + '</span>'+
				  '<span class="alarm-span"></span>'+
				  '<span class="alarm-location">' + location + '</span>'+
				  '<span class="alarm-span"></span>'+
				  '<span class="alarm-time">' + alarmTime + '</span>'+
				  '<span class="alarm-span"></span>'+
				  '<span class="alarm-opreator"> 责任人：' + opreator + '</span>'+
				  '<span class="alarm-span"></span>'+
				  imgHtml +
				  '<span class="alarm-status">' + status + '</span>'+
				  '</li>';
		$("#item-text-ul").append(div);
	});
/*	alarmSlide();*/
}
function alarmSlide(){
	if($("#playStateCell").hasClass("pauseState")){
		$("#playStateCell").removeClass("pauseState");
	}
	$("#playStateCell").triggerHandler('click');
	$("#alarm-content").unbind();
	$("#playStateCell").unbind();
	$("#item-text-ul .clone").remove();
	if($("#alarm-content .tempWrap").length > 0){
		$("#item-text-ul").unwrap();
	}
	$("#alarm-content").slide({ mainCell:"#item-text-ul",autoPage:true,effect:"topLoop",autoPlay:true,vis:5,interTime:1500,playStateCell:"#playStateCell"});
}
function createSnapModal(snapshotImages,event) {
	event.stopPropagation();
	if(snapshotImages=="undefined"){
		return;
	}
	createModalWithLoad("alarm-device-img", 730, 500, "重要报警抓拍",
			"alarmEventDefines/snapshotImage?snapshotImages=" + snapshotImages, "", "", "");
	openModal("#alarm-device-img-modal", true, false);
}
// 系统实时动态
function dynamicSysData(data) {
	var liCount = $("#alarm-content ul li:not(.clone)").length;
	if(!data.todayRepeatAlarm){
		$("#alarm-count").html(Number($("#alarm-count").html())+1);
	}
	var status = "处理中";
	var opreator = "- -";
	var alarmTime = "";
	var location = "- -";
	var describe = "";
	if (typeof (data.lastAlarmTime) != "undefined") {
		alarmTime = data.lastAlarmTime;
	}
	if (typeof (data.devicePosition) != "undefined"
			&& data.devicePosition != "null" && data.devicePosition != null) {
		location = data.devicePosition;
	}
	if (typeof (data.describe) != "undefined") {
		describe = data.describe;
	}
	var div = '<li class="item_text">'+
	  '<span class="alarm-describes">' + describe + '</span>'+
	  '<span class="alarm-span"></span>'+
	  '<span class="alarm-location">' + location + '</span>'+
	  '<span class="alarm-span"></span>'+
	  '<span class="alarm-time">' + alarmTime + '</span>'+
	  '<span class="alarm-span"></span>'+
	  '<span class="alarm-opreator"> 责任人：' + opreator + '</span>'+
	  '<span class="alarm-span"></span>'+
	  '<span class="alarm-status">' + status + '</span>'+
	  '</li>';
	$("#item-text-ul").prepend(div);
	if(liCount > 20){
		$("#item-text-ul li:not(.clone)").last().remove();
	}
	alarmSlide();
}

function openFireFightingPage(code) {
	if(code=="FFM_OUTSIDE_PAGE"){
		createPage(null, "消防报警系统", null, "/fireFightingManage/ffmStaticLink");
	}else if(code =="FIRE_MAINTAIN_PAGE"){
		createPage(null, "消防事件概要", null, "/fireFightingManage/ffmOutsideDetailInfo");
	}
}

//lora模块初始化
function loraDeviceData(){
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/iotSensorManage/queryLoraNum?projectCode="+projectCode,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var data = JSON.parse(data);
			if (data) {
				$("#co2").html(data.co2);
				if(data.pm == "null" || data.pm == ""){
					$("#pm25").html("-   -");
					$("#pm_img").hide();
				}else{
				$("#pm25").html(toDecimal1(data.pm));
				$("#pm_img").show();
				}
				$("#cover").html(data.cover);
				if(data.pm<35){
					$("#pm_img").attr("src",ctx+"/static/img/lora/perfect.svg");
				}else if(35<=data.pm && data.pm<75){
					$("#pm_img").attr("src",ctx+"/static/img/lora/good.svg");
				}else if(75<=data.pm && data.pm<115){
					$("#pm_img").attr("src",ctx+"/static/img/lora/slightPollution.svg");
				}else if(115<=data.pm && data.pm<150){
					$("#pm_img").attr("src",ctx+"/static/img/lora/middlePollution.svg");
				}else if(150<=data.pm && data.pm<250){
					$("#pm_img").attr("src",ctx+"/static/img/lora/serious.svg");
				}else if(250<=data.pm){
					$("#pm_img").attr("src",ctx+"/static/img/lora/severe.svg");
				}
			}
		},
		error : function(req, error, errObj) {
			setTimeout("getFiresData()", time);
		}
	});
	getEchartsData(154, "loraEcharts");
}

function toDecimal1(x) {
	   var f = parseFloat(x);
	   if (isNaN(f)) {
	      return false;
	   }
	   var f = Math.round(x*100)/100;
	   var s = f.toString();
	   var rs = s.indexOf('.');
	   if (rs < 0) {
	      rs = s.length;
	      s += '.';
	   }
	   while (s.length <= rs + 1) {
	      s += '0';
	   }
	   return s;
	}

//工作单模块初始化
function workOrderDate(){
	$.ajax({
		type : "post",
		url : ctx + "/system/workOrderLoraData/queryWorkNum?projectCode="+projectCode,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var data = JSON.parse(data);
			if (data) {
				$("#workNum").html(data.workTotal);
				if((data.completedNum+data.handleNum) == 0){
					$("#carryOut").html("0%");
				}else{;
				    $("#carryOut").html(Math.round(data.completedNum/(data.completedNum+data.handleNum)*100 *10)/10+"%");
				}
				$("#carryOutRate").css("width",data.completedNum/(data.completedNum+data.handleNum)*100+"%");
				worklistEcharts(data.handleNum,data.completedNum,data.cancelNum);
			}
		},
		error : function(req, error, errObj) {
		}
	});
/*getEchartsData(153, "worksDiv");*/


}

function worklistEcharts(handleNum,completedNum,cancelNum){
	var obj = echarts.init(document.getElementById("worksDiv"));
	obj.clear();
	var option = {
			"title": {
				"text": "",
				"left": "18%",
				"top": "30",
				"textStyle": {
					"fontSize": "18",
					"fontWeight": "normal",
					"color": "#FFFFFF"
				}
			},
			"tooltip": {
				"trigger": "item",
				"show": false,
				"formatter": "{a}<br/>{b}({d}%)"
			},
			"color": ["#7DB8F8", "#4799F5", "#F37B7B"],
			"legend": {
				"icon": "circle",
				"orient": "vertical",
				"x": "62%",
				"y": "24%",
				"itemWidth": 12,
				"itemHeight": 12,
				"data": ["处理中：" + handleNum,
				         "已完成：" + completedNum,
				         "已取消：" + cancelNum],
				"textStyle": {
					"color": "#979797"
				}
			},
			"series": [{
				"type": "pie",
				"radius": ["34%", "72%"],
				"center": ["30%", "50%"],
				"data": [{
					"value": 54,
					"itemStyle": {
						"normal": {
							"color": "rgba(77,161,255,0.1)"
						}
					}
				}],
				"label": {
					"normal": {
						"show": false
					}
				}
			}, {
				"name": "",
				"type": "pie",
				"radius": ["34%", "62%"],
				"center": ["30%", "50%"],
				"data": [{
					"name": "处理中：" + handleNum,
					"value": handleNum
				}, {
					"name": "已完成：" + completedNum,
					"value": completedNum
				}, {
					"name": "已取消：" + cancelNum,
					"value": cancelNum
				}],
				"label": {
					"normal": {
						"position": "outside",
						"textStyle": {
							"color": "#979797",
							"fontSize": 12
						}
					}
				},
				"labelLine": {
					"normal": {
						"lineStyle": {
							"color": "#979797",
							"width": 1,
							"type": "solid"
						}
					}
				},
				"itemStyle": {
					"normal": {
						"label": {
							"show": false,
							"formatter": "{d}%"
						}
					}
				}
			}]
		}
	obj.setOption(option);
}

//跳转至工单中心
$("#work_sheet_skip").click(function() {
	unloadAndRelease();
	var key="ALARM_WORK";
	var menuValue = menuMap.get(key);
	if(menuValue){
		createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
	}
});

function getAllSensorAlarmShowData(){
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/iotSensorManage/queryAllSensorAlarmShowData?projectCode="+projectCode,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var data = JSON.parse(data);
			if (data) {
				$("#parkingGemNum").html(data.parkingGeomagnetism.deviceTotal);
				$("#parkingGemNormal").html(data.parkingGeomagnetism.noraml);
				$("#parkingGemOffline").html(data.parkingGeomagnetism.offline);
				$("#parkingGemLowPower").html(data.parkingGeomagnetism.lowBatteryAlarm);
				$("#fireGateGemNum").html(data.fireGateGeoMagnetism.deviceTotal);
				$("#fireGateGemNormal").html(data.fireGateGeoMagnetism.noraml);
				$("#fireGateGemOffline").html(data.fireGateGeoMagnetism.offline);
				$("#fireGateGemLowPower").html(data.fireGateGeoMagnetism.lowBatteryAlarm);
				$("#fireGateGemMonitor").html(data.fireGateGeoMagnetism.monitorAlarm);
				$("#iotManholeCoverNum").html(data.iotManholeCover.deviceTotal);
				$("#iotManholeCoverNormal").html(data.iotManholeCover.noraml);
				$("#iotManholeCoverOffline").html(data.iotManholeCover.offline);
				$("#iotManholeCoverMonitor").html(data.iotManholeCover.monitorAlarm);
				$("#iotManholeCoverLowPower").html(data.iotManholeCover.lowBatteryAlarm);
				$("#iotTrashcanNum").html(data.iotTrashcan.deviceTotal);
				$("#iotTrashcanNormal").html(data.iotTrashcan.noraml);
				$("#iotTrashcanOffline").html(data.iotTrashcan.offline);
				$("#iotTrashcanMonitor").html(data.iotTrashcan.monitorAlarm);
				$("#iotTrashcanLowPower").html(data.iotTrashcan.lowBatteryAlarm);
				$("#iotEnvironmentNum").html(data.iotEnvironment.deviceTotal);
				$("#iotEnvironmentNormal").html(data.iotEnvironment.noraml);
				$("#iotEnvironmentOffline").html(data.iotEnvironment.offline);
				var pm25=data.iotEnvironment.monitorValue;
				if(pm25 == "null" || pm25 == ""){
					$("#iotEnvironmentMonitor").html("-   -");
				}else{
					$("#iotEnvironmentMonitor").html(pm25);
					if(pm25<35){
						$("#pm25State").html("优");
					}else if(35<=pm25 && pm25<75){
						$("#pm25State").html("良");
					}else if(75<=pm25 && pm25<115){
						$("#pm25State").html("轻度污染");
					}else if(115<=pm25 && pm25<150){
						$("#pm25State").html("中度污染");
					}else if(150<=pm25 && pm25<250){
						$("#pm25State").html("重度污染");
					}else if(250<=pm25){
						$("#pm25State").html("严重污染");
					}
				}

				$("#iotElectricityMeterNum").html(data.iotElectricityMeter.deviceTotal);
				$("#iotElectricityMeterNormal").html(data.iotElectricityMeter.noraml);
				$("#iotElectricityMeterOffline").html(data.iotElectricityMeter.offline);
				$("#iotElectricityMeterMonitor").html(data.iotElectricityMeter.monitorValue);
			}
		},
		error : function(req, error, errObj) {
			setTimeout("getAllSensorAlarmShowData()", time);
		}
	});
}