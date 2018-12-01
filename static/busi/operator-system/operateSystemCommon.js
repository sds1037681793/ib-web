function startConn(gatewayAddr) {
	connect(gatewayAddr);
	setInterval("connect('" + gatewayAddr + "')", 40000);
}

function connect(gatewayAddr) {
	if (isConnectedGateWay) {
		return;
	}
	var url = gatewayAddr + '/websocket';
	g_gatewayAddr = gatewayAddr;
	var socket = new SockJS(url);
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		isConnectedGateWay = true;
		console.info("网关连接成功！");
		// 消防火警报警、电梯困人报警 视频弹窗websocket连接
		toSubscribeElevatorAlarmInfo();
		// 告警中心告警
		stompClient.subscribe('/topic/operateSystemMainData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			websocketCallBack(json);
		});
		// 项目信息
		stompClient.subscribe('/topic/projectData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			websocketProjectCallBack(json);
		});
	}, onerror);
}

function websocketProjectCallBack(json) {
	if (json.type == 'HVAC') {
		if(json.data.projectTotalCount){
			$("#havc_system_detail_num").html(json.data.projectTotalCount);
		}
	} else if (json.type == 'ELEVATOR') {
		// $("#elevatorm_device_num").html(value.projectTotalNum);
	} else if (json.type == 'ACCESS_CONTROL') {
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'FIRE_FIGHTING') {
		if(json.data.waterOnline){
			$("#water_system_detail_num").html(parseInt(json.data.waterOnline) + parseInt(json.data.waterOffline));
		}
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MORNITORING') {
	}else if(json.type == 'PARKING'){
		if(json.data.deviceFalutNum == null){
			json.data.deviceFalutNum = 0;
		}
		$("#basementBlock_parking_num").html(parseInt(json.data.deviceNormalNum) + parseInt(json.data.deviceFalutNum));
	}
}

// 根据类型转入不同的方法
function websocketCallBack(json) {
	if (json.type == 'ALARM') {
		handelNewestAlarmData(json.data);
	} else if (json.type == 'ACCESS_CONTROL') {
	} else if (json.type == 'ALARM_NUM_BEFORE_DAWN') {
		beforeDawnInit();
	} else if (json.type == 'FIRE_FIGHTING') {
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MORNITORING') {
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'HVAC') {
		var hvacFrame = document.getElementById('hvac_page-iframe');
		if (hvacFrame == undefined) {
			return;
		}
		hvacFrame.contentWindow.hvacWarmDataDeal(json.data);
	} else if (json.type == 'PARKING') {
		updateParking3DPageData(json.data);
	} else if (json.type == 'ENV_MONITOR') {
	} else if (json.type == 'ELEVATOR') {
		if (json.data.uuid != undefined) {
			updateElevatorStatus(json.data);
		}
		if (document.getElementById('elevatorRunningMonitorPage-iframe')) {
			var firstFrame = document.getElementById('elevatorRunningMonitorPage-iframe');
			if (firstFrame.contentWindow.document.getElementById('elevator-detail-iframe')) {
				var tempFrame = firstFrame.contentWindow.document.getElementById('elevator-detail-iframe');
				if (tempFrame == undefined) {
					return;
				}
				if (json.data.uuid == undefined) {
					// 没有uuid说明是运行数据
					tempFrame.contentWindow.updateRunningData1(json.data);
				} else {
					tempFrame.contentWindow.updateAlarmData1(json.data);
				}
			}
		}
	} else if (json.type == 'ELEVATOR_FACE') {
		if (document.getElementById('elevatorRunningMonitorPage-iframe')) {
			var firstFrame = document.getElementById('elevatorRunningMonitorPage-iframe');
			if (firstFrame.contentWindow.document.getElementById('elevator-detail-iframe')) {
				var tempFrame = firstFrame.contentWindow.document.getElementById('elevator-detail-iframe');
				if (tempFrame == undefined) {
					return;
				}
				tempFrame.contentWindow.windowPushData(json.data);
			}
		}
	}
}

function onerror(frame) {
	if (frame.indexOf("Lost connection") > -1) {
		console.info("未连接上网关地址：" + g_gatewayAddr);
		isConnectedGateWay = false;
		disconnect();
	}
}

function disconnect() {
	if (stompClient != null) {
		stompClient.disconnect();
	}
}

function unloadAndRelease() {
	disconnect();
}

// 凌晨报警故障统计
function beforeDawnInit() {
	if ($("#alarm-number-data").html() != undefined) {
		$("#alarm-num").empty();
		$("#alarmLimit").empty();
		$("#alarmLimit").show();
		$("#faultLimit").hide();
		$("#fault_font").css("color", "rgba(255,255,255,0.50)");
		$("#alarm_font").css("color", "#56E4FF");
		$("#fault_active_span").removeClass("alarm-active-line");
		$("#alarm_active_span").addClass("alarm-active-line");
		getNewestAlarmData(1);
	} else {
		$("#alarm-num").empty();
		$("#faultLimit").empty();
		$("#alarmLimit").hide();
		$("#faultLimit").show();
		$("#alarm_font").css("color", "rgba(255,255,255,0.50)");
		$("#fault_font").css("color", "#56E4FF");
		$("#alarm_active_span").removeClass("alarm-active-line");
		$("#fault_active_span").addClass("alarm-active-line");
		getNewestAlarmData(2);
	}
}

/**
 * 处理推送的告警信息
 * @param data
 * @returns
 */
function handelNewestAlarmData(data) {
	var recoveryTime = data.recoveryTime;
	var fool = data.fool;
	// 告警
	if (recoveryTime == undefined || recoveryTime == "" || recoveryTime == null) {
		var deviceId = data.deviceId;
		var describe = data.describe;
		var firstAlarmTime = data.lastAlarmTime;
		firstAlarmTime = firstAlarmTime.substring(0, 10)
		var recoveryTime = data.recoveryTime;
		var systemName = data.systemName;
		var devicePosition = data.devicePosition;
		if (devicePosition == undefined || devicePosition == null || devicePosition == "") {
			devicePosition = "";
		}
		if (describe.length >= 10) {
			describe = describe.substring(0, 10);
		}
		if(devicePosition.length>12){
			devicePosition = devicePosition.substring(0, 12)+"..."; 
		}
		stree = "no";
		var ids = deviceId + "remar";
		var addressId = deviceId + "address";
		if ((data.eventType ==1||data.eventType ==3||data.eventType ==4||data.eventType ==5) && !data.todayRepeatAlarm) {
			// 删除最后一条，新增第一条
			var divLength = $("#alarmLimit").children().length;
			if(divLength>=5){
				$("#alarmLimit > div:last").remove();
			}
		} else if ((data.eventType ==2||data.eventType ==6 ) && !data.todayRepeatAlarm) {
			var divLength = $("#faultLimit").children().length;
			if(divLength>=5){
				$("#faultLimit > div:last").remove();
			}
		}
		var html = '';

//		html += '<div id="' + ids + '" onclick="handleAddress(\'' + location + '\',\'' + recoveryTime + '\')" class="alarm_box"">' + '<table style="height:44px; width: 300px;"><tr>  <td class="alarm_type">' + describe + '</td> <td id="' + addressId + '" class="alarm_device_name" rowspan="2">' + devicePosition + '</td>' + '<td class="firstAlarmTime" rowspan="2">' + firstAlarmTime + '</td> </tr><tr><td class="systemName">' + systemName + '</td><td></td><td></td>' + '</tr></table></div>';
		
		html +='<div id="' + ids + '" onclick="handleAddress(\'' + location + '\',\'' + recoveryTime + '\')" class="alarm_box"">' +
	        	'<table style="height:44px; width: 300px;"><tr>  <td class="alarm_type">' + describe + '</td>'+
	        	'<td class="systemName">' + systemName + '</td> </tr>' + 
	        	'<tr><td id="' + addressId + '" class="alarm_device_name">' + devicePosition + '</td><td class="firstAlarmTime" rowspan="2">' + firstAlarmTime + '</td></tr></table></div>';
		if ((data.eventType ==1||data.eventType ==3||data.eventType ==4||data.eventType ==5)  && !data.todayRepeatAlarm) {
			$("#alarmLimit").prepend(html);
			$("#alarm-number-data").html(parseInt($("#alarm-number-data").html()) + 1);
			$("#alarm-untreated-data").html(parseInt($("#alarm-untreated-data").html()) + 1);
		} else if ((data.eventType ==2||data.eventType ==6 ) && !data.todayRepeatAlarm) {
			$("#faultLimit").prepend(html);
			$("#fault-number-data").html(parseInt($("#fault-number-data").html()) + 1);
			$("#fault-untreated-data").html(parseInt($("#fault-untreated-data").html()) + 1);
		}
		// 告警楼层
		if (fool != null && fool != undefined && fool != "") {
			floorAlarmLocation(fool)
		}
	} else {
		var deviceId = data.deviceId;
		var ids = deviceId + "remar";
		if (data.eventType ==1||data.eventType ==3||data.eventType ==4||data.eventType ==5) {
			$("#alarm-untreated-data").html(parseInt($("#alarm-untreated-data").html()) - 1);
			$("#"+ids).remove();
			var divLength = $("#alarmLimit").children().length;
			if(divLength>=4){
				beforeDawnInit();
			}
		} else if (data.eventType ==2||data.eventType ==6) {
			$("#fault-untreated-data").html(parseInt($("#fault-untreated-data").html()) - 1);
			$("#"+ids).remove();
			var divLength = $("#faultLimit").children().length;
			if(divLength>=4){
				beforeDawnInit();
			}
		}
		
		
		// 告警恢复
		if (fool != null && fool != undefined && fool != "") {
			// 取消楼层闪烁
			floorAlarmClose(fool);
		}
	}
}

/**
 * 获取项目所有的设备
 * @returns
 */
function getProjectAllDeviceCount() {
	$.ajax({
		type : "get",
		url : ctx + "/device/homePage/getProjectAllDeviceCount?projectId=" + projectId,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				$("#deviceProjectCount").text(data);
				if (data.indexOf(".") < 0) {
					$("#deviceWan").text("");
				} else {
					$("#deviceWan").text("万");
				}
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function unloadAndRelease() {
	if (stompClient != null) {
		stompClient.unsubscribe('/topic/projectData/' + projectCode);
		stompClient.unsubscribe('/topic/ffmAlarmVideoData/' + projectCode);
		stompClient.unsubscribe('/topic/elevatorAlarmVideoPopoverRunningData/' + projectCode);
		stompClient.unsubscribe('/topic/elevatorAlarmVideoPopover/' + projectCode);
	}
}

/**
 * 查询设备正常异常总数
 * @returns
 */
function getSubsystemNormalCount() {
	$.ajax({
		type : "post",
		url : ctx + "/device/homePage/getSubsystemNormalCount?projectCode=" + projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				data = $.parseJSON(data);
				abnormalCount = data.numberCount;
				if (isNaN(abnormalCount) || abnormalCount == undefined) {
					abnormalCount = 0;
				}
				var count = data.count;
				var normal = data.normal;
				if (isNaN(count) || count == undefined) {
					count = 0;
				}
				if (isNaN(normal) || normal == undefined) {
					normal = 0;
				}
				var abnormal = count - normal;
				// $("#deviceProjectCount").text(count);
				$("#deviceNormal").text(normal);
				$("#deviceAbnormal").text(abnormal);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

/**
 * 获取最新报警信息
 * @returns
 */
function getNewestAlarmData(eventType) {
	$.ajax({
		type : "post",
		url : ctx + "/alarm-center/alarmRecord/getAlarmRecordNodeLimitInfo?eventType=" + eventType,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data != null) {
				var datas = JSON.parse(data);
				handleFool(datas);
				var stree = 0;
				if (eventType == 1) {
					html = '<div id="alarm-nums" style="height:47px;width:300px;padding-top: 6px;" class="alarm_box">' + '<span id="alarm-span-name" class="alarm-number" style="font-size: 14px;color: #FFFFFF;">今日报警总数：</span>' + '<span id="alarm-number-data" style="font-size: 20px;color: #FFB43A;display:inline-block;width:100px;">100</span>' + '<span class="alarm-number" style="margin-left: 37px;font-size: 14px;color: #FFFFFF;margin-left: 5px;">未恢复：' + '<span id="alarm-untreated-data" style="font-size: 20px;color: #FF5E72;">0</span></span></div>'
					if($("#alarm-nums").length==0){
						$("#alarm-num").append(html);
					}
					$("#alarm-number-data").html(datas.totalCount);
					$("#alarm-untreated-data").html(datas.unRecoveryCount);
				} else {
					html = '<div id="fault-nums" style="height:47px;width:300px;padding-top: 6px;" class="alarm_box">' + '<span id="fault-span-name" class="alarm-number" style="font-size: 14px;color: #FFFFFF;">今日故障总数：</span>' + '<span id="fault-number-data" style="font-size: 20px;color: #FFB43A;display:inline-block;width:100px;">100</span>' + '<span class="fault-number" style="margin-left: 37px;font-size: 14px;color: #FFFFFF;margin-left: 5px;">未恢复：' + '<span id="fault-untreated-data" style="font-size: 20px;color: #FF5E72;">0</span></span></div>'
					if($("#alarm-nums").length==0){
						$("#alarm-num").append(html);
					}
					$("#fault-number-data").html(datas.totalCount);
					$("#fault-untreated-data").html(datas.unRecoveryCount);
				}
				$(eval(datas.resultAllList)).each(function() {
					stree = stree + 1;
					var deviceId = this.deviceId;
					var describe = this.describe;
					var location = this.location;
					var firstAlarmTime = this.firstAlarmTime;
					var systemName = this.systemName;
					firstAlarmTime = firstAlarmTime.substring(0, 10)
					var recoveryTime = this.recoveryTime;
					var devicePosition = this.devicePosition;
					if (devicePosition == undefined) {
						devicePosition = "";
					} else {
					}
					if(devicePosition.length>12){
						devicePosition = devicePosition.substring(0, 12)+"..."; 
					}
					if (describe.length >= 10) {
						describe = describe.substring(0, 10);
					}
					var ids = deviceId + "remar";
					var addressId = deviceId + "address";
					var html = '';
					html += '<div id="' + stree + '">'+
					        '<div id="' + ids + '" onclick="handleAddress(\'' + location + '\',\'' + recoveryTime + '\')" class="alarm_box"">' +
					        '<table style="height:44px; width: 300px;"><tr>  <td class="alarm_type">' + describe + '</td>'+
					        '<td class="systemName">' + systemName + '</td> </tr>' + 
					        '<tr><td id="' + addressId + '" class="alarm_device_name">' + devicePosition + '</td><td class="firstAlarmTime" rowspan="2">' + firstAlarmTime + '</td></tr></table></div></div>';
					if (eventType == 1) {
						$("#alarmLimit").append(html);
					} else {
						$("#faultLimit").append(html);
					}
					// 楼层闪烁
					/*
					 * if (recoveryTime == undefined || recoveryTime == "" ||
					 * recoveryTime == null) { if (devicePosition != undefined &&
					 * devicePosition != "") { floorAlarm(devicePosition); } }
					 */
				});

			}
		},
		error : function(req, error, errObj) {
		}
	});

}

/**
 * 第一次查询时判断楼层下是否有报警
 * @param datas
 * @returns
 */
function handleFool(datas) {
	var oneFool = datas.oneFool;
	var gFool = datas.gFool;
	var threeFool = datas.threeFool;
	// 有告警
	if (oneFool > 0) {
		// 闪烁
		floorAlarm("1F");
	} else {
		// 取消闪烁
		floorAlarmClose("1F");
	}

	// 有告警
	if (gFool > 0) {
		// 闪烁
		floorAlarm("G");
	} else {
		// 取消闪烁
		floorAlarmClose("G");
	}

	// 有告警
	if (threeFool > 0) {
		// 闪烁
		floorAlarm("3F");
	} else {
		// 取消闪烁
		floorAlarmClose("3F");
	}
}

/**
 * 楼层闪烁效果
 * @param devicePosition
 * @returns
 */
function handleAddress(location, recoveryTime) {
	if (recoveryTime == "undefined" || recoveryTime == "" || recoveryTime == null) {
		if (location != undefined && location != "") {
			floorAlarmLocation(location);
		}
	}
}

// 能耗数据
function getSupplyPowerProjectData() {
	$.ajax({
		type : "post",
		url : ctx + "/power-supply/supplyPowerMain/getPds3DPageData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				var result = data.data;
				$("#id_publicPowerConsumption").html(result.publicPowerConsumption);
				$("#id_allPowerConsumption").html(result.allPowerConsumption);
			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});

	getBingEchart(127, "power_echart");
}

// 电梯告警视频弹窗
function toSubscribeElevatorAlarmInfo() {
	if (isConnectedGateWay) {
		stompClient.subscribe('/topic/elevatorAlarmVideoPopover/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			// 摄像机id为空，不进行推送
			if (json.cameraDeviceId != undefined) {
				// 判断数组是否有值
				if (elevatorAlarmDevice.length > 0) {
					// 如果为空，代表告警已经全部恢复
					if (json.alarmType == 2) {
						if (json.alarmCode == "37") {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									elevatorAlarmDevice[i].alarmName = json.alarmName;
									elevatorAlarmDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorAlarmDevice[i].runningState = json.runningState;
									elevatorAlarmDevice[i].cameraStatus = json.cameraStatus;
									// 判断此是否正在查看，如果正在查看，则不删除，否则删除
									document.getElementById('show-elevator-alarm-video-iframe').contentWindow.deleteElevatorInfo(json.deviceId, json.deviceName, json.alarmName, i, json.floorDisplaying, json.runningState);
								}
							}
						} else {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									elevatorAlarmDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorAlarmDevice[i].runningState = json.runningState;
									elevatorAlarmDevice[i].alarmName = json.alarmName;
									elevatorAlarmDevice[i].cameraStatus = json.cameraStatus;
									if (elevatorVideoIsOpen == 1) {
										document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
									}
								}
							}
						}
					} else {
						if (json.alarmCode == "37") {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									// 删除原有数据
									elevatorAlarmDevice.splice(i, 1);
								}
							}
							// 在数组最前面添加数据
							elevatorAlarmDevice.unshift({
								"deviceId" : json.deviceId,
								"deviceName" : json.deviceName,
								"alarmName" : json.alarmName,
								"runningState" : json.runningState,
								"floorDisplaying" : json.floorDisplaying,
								"cameraDeviceId" : json.cameraDeviceId,
								"cameraStatus" : json.cameraStatus
							});
							// 判断窗口是否被打开
							if (elevatorVideoIsOpen == 0) {
								showElevatorAlarmVideo(elevatorAlarmDevice);
								elevatorVideoIsOpen = 1;
							} else {
								isNewElevatorAlarm = 1;
								// 更新数据
								document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
							}
						} else {
							for (var i = 0; i < elevatorAlarmDevice.length; i++) {
								if (elevatorAlarmDevice[i].deviceId == json.deviceId) {
									elevatorAlarmDevice[i].floorDisplaying = json.floorDisplaying;
									elevatorAlarmDevice[i].runningState = json.runningState;
									elevatorAlarmDevice[i].alarmName = json.alarmName;
									elevatorAlarmDevice[i].cameraStatus = json.cameraStatus;
									if (elevatorVideoIsOpen == 1) {
										document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
									}
								}
							}
						}
					}
				} else {
					if (json.alarmType == 1 && json.alarmCode == "37") {
						getelevatorAlarmData();
					}
				}
			}
		});

		stompClient.subscribe('/topic/elevatorAlarmVideoPopoverRunningData/' + projectCode, function(result) {
			var elevatorJson = JSON.parse(result.body);
			if (elevatorAlarmDevice.length > 0) {
				for (var i = 0; i < elevatorAlarmDevice.length; i++) {
					if (elevatorAlarmDevice[i].deviceId == elevatorJson.deviceId) {
						elevatorAlarmDevice[i].floorDisplaying = elevatorJson.floorDisplaying;
						elevatorAlarmDevice[i].runningState = elevatorJson.runningState;
						if (elevatorVideoIsOpen == 1) {
							document.getElementById('show-elevator-alarm-video-iframe').contentWindow.updateElevatorInfo();
						}
					}
				}
			}
		});

		/**
		 * 消防火警报警视频弹窗
		 */
		stompClient.subscribe('/topic/ffmAlarmVideoData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			if (json.firesVideoMonitorDTO != null) {
				firesVideoDeviceMap = new HashMap();
				getAllFireFightingCameras();
				//清除原来的，防止有影响
				tempCameraId = null;
			    tempCameraId = json.firesVideoMonitorDTO.cameraDeviceId;
				var dto = {
					"firesDeviceId" : json.firesVideoMonitorDTO.firesDeviceId,
					"cameraName" : json.firesVideoMonitorDTO.cameraName,
					"fireAlarm" : json.firesVideoMonitorDTO.fireAlarm,
					"cameraDeviceId" : json.firesVideoMonitorDTO.cameraDeviceId,
					"cameraStatus" : json.firesVideoMonitorDTO.cameraStatus,
					"recordId" : json.firesVideoMonitorDTO.recordId,
					"eventConfirm" : json.firesVideoMonitorDTO.eventConfirm,
					"confirmType" : json.firesVideoMonitorDTO.confirmType,
					"mark" : json.firesVideoMonitorDTO.mark,
					"msgId" : json.firesVideoMonitorDTO.msgId
				};
				if(firesVideoDeviceMap.get(tempCameraId) != null || typeof (firesVideoDeviceMap.get(tempCameraId)) != "undefined"){
					firesVideoDeviceMap.remove(tempCameraId);
				}
				firesVideoDeviceMap.put(json.firesVideoMonitorDTO.cameraDeviceId, dto);
                firesVideoDeviceList = new Array();
				var values = firesVideoDeviceMap.values();
				for ( var i in values) {
					if (values[i].fireAlarm == 1) {
						if (values[i].cameraDeviceId == tempCameraId) {
							firesVideoDeviceList.unshift({
								"itemText" : values[i].cameraName,
								"itemData" : values[i].cameraDeviceId
							});
						} else {
							firesVideoDeviceList[firesVideoDeviceList.length] = {
								"itemText" : values[i].cameraName,
								"itemData" : values[i].cameraDeviceId
							};
						}
					}
				}
				if (json.firesVideoMonitorDTO.fireAlarm == 1) {
                    openVideoPage();
				}else{
					if (typeof ($("#fires-alarm-video-modal").val()) != "undefined") {
						document.getElementById('fires-alarm-video-iframe').contentWindow.initFiresVideoDropDownList();
					}
				}
			}
		});
	}
}
// 获取饼图echart
function getBingEchart(reportId, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + reportId + "?projectCode=" + projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption($.parseJSON(data));
		},
		error : function(req, error, errObj) {
		}
	});
}

// 更新供配电3D页面
function updateSupplyPower3DPageData(result) {
	$("#id_publicPowerConsumption").html(result.publicPowerConsumption);// 公共能耗
	getBingEchart(127, "power_echart");
}

// 更新停车场3D页面
function updateParking3DPageData(result) {
	$("#car_inPassageNum").html(result.inPassageCarNumDaily);
}

// 停车场模块数据
function getParking3DPageData() {
	$.ajax({
		type : "post",
		url : ctx + "/parking/parkingMain/getParking3DPageData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				var result = data.data;
				$("#car_inPassageNum").html(result.inPassageCarNumDaily);
			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});
}
// 定时获取环境数据
function getEnvRealTimeData() {
	$.ajax({
		type : "post",
		url : ctx + "/system/envMonitorManage/getEnvNowData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				showEnvDiv();
				var envMonitorVO = data.RETURN_PARAM;
				$("#co2RealTimeOutDoor").html(envMonitorVO.co2NowOutDoor);
				$("#pm25RealTimeOutDoor").html(envMonitorVO.pm25NowOutDoor);
				// setInterval(removeEnvDiv,4000);
				removeEnvDiv();
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
function showEnvDiv() {
	setTimeout(function() {// 2秒后显示ʾ
		$("#env_bubble_small").fadeIn();
	}, 1000);
	setTimeout(function() {// 2秒后显示ʾ
		$("#env_bubble_big").fadeIn();
	}, 1500);
	setTimeout(function() {// 6秒后显示ʾ
		$("#env_bubble").fadeIn();
		$("#pm25").fadeIn();
		$("#co2").fadeIn();
		$("#co2RealTimeOutDoor").fadeIn();
		$("#pm25RealTimeOutDoor").fadeIn();
	}, 2000);
}

function removeEnvDiv() {
	setTimeout(function() {// 2秒后消失
		$("#co2RealTimeOutDoor").fadeOut();
		$("#pm25RealTimeOutDoor").fadeOut();
		$("#env_bubble").fadeOut();
		$("#env_bubble_big").fadeOut();
		$("#env_bubble_small").fadeOut();
		$("#pm25").fadeOut();
		$("#co2").fadeOut();
	}, 4000);
}

/**
 * 获取所有的消防摄像头
 *
 * @param deviceId
 * @returns
 */
function getAllFireFightingCameras() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingManage/getFiresAlarmVideoCache",
		dataType : "json",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				console.log(data);
				var lists = data.data;
				$.each(lists, function(index, value) {
					if (value.fireAlarm == 1) {
						var dto = {
							"firesDeviceId" : value.firesDeviceId,
							"cameraName" : value.cameraName,
							"fireAlarm" : value.fireAlarm,
							"cameraDeviceId" : value.cameraDeviceId,
							"cameraStatus" : value.cameraStatus,
							"recordId" : value.recordId,
							"eventConfirm" : value.eventConfirm,
							"confirmType" : value.confirmType,
							"mark" : value.mark,
							"msgId" : value.msgId
						};
						firesVideoDeviceMap.put(value.cameraDeviceId, dto);
					}
				});
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	})

}

function openVideoPage() {
	if (typeof ($("#fires-alarm-video-modal").val()) == "undefined") {
        createSimpleModalWithIframe("fires-alarm-video", 704, 878, ctx + "/fireFightingManage/firesVideoMonitorForArea?videoType=fire-fighting", "", "", "100px","","blue");
		openModal("#fires-alarm-video-modal", false, false);
		$(".modal-dialog").css("transform", "none");
		hiddenScroller();
	} else {
		document.getElementById('fires-alarm-video-iframe').contentWindow.initFiresVideoDropDownList();
		document.getElementById('fires-alarm-video-iframe').contentWindow.showTip();
	}
}

function updateElevatorStatus(data) {
	if (data.alarmType == 1 && data.alarmCode == 37) {
		if (elevatorAlarmNum == 0 && maintenanceState == 1) {
			$(".redMoveElevatorDiv").css("z-index", "4");
		}
		elevatorAlarmNum = elevatorAlarmNum + 1;
	}
	if (data.alarmType != 1 && data.alarmCode == 37) {
		if (elevatorAlarmNum == 1 && maintenanceState == 1) {
			$(".redMoveElevatorDiv").css("z-index", "2");
		}
		elevatorAlarmNum = elevatorAlarmNum - 1;
	}
}

function getElevatorStatus() {
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorDataService/getElevatorStatusList?projectCode=" + projectCode,
		dataType : "json",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.data != null && data.data != "") {
				maintenanceState = data.data.allMaintenanceState;
				elevatorDataList = data.data.elevatorDataList;
				if (data.data.allElevatorState != 1 || maintenanceState != 1) {
					$(".redMoveElevatorDiv").css("z-index", "4");
				}
				if (data.data.allElevatorState != 1) {
					for (var i = 0; i < elevatorDataList.length; i++) {
						var elevatorData = elevatorDataList[i];
						if (elevatorData.elevatorState == 0) {
							elevatorAlarmNum = elevatorAlarmNum + 1;
						}
					}
				}
			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});
}

/**
 * 获取项目所有的设备数，正常异常数
 * @returns
 */
function getProjectDeviceNum() {
	$.ajax({
		type : "post",
		url : ctx + "/device/homePage/getProjectDeviceCount?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				$.each(data, function(index, value) {
					if (index == 'HVAC') {
						$("#hvac_system_detail_num").html(value.projectTotalNum);
					} else if (index == 'ELEVATOR') {
						$("#elevatorm_device_num").html(value.projectTotalNum);
					} else if (index == 'ACCESS_CONTROL') {
					} else if (index == 'POWER_SUPPLY') {
					} else if (index == 'FIRE_FIGHTING') {
						$("#fire_system_detail_num").html(value.projectTotalNum);
					} else if (index == 'SUPPLY_DRAIN') {
					} else if (index == 'VIDEO_MORNITORING') {
					} else if (index == 'PARKING') {
						$("#basementBlock_parking_num").html(value.projectTotalNum);
					}
				});
				$("#env_system_detail_num").html(1);
				getBaseDeviceInfo();
				$("#face_system_detail_num").html(3);
				$("#visitor_system_detail_num").html(2);
				$("#traffic_system_detail_num").html(1);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function getBaseDeviceInfo(){
	$.ajax({
		type: "post",
		url: ctx + "/fire-fighting/fireFightingManage/getWaterDeviceBaseInfo?projectCode="+parent.projectCode,
		async: false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data.data != null && data.code==0) {
				var pageDataVO = data.data;
				$("#water_system_detail_num").html(pageDataVO.waterOnline + pageDataVO.waterOffline);
			}
		},
		error: function(req, error, errObj) {
		}
	});
}