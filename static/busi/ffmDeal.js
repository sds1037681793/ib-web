var eventDeviecTypeList;
var eventTypeList = new Array({
	itemText : "请选择事件",
	itemData : ""
}, {
	itemText : "火警",
	itemData : "1"
}, {
	itemText : "故障",
	itemData : "2"
}, {
	itemText : "联动请求",
	itemData : "3"
}, {
	itemText : "联动回答",
	itemData : "4"
}, {
	itemText : "联动启动",
	itemData : "5"
});
var eventDeviceTypeMap = new HashMap();
var eventBuildingList = new Array({itemText : "请选择建筑物",itemData : ""});
var eventFloorList = new Array({itemText : "请选择楼层",itemData : ""});
var eventAreaList = new Array({itemText : "请选择区域",itemData : ""});
var eventFloorDropdownList;
var eventBuildingList;
var eventAreaDropdownList;
var alarmEventType;
var eventConfirm;
var eventBuildId;
var eventFloorId;
var eventAreaId;
var processResultList = new Array({	itemText : "请选择处理结果",itemData : ""});
var confirmList = new Array({
	itemText : "请选择处理结果",
	itemData : ""
}, {
	itemText : "未确认",
	itemData : "0"
}, {
	itemText : "真实火警",
	itemData : "1"
}, {
	itemText : "误报",
	itemData : "2"
}, {
	itemText : "测试",
	itemData : "3"
});

var faultConfirmList = new Array({
	itemText : "请选择处理结果",
	itemData : ""
}, {
	itemText : "未确认",
	itemData : "0"
}, {
	itemText : "真实故障",
	itemData : "4"
}, {
	itemText : "设备丢失",
	itemData : "5"
}, {
	itemText : "测试",
	itemData : "6"
});
var FaultEventConfirmText = new HashMap();
FaultEventConfirmText.put(0,"未确认");
FaultEventConfirmText.put(4,"真实故障");
FaultEventConfirmText.put(5,"设备丢失");
FaultEventConfirmText.put(6,"测试");

var FaultEventConfirmColor = new HashMap();
FaultEventConfirmColor.put(0,"#F56023");
FaultEventConfirmColor.put(4,"#F56023");
FaultEventConfirmColor.put(5,"#F5A623");
FaultEventConfirmColor.put(6,"#2DBA6C");

var eventConfirmText = new Array("未确认", "真实火警", "误报", "测试");
var eventConfirmColor = new Array("#F56023", "#EE0B0B", "#F5A623", "#2DBA6C");
var confirmObj;
var firesSystemQueryVO = {
	"projectCode" : projectCode,
	"projectId" : projectId
};
var pgTwo;

// 获取历史事件的统计数据
function getAlarmSystemEventHisTotal() {
	var tempVO = {
		"projectCode" : projectCode,
		"projectId" : projectId
	};
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireAlarmSystem/getFiresEventDataVO",
		async : false,
		data : JSON.stringify(tempVO),
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data && data.code == 0 && data.data) {
				$("#no_revocery_num").html(data.data.noRecovery);
				$("#no_confirm_num").html(data.data.noConfirm);
			}

		},
		error : function(req, error, errObj) {
		}
	});

}

// 获取设备类型
function getDeviceType() {
	eventDeviecTypeList = new Array();
	$.ajax({
		type : "get",
		url : ctx + "/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=FIRE_FIGHTING&secondCode=FIRE_ALARM_SYSTEM",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			eventDeviecTypeList[eventDeviecTypeList.length] = {
				itemText : "请设备类型",
				itemData : ""
			};
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					eventDeviceTypeMap.put(this.itemData, this.itemText);
					eventDeviecTypeList[eventDeviecTypeList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置用户类型下拉列表
				deviceTypeObj = $("#device-type-dropdownlist").dropDownList({
					inputName : "deviceTypeName",
					inputValName : "deviceTypeCode",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {

					},
					items : eventDeviecTypeList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	deviceTypeObj.setData("请设备类型", "", "");
}

function initFiresSystemHisEvent() {

	eventTypeObj = $("#event-Type-dropdownlist").dropDownList({
		inputName : "eventTypeName",
		inputValName : "eventTypeValue",
		buttonText : "",
		width : "117px",
		readOnly : false,
		required : true,
		maxHeight : 200,
		onSelect : function(i, data, icon) {
			if (data) {
				if(data == 1){
					processResultList = confirmList;
				}else if (data==2){
					processResultList = faultConfirmList;
				}
				alarmEventType = data;
			} else {
				alarmEventType = null;
			}
			confirmDropdownlist(processResultList);
		},
		items : eventTypeList
	});
	eventTypeObj.setData("请选择事件", "", "");

	
	function confirmDropdownlist(processResultList){
		confirmObj = $("#confirm-dropdownlist").dropDownList({
			inputName : "confirmName",
			inputValName : "confirmValue",
			buttonText : "",
			width : "117px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
				if (data) {
					eventConfirm = data;
				} else {
					eventConfirm = null;
				}
			},
			
			items : processResultList
		});
		confirmObj.setData("请选择处理结果", "", "");
	}
	
	cleanFloor();
	cleanArea();
	getDeviceType();
	getBuildingList();
	getAlarmSystemEventHisTotal();
	// 时间控件
	$("#startTime").datetimepicker({
		id : 'datetimepicker-startDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		hours12 : false,
		allowBlank : true,
		format : 'Y-m-d H:i:s',
		formatDate : 'YYYY-mm-dd hh:mm:ss'
	});
	$("#endTime").datetimepicker({
		id : 'datetimepicker-endDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		hours12 : false,
		allowBlank : true,
		format : 'Y-m-d H:i:s',
		formatDate : 'YYYY-mm-dd hh:mm:ss'
	});
	showHisEventGrid();
}
function reloadEventGrid(){
	pgTwo.load({
		"page" : 1,
		"limitParamName":"limit"
	});
	eventGrid.load();
	getAlarmSystemEventHisTotal();
}
function getBuildingList() {
	eventBuildingList = new Array();
	// 获取建筑物列表
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/getLocationList?locationType=2",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			eventBuildingList[eventBuildingList.length] = {
				itemText : "请选择建筑物",
				itemData : ""
			};
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					eventBuildingList[eventBuildingList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置建筑物下拉列表
				eventBuildingList = $("#building-dropdownlist").dropDownList({
					inputName : "buildingName",
					inputValName : "buildingVal",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							// 根据建筑物获取楼层列表
							getFloorList(data);
							eventBuildId = data;
						} else {
							eventBuildId = null;
							cleanFloor();
							cleanArea();
						}
					},
					items : eventBuildingList
				});
				eventBuildingList.setData("请选择建筑物", "", "");
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

// 获取楼层列表
function getFloorList(parentId) {
	// 先清空列表，以免重复添加数据
	eventFloorList = new Array({itemText : "请选择楼层",itemData : ""});
	// levelTwoTypeMaps = new HashMap();
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/listLocationByParentId?parentId=" + parentId,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					eventFloorList[eventFloorList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置楼层下拉列表
				eventFloorDropdownList = $("#floors-dropdownlist").dropDownList({
					inputName : "floorsName",
					inputValName : "floorsVal",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							getAreaList(data);
							eventFloorId = data;
						} else {
							// 清空区域
							eventFloorId = null;
							cleanArea();
						}
					},
					items : eventFloorList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	eventFloorDropdownList.setData("请选择楼层", "", "");
}

// 获取区域列表
function getAreaList(parentId) {
	// 先清空列表，以免重复添加数据
	eventAreaList=new Array({itemText : "请选择区域",itemData : ""});
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingWaterSystemManage/listLocationByParentId?parentId=" + parentId,
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data != null && data.length > 0) {
				$(eval(data)).each(function() {
					eventAreaList[eventAreaList.length] = {
						itemText : this.itemText,
						itemData : this.itemData
					};
				});
				// 设置用户类型下拉列表
				eventAreaDropdownList = $("#area-dropdownlist").dropDownList({
					inputName : "areaName",
					inputValName : "areaVal",
					buttonText : "",
					width : "117px",
					readOnly : false,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {
						if (data != "" && data != undefined) {
							eventAreaId = data;
						} else {
							eventAreaId = null;
						}
					},
					items : eventAreaList
				});
			}
		},
		error : function(req, error, errObj) {
		}
	});
	eventAreaDropdownList.setData("请选择具体区域", "", "");
}

function showHisEventGrid() {
	// 历史事件数据展现列表
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
				width : 130,
				sortable : false,
				align : 'left'
			}, {
				title : '设备类型',
				name : 'deviceType',
				width : 135,
				sortable : false,
				align : 'left'
			},{
				title : '消息id',
				name : 'msgId',
				width : 130,
				sortable : false,
				align : 'left',
				hidden:true
			}, {
				title : '楼栋',
				name : 'building',
				width : 100,
				sortable : false,
				align : 'left'
			}, {
				title : '楼层',
				name : 'floor',
				width : 100,
				sortable : false,
				align : 'left'
			}, {
				title : '具体区域',
				name : 'area',
				width : 200,
				sortable : false,
				align : 'left'
			}, {
				title : '主机号',
				name : 'hostId',
				width : 80,
				sortable : false,
				align : 'left'
			}, {
				title : '回路号',
				name : 'circuitNumber',
				width : 80,
				sortable : false,
				align : 'left'
			}, {
				title : '测点号',
				name : 'nodeId',
				width : 80,
				sortable : false,
				align : 'left'
			}, {
				title : '发生时间',
				name : 'firstAlarmTime',
				width : 200,
				sortable : false,
				align : 'left'
			}, {
				title : '恢复时间',
				name : 'recoveryTime',
				width : 200,
				sortable : false,
				align : 'left',
				renderer : function(val) {
					if(val && val !=""){
						return	val;
					}else{
						return "/";
					}
				}
			}, {
				title : '持续时长',
				name : 'duration',
				width : 150,
				sortable : false,
				align : 'left',
				renderer : function(val) {
					if(val && val !=""){
						return	val+"s";
					}else{
						return "/";
					}
				}
			}, {
				title : '查看',
				name : '',
				width : 140,
				sortable : false,
				align : 'center',
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
			}, {
				title : '处理结果',
				name : 'eventConfirm',
				width : 140,
				align : 'center',
				lockWidth : true,
				lockDisplay : true,
				renderer : function(val, item, rowIndex) {
					if(item.alarmEventType=="火警"){
						if (item.eventConfirm == 0) {
							var span = '<span class="confirm" style="color:' + eventConfirmColor[item.eventConfirm] + ';">' + eventConfirmText[item.eventConfirm] + '</span>';
							return span;
						} else {
							var span = '<div class="span confirm" style="background:' + eventConfirmColor[item.eventConfirm] + ';">' + eventConfirmText[item.eventConfirm] + '</div>';
							return span;
						}
					}else if(item.alarmEventType=="故障"){
						if (item.eventConfirm == 0) {
							var span = '<span class="confirm" style="color:' + FaultEventConfirmColor.get(item.eventConfirm) + ';">' + FaultEventConfirmText.get(item.eventConfirm) + '</span>';
							return span;
						} else {
							var span = '<div class="span confirm" style="background:' + FaultEventConfirmColor.get(item.eventConfirm) + ';">' + FaultEventConfirmText.get(item.eventConfirm) + '</div>';
							return span;
						}
					}else{
						return "/";
					}
				}
			}
	];
	pgTwo = $('#pg_two').mmPaginator({"limitList" : [15],"limitParamName":"limit"});
	eventGrid = $('#tb-historicalData').mmGrid({
		height : 630,
		cols : cols,
		url : ctx + "/fire-fighting/fireAlarmSystem/listEventHis",
		method : 'get',
		remoteSort : false,
		sortName : 'id',
		sortStatus : 'desc',
		fullWidthRows : false,
		showBackboard:false,
		nowrap:true,
		autoLoad : false,
		params : function() {
			firesSystemQueryVO = {
				"projectId" : projectId,
				"projectCode" : projectCode
			};

			if (eventAreaId != null) {
				$(firesSystemQueryVO).attr({
					"localId" : eventAreaId
				});
			} else if (eventFloorId != null) {
				$(firesSystemQueryVO).attr({
					"localId" : eventFloorId
				});
			} else if (eventBuildId != null) {
				$(firesSystemQueryVO).attr({
					"localId" : eventBuildId
				});
			}

			var hostNumber = $("#hostId").val();

			if (hostNumber != "" && hostNumber != undefined) {
				$(firesSystemQueryVO).attr({
					"hostNumber" : hostNumber
				});
			}
			var loopNumber = $("#loopId").val();
			if (loopNumber != "" && loopNumber != undefined) {
				$(firesSystemQueryVO).attr({
					"loopNumber" : loopNumber
				});
			}

			var testNumber = $("#testId").val();
			if (testNumber != "" && testNumber != undefined) {
				$(firesSystemQueryVO).attr({
					"testNumber" : testNumber
				});
			}

			if (eventConfirm != "" && eventConfirm != undefined) {
				$(firesSystemQueryVO).attr({
					"eventConfirm" : eventConfirm
				});
			}
			if (alarmEventType != "" && alarmEventType != undefined) {
				$(firesSystemQueryVO).attr({
					"alarmEventType" : alarmEventType
				});
			}

			var deviceTypeCode = $("#deviceTypeCode").val();

			if (deviceTypeCode != "" && deviceTypeCode != undefined) {
				$(firesSystemQueryVO).attr({
					"deviceTypeCode" : deviceTypeCode
				});
			}
			var selectForm = getFormData("event_alarm_form");
			var startDate = selectForm.startTime.trim();
			var endDate = selectForm.endTime.trim();
			if (startDate != "" && startDate != undefined) {
				$(firesSystemQueryVO).attr({
					"startTime" : startDate
				});
			}
			if (endDate != "" && endDate != undefined) {
				$(firesSystemQueryVO).attr({
					"endTime" : endDate
				});
			}
			return firesSystemQueryVO;
		},
		plugins : [
		           pgTwo
		]
	});
	eventGrid.on('cellSelect', function(e, item, rowIndex, colIndex) {
		e.stopPropagation();
		if ($(e.target).is('.confirm') || $(e.target).is('.span')) {
			confirmItem = item;
			//消息id
			var msgId = item.msgId;
			var record = item.id;
			var eventType = item.alarmEventType;
			if(eventType=="火警"){
				eventType = 1;
			}else if(eventType=="故障"){
				eventType =2;
			}
			if (item.eventConfirm == 0) {
				// 点击确认
				createModalWithLoad("alarm-record-confirm-div", 600, 365, "结果确认", "fireFightingManage/ffmEventConfirm?recordId=" + record + "&confirmType=" + item.eventConfirm + "&eventType="+eventType + "&msgId="+msgId, "updateConfirm()", "confirm-close", "");
				openModal("#alarm-record-confirm-div-modal", false, false);
			}else{
				// 点击查看报警确认
				createModalWithLoad("alarm-record-confirm-div", 600, 220, "结果确认", "fireFightingManage/ffmEventConfirmDetail?recordId=" + record + "&confirmType=" + item.eventConfirm + "&eventType="+eventType +"&confirmDetail="+item.confirmType, "", "", "");
				openModal("#alarm-record-confirm-div-modal", false, false);
			}
		} else if ($(e.target).is('.item-img')) {
			var deviceId = item.cameraId;
			var deviceStatus = item.cameraStatus;
			// 点击查看视频弹框
			createModalWithLoad("authorizeOrder-div", 820, 555, "消防视频", "fireFightingManage/ffmVideoMonitorAlertPage?deviceStatus=" + deviceStatus + "&deviceId=" + deviceId, "", "", "");
			openModal("#authorizeOrder-div-modal", false, false);
		} else if ($(e.target).is('.item-imgs')) {
			// 点击查看图片
			var deviceNumber = item.deviceNumber;
			createModalWithLoad("edit-group-add", 820, 685, "消防报警抓拍", "fireFightingManage/ffmAlarmImagesPage?deviceNumber=" + deviceNumber, "", "", "");
			openModal("#edit-group-add-modal", false, false);
		}
	}).on('loadSuccess', function(e, data) {

	}).on('loadError', function(req, error, errObj) {
		showDialogModal("passage-error-div", "操作错误", "数据加载失败：" + errObj);
	}).load();

	
	$("#btn-query-event").click(function() {
		reloadEventGrid();
	});
	$('#export-event').on('click', function() {
		exportEventExecl();
	});

}

function cleanFloor() {
	eventFloorList = new Array({itemText : "请选择楼层",itemData : ""});
	// 楼层列表
	eventFloorDropdownList = $('#floors-dropdownlist').dropDownList({
		buttonText : "",
		width : "117px",
		readOnly : false,
		required : true,
		maxHeight : 200,
		onSelect : function(i, data, icon) {
			if (data) {
				eventFloorId = data;
			} else {
				eventFloorId = null;
			}
		},
		items : eventFloorList
	});
	eventFloorDropdownList.setData('请选择楼层', '');
}

function cleanArea() {
	eventAreaList=new Array({itemText : "请选择区域",itemData : ""});;
	// 具体区域列表
	eventAreaDropdownList = $('#area-dropdownlist').dropDownList({
		buttonText : "",
		width : "117px",
		readOnly : false,
		required : true,
		maxHeight : 300,
		onSelect : function(i, data, icon) {
			if (data) {
				eventAreaId = data;
			} else {
				eventAreaId = null;
			}
		},
		items : eventAreaList
	});
	eventAreaDropdownList.setData('请选择具体区域', '');
}

// 导出excel
function exportEventExecl() {
	var url = ctx + "/fire-fighting/fireAlarmSystem/alarmSystemHisRecordExcel";
	var params = "?projectId=" + projectId + "&projectCode=" + projectCode + "&hostId=" + firesSystemQueryVO.hostNumber + "&loopId=" + firesSystemQueryVO.loopNumber 
	+ "&testId=" + firesSystemQueryVO.testNumber + "&alarmEventType=" + firesSystemQueryVO.alarmEventType
	+ "&deviceTypeCode=" + firesSystemQueryVO.deviceTypeCode + "&locationId=" + firesSystemQueryVO.localId 
	+ "&startTime=" + firesSystemQueryVO.startTime + "&endTime=" + firesSystemQueryVO.endTime
	+ "&eventConfirm="+firesSystemQueryVO.eventConfirm
	+ "&pageNumber=1&pageSize=1000&sortType=desc&sortName=id";
	params = params.replace(/undefined/g,"");
	window.open(url + params);
}

function flushPage(){
	eventTypeObj.setData("请选择事件", "", "");
	deviceTypeObj.setData("请设备类型", "", "");
	confirmObj.setData("请选择处理结果", "", "");
	eventBuildingList.setData("请选择建筑物", "", "");
	cleanFloor();
	cleanArea();
	$("#hostId").val("");
	$("#loopId").val("");
	$("#testId").val("");
	$("#startTime").val("");
	$("#endTime").val("");
	eventFloorId=null;
	eventAreaId = null;
	eventBuildId = null;
	eventConfirm = null;
	alarmEventType = null;
	getAlarmSystemEventHisTotal();
	reloadEventGrid();
}
