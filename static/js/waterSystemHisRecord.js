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

function waterSystemHisInit(ctx) {
	areaId = "";
	floorId = "";
	buildingId = "";
	// 时间控件
	$("#startDate_his").datetimepicker({
		id : 'datetimepicker-startDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		hours12 : false,
		allowBlank : true,
		format : 'Y-m-d H:i:s',
		formatDate : 'YYYY-mm-dd hh:mm:ss'
	});
	$("#endDate_his").datetimepicker({
		id : 'datetimepicker-endDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		hours12 : false,
		allowBlank : true,
		format : 'Y-m-d H:i:s',
		formatDate : 'YYYY-mm-dd hh:mm:ss'
	});
	var alarmTypeList = new Array();
	alarmTypeList[alarmTypeList.length] = {itemText: "请选择事件类型", itemData: "0", Selected:true};
	alarmTypeList[alarmTypeList.length] = {itemText: "水压异常", itemData: "6", };
	alarmTypeList[alarmTypeList.length] = {itemText: "电动阀异常", itemData: "7"};
	alarmTypeList[alarmTypeList.length] = {itemText: "离线", itemData: "8"};
	//事件类型
	alarTypeDropdownList = $('#alarm-event-type-dropdownlist_his').dropDownList({
		inputName : "alarmTypeName",
		inputValName : "alarmTypeVal",
		buttonText : "",
		width : "110px",
		readOnly : false,
		required : true,
		maxHeight : 200,
		onSelect : function(i, data, icon) {
		},
		items : alarmTypeList
	});
	alarTypeDropdownList.setData('请选择事件类型', '0');
	// 获取设备类型列表
	$.ajax({
		type : "get",
		url : ctx + "/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=FIRE_FIGHTING&secondCode=FIRE_TERMINAL_WATER_TEST_SYSTEM",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			deviceTypeList =[];
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
				tempDeviceTypeList = $("#device-type-dropdownlist_his").dropDownList({
					inputName : "deviceTypeName_his",
					inputValName : "deviceTypeVal_his",
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
			buildingList = [];
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
				tempBuildingList = $("#building-dropdownlist_his").dropDownList({
					inputName : "buildingName",
					inputValName : "buildingVal_his",
					buttonText : "",
					width : "110px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							buildingId = data;
							// 根据建筑物获取楼层列表
							getFloorListHis(data);
						} else if (data == "") {
							buildingId = data;
							floorId = data;
							areaId = data;
							getFloorListHis(data);
							getAreaListHis(data);
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
	tempAlarmStatusDropdownList = $('#alarm-status-dropdownlist_his').dropDownList({
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


	// 楼层列表
	tempFloorDropdownList = $('#floor-dropdownlist_his').dropDownList({
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
	tempAreaDropdownList = $('#area-dropdownlist_his').dropDownList({
		buttonText : "",
		width : "110px",
		readOnly : false,
		required : true,
		maxHeight : 300,
		onSelect : function(i, data, icon) {
			comStatus = data;
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
				title : '事件',
				name : 'alarmEventType',
				width : 170,
				sortable : false,
				align : 'left'
					
			}, {
				title : '设备类型',
				name : 'deviceType',
				width : 180,
				sortable : false,
				align : 'left'
			}, {
				title : '楼栋',
				name : 'building',
				width : 140,
				sortable : false,
				align : 'left'
			}, {
				title : '楼层',
				name : 'floor',
				width : 140,
				sortable : false,
				align : 'left'
			}, {
				title : '安装位置',
				name : 'position',
				width : 140,
				sortable : false,
				align : 'left'
			}, {
				title : '主机号',
				name : 'hostNumber',
				width : 130,
				sortable : false,
				align : 'left'
			}, {
				title : '回路号',
				name : 'loopNumber',
				width : 130,
				sortable : false,
				align : 'left'
			}, {
				title : '测点号',
				name : 'testNumber',
				width : 130,
				sortable : false,
				align : 'left'
			}, {
				title : '发生时间',
				name : 'occuredTime',
				width : 170,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.occuredTime != undefined&& item.occuredTime.length > 0) {
						return item.occuredTime.substr(0, 19);
					} else {
						return "";
					}
				}
			}, {
				title : '恢复时间',
				name : 'recoveryTime',
				width : 163,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.recoveryTime != undefined&& item.recoveryTime.length > 0) {
						return item.recoveryTime.substr(0, 19);
					} else {
						return "/";
					}
				}
			}, {
				title : '持续时长',
				name : 'duration',
				width : 102,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.duration != undefined && item.duration !=null && item.duration !=0) {
						return item.duration+"s"
					} else {
						return "/";
					}
				}
			}
	];
	var pg_his = $('#pg_his').mmPaginator({
		"limitList" : [
			15
		]
	});
	picHisGrid = $('#tb-historicalData').mmGrid({
		height : 630,
		cols : cols,
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/getHisRecord",
		method : 'post',
		remoteSort : false,
		sortName : 'createTime',
		sortStatus : 'desc',
		fullWidthRows : false,
		showBackboard:false,
		autoLoad : false,
		nowrap:true,
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
			var alarmEventType = $("#alarmTypeVal").val();
			if (alarmEventType != "" && alarmEventType != undefined) {
				$(data).attr({
					"alarmEventType" : alarmEventType
				});
			}
			var hostNumber = $("#hostNumber_his").val();
			if (hostNumber != "" && hostNumber != undefined) {
				$(data).attr({
					"hostNumber" : hostNumber
				});
			}
			var loopNumber = $("#loopNumber_his").val();
			if (loopNumber != "" && loopNumber != undefined) {
				$(data).attr({
					"loopNumber" : loopNumber
				});
			}

			var testNumber = $("#testNumber_his").val();
			if (testNumber != "" && testNumber != undefined) {
				$(data).attr({
					"testNumber" : testNumber
				});
			}
			var deviceTypeCode = $("#deviceTypeVal_his").val();
			if (deviceTypeCode != "" && deviceTypeCode != undefined) {
				$(data).attr({
					"deviceTypeCode" : deviceTypeCode
				});
			}
			var areaId  =  $("#areaVal_his").val();
			var floorId  =  $("#floorVal_his").val();
			var buildingId  = $("#buildingVal_his").val();
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

			var selectForm = getFormData("select-form_his");
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
		     pg_his
		]
	});
	picHisGrid.on('cellSelect', function(e, item, rowIndex, colIndex) {

	}).on('loadSuccess', function(e, data) {
		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
	}).on('loadError', function(req, error, errObj) {
		showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
	}).load();

	$("#btn-query-summary_his").on('click', function() {
		pg_his.load({
			"page" : 1
		});
		picHisGrid.load();
		// 未恢复数据统计
		getUnrecoveryCount();
	});

	$("#export-summary_his").on('click', function() {
		hisRecordExportExcel();
	});
	// 未恢复数据统计
	getUnrecoveryCount();
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
			itemText : '水压异常',
			itemData : '1'
		}, {
			itemText : '电动阀异常',
			itemData : '2'
		}
];
var tempAlarmStatusDropdownList;

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
function getFloorListHis(parentId) {
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
				tempFloorDropdownList = $("#floor-dropdownlist_his").dropDownList({
					inputName : "floorName",
					inputValName : "floorVal_his",
					buttonText : "",
					width : "110px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							getAreaListHis(data);
							floorId = data;
						} else if (data == "") {
							getAreaListHis(data);
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
function getAreaListHis(parentId) {
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
				tempAreaDropdownList = $("#area-dropdownlist_his").dropDownList({
					inputName : "areaName",
					inputValName : "areaVal_his",
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
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/getWaterSystemData",
		dataType : "json",
		data : JSON.stringify(waterSystemData),
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

// 水系统历史记录导出excel
function hisRecordExportExcel() {
	var alarmEventType = $("#alarmTypeVal").val();
	var hostNumber_his = $("#hostNumber_his").val();
	var loopNumber_his = $("#loopNumber_his").val();
	var testNumber_his = $("#testNumber_his").val();
	var deviceTypeCode_his = $("#deviceTypeVal_his").val();
	var areaId_his =  $("#areaVal_his").val();
	var floorId_his =  $("#floorVal_his").val();
	var buildingId_his = $("#buildingVal_his").val();
	var locationId_his ="";
	if (areaId_his != "" && areaId_his != undefined) {
		locationId_his = areaId_his;
	} else if (floorId_his != "" && floorId_his != undefined) {
		locationId_his = floorId_his;
	} else if (buildingId_his != "" && buildingId_his != undefined) {
		locationId_his = floorId_his;
	}
	var selectForm = getFormData("select-form_his");
	var startTime = selectForm.startDate.trim();
	var endTime = selectForm.endDate.trim();
	var url = ctx + "/fire-fighting/fireFightingWaterSystemManage/waterSystemHisRecordExcel";
	var prams = "?projectId=" + projectId +"&projectCode="+projectCode+ "&hostNumber=" +hostNumber_his +"&alarmEventType=" +alarmEventType + "&loopNumber=" +loopNumber_his + "&testNumber=" + testNumber_his + "&deviceTypeCode=" + deviceTypeCode_his + "&locationId=" + locationId_his + "&startTime=" +  startTime + "&endTime=" + endTime + "&pageNumber=1&pageSize=1000&sortType=desc&sortName=createTime";
	window.open(url + prams);
}

function flushPage(){
	$("#hostNumber_his").val("");
	$("#loopNumber_his").val("");
	$("#testNumber_his").val("");
	$("#startDate_his").val("");
	$("#endDate_his").val("");
	var selectForm = getFormData("select-form_his");
	 selectForm.startDate ="";
	 selectForm.endDate="";
}
