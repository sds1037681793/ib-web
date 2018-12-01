<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />

<!DOCTYPE html>
<html>
<head>
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="content-default" style="min-width: 1050px;">
		<form>
			<table style="min-width: 1000px;">
				<tr>
					<td align="right" width="100">电梯名称：</td>
					<td><input id="deviceName" name="deviceName"
						placeholder="电梯名称" class="form-control required" type="text"
						style="width: 140px" /></td>
					<td align="right" style="width: 4rem;">二级分类：</td>
					<td><div id="second-level-dropdownlist"></div></td>

					<td align="right" style="width: 4rem;">设备类型：</td>
					<td><div id="device-type-dropdownlist"></div></td>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
					<!-- 			<td align="right" style="width:4rem;">一级分类：</td> -->
					<!-- 			<td><div id="first-type-dropdownlist"></div></td> -->


				</tr>
				<tr>

					<td align="right" style="width: 4rem;">维保状态：</td>
					<td><div id="maintenance-state-dropdownlist"></div></td>

					<td align="right" style="width: 11rem;">维保开始时间：</td>
					<td><input id="startTime" name="startTime"
						class="form-control required" type="text" style="width: 150px;" /></td>

					<td align="right" style="width: 9rem;">维保结束时间：</td>
					<td><input id="endTime" name="endTime"
						class="form-control required" type="text" style="width: 150px;" /></td>

					<td>
						<button id="btn-query-info" type="button" class="btn btn-default btnicons"
							style="margin-left: 3rem;">
							<p class="btniconimg"><span>查询</span></p>
						</button>
					</td>
					<!-- 			<td> -->
					<!-- 			<button id="export" name="export" type="button" class="btn btn-default " style="margin-left: 3rem;width:78px; color: #00BFA5;outline:0;border-color: #00BFA5;">导出</button> -->
					<!-- 			</td>  -->
				</tr>
			</table>
		</form>
	</div>

	<table id="record-table" class="record-table"
		style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto; min-width: 750px;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>

	<div id="pg" style="text-align: right;"></div>
	<div id="error-div"></div>
	<div id="datetimepicker-div"></div>

	<script type="text/javascript">
		var recordTable;
		var secondLevelType = "";
		var tbDevices;
		var deviceTypeMap;
		var secondLevelTypeMap = new HashMap();
		$(document).ready(function() {

			//  			//分类
			getTwoCreatyType();

			//  			//设备类型
			getDeviceType();

			var maintenanceStatusListInfo = new Array({
				itemText : "请选择维保状态",
				itemData : ""
			}, {
				itemText : '处理中',
				itemData : '0'
			}, {
				itemText : '已完成',
				itemData : '1'
			});
			maintenanceStateList = $("#maintenance-state-dropdownlist").dropDownList({
				inputName : "maintenance-state-Name",
				inputValName : "maintenance-state-Type",
				buttonText : "",
				width : "108px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				items : maintenanceStatusListInfo
			});
			maintenanceStateList.setData("请选择维保状态", "", "");

			$("#startTime").datetimepicker({
				id : 'datetimepicker-startTime',
				containerId : 'datetimepicker-div',
				lang : 'ch',
				timepicker : true,
				customFormat : "yyyy-MM-dd hh:mm:ss",
				hours12 : false,
				allowBlank : true,
				format : 'Y-m-d H:i:s',
				formatDate : 'YYYY-mm-dd HH:mm:ss'

			});

			$("#endTime").datetimepicker({
				id : 'datetimepicker-endTime',
				containerId : 'datetimepicker-div',
				lang : 'ch',
				timepicker : true,
				customFormat : "yyyy-MM-dd hh:mm:ss",
				hours12 : false,
				allowBlank : true,
				format : 'Y-m-d H:i:s',
				formatDate : 'YYYY-mm-dd HH:mm:ss'

			});

			var infoCols = [
					{
						title : '流水号',
						name : 'id',
						width : 150,
						sortable : false,
						align : 'left',
						hidden : true
					}, {
						title : '电梯编号',
						name : 'deviceNo',
						width : 200,
						sortable : false,
						align : 'left'
					}, {
						title : '电梯名称',
						name : 'deviceName',
						width : 160,
						sortable : false,
						align : 'left'
					}, {
						title : '设备类型',
						name : 'deviceTypeCode',
						width : 120,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.deviceTypeCode != null) {
								return deviceTypeMap.get(item.deviceTypeCode);
							}
						}
					}, {
						title : '一级分类',
						name : 'deviceFirstLevel',
						width : 150,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							return "电梯系统";
						}
					}, {
						title : '二级分类',
						name : 'deviceSecondLevelCode',
						width : 200,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.deviceSecondLevelCode != null) {
								return secondLevelTypeMap.get(item.deviceSecondLevelCode);
							}
						}
					},

					{
						title : '维保时间',
						name : 'maintenanceStartTime',
						width :200,
						sortable : false,
						align : 'left'
					}, {
						title : '下次维保时间',
						name : 'nextMaintenanceTime',
						width : 200,
						sortable : false,
						align : 'left'
					}, {
						title : '是否超期',
						name : 'maintenanceDelayStatusName',
						width : 120,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.maintenanceDelayStatus == 0) {
								return "正常";
							} else if (item && item.maintenanceDelayStatus == 1) {
								return "延期";
							} else if (item && item.maintenanceDelayStatus == 2) {
								return "延期处理";
							}
						}
					}, {
						title : '维保状态',
						name : 'maintenanceStatusName',
						width : 120,
						sortable : false,
						align : 'left',
						renderer : function(val, item, rowIndex) {
							if (item && item.maintenanceStatus == 0) {
								return "处理中";
							} else if (item && item.maintenanceStatus == 1) {
								return "已完成";
							}
						}
					}

			];

			var pg = $('#pg').mmPaginator({
				"limitList" : [
					20
				]
			});

			tbDevices = $('#record-table').mmGrid({
				width:'99%',
				height : 776,
				cols : infoCols,
				url : "${ctx}/elevator/elevatorMaintenanceRecord/queryRecordList",
				method : 'post',
				remoteSort : false,
				multiSelect : false,
				nowrap : true,
				checkCol : false,
				fullWidthRows : true,
				autoLoad : false,
				showBackboard : false,
				params : function() {

					var deviceName = $.trim($("#deviceName").val());
					var deviceSecondLevelCode = $("#secondLevelCode").val();

					// 设备类型
					var deviceTypeCode = $("#deviceTypeCode").val();

					var maintenanceStatus = $("#maintenance-state-Type").val().trim();

					var startTime = $("#startTime").val().trim();
					if (startTime != undefined && startTime.length > 0) {
						startTime = startTime;
					} else {
						startTime = "";
					}

					var endTime = $("#endTime").val().trim();
					if (endTime != undefined && endTime.length > 0) {
						endTime = endTime;
					} else {
						endTime = "";
					}

					data = {
						"projectCode" : projectCode,
						"deviceName" : deviceName,
						"deviceSecondLevelCode" : deviceSecondLevelCode,
						"maintenanceStatus" : maintenanceStatus,
						"startTime" : startTime,
						"endTime" : endTime
					};
					return data;
				},
				plugins : [
					pg
				]
			});
			tbDevices.on('cellSelect', function(e, item, rowIndex, colIndex) {
				e.stopPropagation();
				if ($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')) {

				} else if ($(e.target).is('.calss-modify') || $(e.target).is('.modify')) {

				} else if ($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')) {
				}
			}).on('loadSuccess', function(e, data) {

			}).on('loadError', function(req, error, errObj) {
			}).load();

		});
		$('#export').on('click', function() {
			exportExecl();
		});

		$('#btn-query-info').on('click', function() {
			tbDevices.load();
		});

		// 获取设备类型
		function getDeviceType() {
			deviceTypeList = new Array();
			deviceTypeMap = new HashMap();
			$.ajax({
				type : "get",
				url : "${ctx}/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=ELEVATOR&secondCode=" + secondLevelType,
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					deviceTypeList[deviceTypeList.length] = {
						itemText : "请设备类型",
						itemData : ""
					};
					if (data != null && data.length > 0) {
						$(eval(data)).each(function() {
							deviceTypeMap.put(this.itemData, this.itemText);
							deviceTypeList[deviceTypeList.length] = {
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
							items : deviceTypeList
						});
					}
				},
				error : function(req, error, errObj) {
				}
			});
			deviceTypeObj.setData("请设备类型", "", "");

		}

		// 二级分类
		function getTwoCreatyType() {
			levelTwoTypeList = new Array();
			$.ajax({
				type : "post",
				url : "${ctx}/device/deviceInfo/listDeviceParentCode?deviceFirstLevelCode=ELEVATOR",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					levelTwoTypeList[levelTwoTypeList.length] = {
						itemText : "请选择二级系统",
						itemData : ""
					};
					if (data != null && data.length > 0) {
						$(eval(data)).each(function() {
							secondLevelTypeMap.put(this.itemData, this.itemText);
							levelTwoTypeList[levelTwoTypeList.length] = {
								itemText : this.itemText,
								itemData : this.itemData
							};
						});
						// 设置用户类型下拉列表
						levelTwoTypeObj = $("#second-level-dropdownlist").dropDownList({
							inputName : "secondLevelName",
							inputValName : "secondLevelCode",
							buttonText : "",
							width : "117px",
							readOnly : false,
							required : true,
							maxHeight : 200,
							onSelect : function(i, data, icon) {
								if (data != "" && data != undefined) {
									secondLevelType = data;
								} else {
									secondLevelType = "";
								}
								getDeviceType();
							},
							items : levelTwoTypeList
						});
					}
				},
				error : function(req, error, errObj) {
				}
			});
			levelTwoTypeObj.setData("请选择二级系统", "", "");
		}

		function exportExecl() {
			var level = $("#powerType").val();
			var startTime = $("#startTime").val().trim();
			var endTime = $("#endTime").val().trim();
			var url = "${ctx}/power-supply/pdsElectricityMeterRecordHis/exportExecl";
			var prams = "?startTime=" + startTime + "&endTime=" + endTime + "&level=" + level + "&projectCode=" + projectCode + "&pageNumber=1&pageSize=500&sortType=desc&sortName=deviceNo&queryType=2";
			// 			$.each(dynamicTableItems, function(n, item) {
			// 				var object = $("#" + item.inputName).val();
			// 				if (object != undefined && object != null) {
			// 					prams = prams + "&" + item.inputName + "=" + $.trim($("#" + item.inputName).val());
			// 				}
			// 			});
			window.open(url + prams);
		}
	</script>
</body>
</html>