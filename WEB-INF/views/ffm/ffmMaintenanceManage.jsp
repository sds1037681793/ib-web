<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<title>消防维保情况</title>
</head>
<body>
	<div style="margin-top: 10px; margin-right: 10px; width: 100%;"
		class="content-default">
		<form id="select-form" style="margin-top: 13px;">
			<table>
				<tr>
					<td align="right" width="100">测点名称：</td>
					<td><input id="deviceName" type="text"
						class="form-control required" style="width: 150px" /></td>
					<td align="right" width="100">位置：</td>
					<td><input id="position" type="text"
						class="form-control required" style="width: 150px" /></td>
					<td align="right" width="100">二级分类</td>
					<td>
						<div id="second-level-dropdownlist"></div>
					</td>
					<td align="right" width="100">设备类型：</td>
					<td>
						<div id="device-type-dropdownlist"></div>
					</td>
					<td align="right" width="100">维保状态</td>
					<td>
						<div id="maintenanceStatus-dropdownlist"></div>
					</td>
				</tr>
				<tr>
					<td align="right" width="100">主机号：</td>
					<td><input id="master" type="text"
						class="form-control required" style="width: 150px" /></td>
					<td align="right" width="100">回路号：</td>
					<td><input id="circuit" type="text"
						class="form-control required" style="width: 150px" /></td>
					<td align="right" width="100">测点号：</td>
					<td><input id="sight" type="text"
						class="form-control required" style="width: 150px" /></td>
						<td align="right" style="width: 11rem;">维保开始时间：</td>
					<td><input id="startDate" name="startDate"
						class="form-control required" type="text" style="width: 150px" /></td>
					<td align="right" style="width: 9rem;">维保结束时间：</td>
					<td><input id="endDate" name="endDate"
						class="form-control required" type="text" style="width: 150px" /></td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td>
						<button id="btn-query" type="button"
							class="btn btn-default btn-common btn-common-green btnicons"
							style="margin-left: 67px;">
							<p class="btniconimg"><span>查询</span></p>
						</button>
					</td>
				</tr>
			</table>
		</form>
	</div>


	<table id="tb_maintenance"
		style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>


	<div id="pg" style="text-align: right;"></div>
	<div id="datetimepicker-div"></div>
	<div id="error-div"></div>
	<script type="text/javascript">
		
	var levelTwoTypeList;
	var deviceTypeList;
	var deviceTypeMap = new HashMap();
	var secondLevelType="";
	var secondLevelTypeMap = new HashMap();
	var deviceTypeCode="";
	var pg;
	
	$("#startDate").datetimepicker({
		id : 'datetimepicker-validDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		customFormat:"yyyy-MM-dd hh:mm:ss",
		hours12:false,
		allowBlank:true,
		format: 'Y-m-d H:i:s',
		formatDate: 'YYYY-mm-dd HH:mm:ss'

	});

	$("#endDate").datetimepicker({
		id : 'datetimepicker-expireDate',
		containerId : 'datetimepicker-div',
		lang : 'ch',
		timepicker : true,
		customFormat:"yyyy-MM-dd hh:mm:ss",
		hours12:false,
		allowBlank:true,
		format: 'Y-m-d H:i:s',
		formatDate: 'YYYY-mm-dd HH:mm:ss'

	});
	
	$(document).ready(function(){
		getTwoCreatyType();
		maintenanceStatus();
		getDeviceType();
		// 事件展现列表
	    var cols = [
				{title:'序号',name:'id',width:100,sortable:false,align:'left'},
				{title:'测点名称',name:'deviceName',width:150,sortable:false,align:'left'},
				{title:'设备类型',name:'deviceTypeCode',width:150,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.deviceTypeCode!=null){
						return deviceTypeMap.get(item.deviceTypeCode);
					}  
				}},
				{title:'一级分类',name:'deviceFirstLevel',width:100,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					return "消防系统";
				}},
				{title:'二级分类',name:'deviceSecondLevel',width:150,sortable:false,align:'left',renderer:function (val, item , rowIndex){
					if (item && item.deviceSecondLevel!=null){
						return secondLevelTypeMap.get(item.deviceSecondLevel);
					}  
				}},
				{title:'位置',name:'position',width:150,sortable:false,align:'left'},
				{title:'主机号',name:'master',width:100,sortable:false,align:'center'},
				{title:'回路号',name:'circuit',width:100,sortable:false,align:'center'},
				{title:'测点号',name:'sight',width:100,sortable:false,align:'center'},
				{title:'维保时间',name:'maintenanceTime',width:200,sortable:false,align:'left'},
				{title:'维保状态',name:'maintenanceStatus',width:100,sortable:false,align:'left',renderer:function(val, item , rowIndex){
					if(item && item.maintenanceStatus!=null){
						if(item.maintenanceStatus==0){
							return "处理中";
						}else{
							return "已完成";
						}
					}
				}}
			];
			pg = $('#pg').mmPaginator({"limitList":[20]});
			tbMaintenance = $('#tb_maintenance').mmGrid({
			width:'99%',
			height:776,
			cols:cols,
			url:"${ctx}/fire-fighting/fireFightingManage/listMaintenance",
			contentType : "application/json;charset=utf-8",
			method:'get',
			remoteSort:false,
// 			sortName:'maintenanceTime',
// 			sortStatus:'desc',
			multiSelect:true,
			fullWidthRows:true,
			showBackboard:false,
			autoLoad:false,
			nowrap:true,
			params:function(){
				data = {"projectCode":projectCode};
				var deviceSecondCode = $("#deviceSecondCode").val();
				if (deviceSecondCode != "" && deviceSecondCode != undefined){
					$(data).attr({"deviceSecondCode": deviceSecondCode});
				}
				var deviceTypeCode = $("#deviceTypeCode").val();
				if (deviceTypeCode != "" && deviceTypeCode != undefined){
					$(data).attr({"deviceTypeCode": deviceTypeCode});
				}
			    var startDate = $("#startDate").val();
				if (startDate != "" && startDate != undefined){
					$(data).attr({"startDate": startDate});
				}
			    var endDate = $("#endDate").val();
				if (endDate != ""&&endDate!=undefined){
					$(data).attr({"endDate": endDate});
				}
				var master = $("#master").val();
				if (master != "" && master != undefined){
					$(data).attr({"master": master});
				}
				var circuit = $("#circuit").val();
				if (circuit != ""&&circuit!=undefined){
					$(data).attr({"circuit": circuit});
				} 
				var sight = $("#sight").val();
				if (sight != "" && sight != undefined){
					$(data).attr({"sight": sight});
				}
				var deviceName = $("#deviceName").val();
				if (deviceName != ""&& deviceName!=undefined){
					$(data).attr({"deviceName": deviceName});
				} 
				var position = $("#position").val();
				if (position != "" && position != undefined){
					$(data).attr({"position": position});
				}
				var maintenanceStatus = $("#maintenanceStatus").val();
				if (maintenanceStatus != ""&&maintenanceStatus!=undefined){
					$(data).attr({"maintenanceStatus": maintenanceStatus});
				}  
				return data;
			},
			plugins:[pg]
		});
			tbMaintenance.on('cellSelect',function(e,item,rowIndex,colIndex){
				e.stopPropagation();
				if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
					
				}else if($(e.target).is('.calss-modify') || $(e.target).is('.modify')){
					  
				}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
				}
			}).on('loadSuccess',function(e,data){
				
			}).on('loadError',function(req, error, errObj) {
 			}).load();
	})
	 // 获取设备类型
	function getDeviceType(){
		deviceTypeList= new Array();
		$.ajax({
			type: "get",
			url: "${ctx}/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=FIRE_FIGHTING&secondCode="+secondLevelType,
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				deviceTypeList[deviceTypeList.length] = {itemText: "请设备类型", itemData: ""};
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						deviceTypeMap.put(this.itemData,this.itemText);
						deviceTypeList[deviceTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					deviceTypeObj = $("#device-type-dropdownlist").dropDownList({
						inputName: "deviceTypeName",
						inputValName: "deviceTypeCode",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {
							
						},
						items: deviceTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		deviceTypeObj.setData("请设备类型" ,"", "");
		
	}
	
	 // 二级分类
    function getTwoCreatyType(){
    	levelTwoTypeList = new Array();
		$.ajax({
			type: "post",
			url: "${ctx}/device/deviceInfo/listDeviceParentCode?deviceFirstLevelCode=FIRE_FIGHTING",
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				levelTwoTypeList[levelTwoTypeList.length] = {itemText: "请选择二级系统", itemData: ""};
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
						secondLevelTypeMap.put(this.itemData,this.itemText);
						levelTwoTypeList[levelTwoTypeList.length] = {itemText: this.itemText, itemData: this.itemData};
					});
					// 设置用户类型下拉列表
					levelTwoTypeObj = $("#second-level-dropdownlist").dropDownList({
						inputName: "deviceSecondName",
						inputValName: "deviceSecondCode",
						buttonText: "",
						width: "117px",
						readOnly: false,
						required: true,
						maxHeight: 200,
						onSelect: function(i, data, icon) {
							if(data != "" && data != undefined){
								secondLevelType = data;
							}else{
								secondLevelType ="";
							}
							getDeviceType();
						},
						items: levelTwoTypeList
					});
				}
			},
			error: function(req, error, errObj) {
			}
		});
		levelTwoTypeObj.setData("请选择二级系统" ,"", "");
    }
	
	 $("#btn-query").click(function(){
		 pg.load({"page":1});
		 tbMaintenance.load();
	 })
	 //初始化维保状态列表
	function maintenanceStatus(){
		var maintenanceStatusList =new Array({itemText: "请选择维保状态", itemData: ""},{itemText: "处理中", itemData: "0"},{itemText: "已完成", itemData: "1"});
		maintenanceStatusObj = $("#maintenanceStatus-dropdownlist").dropDownList({
			inputName: "maintenanceStatusName",
			inputValName: "maintenanceStatus",
			buttonText: "",
			width: "117px",
			readOnly: false,
			required: true,
			maxHeight: 200,
			onSelect: function(i, data, icon) {
				
			},
			items: maintenanceStatusList
		});
		maintenanceStatusObj.setData("请选择维保状态" ,"", "");
	}
	</script>
</body>
</html>