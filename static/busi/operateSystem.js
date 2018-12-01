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
		// 告警中心告警
		stompClient.subscribe('/topic/operateSystemData/' + projectCode,
				function(result) {
					var json = JSON.parse(result.body);
					websocketCallBack(json);
				});
	}, onerror);
}

// 根据类型转入不同的方法
function websocketCallBack(json) {
	if (json.type == 'ALARM') {
		handelNewestAlarmData(json.data);
	} else if (json.type == 'TEST') {
	} else if (json.type == 'ACCESS_CONTROL') {
		undateAccessData(json.data);
		showFaceRecoginaze(json.data);
	} else if (json.type == 'FIRE_FIGHTING') {
	} else if (json.type == 'SUPPLY_DRAIN') {
	} else if (json.type == 'VIDEO_MORNITORING') {
	} else if (json.type == 'POWER_SUPPLY') {
	} else if (json.type == 'HVAC') {
	} else if (json.type == 'PARKING') {
		updateParkingData(json.data);
	} else if (json.type == 'ENV_MONITOR') {
		setEnvMaxMinVO(json.data);
	} else if (json.type == 'ELEVATOR') {
		if (json.data.uuid == undefined) {
			// 没有uuid说明是运行数据
			updateRunningData(json.data);
		} else {
			updateAlarmData(json.data);
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
// 获取饼图echart
function getBingEchart(reportId, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + reportId+"?projectCode="+projectCode,
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

/**
 * 根据设备类型id获取图片
 * 
 * @param deviceTypeId
 * @returns
 */
function handleImage(deviceTypeId) {
	var url = "";
	if (deviceTypeId == 1) {
		// 电梯
		url = ctx + "/static/img/device/deviceIcon/diantixitong.svg";
	} else if (deviceTypeId == 2) {
		// 稳压泵
		url = ctx + "/static/img/device/deviceIcon/jishui.svg";
	} else if (deviceTypeId == 3) {
		// 集水坑潜水泵
		url = ctx + "/static/img/device/deviceIcon/paishui.svg";
	} else if (deviceTypeId == 4) {
		// 三相电力仪表
		url = ctx + "/static/img/device/deviceIcon/qiangdian.svg";
	} else if (deviceTypeId == 6 || deviceTypeId == 7 || deviceTypeId == 8
			|| deviceTypeId == 9 || deviceTypeId == 10 || deviceTypeId == 11) {
		// 冷机 冷却泵 冷冻泵 冷却塔 集水器 分水器
		url = ctx + "/static/img/device/deviceIcon/lengyuan.svg";
	} else if (deviceTypeId == 12 || deviceTypeId == 13 || deviceTypeId == 32
			|| deviceTypeId == 33) {
		// 暖源集水器 暖源分水器 锅炉 热水循环泵
		url = ctx + "/static/img/device/deviceIcon/nuanyuan.svg";
	} else if (deviceTypeId == 14) {
		// 全热新风机
		url = ctx + "/static/img/device/deviceIcon/xinfeng.svg";
	} else if (deviceTypeId == 15) {
		// 排风机
		url = ctx + "/static/img/device/deviceIcon/paifeng.svg";
	} else if (deviceTypeId == 16) {
		// 温控面板
		url = ctx + "/static/img/device/deviceIcon/shineiwendu.svg";
	} else if (deviceTypeId == 17) {
		// 空调机组
		url = ctx + "/static/img/device/deviceIcon/kongtiao.svg";
	} else if (deviceTypeId == 18 || deviceTypeId == 19 || deviceTypeId == 22 || deviceTypeId == 23) {
		// 门禁控制板 门禁读头
		url = ctx + "/static/img/device/deviceIcon/menjin.svg";
	} else if (deviceTypeId == 20 || deviceTypeId == 21) {
		// 人行摆闸控制板 人行摆闸读头
		url = ctx + "/static/img/device/deviceIcon/renxingbaizha.svg";
	} else if (deviceTypeId == 24 || deviceTypeId == 25 || deviceTypeId == 26) {
		// 道闸控制板 显示屏 车牌识别相机
		url = ctx + "/static/img/device/deviceIcon/tingchechang.svg";
	} else if (deviceTypeId == 27 || deviceTypeId == 28 || deviceTypeId == 38
			|| deviceTypeId == 39 || deviceTypeId == 40 || deviceTypeId == 41
			|| deviceTypeId == 42 || deviceTypeId == 43 || deviceTypeId == 44
			|| deviceTypeId == 45 || deviceTypeId == 46 || deviceTypeId == 47
			|| deviceTypeId == 48 || deviceTypeId == 49 || deviceTypeId == 51
			|| deviceTypeId == 52 || deviceTypeId == 53 || deviceTypeId == 55
			|| deviceTypeId == 56 || deviceTypeId == 57 || deviceTypeId == 60
			|| deviceTypeId == 61 || deviceTypeId == 62 || deviceTypeId == 34
			|| deviceTypeId == 69 || deviceTypeId == 68 || deviceTypeId == 73
			|| deviceTypeId == 72 || deviceTypeId == 74) {
		// 消防
		// 道闸控制板 显示屏 车牌识别相机
		url = ctx + "/static/img/device/deviceIcon/xiaofangbaojing.svg";
	} else if (deviceTypeId == 75 || deviceTypeId == 76 || deviceTypeId == 64
			|| deviceTypeId == 67) {
		// 道闸控制板 显示屏 车牌识别相机
		url = ctx + "/static/img/device/deviceIcon/xiaofangmoduanshishui.svg";
	}else if(deviceTypeId == 70 || deviceTypeId == 71){
		// 普通监控相机 NVR
		url = ctx+"/static/img/device/deviceIcon/jiankong.svg";
	}
	return url;
}

// 处理推送的告警信息
function handelNewestAlarmData(data) {
	var deviceName = data.deviceName;
	var describe = data.describe;
	var deviceTypeId = data.deviceTypeId;
	var lastAlarmTime = data.lastAlarmTime;
	var level = data.level;
	var devicePosition = data.devicePosition;
	var alarmColor = "#FF7600";
	// var imgurl=ctx+"/static/img/operateSystem/paifeng.svg";
	var imgurl = handleImage(deviceTypeId);
	if (level == 1) {
		alarmColor = "#EF2D2D";
		level = "高级";
	} else if (level == 2) {
		alarmColor = "#FF7600";
		level = "中级";
	} else {
		alarmColor = "#C59B1E";
		level = "低级";
	}
	var dian = "..";
	if (undefined == devicePosition) {
		devicePosition = "";
	}
	if (devicePosition.length >= 5) {
		devicePosition = devicePosition.substring(0, 4);
		devicePosition = devicePosition+dian;
	}
	if (describe.length >= 5) {
		describe = describe.substring(0, 4);
		describe = describe+dian;
	}
	if(deviceName != undefined){
		if (deviceName.length >= 8) {
			deviceName = deviceName.substring(0, 7);
			deviceName = deviceName+dian;
		}
	}else{
		deviceName = "";
	}
	street = street + 1;
	var remar = "remar" + street;
	// 删除最后一条，新增第一条
	$("#alarmLimit > div:last").remove();
	var height = "100%";
	var html = '';
	html += '<div id="'
			+ remar
			+ '" class="alarm_box"><table style="height: '+height+'; width: 100%;"><tr>'
			+ '<td rowspan="2" class="alarm_tr"><img style="vertical-align: bottom;"src="'
			+ imgurl + '"></td>'
			+ '<td id="" class="alarm_device_name" colspan="2">' + deviceName
			+ '</td><td class="alarm_type" align="right">' + lastAlarmTime
			+ '</td>' + '</tr><tr><td class="alarm_type">' + describe
			+ '</td><td class="alarm_type">' + '' + devicePosition
			+ '</td><td align="right"><div class="alarm_class"'
			+ 'style="background: ' + alarmColor + ';">' + level
			+ '</div></td></tr></table></div>';
	$("#alarmLimit").prepend(html);
}

// 获取最新报警信息
function getNewestAlarmData() {
	// newestAlarm = setTimeout("getNewestAlarmData()",10000);
	$
			.ajax({
				type : "post",
				url : ctx + "/alarm-center/alarmRecord/getAlarmRecordLimitInfo",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data != null) {
						// /$("#remar").remove();
						var stree = 0;
						$("#alarmLimit").find("div").remove();
						$(eval(data))
								.each(
										function() {
											stree = stree + 1;
											var remar = "remar" + stree;
											var deviceName = this.deviceName;
											var describe = this.describe;
											var deviceTypeId = this.deviceTypeId;
											var lastAlarmTime = this.lastAlarmTime;
											var level = this.level;
											var devicePosition = this.devicePosition;
											var alarmColor = "#FF7600";
											var imgurl = handleImage(deviceTypeId);
											var dian = "..";
											if (level == 1) {
												alarmColor = "#EF2D2D";
												level = "高级";
											} else if (level == 2) {
												alarmColor = "#FF7600";
												level = "中级";
											} else {
												alarmColor = "#C59B1E";
												level = "低级";
											}
											if (undefined == devicePosition) {
												devicePosition = "";
											}
											if (devicePosition.length >= 5) {
												devicePosition = devicePosition.substring(0, 4);
												devicePosition = devicePosition+dian;
											}
											if (describe.length >= 5) {
												describe = describe.substring(0, 4);
												describe = describe+dian;
											}
											if(deviceName != undefined){
												if (deviceName.length >= 8) {
													deviceName = deviceName.substring(0, 7);
													deviceName = deviceName+dian;
												}
											}else{
												deviceName = "";
											}
											var html = '';
											var height = "100%";
											if(remar == "remar1"){
												height = "94%";
											}
											html += '<div id="'
													+ remar
													+ '" class="alarm_box"><table style="height: '+height+'; width: 100%;"><tr>'
													+ '<td rowspan="2" class="alarm_tr"><img style="vertical-align: bottom;"src="'
													+ imgurl
													+ '"></td>'
													+ '<td id="" class="alarm_device_name" colspan="2">'
													+ deviceName
													+ '</td><td class="alarm_type" align="right">'
													+ lastAlarmTime
													+ '</td>'
													+ '</tr><tr><td class="alarm_type">'
													+ describe
													+ '</td><td class="alarm_type">'
													+ ''
													+ devicePosition
													+ '</td><td align="right"><div class="alarm_class"'
													+ 'style="background: '
													+ alarmColor
													+ ';">'
													+ level
													+ '</div></td></tr></table></div>';
											$("#alarmLimit").append(html);
										});
					}
				},
				error : function(req, error, errObj) {
				}
			});

}

function parkingCountEchart() {
	getBingEchart(117, "parkingEchart");
	getParkingData();
}

function getParkingData(){
	//停车场模块数据初始化
		  $.ajax({
		        type : "post",
		        url : ctx + "/parking/parkingMain/getParkingOperationSystemPageData?projectCode="+projectCode,
		        dataType : "json",
		        contentType : "application/json;charset=utf-8",
		        success : function(data) {
			        if( data.code==0&&data.data!=null){
			        	var result  = data.data;
			        		$("#parking_remainParkingSpace").html(result.remainParkingSpace); //剩余车位
			        		$("#parking_inPassageCarNum").html(result.inPassageCarNum); //入口车流量
			        		var licenceInfoObj = result.licenceInfos;
			        		for(var i in licenceInfoObj){
			        			
			        			var carColor = "temp_car";
			        			if(licenceInfoObj[i].carType =='固定车'){
			        				carColor ="fixed_car";
			        			}else if(licenceInfoObj[i].carType =='访客车'){
			        				carColor ="visit_car";
			        			}else{
			        				carColor = "temp_car"
			        			}
			        			
			        			var divLicence ="<div class='car_info'><div class='car_plate'>"+licenceStrDeal(licenceInfoObj[i].licencePlate) +"</div>" +
			        					"<div class='car_type "+carColor+"'>"+licenceInfoObj[i].carType +"</div>" +
			        					"<div class='car_time'>"+licenceInfoObj[i].inTime+"</div>" +
			        					"</div>";
			        			
			        			$("#parking_licenceDiv").append(divLicence);
			        			
			        		}
			        		
			        }else{
			        	
			        }
		        },
		        error : function(req,error, errObj) {
		            return;
		            }
		        });
}

//加载投屏电梯基础信息
function getDisplayElevator() {
	$
			.ajax({
				type : "post",
				url : ctx + "/device/manage/getCurrDisplayElevators",
				success : function(data) {
					if (data && data.code == 0 && data.data) {
						var currElevator = data.data;
						var newElevatorDiv = '';
						for (var i = 0; i < currElevator.length; i++) {
							var val = currElevator[i];
							// 处理电梯名称：最多显示6个汉字，超出显示...
							var currElevatorName = val.name;
							if (currElevatorName.length > 6) {
								currElevatorName = currElevatorName.substring(0,5) + "...";
							}
							if (displayElevatorList == "") {
								displayElevatorList = val.id;
							} else {
								displayElevatorList = displayElevatorList + ","
										+ val.id;
							}
							$(".dianti_status").find("img").eq(i).attr("id","img"+val.deviceNumber);
							newElevatorDiv = '<div class="elevator_area" id="body'
									+ val.deviceNumber
									+ '">'
									+ '<div id="parent'
									+ val.deviceNumber
									+ '" style="width: 90px; height: 100%;">'
									+ '<div class="elevator_name">'
									+ currElevatorName
									+ '</div>'
									+ '<div id="backImage'
									+ val.deviceNumber
									+ '" class="elevator_img" style="background-image: url('
									+ diantikongxianImage
									+ ')">'
									+ '</div>'
									+ '<div id="runningStatus'
									+ val.deviceNumber
									+ '" class="elevator_descript" style="margin-top: 14px;">电梯正在空闲</div>'
									+ '<div id="floor'
									+ val.deviceNumber
									+ '" class="elevator_descript" style="margin-top: 4px;">当前停留1F</div>'
									+ '</div></div>'
							$("#elevatorBox").append(newElevatorDiv);
						}
						// 电梯设备相关数据加载完毕后马上获取最新的电梯运行数据
						getFirstRunningData(displayElevatorList, true);
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", errObj);
					return;
				}
			});
}

// 初始化电梯运行数据
function getFirstRunningData(displayElevatorList, flag) {
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorDataService/getDisplayElevatorData?deviceIdList="
				+ displayElevatorList + "&projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		async : false,
		success : function(data) {
			if (data && data.code == 0 && data.data) {
				var currElevator = data.data;
				var newElevatorDiv = '';
				var statusPic = diantizhengchangPic;
				for (var i = 0; i < currElevator.length; i++) {
					var val = currElevator[i].runningRecord;
					// 处理电梯名称：最多显示6个汉字，超出显示...
					var currElevatorName = val.deviceName;
					if (currElevatorName.length > 6) {
						currElevatorName = currElevatorName.substring(0,5) + "...";
					}
					if (flag && currElevator[i].alarmNum != 0) {// 当前电梯故障
						yunxingStatus = diantiguzhangImage;
						yunxingStatusText = "故障";
						elevatorAlarmMap.put(val.deviceNo, currElevator[i].alarmNum);
						statusPic = diantiguzhangPic;
					} else {
						// 判断运行状态
						if (val.elevatorState == 1 && val.runningState == 1) {
							yunxingStatus = diantishangImage;
							yunxingStatusText = "上行";
						} else if (val.elevatorState == 1 && val.runningState == 2) {
							yunxingStatus = diantixiaImage;
							yunxingStatusText = "下行";
						} else if (val.elevatorState == 1 && val.runningState == 3) {
							yunxingStatus = diantikongxianImage;
							yunxingStatusText = "空闲";
						} else if (val.elevatorState == 2) {
							yunxingStatus = diantijianxiuImage;
							yunxingStatusText = "检修";
						} else if (val.elevatorState == 3) {
							yunxingStatus = diantizhutingImage;
							yunxingStatusText = "驻停";
						} else {
							yunxingStatus = diantiguzhangImage;
							yunxingStatusText = "故障";
							statusPic = diantiguzhangPic;
						}
						elevatorRunningMap.put(val.deviceNo, yunxingStatusText);
					}
					
					$("#img"+val.deviceNo).attr("src",statusPic);
					
					newElevatorDiv = '<div id="parent'+val.deviceNo+'" style="width: 90px; height: 100%;">'
							+ '<div class="elevator_name">'+currElevatorName+'</div>'
							+ '<div id="backImage'+val.deviceNo+'" class="elevator_img" style="background-image: url('+yunxingStatus+')">'
							+ '</div>'
							+ '<div id="runningStatus'+val.deviceNo+'" class="elevator_descript" style="margin-top: 14px;">电梯正在'+yunxingStatusText
							+ '</div>'
							+ '<div id="floor'+val.deviceNo+'" class="elevator_descript" style="margin-top: 4px;">当前停留'+val.floorDisplaying+'F</div>'
							+ '</div>'
					$("#parent" + val.deviceNo).html(newElevatorDiv);
				}
			}
		},
		error : function(req, error, errObj) {
			return;
		}
	});
}

//更新某个电梯的状态-运行数据
function updateRunningData(val) {
	var status = diantizhengchangPic;
	var oldBody = $('#body' + val.elevatorCode);
	if (oldBody.attr("class") != 'elevator_area') {
		return;
	}
	// 判断运行状态
	if (val.elevatorState == 1 && val.runningState == 1) {
		yunxingStatus = diantishangImage;
		yunxingStatusText = "电梯正在上行";
	} else if (val.elevatorState == 1 && val.runningState == 2) {
		yunxingStatus = diantixiaImage;
		yunxingStatusText = "电梯正在下行";
	} else if (val.elevatorState == 1 && val.runningState == 3) {
		yunxingStatus = diantikongxianImage;
		yunxingStatusText = "电梯正在空闲";
	} else if (val.elevatorState == 2) {
		yunxingStatus = diantijianxiuImage;
		yunxingStatusText = "电梯正在检修";
	} else if (val.elevatorState == 3) {
		yunxingStatus = diantizhutingImage;
		yunxingStatusText = "电梯正在驻停";
	} else {
		yunxingStatus = diantiguzhangImage;
		yunxingStatusText = "电梯正在故障";
		status = diantiguzhangPic;
	}
	//更新电梯状态
	$("img"+val.elevatorCode).attr("src",status);
	// 更新电梯背景图
	var t_body = $('#backImage' + val.elevatorCode);
	t_body.css("background-image", "url(" + yunxingStatus + ")");

	// 更新运行状态语句
	var t_running = $('#runningStatus' + val.elevatorCode);
	t_running.html(yunxingStatusText);

	// 更新楼层展示语句
	var floorDisplay = '电梯当前停留' + val.floorDisplaying + 'F';
	var t_floor = $('#floor' + val.elevatorCode);
	t_floor.html(floorDisplay);
}

//更新某个电梯的状态-告警数据
function updateAlarmData(val) {
	var oldBody = $('#body' + val.elevatorCode);
	if (oldBody.attr("class") != 'elevator_area') {
		return;
	}
	
	// 默认视为产生告警数据
	yunxingStatus = diantiguzhangImage;
	yunxingStatusText = "电梯正在故障";
	var status = diantiguzhangPic;
	
	if (val.alarmType == 2) {
		// 如果告警恢复的数据，判断之前告警数减去-1后是否为零，为零说明这台电梯已经没有告警数则显示空闲图，否则还是显示故障图
		var oldAlarmNum = elevatorAlarmMap.get(val.elevatorCode);
		if (oldAlarmNum - 1 <= 0) {
			var tempStatus = elevatorRunningMap.get(val.elevatorCode);
			if (tempStatus == "上行") {
				yunxingStatus = diantishangImage;
				yunxingStatusText = "电梯正在上行";
				status = diantizhengchangPic;
			} else if (tempStatus == "下行") {
				yunxingStatus = diantixiaImage;
				yunxingStatusText = "电梯正在下行";
				status = diantizhengchangPic;
			} else if (tempStatus == "空闲") {
				yunxingStatus = diantikongxianImage;
				yunxingStatusText = "电梯正在空闲";
				status = diantizhengchangPic;
			} else if (tempStatus == "检修") {
				yunxingStatus = diantijianxiuImage;
				yunxingStatusText = "电梯正在检修";
				status = diantizhengchangPic;
			} else if (tempStatus == "驻停") {
				yunxingStatus = diantizhutingImage;
				yunxingStatusText = "电梯正在驻停";
				status = diantizhengchangPic;
			} else {
				yunxingStatus = diantiguzhangImage;
				yunxingStatusText = "电梯正在故障";
				status = diantiguzhangPic;
			}
		}
		elevatorAlarmMap.put(val.elevatorCode, oldAlarmNum - 1);
	}
	//更新电梯状态
	$("img"+val.elevatorCode).attr("src",status);
	
	// 更新电梯背景图
	var t_body = $('#backImage' + val.elevatorCode);
	t_body.css("background-image", "url(" + yunxingStatus + ")");
	
	// 更新运行状态语句
	var t_running = $('#runningStatus' + val.elevatorCode);
	t_running.html(yunxingStatusText);
}

//视频监控轮播
var video_deviceId = "";
function callbackLoadVideo() {
	loadVideo();
}
function loadVideo() {
	$.ajax({
		type : "post",
		url : ctx + "/video-monitoring/video/cameraCarousel?projectCode="
				+ projectCode + "&deviceId=" + video_deviceId,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data) {
				video_deviceId = data.id;
				$("#video_name").html(data.name);
				showVideo(video_deviceId);
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
	setTimeout("loadVideo()", 60000 * 2);
}

function showVideo(deviceId) {
	$("#video-iframe")[0].contentWindow.closeVideo();
	$("#video-iframe")[0].contentWindow.startPlay(deviceId);
}

function hiddenScroller() {
	var height = $(window).height();
	if (height > 1070) {
		document.documentElement.style.overflowY = 'hidden';
	} else {
		document.documentElement.style.overflowY = 'auto';
	}
}
$(window).resize(function() {
	var height = $(this).height();
	if (height > 1070) {
		document.documentElement.style.overflowY = 'hidden';
		$(".modal-open .modal").css("overflow-y","hidden");
	} else {
		document.documentElement.style.overflowY = 'auto';
	}

});
/**
 * 查询环境监测数据（所有,进入页面时调用）
 * 
 * @returns
 */
function getEnvMonitorData() {
	$.ajax({
		type : "post",
		url : ctx
				+ "/system/envMonitorManage/getAllEnvMonitorData?projectCode="
				+ projectCode + "&page=OPERATE_PAGE",
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var envMonitorVO = data.RETURN_PARAM.envMonitorVO;
				setEnvMonitorVO(envMonitorVO);
				setEnvMaxMinVO(envMonitorVO);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

/**
 * 查询实时环境信息
 * 
 * @returns
 */
function getEnvNowData() {
	$.ajax({
		type : "post",
		url : ctx + "/system/envMonitorManage/getEnvNowData?projectCode="
				+ projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var envMonitorVO = data.RETURN_PARAM;
				setEnvMonitorVO(envMonitorVO);

			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function showValue(data) {
	if (data != "--") {
		if(Number(data)>=10000){
			return (Number(data)/10000).toFixed(1) +"万";
		}
		return Number(data).toFixed(1);
	} else {
		return "--";
	}
}

function setEnvMonitorVO(envMonitorVO) {
	$("#co2NowOutDoor").html(showValue(envMonitorVO.co2NowOutDoor) + "ppm");
	$("#co2NowInDoor").html(showValue(envMonitorVO.co2NowInDoor) + "ppm");
	$("#pm25NowOutDoor").html(showValue(envMonitorVO.pm25NowOutDoor) + "μg/m³");
	$("#pm25NowInDoor").html(showValue(envMonitorVO.pm25NowInDoor) + "μg/m³");

}

function setEnvMaxMinVO(envMonitorVO) {
	$("#co2MaxOutDoor").html(showValue(envMonitorVO.co2MaxOutDoor) + "ppm");
	$("#co2MinOutDoor").html(showValue(envMonitorVO.co2MinOutDoor) + "ppm");
	$("#co2MaxInDoor").html(showValue(envMonitorVO.co2MaxInDoor) + "ppm");
	$("#co2MinInDoor").html(showValue(envMonitorVO.co2MinInDoor) + "ppm");
	$("#pm25MaxOutDoor").html(showValue(envMonitorVO.pm25MaxOutDoor) + "μg/m³");
	$("#pm25MinOutDoor").html(showValue(envMonitorVO.pm25MinOutDoor) + "μg/m³");
	$("#pm25MaxInDoor").html(showValue(envMonitorVO.pm25MaxInDoor) + "μg/m³");
	$("#pm25MinInDoor").html(showValue(envMonitorVO.pm25MinInDoor) + "μg/m³");
}
/**
 * 1分钟刷新一次环境实时数据
 * 
 * @returns
 */
function flushEnvNowData() {
	getEnvNowData();
	setTimeout("flushEnvNowData()", 60000);
}
/**
 * 1分钟刷新一次供配电实时数据
 * 
 * @returns
 */
function flushPdsData() {
	getPdsOperateSysData();
	setTimeout("flushPdsData()", 60000);
}

//更新停车场数据
function updateParkingData(data){
	//车牌信息
	var licenceInfo = data.licenceInfo;
	//入场类型
	openDoor(licenceInfo.passageType);//动画效果
	
	if(licenceInfo.passageType==1){
		$("#parking_remainParkingSpace").html(data.remainParkingSpace); //剩余车位
		$("#parking_inPassageCarNum").html(data.inPassageCarNum); //入口车流量
		
		if($("#parking_licenceDiv").children().length>3){
			$("#parking_licenceDiv").children().eq(3).remove();
		}
		var carColor = "temp_car";
		if(licenceInfo.carType =='固定车'){
			carColor ="fixed_car";
		}else if(licenceInfo.carType =='访客车'){
			carColor ="visit_car";
		}else{
			carColor = "temp_car"
		}
		var licenceDiv ="<div class='car_info'><div class='car_plate'>"+licenceStrDeal(licenceInfo.licencePlate) +"</div>" +
			"<div class='car_type "+carColor+"'>"+licenceInfo.carType +"</div>" +
			"<div class='car_time'>"+licenceInfo.inTime+"</div>" +
			"</div>";
		
		$("#parking_licenceDiv").prepend(licenceDiv);
	}

	
	
}

//车牌切割-中间加空格
function licenceStrDeal(strData){
	if(strData!=null && strData.length>2){
		return strData.substring(0,2) + "&nbsp"+ strData.substring(2,strData.length);
	}
}

//人行流量数据处理
function getProjectFaceWall() {
	$.ajax({
		type : "post",
		url : ctx
				+ "/access-control/accessStatistics/getProjectFaceWall?projectCode="
				+ projectCode,
		async : false,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(result) {
			if (result && typeof(result.code) != undefined && result.code == 0) {
				undateAccessData(result.data)
			}
		},
		error : function(req, error, errObj) {
		}
	});
}
function undateAccessData(data){
	//数据百分比处理
	if(typeof(data.totalNum) != 'undefined'){
		if (data.totalNum >= 10000) {
			$("#access-totalNum").html(Math.floor(data.totalNum *10/10000) / 10 + "万");
		}else{
			$("#access-totalNum").html(data.totalNum);
		}
	}
	if(data.totalNum > 0){
		accessChangePercent("access-gender",Math.round(100*data.genderPercent/data.totalNum));
		accessChangePercent("access-age",Math.round(100*data.agePercent/data.totalNum));
		accessChangePercent("access-owner",Math.round(100*data.ownerPercent/data.totalNum));
	}
	//人脸图片处理
	if(data.userList){
		appendFaceImage(data.userList);
	}
}
//人行流量更改百分比
function accessChangePercent(id, leftPercent){
	if(typeof(leftPercent) == 'undefined'){
		return;
	}
	if(leftPercent < 0){
		leftPercent = 0;
	}
	if(leftPercent > 100){
		leftPercent = 100;
	}
	$("#" + id + " .mask").animate({left: leftPercent + "%"}, 500);
	$("#" + id + " .left-percent").html(leftPercent + "%");
	$("#" + id + " .right-percent").html((100 - leftPercent) + "%");
}
//人行流量人脸图片
function appendFaceImage(userList){
	jQuery.each(userList.reverse(), function(i, val) { 
		if($("#facewall_" + val.personId).length > 0){
			$("#facewall_" + val.personId).remove();
		} else{
			var faceSize = $("#access-face .face_info").size();
			if(faceSize >= 8){
				$("#access-face .face_info:last").remove();
			}
		}
		var faceClass = "face_img";
		if(val.personType == 0){
			faceClass = "face_img face_stranger_img";
		}
		var faceHtml = '<div class="face_info" id="facewall_' + val.personId + '"><img class="' + faceClass + '" src="' + val.faceUrl + '"></div>';
		//startFaceRecoginaze(val.faceUrl);//开始展现人脸识别效果
		$("#access-face").prepend(faceHtml);
	});
}

function showFaceRecoginaze(data){
	jQuery.each(data.userList.reverse(), function(i, val) {
		startFaceRecoginaze(val.faceUrl);//开始展现人脸识别效果
	});
}
