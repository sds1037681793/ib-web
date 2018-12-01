    var tbAuthorizeOrder;
 	var today = "${today}";
 	/* $('#startDate').val(today);
 	$('#endDate').val(today);        */
 	var organizeId = $("#login-org").data("orgId");
 	var deviceTypeList = new Array();
 	var buildingList = new Array();
 	var floorList = new Array();
 	var areaList = new Array();
 	var stateList = new Array();
 	var systemType = 1;
 	var buildingId;
 	var floorId;
 	var areaId;
 	var tempBuildingList;
 	var tempDeviceTypeList;
 	var deviceTypeCode;
 	var alarmStatus;
 	var alarmSystemData;
 	var hostNumber;
 	var loopNumber;
 	var testNumber;
 	var startDate;
 	var endDate;
 	var locationId;
 	var pg;
 	//楼层列表
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
 	//报警状态列表
 	var alarmStatusDropdownList = [
 			{
 				itemText : '请选择报警状态',
 				itemData : ''
 			}, {
 				itemText : '正常',
 				itemData : '0'
 			}, {
 				itemText : '火警',
 				itemData : '1'
 			}, {
 				itemText : '故障',
 				itemData : '2'
 			}, {
 				itemText : '回答',
 				itemData : '3'
 			}
 	];
 	var tempAlarmStatusDropdownList;
function ffmAlarmSysteminit(ctx){
	areaId = "";
		floorId = "";
		buildingId = "";
		$("#startDate").datetimepicker({
			id: 'datetimepicker-startDate',
			containerId: 'datetimepicker-div',
			lang: 'ch',
			timepicker: true,
			hours12 : false,
			allowBlank:true,
			format : 'Y-m-d H:i:s',
			formatDate : 'YYYY-mm-dd hh:mm:ss'
		});
		$("#endDate").datetimepicker({
			id: 'datetimepicker-endDate',
			containerId: 'datetimepicker-div',
			lang: 'ch',
			timepicker: true,
			hours12 : false,
			allowBlank:true,
			format : 'Y-m-d H:i:s',
			formatDate : 'YYYY-mm-dd hh:mm:ss'
		});
		
		deviceType = $("#deviceType-dropdownlist").dropDownList({
			inputName: "deviceTypeName",
			inputValName: "deviceTypeId",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: deviceTypeList
		});
		
		//楼层列表
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
		
		 state = $("#state-dropdownlist").dropDownList({
			inputName: "stateName",
			inputValName: "stateId",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {},
			items: stateList
		});
		 deviceTypeList = new Array();
		// 获取设备类型列表
			$.ajax({
				type : "get",
				url : ctx + "/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=FIRE_FIGHTING&secondCode=FIRE_ALARM_SYSTEM",
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
							// 							levelTypeMaps.put(this.itemData,this.itemText);
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
			
			// 报警类型列表
			tempAlarmStatusDropdownList = $('#state-dropdownlist').dropDownList({
				inputName : "alarmStatus",
				inputValName : "alarmStatusVal",
				buttonText : "",
				width : "117px",
				readOnly : false,
				required : true,
				maxHeight : 300,
				onSelect : function(i, data, icon) {
					alarmStatus = data;
				},
				items : alarmStatusDropdownList
			});
			
		 	if(projectAlarmStatus!= null && projectAlarmStatus.length>0 ){
		 		alarmStatus=projectAlarmStatus;
		 		tempAlarmStatusDropdownList.setData(alarmStatusDropdownList[Number(alarmStatus)+1].itemText, alarmStatus,'');
		 	} else {
		 		tempAlarmStatusDropdownList.setData('请选择报警状态', '');
		 	}
		
		var cols = [
					{title:'设备名称',name:'deviceName',sortable: false,width:200,align:'left'},
					{title:'设备类型',name:'deviceType',sortable: false,width:140,align:'left'},
					{title:'楼栋',name:'building',sortable: false,width:140,align:'left'},
					{title:'楼层',name:'floor',sortable: false,width:145,align:'left'},
					{title:'具体区域',name:'area',sortable: false,width:180,align:'left'},
					{title:'主机号',name:'hostNumber',sortable: false,width:140,align:'left'},			
					{title:'回路号',name:'loopNumber',sortable: false,width:140,align:'left'},			
					{title:'测点号',name:'measuringPoint',sortable: false,width:140,align:'left'},
					{
						title : '状态',
						name : 'alarmStatus',
						width : 140,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item.alarmStatus.indexOf('火警') != -1) {
								return '<span style="text-align:left;color:red;">'+item.alarmStatus+'</span>';
							} else {
								return '<span style="text-align:left;">'+item.alarmStatus+'</span>';
							}
						}
					},
					{
						title : '发生时间',
						name : 'maintenanceTime',
						width : 250,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item.maintenanceTime.length >= 21) {
								return '<span style="text-align:left;">'+item.maintenanceTime.substring(0,19)+'</span>';
							} else {
								return '<span style="text-align:left;">'+item.maintenanceTime+'</span>';
							}
						}
					}, 
					{title:'查看', name:'' ,width:120, align:'left', lockWidth:true, lockDisplay: true, renderer: function(val, item , rowIndex){
						if(item.cameraId==undefined){
							var modifyObj = "/";
							return modifyObj;
						}
						if(item.cameraId!=undefined){
							var videoSrc = ctx+"/static/img/ffm/shipin.svg";
							var pictureSrc = ctx+"/static/img/ffm/tupian.svg";
							var modifyObj = '<img class="item-img" src="'+videoSrc+'"/>';
 							var deleteObj = '<img class="item-imgs" src="'+pictureSrc+'"/>';
							return modifyObj + deleteObj;
						}

					}}
		            ];
		pg=$('#pg').mmPaginator({"limitList":[15],"limitParamName":"limit"});
		tbAuthorizeOrder = $('#tb_authorizeOrder').mmGrid({
			height:630,
			cols:cols,
			url:ctx + '/fire-fighting/fireAlarmSystem/listQuery',
			method:'post',
			params:function(){
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

				if (alarmStatus != "" && alarmStatus != undefined) {
					$(data).attr({
						"alarmStatus" : alarmStatus
					});
				}
				
				if (deviceTypeCode != "" && deviceTypeCode != undefined) {
					$(data).attr({
						"deviceTypeCode" : deviceTypeCode
					});
				}

				if (areaId != "" && areaId != undefined) {
					locationId=areaId;
					$(data).attr({
						"locationId" : areaId
					});
				} else if (floorId != "" && floorId != undefined) {
					locationId=floorId;
					$(data).attr({
						"locationId" : floorId
					});
				} else if (buildingId != "" && buildingId != undefined) {
					locationId=buildingId;
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
			remoteSort:false,
			sortName:'id',
			sortStatus:'desc',
			multiSelect:false,
			checkCol:false,
		    nowrap:true,
			fullWidthRows:false,
			autoLoad:false,
			showBackboard:false,
			plugins:[pg]
		});
		tbAuthorizeOrder.on('cellSelect',function(e,item,rowIndex,colIndex){
			e.stopPropagation();
			if ($(e.target).is('.item-img')) {	
				var deviceId = item.cameraId;
				var deviceStatus = item.cameraStatus;
				// 点击查看视频弹框
				createModalWithLoad("authorizeOrder-div", 820, 595, "消防报警视频", "fireFightingManage/ffmVideoMonitorAlertPage?deviceId="+deviceId+"&deviceStatus="+deviceStatus, "", "", "");
				openModal("#authorizeOrder-div-modal", false, false);
			} else if ($(e.target).is('.item-imgs')) {	
				// 点击查看图片
				var deviceNumber = item.deviceNumber;
				createModalWithLoad("edit-group-add", 820, 685, "消防报警抓拍", "fireFightingManage/ffmAlarmImagesPage?deviceNumber="+deviceNumber, "", "", "");
				openModal("#edit-group-add-modal", false, false);
			}
		}).on('loadSuccess',function(e,data){
		}).on('loadError',function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", "数据加载失败：" + errObj);
		}).load();
		
		$('#btn-query-summary').on('click', function(){		
			/*pg.load({"page":1,"limitParamName":"limit"});
			tbAuthorizeOrder.load();*/
			reloadGrid();
		});
		getAlarmSystemDataNum();
		//获取楼层列表
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
		
		//获取区域列表
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

$('#export-summary').on('click',function(){
		exportExecl();
		});
		
	//导出excel
	function exportExecl() {
		 if(deviceTypeCode==undefined){
			deviceTypeCode = "";
		}
		if(alarmStatus==undefined){
			alarmStatus = "";
		}
		if(locationId==undefined){
			locationId = "";
		} 
		var url = ctx + "/fire-fighting/fireAlarmSystem/ffmAlarmDataExecl";
		var prams = "?projectId=" + projectId + "&hostNumber=" + hostNumber+ "&projectCode="+projectCode+ "&loopNumber=" + loopNumber
		+  "&testNumber=" + testNumber+  "&alarmStatus=" + alarmStatus+  "&deviceTypeCode=" + deviceTypeCode+  "&locationId=" + locationId
		+  "&startTime=" + startDate+  "&endTime=" + endDate
				+"&pageNumber=1&pageSize=1000&sortType=desc&sortName=timeStamp";
		window.open(url+prams);
	}

	function deleteOrder(rowIndex){
		var deleteRow = tbAuthorizeOrder.row(rowIndex);
		$.ajax({
			type:"post",
			url:ctx + "/authorizeChangeOrder/deleteOrder/"+deleteRow.id,
			dataType:"json",
			contentType: "application/json;charset=utf-8",
			success:function(data) {
				if (data && data.CODE && data.CODE == "SUCCESS") {
					showDialogModal("error-div", "操作提示", "删除成功");
					tbAuthorizeOrder.load();
					return true;
				} else {
					showAlert('warning', data.MESSAGE, "edit-cust-button-confirm", 'top');
					return false;
				}
			},
			error: function(req,error,errObj) {
				showAlert('warning', '提交失败：'+errObj, "edit-cust-button-confirm", 'top');
				return false;		
			}
		});
	}

	function getAlarm(){
		$.ajax({
			type:"post",
			url:ctx + "/fire-fighting/fireAlarmSystem/fireAlarmData?projectCode="+projectCode+"&systemType="+systemType,
			dataType:"json",
			contentType: "application/json;charset=utf-8",
			success:function(data) {
				$("#alarm").html(data);
			},
			error: function(req,error,errObj) {
				showAlert('warning', '提交失败：'+errObj, "edit-cust-button-confirm", 'top');
				return false;		
			}
		});
	}

	function getFault(){
		$.ajax({
			type:"post",
			url:ctx + "/fire-fighting/fireAlarmSystem/fireFaultData?projectCode="+projectCode+"&systemType="+systemType,
			dataType:"json",
			contentType: "application/json;charset=utf-8",
			success:function(data) {
				$("#fault").html(data);
			},
			error: function(req,error,errObj) {
				showAlert('warning', '提交失败：'+errObj, "edit-cust-button-confirm", 'top');
				return false;		
			}
		});
	}

	function getAnswer(){
		$.ajax({
			type:"post",
			url:ctx + "/fire-fighting/fireAlarmSystem/fireAnswerData?projectCode="+projectCode+"&systemType="+systemType,
			dataType:"json",
			contentType: "application/json;charset=utf-8",
			success:function(data) {
				$("#answer").html(data);
			},
			error: function(req,error,errObj) {
				showAlert('warning', '提交失败：'+errObj, "edit-cust-button-confirm", 'top');
				return false;		
			}
		});
	}

	function VideoMonitor(deviceId){
		createModalWithLoad("device-detail", 560, 340, "查看设备状态明细", "fireFightingManage/ffmVideoMonitorAlertPage?deviceId="+deviceId+"", "", "", "");
		$("#device-detail-modal").modal('show');
	}

	function getAlarmSystemDataNum() {
		var tempVO = {"projectCode" : projectCode};
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireAlarmSystem/getAlarmSystemData",
		dataType : "json",
		data : JSON.stringify(tempVO),
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			$("#fireStatus").text(data.fireStatusNum);
			$("#faultStatus").text(data.faultStatusNum);
			$("#linkage").text(data.linkageNum);
		},
		error : function(req, error, errObj) {
			showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	});
	}
	function reloadGrid(){
		pg.load({"page":1,"limitParamName":"limit"});
		tbAuthorizeOrder.load();
	}
	function flushRealTimePage(){
		tempDeviceTypeList.setData("请选择设备类型", "", "");
		tempBuildingList.setData("请选择建筑物", "", "");
		tempAlarmStatusDropdownList.setData('请选择报警状态', '');
		$("#hostNumber").val("");
		$("#loopNumber").val("");
		$("#measuringPoint").val("");
		$("#startDate").val("");
		$("#endDate").val("");
		alarmStatus=null;
		deviceTypeCode = null;
		areaId = null;
		floorId = null;
		buildingId = null;
		getAlarmSystemDataNum();
		reloadGrid();
		
	}