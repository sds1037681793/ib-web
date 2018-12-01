// 查询VO用到的查询条件变量
var alarmStatus;
var comStatus;
var deviceTypeCode;
var buildingId;
var floorId;
var areaId;
var waterSystemData;

var deviceTypeList = new Array();
var buildingList = new Array();
var floorList = new Array();
var areaList = new Array();
var tempDeviceTypeList;
var tempBuildingList;
var picGridData =null;

function waterSystemRealTimeInit(ctx) {
	areaId = "";
	floorId = "";
	buildingId = "";
	$("#hostNumber").val("");
	$("#loopNumber").val("");
	$("#testNumber").val("");
	$("#startDate").val("");
	$("#endDate").val("");
	// 时间控件
	$("#startDate").datetimepicker({
		id : 'datetimepicker-startDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		hours12 : false,
		allowBlank : true,
		format : 'Y-m-d H:i:s',
		formatDate : 'YYYY-mm-dd hh:mm:ss'
	});
	$("#endDate").datetimepicker({
		id : 'datetimepicker-endDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		hours12 : false,
		allowBlank : true,
		format : 'Y-m-d H:i:s',
		formatDate : 'YYYY-mm-dd hh:mm:ss'
	});

	// 获取设备类型列表
	$.ajax({
		type : "get",
		url : ctx + "/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=FIRE_FIGHTING&secondCode=FIRE_TERMINAL_WATER_TEST_SYSTEM",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			deviceTypeList[deviceTypeList.length] = {
				itemText : "请选择设备类型",
				itemData : ""
			};
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					deviceTypeList[deviceTypeList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置设备类型下拉列表
				tempDeviceTypeList = $("#device-type-dropdownlist").dropDownList({
					inputName : "deviceTypeName",
					inputValName : "deviceTypeVal",
					buttonText : "",
					width : "110px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						deviceTypeCode = data;
					},
					items : deviceTypeList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	tempDeviceTypeList.setData("请选择设备类型", "", "");

	// 获取建筑物列表
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/getLocationList?locationType=" + 2,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			buildingList[buildingList.length] = {
				itemText : "请选择建筑物",
				itemData : ""
			};
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					// levelTypeMaps.put(this.itemData,this.itemText);
					buildingList[buildingList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置建筑物下拉列表
				tempBuildingList = $("#building-dropdownlist").dropDownList({
					inputName : "buildingName",
					inputValName : "buildingVal",
					buttonText : "",
					width : "110px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							buildingId = data;
							// 根据建筑物获取楼层列表
							getFloorList(data);
						} else if (data == "") {
							buildingId = data;
							floorId = data;
							areaId = data;
							getFloorList(data);
							getAreaList(data);
							tempFloorDropdownList.setData("请选择楼层", "", "");
							tempAreaDropdownList.setData("请选择具体区域", "", "");
						}
					},
					items : buildingList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	tempBuildingList.setData("请选择建筑物", "", "");

	// 报警类型列表
	tempAlarmStatusDropdownList = $('#alarm-status-dropdownlist').dropDownList({
		inputName : "alarmStatus",
		inputValName : "alarmStatusVal",
		buttonText : "",
		width : "110px",
		readOnly : false,
		required : true,
		maxHeight : 300,
		onSelect : function(i, data, icon) {
			alarmStatus = data;
		},
		items : alarmStatusDropdownList
	});
	tempAlarmStatusDropdownList.setData('请选择报警状态', '');
	
	if(projectAlarmStatus!= null && projectAlarmStatus.length>0 ){
 		alarmStatus=projectAlarmStatus;
 		tempAlarmStatusDropdownList.setData(alarmStatusDropdownList[Number(alarmStatus)+1].itemText, alarmStatus,'');
 	} else {
 		tempAlarmStatusDropdownList.setData('请选择报警状态', '');
 	}

	// 通讯状态列表
	tempComStatusDropdownList = $('#com-status-dropdownlist').dropDownList({
		inputName : "comStatus",
		inputValName : "comStatusVal",
		buttonText : "",
		width : "110px",
		readOnly : false,
		required : true,
		maxHeight : 300,
		onSelect : function(i, data, icon) {
			comStatus = data;
		},
		items : comStatusDropdownList
	});
	tempComStatusDropdownList.setData('请选择通讯状态', '');
	
	if(projectComStatus!= null && projectComStatus.length>0 ){
		comStatus=projectComStatus;
		tempComStatusDropdownList.setData(comStatusDropdownList[Number(comStatus)+1].itemText, comStatus,'');
 	} else {
 		tempComStatusDropdownList.setData('请选择通讯状态', '');
 	}

	// 楼层列表
	tempFloorDropdownList = $('#floor-dropdownlist').dropDownList({
		inputName : "floorName",
		inputValName : "floorVal",
		buttonText : "",
		width : "110px",
		readOnly : false,
		required : true,
		maxHeight : 200,
		onSelect : function(i, data, icon) {
		},
		items : floorDropdownList
	});
	tempFloorDropdownList.setData('请选择楼层', '');

	// 具体区域列表
	tempAreaDropdownList = $('#area-dropdownlist').dropDownList({
		inputName : "areaName",
		inputValName : "areaVal",
		buttonText : "",
		width : "110px",
		readOnly : false,
		required : true,
		maxHeight : 300,
		onSelect : function(i, data, icon) {
			areaId = data;
		},
		items : areaDropdownList
	});
	tempAreaDropdownList.setData('请选择具体区域', '');

	// 数据展现列表
	var cols = [
			{
				title : 'id',
				name : 'id',
				width : 100,
				sortable : false,
				align : 'left',
				hidden : 'true'
			}, {
				title : 'deviceId',
				name : 'deviceId',
				width : 100,
				sortable : false,
				align : 'left',
				hidden : 'true'
			}, {
				title : '设备名称',
				name : 'deviceName',
				width : 145,
				sortable : false,
				align : 'left'
			}, {
				title : '设备类型',
				name : 'deviceType',
				width : 160,
				sortable : false,
				align : 'left'
			}, {
				title : '楼栋',
				name : 'building',
				width : 100,
				sortable : false,
				align : 'left'
			}, {
				title : '楼层',
				name : 'floor',
				width : 120,
				sortable : false,
				align : 'left'
			}, {
				title : '具体区域',
				name : 'area',
				width : 140,
				sortable : false,
				align : 'left'
			}, {
				title : '主机号',
				name : 'hostNumber',
				width : 60,
				sortable : false,
				align : 'left'
			}, {
				title : '回路号',
				name : 'loopNumber',
				width : 60,
				sortable : false,
				align : 'left'
			}, {
				title : '测点号',
				name : 'testNumber',
				width : 80,
				sortable : false,
				align : 'left'
			}, {
				title : '实时水压(Mpa)',
				name : 'waterPressure',
				width : 120,
				sortable : false,
				align : 'left'
			}, {
				title : '实时水流量',
				name : 'waterFlux',
				width : 100,
				sortable : false,
				align : 'left'
			}, {
				title : '报警状态',
				name : 'alarmStatus',
				width : 180,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.alarmStatus.indexOf('异常') != -1) {
						return '<span style="text-align:left;color:red;">'+item.alarmStatus+'</span>';
					} else {
						return '<span style="text-align:left;">'+item.alarmStatus+'</span>';
					}
				}
			}, {
				title : '通讯状态',
				name : 'communicationStatus',
				width : 90,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.communicationStatus == "离线") {
						return '<span style="text-align:left;color:red;">离线</span>';
					} else {
						return '<span style="text-align:left;">'+item.communicationStatus+'</span>';
					}
				}
			}, {
				title : '发生时间',
				name : 'occuredTime',
				width : 160,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.occuredTime.length >= 21) {
						return '<span style="text-align:left;">'+item.occuredTime.substring(0,19)+'</span>';
					} else {
						return '<span style="text-align:left;">'+item.occuredTime+'</span>';
					}
				}
			}, {
				title : '操作',
				name : '',
				width : 80,
				align : 'left',
				lockWidth : true,
				lockDisplay : true,
				renderer : function(val) {
					return'<div class="water_pressure_curve">水压曲线</div>';
				}
			}
	];
	var pg = $('#pg').mmPaginator({
		"limitList" : [
			15
		]
	});
	picGrid = $('#tb-summaryData').mmGrid({
		height : 630,
		cols : cols,
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/list",
		method : 'post',
		remoteSort : false,
		sortName : 'createTime',
		sortStatus : 'desc',
		fullWidthRows : false,
		showBackboard : false,
		nowrap : true,
		autoLoad : false,
		params : function() {
			var data = {};
			if (projectId != "" && projectId != undefined) {
				$(data).attr({
					"projectId" : projectId
				});
			}
			if (projectCode != "" && projectCode != undefined) {
				$(data).attr({
					"projectCode" : projectCode
				});
			}
			var hostNumber = $("#hostNumber").val();
			if (hostNumber != "" && hostNumber != undefined) {
				$(data).attr({
					"hostNumber" : hostNumber
				});
			}
			var loopNumber = $("#loopNumber").val();
			if (loopNumber != "" && loopNumber != undefined) {
				$(data).attr({
					"loopNumber" : loopNumber
				});
			}

			var testNumber = $("#testNumber").val();
			if (testNumber != "" && testNumber != undefined) {
				$(data).attr({
					"testNumber" : testNumber
				});
			}

			if (alarmStatus != "" && alarmStatus != undefined) {
				$(data).attr({
					"alarmStatus" : alarmStatus
				});
			}
			if (comStatus != "" && comStatus != undefined) {
				$(data).attr({
					"communicationStatus" : comStatus
				});
			}

			if (deviceTypeCode != "" && deviceTypeCode != undefined) {
				$(data).attr({
					"deviceTypeCode" : deviceTypeCode
				});
			}

			if (areaId != "" && areaId != undefined) {
				$(data).attr({
					"locationId" : areaId
				});
			} else if (floorId != "" && floorId != undefined) {
				$(data).attr({
					"locationId" : floorId
				});
			} else if (buildingId != "" && buildingId != undefined) {
				$(data).attr({
					"locationId" : buildingId
				});
			}

			var selectForm = getFormData("select-form");
			var startDate = selectForm.startDate.trim();
			var endDate = selectForm.endDate.trim();
			if (startDate != "" && startDate != undefined) {
				$(data).attr({
					"startTime" : startDate
				});
			}
			if (endDate != "" && endDate != undefined) {
				$(data).attr({
					"endTime" : endDate
				});
			}
			waterSystemData = data;
			return data;
		},
		plugins : [
			pg
		]
	});
	picGrid.on('cellSelect', function(e, item, rowIndex, colIndex) {
		if ($(e.target).is('.water_pressure_curve')) {
			checkWaterPress(rowIndex);
		} 
	}).on('loadSuccess', function(e, data) {
		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
	}).on('loadError', function(req, error, errObj) {
		showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
	}).load();

	$("#btn-query-summary").on('click', function() {
		pg.load({
			"page" : 1
		});
		picGrid.load();
		// 获取测点离线、水压异常、电动阀异常数值
		getWaterSystemDataNum();
	});

	$("#export-realtime").on('click', function() {
		realTimeExportExcel();
	});
	// 获取测点离线、水压异常、电动阀异常数值
	getWaterSystemDataNum();
}

// 报警状态列表
var alarmStatusDropdownList = [
		{
			itemText : '请选择报警状态',
			itemData : ''
		}, {
			itemText : '正常',
			itemData : '0'
		}, {
			itemText : '水压异常-电动阀正常',
			itemData : '1'
		}, {
			itemText : '水压正常-电动阀异常',
			itemData : '2'
		}, {
			itemText : '水压异常-电动阀异常',
			itemData : '3'
		}, {
			itemText : '报警',
			itemData : '4'
		}
];
var tempAlarmStatusDropdownList;

// 通讯状态列表
var comStatusDropdownList = [
		{
			itemText : '请选择通讯状态',
			itemData : ''
		}, {
			itemText : '在线',
			itemData : '0'
		}, {
			itemText : '离线',
			itemData : '1'
		}
];
var tempComStatusDropdownList;

// 楼层列表
var floorDropdownList = [
	{
		itemText : '请选择楼层',
		itemData : ''
	}
];
var tempFloorDropdownList;

// 具体区域列表
var areaDropdownList = [
	{
		itemText : '请选择具体区域',
		itemData : ''
	}
];
var tempAreaDropdownList;

// 获取楼层列表
function getFloorList(parentId) {
	// 先清空列表，以免重复添加数据
	floorList.splice(0, floorList.length);
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/listLocationByParentId?parentId=" + parentId,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			floorList[floorList.length] = {
				itemText : "请选择楼层",
				itemData : ""
			};
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					floorList[floorList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置楼层下拉列表
				tempFloorDropdownList = $("#floor-dropdownlist").dropDownList({
					inputName : "floorName",
					inputValName : "floorVal",
					buttonText : "",
					width : "110px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							getAreaList(data);
							floorId = data;
						} else if (data == "") {
							getAreaList(data);
							tempAreaDropdownList.setData("请选择具体区域", "", "");
							floorId = data;
							areaId = data;
						}
					},
					items : floorList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	tempFloorDropdownList.setData("请选择楼层", "", "");
}

// 获取区域列表
function getAreaList(parentId) {
	// 先清空列表，以免重复添加数据
	areaList.splice(0, areaList.length);
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/listLocationByParentId?parentId=" + parentId,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			areaList[areaList.length] = {
				itemText : "请选择具体区域",
				itemData : ""
			};
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					areaList[areaList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置用户类型下拉列表
				tempAreaDropdownList = $("#area-dropdownlist").dropDownList({
					inputName : "areaName",
					inputValName : "areaVal",
					buttonText : "",
					width : "110px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							areaId = data;
						} else if (data == "") {
							areaId = data;
						}
					},
					items : areaList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	tempAreaDropdownList.setData("请选择具体区域", "", "");
}

function getWaterSystemDataNum() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/getWaterSystemData?projectCode="+projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			$("#offLineNum").text(data.offLineNum);
			$("#waterExcNum").text(data.waterPressureExceptionNum);
			$("#eleExcNum").text(data.electricExceptionNum);
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}

// 水系统实时信息导出excel
function realTimeExportExcel() {
	var hostNumber = $("#hostNumber").val();
	if (hostNumber == undefined) {
		hostNumber = ""
	}
	var loopNumber = $("#loopNumber").val();
	if (loopNumber == undefined) {
		loopNumber = ""
	}

	var testNumber = $("#testNumber").val();
	if (testNumber == undefined) {
		testNumber = ""
	}

	if (alarmStatus == undefined) {
		alarmStatus = ""
	}

	if (comStatus == undefined) {
		comStatus = ""
	}

	if (deviceTypeCode == undefined) {
		deviceTypeCode = ""
	}

	var locationId;
	if (areaId != "" && areaId != undefined) {
		locationId = areaId;
	} else if (floorId != "" && floorId != undefined) {
		locationId = floorId;
	} else if (buildingId != "" && buildingId != undefined) {
		locationId = buildingId;
	} else {
		locationId = "";
	}

	var selectForm = getFormData("select-form");
	var startTime = selectForm.startDate.trim();
	var endTime = selectForm.endDate.trim();
	if (startTime == undefined) {
		startTime = "";
	}
	if (endTime == undefined) {
		endTime = "";
	}
	
	var url = ctx + "/fire-fighting/fireFightingWaterSystemManage/waterSystemDataExcel";
	var prams = "?projectId=" + projectId + "&hostNumber=" + hostNumber + "&loopNumber=" + loopNumber + "&testNumber=" + testNumber + "&alarmStatus=" + alarmStatus + "&communicationStatus="
	+ comStatus + "&deviceTypeCode=" + deviceTypeCode +"&projectCode="+projectCode + "&locationId=" + locationId + "&startTime=" + startTime + "&endTime=" + endTime + "&pageNumber=1&pageSize=1000&sortType=desc&sortName=timeStamp";
	window.open(url + prams);

	waterSystemData = null;
}


//查看水压曲线图
function checkWaterPress(rowIndex) {
	    picGridData =picGrid.row(rowIndex);
		//跳转查看水压曲线图
		createModalWithLoad("water-pressure-detail", 720,600, "水压曲线图",
				"fireFightingManage/ffmWaterPressureEchart", "", "", "");
		openModal("#water-pressure-detail-modal", true, false);
}