<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>地磁信息</title>
</head>
<body>
	<div style="margin-top: 10px; margin-right: 10px; width: 100%;"
		class="content-default">
		<form id="select-form" style="margin-top: 13px;">
			<table>
				<tr>
					<td align="right" width="100">设备类型：</td>
					<td>
						<div id="device-type-dropdownlist"></div>
					</td>
					<td align="right" width="150">设备名称：</td>
					<td><input id="deviceName" type="text"
						class="form-control required" style="width: 150px" /></td>
					<td align="right" width="100">设备编码：</td>
					<td><input id="deviceNo" type="text"
						class="form-control required" style="width: 150px" /></td>
					<td>
						<button id="btn-query" type="button"
							class="btn btn-default btn-common btn-common-green btnicons"
							style="margin-left: 67px;">
							<p class="btniconimg">
								<span>查询</span>
							</p>
						</button>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<table id="tb_geomag"
		style="border: 1px solid; height: 99%; width: 99%; margin: 0 auto;">
		<tr>
			<th rowspan="" colspan=""></th>
		</tr>
	</table>
	<div id="pg" style="text-align: right;"></div>
	<div id="datetimepicker-div"></div>
	<div id="error-div"></div>
	
	
	<script type="text/javascript">
	var deviceTypeList;
		$(document).ready(function(){
			getDeviceType();
			var cols = [
						{title:'序号',name:'id',width:50,sortable:false,align:'left'},
						{title:'设备类型',name:'deviceType',width:150,sortable:false,align:'left'},
						{title:'设备编码',name:'deviceNo',width:150,sortable:false,align:'left'},
						{title:'设备名称',name:'deviceName',width:150,sortable:false,align:'left'},
						{title:'电压状态',name:'lowBatteryStatus',width:100,sortable:false,align:'center',
						renderer:function (val, item , rowIndex){
							if (item.lowBatteryStatus==1){
								return "欠压";
							}  else{
								return "正常";
							}
						}},
						{title:'占用状态',name:'monitorStatus', width:100,sortable:false,align:'center',renderer:function (val, item , rowIndex){
							if(item.deviceType=='车位地磁'||item.deviceType=='消防门地磁'){
								if (item.monitorStatus==1){
									return "占用";
								}  else{
									return "空闲";
								}
							}else{
								"";
							}

						}},
						{title:'设备状态',name:'deviceStatus',width:100,sortable:false,align:'center',renderer:function (val, item , rowIndex){
							if (item.deviceStatus==1){
								return "离线";
							}  else{
								return "在线";
							}
						}},
						{title:'电量',name:'battery',width:100,sortable:false,align:'center',renderer:function (val, item , rowIndex){
							if (item.battery != null){
								return item.battery.toFixed(2);
							}
						}},
						{title:'电压',name:'voltage',width:100,sortable:false,align:'center'},
						{title:'更新时间',name:'maintenanceTime',width:200,sortable:false,align:'left',hidden:true}
					];
					pg = $('#pg').mmPaginator({"limitList":[20]});
					tbGeomag = $('#tb_geomag').mmGrid({
					width:'99%',
					height:776,
					cols:cols,
					url:"${ctx}/fire-fighting/iotSensorManage/listQuery",
					contentType : "application/json;charset=utf-8",
					method:'post',
					remoteSort:false,
//		 			sortName:'maintenanceTime',
//		 			sortStatus:'desc',
					multiSelect:true,
					fullWidthRows:true,
					showBackboard:false,
					autoLoad:false,
					nowrap:true,
					params:function(){
						data = {"projectCode":projectCode};
						
						var deviceTypeCode = $("#deviceTypeCode").val();
						if (deviceTypeCode != "" && deviceTypeCode != undefined){
							$(data).attr({"deviceTypeCode": deviceTypeCode});
						}
					   
						var deviceName = $("#deviceName").val();
						if (deviceName != "" && deviceName != undefined){
							$(data).attr({"deviceName": deviceName});
						}
						var deviceNo = $("#deviceNo").val();
						if (deviceNo != ""&&deviceNo!=undefined){
							$(data).attr({"deviceNo": deviceNo});
						} 
					
						return data;
					},
					plugins:[pg]
				});
					tbGeomag.on('cellSelect',function(e,item,rowIndex,colIndex){
						e.stopPropagation();
						if($(e.target).is('.calss-view') || $(e.target).is('.glyphicon-search')){
							
						}else if($(e.target).is('.calss-modify') || $(e.target).is('.modify')){
							  
						}else if($(e.target).is('.calss-delete') || $(e.target).is('.glyphicon-remove')){
						}
					}).on('loadSuccess',function(e,data){
						
					}).on('loadError',function(req, error, errObj) {
		 			}).load();
			
		});
		 $("#btn-query").click(function(){
			 pg.load({"page":1});
			 tbGeomag.load();
		 })
		 
		 
		 // 获取设备类型
	function getDeviceType(){
		deviceTypeList= new Array();
		$.ajax({
			type: "get",
			url: "${ctx}/device/deviceInfo/listDeviceTypeByFirstCodeAndSecondCode?firstCode=INTERNET_OF_THINGS_SYSTEM&secondCode=",
			async: false,
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				deviceTypeList[deviceTypeList.length] = {itemText: "请设备类型", itemData: ""};
				if (data != null && data.length > 0) {
					$(eval(data)).each(function(){
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
	</script>
</body>
</html>
