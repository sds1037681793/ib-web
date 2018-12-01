var tbAuthorizeOrder;
var today = "${today}";
/*
 * $('#startDate').val(today); $('#endDate').val(today);
 */
var organizeId = $("#login-org").data("orgId");
var deviceTypeList = new Array();
var buildingList = new Array();
var floorList = new Array();
var areaList = new Array();
var systemType = 3;
var buildingId;
var floorId;
var areaId;
var tempBuildingList;
var tempDeviceTypeList;
var deviceTypeCode;
var alarmSystemData;
var hostNumber;
var loopNumber;
var testNumber;
var startDate;
var endDate;
var locationId;
var pg;
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

function ffmAlarmSysteminit(ctx) {
	areaId = "";
	floorId = "";
	buildingId = "";
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

	deviceType = $("#deviceType-dropdownlist").dropDownList({
		inputName : "deviceTypeName",
		inputValName : "deviceTypeId",
		buttonText : "",
		width : "117px",
		readOnly : false,
		required : true,
		maxHeight : 200,
		onSelect : function(i, data, icon) {
		},
		items : deviceTypeList
	});

	// 楼层列表
	tempFloorDropdownList = $('#floor-dropdownlist').dropDownList({
		buttonText : "",
		width : "117px",
		readOnly : false,
		required : true,
		maxHeight : 200,
		onSelect : function(i, data, icon) {
		},
		items : floorDropdownList
	});
	tempFloorDropdownList.setData('请选择楼层', '');

	// 具体区域列表
	tempAreaDropdownList = $('#specificArea-dropdownlist').dropDownList({
		buttonText : "",
		width : "117px",
		readOnly : false,
		required : true,
		maxHeight : 300,
		onSelect : function(i, data, icon) {
			comStatus = data;
		},
		items : areaDropdownList
	});
	tempAreaDropdownList.setData('请选择具体区域', '');

	deviceTypeList = new Array();
	// 获取设备类型列表
	$.ajax({
		type : "get",
		url : ctx + "/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=FIRE_FIGHTING&secondCode=FIRE_OUTSIDE_SYSTEM",
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
				tempDeviceTypeList = $("#deviceType-dropdownlist").dropDownList({
					inputName : "deviceTypeName",
					inputValName : "deviceTypeVal",
					buttonText : "",
					width : "117px",
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
	buildingList = new Array();
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
				tempBuildingList = $("#ban-dropdownlist").dropDownList({
					inputName : "buildingName",
					inputValName : "buildingVal",
					buttonText : "",
					width : "117px",
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
				tempBuildingList.setData("请选择建筑物", "", "");
			}
		},
		error : function(req, error, errObj) {
		}
	});

	var cols = [
			{
				title : '设备名称',
				name : 'deviceName',
				sortable : false,
				width : 125,
				align : 'left'
			}, {
				title : '设备类型',
				name : 'deviceType',
				sortable : false,
				width : 140,
				align : 'left'
			}, {
				title : '楼栋',
				name : 'building',
				sortable : false,
				width : 120,
				align : 'left'
			}, {
				title : '楼层',
				name : 'floor',
				sortable : false,
				width : 120,
				align : 'left'
			}, {
				title : '具体区域',
				name : 'area',
				sortable : false,
				width : 120,
				align : 'left'
			}, {
				title : '主机号',
				name : 'hostNumber',
				sortable : false,
				width : 50,
				align : 'left'
			}, {
				title : '回路号',
				name : 'loopNumber',
				sortable : false,
				width : 50,
				align : 'left'
			}, {
				title : '测点号',
				name : 'measuringPoint',
				sortable : false,
				width : 100,
				align : 'left'
			}, {
				title : '火警',
				name : 'alarmStatus',
				width : 80,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					return switchValue(item.fireStatus);
				}
			}, {
				title : '低电压报警',
				name : 'alarmStatus',
				width : 100,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					return	switchValue(item.slba);
				}
			}, {
				title : '烟感失联报警',
				name : 'alarmStatus',
				width : 100,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					return switchValue(item.slfa);
				}
			}, {
				title : '底座防拆报警',
				name : 'alarmStatus',
				width : 100,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					return switchValue(item.soa);
				}
			}, {
				title : '温度超限报警',
				name : 'alarmStatus',
				width : 100,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					return switchValue(item.tpa);
				}
			}, {
				title : '发生时间',
				name : 'maintenanceTime',
				width : 190,
				sortable : false,
				align : 'left',
				renderer : function(val, item, rowIndex) {
					if (item.maintenanceTime.length >= 21) {
						return '<span style="text-align:left;">' + item.maintenanceTime.substring(0, 19) + '</span>';
					} else {
						return '<span style="text-align:left;">' + item.maintenanceTime + '</span>';
					}
				}
			}, {
				title : '查看',
				name : '',
				width : 100,
				align : 'left',
				lockWidth : true,
				lockDisplay : true,
				renderer : function(val, item, rowIndex) {
					if (item.cameraId == undefined) {
						var modifyObj = "/";
						return modifyObj;
					}
					if (item.cameraId != undefined) {
						var videoSrc = ctx + "/static/img/ffm/shipin.svg";
						var pictureSrc = ctx + "/static/img/ffm/tupian.svg";
						var modifyObj = '<img class="item-img" src="' + videoSrc + '"/>';
						var deleteObj = '<img class="item-imgs" src="' + pictureSrc + '"/>';
						return modifyObj + deleteObj;
					}

				}
			}
	];
	pg = $('#pg').mmPaginator({
		"limitList" : [
			15
		],
		"limitParamName" : "limit"
	});
	tbAuthorizeOrder = $('#tb_authorizeOrder').mmGrid({
		height : 630,
		cols : cols,
		url : ctx + '/fire-fighting/fireOutsideSystem/listQuery',
		method : 'post',
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

			hostNumber = $("#hostNumber").val();
			if (hostNumber != "" && hostNumber != undefined) {
				$(data).attr({
					"hostNumber" : hostNumber
				});
			}
			loopNumber = $("#loopNumber").val();
			if (loopNumber != "" && loopNumber != undefined) {
				$(data).attr({
					"loopNumber" : loopNumber
				});
			}

			testNumber = $("#measuringPoint").val();
			if (testNumber != "" && testNumber != undefined) {
				$(data).attr({
					"testNumber" : testNumber
				});
			}

			if (deviceTypeCode != "" && deviceTypeCode != undefined) {
				$(data).attr({
					"deviceTypeCode" : deviceTypeCode
				});
			}

			if (areaId != "" && areaId != undefined) {
				locationId = areaId;
				$(data).attr({
					"locationId" : areaId
				});
			} else if (floorId != "" && floorId != undefined) {
				locationId = floorId;
				$(data).attr({
					"locationId" : floorId
				});
			} else if (buildingId != "" && buildingId != undefined) {
				locationId = buildingId;
				$(data).attr({
					"locationId" : buildingId
				});
			}

			var selectForm = getFormData("select-form");
			startDate = selectForm.startDate.trim();
			endDate = selectForm.endDate.trim();
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
			alarmSystemData = data;
			return data;
		},
		remoteSort : false,
		sortName : 'id',
		sortStatus : 'desc',
		multiSelect : false,
		checkCol : false,
		nowrap : true,
		fullWidthRows : false,
		autoLoad : false,
		showBackboard : false,
		plugins : [
			pg
		]
	});
	tbAuthorizeOrder.on('cellSelect', function(e, item, rowIndex, colIndex) {
		e.stopPropagation();
		if ($(e.target).is('.item-img')) {
			var deviceId = item.cameraId;
			var deviceStatus = item.cameraStatus;
			// 点击查看视频弹框
			createModalWithLoad("authorizeOrder-div", 820, 595, "消防报警视频", "fireFightingManage/ffmVideoMonitorAlertPage?deviceId=" + deviceId + "&deviceStatus=" + deviceStatus, "", "", "");
			openModal("#authorizeOrder-div-modal", false, false);
		} else if ($(e.target).is('.item-imgs')) {
			// 点击查看图片
			var deviceNumber = item.deviceNumber;
			createModalWithLoad("edit-group-add", 820, 685, "消防报警抓拍", "fireFightingManage/ffmAlarmImagesPage?deviceNumber=" + deviceNumber, "", "", "");
			openModal("#edit-group-add-modal", false, false);
		}
	}).on('loadSuccess', function(e, data) {
	}).on('loadError', function(req, error, errObj) {
		showDialogModal("error-div", "操作错误", "数据加载失败：" + errObj);
	}).load();

	$('#btn-query-summary').on('click', function() {
		/*
		 * pg.load({"page":1,"limitParamName":"limit"});
		 * tbAuthorizeOrder.load();
		 */
		reloadGrid();
	});
	getOutsideSystemDataNum();
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
						width : "117px",
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
					tempAreaDropdownList = $("#specificArea-dropdownlist").dropDownList({
						inputName : "areaName",
						inputValName : "areaVal",
						buttonText : "",
						width : "117px",
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
}

$('#export-summary').on('click', function() {
	exportExecl();
});

// 导出excel
function exportExecl() {
	if (deviceTypeCode == undefined) {
		deviceTypeCode = "";
	}
	if (locationId == undefined) {
		locationId = "";
	}
	var url = ctx + "/fire-fighting/fireOutsideSystem/ffmOutsideRealTimeDataExecl";
	var prams = "?projectId=" + projectId + "&hostNumber=" + hostNumber + "&projectCode=" + projectCode + "&loopNumber=" + loopNumber + "&testNumber=" + testNumber + "&deviceTypeCode=" + deviceTypeCode + "&locationId=" + locationId + "&startTime=" + startDate + "&endTime=" + endDate + "&pageNumber=1&pageSize=1000&sortType=desc&sortName=timeStamp";
	window.open(url + prams);
}

function VideoMonitor(deviceId) {
	createModalWithLoad("device-detail", 560, 340, "查看设备状态明细", "fireFightingManage/ffmVideoMonitorAlertPage?deviceId=" + deviceId + "", "", "", "");
	$("#device-detail-modal").modal('show');
}

function getOutsideSystemDataNum() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireOutsideSystem/getAlarmData?projectCode=" + projectCode,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			$("#fires").text(data.fires);
			$("#tpaNumber").text(data.tpaNumber);
			$("#slfaNumber").text(data.slfaNumber);
			$("#slbaNumber").text(data.slbaNumber);
			$("#soaNumber").text(data.soaNumber);
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
}
function reloadGrid() {
	pg.load({
		"page" : 1,
		"limitParamName" : "limit"
	});
	tbAuthorizeOrder.load();
}
function flushRealTimePage() {
	tempDeviceTypeList.setData("请选择设备类型", "", "");
	tempBuildingList.setData("请选择建筑物", "", "");
	$("#hostNumber").val("");
	$("#loopNumber").val("");
	$("#measuringPoint").val("");
	$("#startDate").val("");
	$("#endDate").val("");
	deviceTypeCode = null;
	areaId = null;
	floorId = null;
	buildingId = null;
	getOutsideSystemDataNum();
	reloadGrid();

}

function switchValue(value) {
	if (value == 1) {
		return "是";
	} else {
		return "否";
	}

}