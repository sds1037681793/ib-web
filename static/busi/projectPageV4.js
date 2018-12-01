


function flushProjectAccessControlData() {
	if (typeof (flushProjectAccessControl) != "undefined"
			&& 'undefined' != typeof ($("#project-access-control").val())) {
		getProjectAccessControlData(2);
		flushProjectAccessControl = setTimeout("flushProjectAccessControlData()", 60000);

	}
}

function flushProjectParkingData() {
	if (typeof (flushProjectParking) != "undefined"
			&& 'undefined' != typeof ($("#parking_remainParkingSpace").val())) {
		getParkingProjectData();
		flushProjectParking = setTimeout("flushProjectParkingData()", 60000);
	}
}

function getProjectAccessControlData(type) {
	$.ajax({
		type : "post",
		url : ctx + "/access-control/accessStatistics/projectData?projectCode="+projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(result) {
			if (result && typeof(result.code) != undefined && result.code == 0) {
				var returnVal = result.data;
				$("#project-access-control-abnormal").html(returnVal.deviceAbnormalNum);
// $("#project-access-control-door").html(returnVal.doorNum);

				var visitor = returnVal.pgInVisitorRecordNum
				if (visitor >= 10000) {
					visitor = Math.floor(visitor*100/10000) / 100;
					$("#project-access-control-visitor").next().show();
				} else {
					$("#project-access-control-visitor").next().hide();
				}
				$("#project-access-control-visitor").html(visitor);

/*
 * var pgOutRecordNum = returnVal.pgOutRecordNum; if (pgOutRecordNum >= 10000) {
 * pgOutRecordNum = Math.floor(pgOutRecordNum *100/10000) / 100;
 * $("#project-access-control-out").next().show(); } else {
 * $("#project-access-control-out").next().hide(); }
 * $("#project-access-control-out").html(pgOutRecordNum);
 */

				var pgInRecordNum = returnVal.pgInRecordNum;
				if (pgInRecordNum >= 10000) {
					pgInRecordNum = Math.floor(pgInRecordNum *100/10000) / 100;
					$("#project-access-control-in").next().show();
				} else {
					$("#project-access-control-in").next().hide();
				}
				$("#project-access-control-in").html(pgInRecordNum);

				projectAccessControlDeviceNo = returnVal.deviceNum;
				if(type==1){
					projectDeviceStateData("ACCESS_CONTROL",returnVal.deviceNum-returnVal.deviceAbnormalNum,returnVal.deviceAbnormalNum);
				}
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
	getData(121, "project-access-control-report");
}

function setProjectAccessControlAbnormal(data) {
	$("#project-access-control-abnormal").html(data.num);
	projectDeviceStateData("ACCESS_CONTROL",projectAccessControlDeviceNo-data.num,data.num);
}

function goAccessControl(){
	var key="ACCESS-CONTROL-MENU-1";
	var menuValue = menuMap.get(key);
	if(menuValue){
		createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
	}
}

function hvac() {
	$
			.ajax({
				type : "post",
				url : ctx + "/hvac/hvacHomeInformationQuery/project?projectCode="+projectCode,
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if ("REFRIGERATOR" == data.openType) {
						$('#openCount').html(data.openCount);
						if (data.inTemperature == null
								&& data.inPressure == null) {
							$('#refInPressure')
									.html(
											"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						}else if(data.inTemperature == null && data.inPressure != null){
							$('#refInPressure').html(
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
											+ data.inPressure + "mpa");
						}else if(data.inTemperature != null && data.inPressure == null){
							$('#refInPressure').html(
									data.inTemperature + "℃  "
											+ "&nbsp;-");
						}else {
							$('#refInPressure').html(
									data.inTemperature + "℃  &nbsp"
											+ data.inPressure + "mpa");
						}
						if (data.outTemperature == null
								&& data.outPerssure == null) {
							$('#refOutPerssure')
									.html(
											"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						}else if(data.outTemperature == null && data.outPerssure != null){
							$('#refOutPerssure').html(
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
											+ data.outPerssure + "mpa");
						}else if(data.outTemperature != null && data.outPerssure == null){
							$('#refOutPerssure').html(
									data.outTemperature + "℃  "
											+ "&nbsp;-");
						} else {
							$('#refOutPerssure').html(
									data.outTemperature + "℃  &nbsp"
											+ data.outPerssure + "mpa");
						}
						$('#boiInPressure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						$('#boiOutPerssure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
					} else if ("BOILER" == data.openType) {
						$('#openCount').html(data.openCount);
						if (data.inTemperature == null
								&& data.inPressure == null) {
							$('#boiInPressure')
									.html(
											"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						}else if(data.inTemperature == null && data.inPressure != null){
							$('#boiInPressure').html(
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
											+ data.inPressure + "mpa");
						}else if(data.inTemperature != null && data.inPressure == null){
							$('#boiInPressure').html(
									data.inTemperature + "℃  "
											+ "&nbsp;-");
						} else {
							$('#boiInPressure').html(
									data.inTemperature + "℃  &nbsp"
											+ data.inPressure + "mpa");
						}
						if (data.outTemperature == null
								&& data.outPerssure == null) {
							$('#boiOutPerssure')
									.html(
											"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						}else if(data.outTemperature == null && data.outPerssure != null){
							$('#boiOutPerssure').html(
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
											+ data.outPerssure + "mpa");
						}else if(data.outTemperature != null && data.outPerssure == null){
							$('#boiOutPerssure').html(
									data.outTemperature + "℃  "
											+ "&nbsp;-");
						} else {
							$('#boiOutPerssure').html(
									data.outTemperature + "℃  &nbsp"
											+ data.outPerssure + "mpa");
						}
						$('#refInPressure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						$('#refOutPerssure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
					} else if ("" == data.openType) {
						$('#openCount').html("-");
						$('#boiInPressure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						$('#boiOutPerssure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						$('#refInPressure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
						$('#refOutPerssure')
								.html(
										"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
					}

					var normalCount =data.projectTotalCount-data.faultCount;
					var abnormalCount =data.faultCount;
					projectDeviceStateData("HVAC",normalCount,abnormalCount)

				},
				error : function(req, error, errObj) {
					return;
				}
			});
}


function toSubscribe(){
	if (isConnectedGateWay) {
		// 暖通空调首页信息识别结果
		stompClient.subscribe('/topic/projectData/' + projectCode, function(result) {
			var json = JSON.parse(result.body);
			console.log(json);
			websocketCallBack(json);
		});
	}
}


function unloadAndRelease() {
	if(stompClient != null) {
		stompClient.unsubscribe('/topic/projectData/' + projectCode);
	}
}

// 显示暖通首页信息
function displayHvacInfo(data) {
	if ("REFRIGERATOR" == data.openType) {
		$('#openCount').html(data.openCount);
		if(data.inTemperature != null
				|| data.inPressure != null){
		if (data.inTemperature == null
				&& data.inPressure == null) {
			$('#refInPressure')
					.html(
							"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		}else if(data.inTemperature == null && data.inPressure != null){
			$('#refInPressure').html(
					"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
							+ data.inPressure + "mpa");
		}else if(data.inTemperature != null && data.inPressure == null){
			$('#refInPressure').html(
					data.inTemperature + "℃  "
							+ "&nbsp;-");
		}else {
			$('#refInPressure').html(
					data.inTemperature + "℃  &nbsp"
							+ data.inPressure + "mpa");
		}
		}
		if(data.outTemperature != null
				|| data.outPerssure != null){
		if (data.outTemperature == null
				&& data.outPerssure == null) {
			$('#refOutPerssure')
					.html(
							"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		}else if(data.outTemperature == null && data.outPerssure != null){
			$('#refOutPerssure').html(
					"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
							+ data.outPerssure + "mpa");
		}else if(data.outTemperature != null && data.outPerssure == null){
			$('#refOutPerssure').html(
					data.outTemperature + "℃  "
							+ "&nbsp;-");
		} else {
			$('#refOutPerssure').html(
					data.outTemperature + "℃  &nbsp"
							+ data.outPerssure + "mpa");
		}
		}
		$('#boiInPressure')
				.html(
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		$('#boiOutPerssure')
				.html(
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
	} else if ("BOILER" == data.openType) {
		$('#openCount').html(data.openCount);
		if (data.inTemperature != null
				|| data.inPressure != null) {
		if (data.inTemperature == null
				&& data.inPressure == null) {
			$('#boiInPressure')
					.html(
							"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		}else if(data.inTemperature == null && data.inPressure != null){
			$('#boiInPressure').html(
					"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
							+ data.inPressure + "mpa");
		}else if(data.inTemperature != null && data.inPressure == null){
			$('#boiInPressure').html(
					data.inTemperature + "℃  "
							+ "&nbsp;-");
		} else {
			$('#boiInPressure').html(
					data.inTemperature + "℃  &nbsp"
							+ data.inPressure + "mpa");
		}
		}
		if (data.outTemperature != null
				|| data.outPerssure != null) {
		if (data.outTemperature == null
				&& data.outPerssure == null) {
			$('#boiOutPerssure')
					.html(
							"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		}else if(data.outTemperature == null && data.outPerssure != null){
			$('#boiOutPerssure').html(
					"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;"
							+ data.outPerssure + "mpa");
		}else if(data.outTemperature != null && data.outPerssure == null){
			$('#boiOutPerssure').html(
					data.outTemperature + "℃  "
							+ "&nbsp;-");
		} else {
			$('#boiOutPerssure').html(
					data.outTemperature + "℃  &nbsp"
							+ data.outPerssure + "mpa");
		}
		}
		$('#refInPressure')
				.html(
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		$('#refOutPerssure')
				.html(
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
	} else if ("" == data.openType) {
		$('#openCount').html("-");
		$('#boiInPressure').html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		$('#boiOutPerssure').html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		$('#refInPressure').html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
		$('#refOutPerssure').html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;-");
	}
	var normalCount =data.projectTotalCount-data.faultCount;
	var abnormalCount =data.faultCount;
	projectDeviceStateData("HVAC",normalCount,abnormalCount)
}

// 电梯项目首页查询正常总数和异常总数
function elevatorStatusData(){
	var typeCode="ELEVATOR";
	var normal=null;
	var abnormal=null;
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorProjectPage/queryElevatorStatus?typeCode=" +typeCode +"&projectId="+projectId + "&projectCode="+ projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var returnVal = data.RETURN_PARAM;
					normal = returnVal.normalElevators;
					abnormal = returnVal.abnormalElevators;
					projectDeviceStateData(typeCode,normal,abnormal);

			}else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}


// 项目首页首次打开查询电梯数据
function getElevatorAndAlarmData() {
	var typeCode = "ELEVATOR"
	$.ajax({
		type : "post",
		url : ctx + "/elevator/elevatorProjectPage/getElevatorAndAlarmProjectData?typeCode=" + typeCode + "&projectId=" + projectId +"&projectCode=" +projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.CODE && data.CODE == "SUCCESS") {
				var returnVal = data.RETURN_PARAM;
				if(returnVal.alarmCode!=null && returnVal.alarmCode=="37"){
					var imgkunren = document.getElementById('imgkunren');
					imgkunren.src = ctx +"/static/icon/index/kunren.svg";
				}else{
					var imgkunren = document.getElementById('imgkunren');
					imgkunren.src = ctx +"/static/icon/index/wukunren.svg";
				}
				$("#totalOfAlarm").html(returnVal.alarms);
				$("#allElevators").html(returnVal.elevators);
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1, null, true);
			}
		},
		error : function(req, error, errObj) {
		}
	});

}
// 推送显示梯控首页
function displayElevatorAndAlarmInfo(json) {
	var alarm= $("#totalOfAlarm").text();
	if(json.alarmCode!=null){
		var imgkunren = document.getElementById('imgkunren');
		imgkunren.src = ctx +"/static/icon/index/kunren.svg";
	}else{
		var imgkunren = document.getElementById('imgkunren');
		imgkunren.src = ctx +"/static/icon/index/wukunren.svg";
	}
	if(json.alarmType=="1"){
		$("#totalOfAlarm").html(parseInt(alarm)+1);
	}else if(json.alarmType=="2" && parseInt(alarm)>0 ){
		$("#totalOfAlarm").html(parseInt(alarm)-1);
	}
}

// 获取供配电信息
function getPdsData() {
	$.ajax({
		type : "post",
		url : ctx + "/power-supply/supplyPowerMain/getCurrentData?projectCode="+projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if ((data.data!=null || data.data!="") && data.code == 0) {
				var result = data.data;
				if(result.currentDayDlp==0){
					$("#id_currentTodayDlp").html("--&nbsp;");
				}else{
					$("#id_currentTodayDlp").html(result.currentDayDlp);
				}
				if(result.currentMonthDlp==0){
					$("#id_currentMonthDlp").html("--");
				}else{
					$("#id_currentMonthDlp").html(result.currentMonthDlp);
				}
				if(result.currentYearDlp==0){
					$("#id_currentYearDlp").html("--");
				}else{
					$("#id_currentYearDlp").html(result.currentYearDlp);
				}
				if(result.aralmNum==0){
					$("#id_pdsAlarmNum").html("--");
				}else{
					$("#id_pdsAlarmNum").html(result.aralmNum);
				}
				projectDeviceStateData('POWER_SUPPLY',result.normalNum,result.falutNum);
			} else {
				$("#id_currentTodayDlp").html("--&nbsp;");
				$("#id_currentMonthDlp").html("--");
				$("#id_currentYearDlp").html("--");
				$("#id_pdsAlarmNum").html("--");
				projectDeviceStateData('POWER_SUPPLY',0,0);
				return false;
			}
		},
		error : function(req, error, errObj) {
		}
	});

}


function websocketCallBack(json) {
	if (json.type == 'HVAC') {
		displayHvacInfo(json.data);
	} else if (json.type == 'TEST') {
		console.log(json.data.name);
	} else if (json.type == 'ELEVATOR') {
		displayElevatorAndAlarmInfo(json.data);
	} else if (json.type == 'ACCESS_CONTROL') {
		setProjectAccessControlAbnormal(json.data)
	} else if (json.type == 'POWER_SUPPLY') {
		displayPdsInfo(json.data);
	} else if (json.type == 'FIRE_FIGHTING') {
		displayFireFighting(json.data);
	} else if (json.type == 'SUPPLY_DRAIN') {
		setProjectSupplyDrain(json.data);
	} else if (json.type == 'VIDEO_MORNITORING') {
		displayVmInfo(json.data);
	}else if(json.type == 'PARKING'){
		 updateParkingData(json.data);
	}

}

// 展示视频监控信息
function displayVmInfo(data) {
	$("#vm-device-count").html(data.projectTotalNum);
	$("#vm-device-normal").html(data.projectNormalNum);
	$("#vm-device-unnormal").html(data.projectAbnormalNum);
	projectDeviceStateData("VIDEO_MORNITORING",data.projectNormalNum,data.projectAbnormalNum);
}
// 打开页面请求视频监控设备数量
function getVideoMonitoringData() {
	$.ajax({
		type : "post",
		url : ctx + "/video-monitoring/vmDeviceStatus/getVmProjectData?projectCode="+projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data){
				displayVmInfo(data);
			}
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}

// 展示供配电信息
function displayPdsInfo(data) {
	$("#id_currentTodayDlp").html(data.currentDayDlp);
	$("#id_currentMonthDlp").html(data.currentMonthDlp);
	$("#id_currentYearDlp").html(data.currentYearDlp);
	$("#id_pdsAlarmNum").html(data.aralmNum);
	projectDeviceStateData('POWER_SUPPLY',data.normalNum,data.falutNum);
}
// 消防最长时间变化
function timeChange() {
if(typeof(flushFiresTime) != "undefined" && 'undefined' != typeof($("#fire_fighting_block").val())){
	firesMaxTime = firesMaxTime + 1000;
	var days = parseInt(firesMaxTime / (1000 * 60 * 60 * 24));
	var hours = parseInt((firesMaxTime % (1000 * 60 * 60 * 24))
			/ (1000 * 60 * 60));
	var minutes = parseInt((firesMaxTime % (1000 * 60 * 60)) / (1000 * 60));
	var seconds =(firesMaxTime % (1000 * 60)) / 1000;
	$("#fires_day").html(days + "天");
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
			$("#fires_day").html("--天");
			$("#fires_time").html("--小时" + "--分钟" + "--秒");
		}
	}
	$("#maintain_number").html(data.maintainNumber + "%");
	$("#maintain_value").css("width", data.maintainNumber + "%");
	$("#alarm_normal").html(data.firesNormal);
	$("#alarm_abnormal").html(data.firesAbnormal);
	$("#fires").html(data.fires);
	$("#water_online").html(data.waterOnline);
	$("#water_offline").html(data.waterOffline);
	$("#water_alarm").html(data.waterAlarm);
	$("#linkage_answer").html(data.linkageAnswer);
	var normalCount =data.firesNormal+data.waterOnline-data.waterAlarm+(data.masterTotal-data.abnormalTotal);
	var abnormalCount =data.firesAbnormal+data.waterOffline+data.waterAlarm+data.abnormalTotal;
	projectDeviceStateData("FIRE_FIGHTING",normalCount,abnormalCount);
	if('undefined' != typeof($("#ffm_master").val())){
		getData(114,"ffm_master");
	}

}

// 打开页面请求消防数据
function getFireFightingProjectData(){
	$.ajax({
		type : "post",
		url : ctx+"/fire-fighting/fireFightingManage/getProjectPageData?projectCode=" + projectCode,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if(data&&data.code==0&&data.data!=null){
				displayFireFighting(data.data);
			}

		},
		error : function(req, error, errObj) {
		}
	});
}


// 给排水一栏初始化
function getSupplyDrain() {
	$.ajax({
			type : "post",
			url : ctx + "/supply-drain/sdmRecordSummary/getProjectData?projectCode="+projectCode,
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			async : false,
			success : function(data) {
				if (data.code == 0) {
					var result = data.data;
					// 填充数据
					$("#supply_drain_fault").html(result.faultTotal);
					$("#bp_open").html(result.bpOpenTotal);
					$("#bp_close").html(result.bpCloseTotal);
					$("#sp_open").html(result.spOpenTotal);
					$("#sp_close").html(result.spCloseTotal);
					var normal=result.boosterPumpTotal+result.submersiblePumpTotal-result.deviceFaultTotal;
					if(normal<0){
						normal=0;
					}
					$("#booster_pump").html(result.boosterPumpTotal);
					$("#submersible_pump").html(result.submersiblePumpTotal);
					projectDeviceStateData("SUPPLY_DRAIN",normal,result.deviceFaultTotal);
				} else {
					showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
							null, true);
				}
			},
			error : function(req, error, errObj) {
			}
		});



}

// 给排水一栏添加数据
function setProjectSupplyDrain(data) {
var supplyDrainData = data;
var normal=supplyDrainData.boosterPumpTotal+supplyDrainData.submersiblePumpTotal-supplyDrainData.deviceFaultTotal;
if(normal<0){
	normal=0;
}
// 填充数据
$("#supply_drain_fault").html(supplyDrainData.faultTotal);
$("#bp_open").html(supplyDrainData.bpOpenTotal);
$("#bp_close").html(supplyDrainData.bpCloseTotal);
$("#submersible_pump").html(supplyDrainData.submersiblePumpTotal);
$("#sp_open").html(supplyDrainData.spOpenTotal);
$("#sp_close").html(supplyDrainData.spCloseTotal);
$("#booster_pump").html(supplyDrainData.boosterPumpTotal);
projectDeviceStateData("SUPPLY_DRAIN",normal,supplyDrainData.deviceFaultTotal);

}

// 查询给排水设备数量
function supplyDrainNum(code){
var drainCodeList=new Array();
drainCodeList.push(code);
var deviceNum;
$.ajax({
	type : "post",
	url : ctx + "/device/manage/getDeviceTotal?deviceCodes="+drainCodeList+"&projectCode="+projectCode,
	dataType : "json",
	async : false,
	contentType : "application/json;charset=utf-8",
	success : function(data) {
		deviceNum = data;
	},
	error : function(req, error, errObj) {
		showDialogModal("error-div", "操作错误", errObj);
		return;
	}
});
return deviceNum;
}

// 弹出框 1主机在线率 2火警最长时间
function newPage(type){
	if(type==1){
		// modalDivId, width, height, title, url, callback, footerType,
		// theme,oriMarginTop
		createModalWithLoad("ffm_page",435, 430, "主机在线率","/fireFightingManage/masterPage?projectCode="+projectCode,"","");
		$("#ffm_page-modal").modal('show');
		
	}else if(type==2){
		createModalWithLoad("ffm_page",885, 430, "火警未处理信息","/fireFightingManage/firesPage?projectCode="+projectCode,"","");
		$("#ffm_page-modal").modal('show');
	}
}

function openFireFightingPage(val1,val2) {
	var QueryVO ={"projectCode":projectCode,"dstModule":val1};
	if(val1=="FIRE_ALERT_NOW_PAGE"){
		createPage(null, "消防报警联动系统", null, "/fireFightingManage/ffmStaticLink?projectAlarmStatus="+val2);
//		openPage("", "", "/fireFightingManage/ffmStaticLink?projectAlarmStatus="+val2);
	}else if(val1 == "WATER_TEST_NOW_PAGE"){
		if(val2=='online'){
			createPage(null, "消防水系统", null, "/fireFightingManage/ffmWaterStatic?projectComStatus=0");
//			openPage("", "", "/fireFightingManage/ffmWaterStatic?projectComStatus=0");//0在线
		}else if(val2 == 'offline'){
			createPage(null, "消防水系统", null, "/fireFightingManage/ffmWaterStatic?projectComStatus=1");
//			openPage("", "", "/fireFightingManage/ffmWaterStatic?projectComStatus=1");//1离线
		}else if(val2 == 'alarm'){
			createPage(null, "消防水系统", null, "/fireFightingManage/ffmWaterStatic?projectAlarmStatus=4");
//			openPage("", "", "/fireFightingManage/ffmWaterStatic?projectAlarmStatus=4");//报警
		}
	}else if(val1 =="FIRE_MAINTAIN_PAGE"){
		createPage(null, "消防事件概要", null, "/fireFightingManage/ffmDetailInfo");
	}

}

function openNewPage(val1,val2){
	if(val1 == 'alarmRecord'){
		createPage(null, "报警事件", null, "alarmRecords/alarmRecordPage");
	}
}


function clickEvent(id,obj){
	if(id==114){
		obj.on('click', function (params) {
			if(params.data){
				newPage(1);
			}
		});
	}

}

// 获取项目所有的设备
function getProjectAllDeviceCount(){
	$.ajax({
		type: "get",
		url: ctx + "/device/homePage/getProjectAllDeviceCount?projectId="+projectId,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null && data.length > 0) {
				$("#deviceProjectCount").text(data);
				if(data.indexOf(".") < 0 ){
					$("#deviceWan").text("");
				}else{
					$("#deviceWan").text("万");
				}
			}
		},
		error: function(req, error, errObj) {
		}
	});
}

	// 跳转给水子系统地图
	$("#supply_drain_skip").click(function(){
		unloadAndRelease();
		openPage("给水子系统地图"," ","/supplyDrain/supplyMonitoring");


	});
	// 跳转电梯系统主界面
	$("#supply_elevator_skip").click(function(){
		unloadAndRelease();
		openPage("电梯子系统主界面"," ","/elevatorSystem/verticalElevator");
	});
	// 跳转暖通空调系统地图
	$("#projectHvacDivId").click(function(){
		unloadAndRelease();
		openPage("暖通冷源系统地图"," ","/hvacRealTimeDataPage/hvacCoolMapPage");
	});
	// 跳转能耗统计页面
	$("#power_supply_skip").click(function(){
		unloadAndRelease();
		openPage("能耗统计"," ","/psdMain/powerConsumption");
	});

	// 视频监控页面
	$("#video-monitoring-skip").click(function(){
		var key="VIDEO-MONITORING-MENU-1";
		var menuValue = menuMap.get(key);
		if(menuValue){
			createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
		}
	});


// 查询当期项目下照明设备总数
function lightingDeviceNum(){
	$.ajax({
		type: "get",
		url: ctx + "/system/lightDevice/getlightDeviceNum?typeCode=LIGHTING_SYSTEM&dataCode=LIGHTING_DEVICE_NUM_"+projectCode,
		dataType : "json",
		async : false,
		contentType: "application/json;charset=utf-8",
		success: function(data) {
			if (data != null) {
				$("#lighting_num").html(data);
			}else{
				$("#lighting_num").html("5877");
			}
		},
		error: function(req, error, errObj) {
		}
	});
}

// 停车场模块数据初始化
function getParkingProjectData(){
	  $.ajax({
	        type : "post",
	        url : ctx + "/parking/parkingMain/getParkingProjectData?projectCode="+projectCode,
	        dataType : "json",
	        contentType : "application/json;charset=utf-8",
	        success : function(data) {
		        if( data.code==0&&data.data!=null){
		        	var result  = data.data;
		        	var parkingDeviceFalutNum = result.deviceFalutNum;
		        	if(parkingDeviceFalutNum == null){
		        		$("#parking_deviceFalutNum").html("--"); // 设备异常数
		        		parkingDeviceFalutNum = 0;
		        	}else{
		        		$("#parking_deviceFalutNum").html(parkingDeviceFalutNum); // 设备异常数
		        	}
		           	$("#parking_spaceUsedRate").html(result.parkUsedSpaceRate);// 车位使用率
		        	$("#parking_inPassageCarNum").html(result.inPassageCarNum); // 入口车流量
		        	// $("#parking_outPassageCarNum").html(result.outPassageCarNum);
					// // 入口车流量
		        	projectDeviceStateData("PARKING",result.deviceNormalNum,parkingDeviceFalutNum);
		        }else{
		        	projectDeviceStateData("PARKING",0,0);
		        }
	        },
	        error : function(req,error, errObj) {
	            return;
	            }
	        });

	  getBingEchart(123,"projectParkingEchart");
}

function updateParkingData(result){
	var dvErrorNum = result.deviceFalutNum;
	if(dvErrorNum == null){
		$("#parking_deviceFalutNum").html("--"); // 设备异常数
		dvErrorNum = 0;
	}else{
		$("#parking_deviceFalutNum").html(result.deviceFalutNum); // 设备异常数
	}
 	$("#parking_spaceUsedRate").html(result.parkUsedSpaceRate);// 车位使用率
	$("#parking_inPassageCarNum").html(result.inPassageCarNum); // 入口车流量
	getBingEchart(123,"projectParkingEchart");
	projectDeviceStateData("PARKING",result.deviceNormalNum,dvErrorNum);
}


function goParkingMonitoring(){
	var key="PARKING-MENU-1";
	var menuValue = menuMap.get(key);
	if(menuValue){
		createPage(menuValue.id, menuValue.name, menuValue.icon, menuValue.url);
	}
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
