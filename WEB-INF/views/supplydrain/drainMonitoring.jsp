<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd HH:mm:ss" />
<!DOCTYPE html>
<html>
<head>
    <link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/static/css/pagination.css" rel="stylesheet"type="text/css" />
	<script src="${ctx}/static/js/jquery.pagination.js"type="text/javascript"></script>
    <link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<style type="text/css"> 

 .header-default { 
 	background-color: #fff; 
 	border: 1px solid #e1e1e1; 
 	padding: 17px; 
 	margin-bottom: 20px; 
 	margin-left: 10px; 
 	width: 99%; 
 	background: #FFFFFF; 
 	border: 1px solid #B2B2B2; 
 	border-radius: 4px; 
 }

 .form-control { 
 	margin-left: 10px; 
 	border: 1px solid #CCCCCC; 
 	border-radius: 2px; 
 }

 #quPassageName, #ddl-btn-quPassageName, #ddl-btn-custmTypeName, 
 	#custmTypeName { 
 	 	border: 1px solid #CCCCCC;  
 	border-radius: 2px; 
	
 } 

 .pagination .current.prev, .pagination .next { 
 	border-color: #FFFFFF; 
 	background: #ffffff; 
 	font-size: 12px; 
 	color:#00BFA5; 
 } 

 .pagination .prev { 
 	border-color: #FFFFFF; 
 	background: #ffffff; 
 	font-size: 12px; 
 	color:#00BFA5;
 } 

 .pagination .current { 
 	border: 0px solid #E3EBED; 
 	background-color: #00BFA5;
 	font-size: 14px; 
 	padding-top: 4px; 
 } 

 .pagination a { 
 	text-decoration: none;
 	background: #FFFFFF; 
 	border: 1px solid #E3EBED;
 	font-family: PingFangSC-Regular; 
 	font-size: 12px; 
 	color: #00BFA5; 
 } 
</style>
</head>
<body>
	<div class="content-default" style="min-width: 99%;">
		<form>
			<table style="min-width: 65%;">
				<tr>
					<td align="right" style="width:8rem;">选择楼栋：</td>
					<td><div id="building-dropdownlist"></div></td>
					<td align="right" style="width:8rem;">选择楼层：</td>
					<td><div id="floor-dropdownlist"></div></td>
					<td align="right" style="width:8rem;">设备编号：</td>
					<td><input id="deviceNumber" name="deviceNumber" placeholder="设备编号"class="form-control required" type="text" style="width:150px;" /></td>
 					<td>
 					<button id="btn-query" type="button" class="btn btn-default btnicons" >
					<p class="btniconimg"><span>查询</span></p>
                	</button>				
                    </td> 
				</tr>
			</table>
		</form>
	</div>
	<div id="drianMonitoringDiv" class="content-default"style="height: 99%; overflow:scroll;overflow:hidden;width: 100%; padding-left: 150px; background: #fff; border: 1px solid #ccc;">
	</div>
	<div class="pagination" style="position: relative; float: right;"></div>
	<div id="error-div" ></div>
	<div id="datetimepicker-div"></div>
	<div id="drainDeviceDetail-img"></div>

 	<script type="text/javascript"> 
      var deviceData;
      //var orgId = $("#login-org").data("orgId");
      var buildingItems=new Array();
      var AllBuilding;
      var floorItems=new Array();
      var Allfloor;
      var limit = 30;
      var code="SUMP_SUBMERSIBLE_PUMP";
      var locationType=5;
      var firstReturnData;
      var returnData;
      var drainDeviceDetail;
      var currentDisplayPage=0;
      var currentDrainDeviceId;
      var isOpenDetail=0;
 		$(document).ready(function(){
 			initPage();
 			toSubscribe();
			$.ajax({
					type : "post",
					url : "${ctx}/device/manages/newBuildings?projectCode="+ projectCode+"&locationType="+locationType+"&code="+code,
					async : false,
					dataType : "json",
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						if (data != null && data.length > 0) {
							$(eval(data)).each(function() {
								buildingItems[buildingItems.length] = {itemText : this.itemText,itemData : this.itemData};
							});
							// 设置楼栋下拉列表
						AllBuilding = $("#building-dropdownlist").dropDownList({
								inputName : 'buildingName',
								inputValName : 'buildingId',
								buttonText : "",
								width : "116px",
								readOnly : false,
								required : true,
								maxHeight : 200,
								onSelect: function(i, data, icon) {
									var id = data;
									if(id==undefined){
										Allfloor = $("#floor-dropdownlist").dropDownList({
											inputName : 'floorName',
											inputValName : 'floorId',
											buttonText : "",
											width : "116px",
											readOnly : false,
											required : true,
											maxHeight : 200,
											items : [{itemText:'所有楼层',itemData:""}]
										});
									Allfloor.setData("所有楼层","", "");
										return;
									}else{
										//这里根据楼栋查询楼层列表
										$.ajax({
											type : "post",
											url : "${ctx}/device/manages/freshAirFloor?parentId="+ id,
											dataType : "json",
											async:false,
											contentType : "application/json;charset=utf-8",
											success : function(data) {
												if (data != null && data.length > 0) {
													floorItems=[];
													$(eval(data)).each(function() {
														floorItems[floorItems.length] = {itemText : this.itemText,itemData : this.itemData};
													});
													// 设置楼栋下拉列表
												Allfloor = $("#floor-dropdownlist").dropDownList({
														inputName : 'floorName',
														inputValName : 'floorId',
														buttonText : "",
														width : "116px",
														readOnly : false,
														required : true,
														maxHeight : 200,
														items : floorItems
													});
												Allfloor.setData("所有楼层","", "");
												if(floorItems.length > 1){
													Allfloor.setData(floorItems[0].itemText,floorItems[0].itemData,'');
												}
											}
											},
											error : function(req, error, errObj) {
											}
									});
									}
								},
								items : buildingItems
							});
							AllBuilding.setData("所有楼栋","", "");
						
					}
					},
					error : function(req, error, errObj) {
					}
			});
  			
 			$('#btn-query').on('click', function() {
				initPage();
			});
 		});
	function  initPage(){
		var data = {
			"projectCode" : projectCode
		};
		$(data).attr({
			"code" : code
		});
		var buildingId=$("#buildingId").val();
		if(buildingId!=null&&buildingId!=""){
			$(data).attr({
				"buildingId" : buildingId
			});
		}
		var floorId=$("#floorId").val();
		if(floorId!=null&&floorId!=""){
			$(data).attr({
				"floorId" : floorId
			});
		}
		var deviceNumber=$("#deviceNumber").val();
		if(deviceNumber!=null&&deviceNumber!=""){
			$(data).attr({
				"deviceNumber" : deviceNumber
			});
		}
		
		$.ajax({
			type : "post",
			url : "${ctx}/device/manage/getDrainDevices?page=1&limit=" + limit
					+ "&sortName=id&sortType=desc",
			data : JSON.stringify(data),
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				$("#drianMonitoringDiv").find("div").remove();
				deviceData = data;
				if(deviceData.items.length>0){
					initDiv(deviceData);
				}else{
					var nodataDiv= '<div style="width:100%;height:600px;padding-top: 3rem;font-size:20px;line-height:600px;text-align:center;">'
						+"无数据"+'</div>';
						$("#drianMonitoringDiv").append(nodataDiv);
				}
			},
			error : function(req, error, errObj) {
			}
		});
	}
	
	function  initDiv(deviceData){
		var deviceParam = {
				"drainDeviceInfo" : deviceData.items
			};
		//给排水附上设备状态
		$.ajax({
			type : "post",
			url : "${ctx}/supply-drain/sdmRunningRecord/getDrainData",
			data : JSON.stringify(deviceParam),
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
			if (data.code == 0) {
				firstReturnData = data.data;
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
						null, true);
			}
			},
			error : function(req, error, errObj) {
			}
			});
		$(".pagination").pagination(deviceData.totalCount, {
			callback : pageselectCallback,
			prev_text : '上一页',
			next_text : '下一页',
			items_per_page : 30,
			num_display_entries : 5,
			num_edge_entries : 2
		});
	}
	
	
	function pageselectCallback(page_index, jq) {
		currentDisplayPage=page_index;
		initData(page_index);
	}
	function initData(page_id) {
		getData(page_id + 1);
	}
	function getData(load_index) {
		//第一遍查询不需要再进行查询一次
		if (load_index == 1) {
			initDivPage();
		} else {
			var data = {
					"projectCode" : projectCode
				};
				$(data).attr({
					"code" : code
				});
				var buildingId=$("#buildingId").val();
				if(buildingId!=null&&buildingId!=""){
					$(data).attr({
						"buildingId" : buildingId
					});
				}
				var floorId=$("#floorId").val();
				if(floorId!=null&&floorId!=""){
					$(data).attr({
						"floorId" : floorId
					});
				}
				var deviceNumber=$("#deviceNumber").val();
				if(deviceNumber!=null&&deviceNumber!=""){
					$(data).attr({
						"deviceNumber" : deviceNumber
					});
				}
				$.ajax({
					type : "post",
					url : "${ctx}/device/manage/getDrainDevices?page="+load_index+"&limit=" + limit
							+ "&sortName=id&sortType=desc",
					data : JSON.stringify(data),
					dataType : "json",
					async : false,
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						deviceData = data;
						initLoadIndexDiv(deviceData);
					},
					error : function(req, error, errObj) {
					}
				});
		}
	}
	function  initLoadIndexDiv(deviceData){
		var deviceParam = {
				"drainDeviceInfo" : deviceData.items
			};
		//给排水附上设备状态
		$.ajax({
			type : "post",
			url : "${ctx}/supply-drain/sdmRunningRecord/getDrainData",
			data : JSON.stringify(deviceParam),
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
			if (data.code == 0) {
				returnData = data.data;
				initDivPage();
			} else {
				showDialogModal("error-div", "提示信息", data.MESSAGE, 1,
						null, true);
			}
			},
			error : function(req, error, errObj) {
			}
			});
	}
	
 		
	function initDivPage() {
		var data;
		if(currentDisplayPage==0){
			data = firstReturnData;
		}else{
			data=returnData;
		}
		$("#drianMonitoringDiv").find("div").remove();
		if(data==null){
			return;
		}
		var dataLength = data.length;
		for (var i = 0; i < dataLength; i++) {
 			var deviceNo=data[i].deviceNumber;
 			var	deviceId=data[i].deviceId;
 			var drainDeviceParam=data[i].drainDeviceParam;
 			var alarmStatus=data[i].alarmStatus;
 			var pump =data[i].pump;
 			var isOpen="--";
 			var skinStatus="${ctx}/static/img/supply-drain/dnormal.svg";//默认正常
 			var deviceFault1;
 			var deviceFault2;
 			var deviceOpen1="${ctx}/static/img/supply-drain/dclose.svg";
 			var deviceOpen2="${ctx}/static/img/supply-drain/dclose.svg";
 			var isOpen1="--";
 			var isOpen2="--";
 			var labelStyle1 = "background:#A9A9A9;";
 			var labelStyle2 = "background:#A9A9A9;";
 			var deviceTotal;
 			var devieLine;
 			var drainDiv;
 			if(alarmStatus!=null && alarmStatus=="1"){
 				isOpen="正常";
 				skinStatus="${ctx}/static/img/supply-drain/dnormal.svg";
 			}else if(alarmStatus!=null && alarmStatus=="2"){
				isOpen="告警";
				skinStatus="${ctx}/static/img/supply-drain/dalarm.svg";
			}
 			if(drainDeviceParam=="2"){//双泵 
 				devieLine="${ctx}/static/img/supply-drain/double.png";
 				if(pump!=null && pump.length==1){
 	 				pumpId1=data[i].pump[0].sdmRunningRecordId;
 					if(data[i].pump[0].openStatus=="1"){
 	 					deviceOpen1="${ctx}/static/img/supply-drain/dopen.svg";
 	 					isOpen1="开启";
 	 					labelStyle1="background:#00BFA5;";
 	 				}else if(data[i].pump[0].openStatus=="2"){
 	 					deviceOpen1="${ctx}/static/img/supply-drain/dclose.svg";
 	 					isOpen1="关闭";
 	 					labelStyle1="background:#A9A9A9;";
 	 				}
 	 				if(data[i].pump[0].faultStatus=="2"){
 	 					deviceOpen1="${ctx}/static/img/supply-drain/fault.svg";
 	 				}
 				}else if(pump!=null && pump.length==2){
 					pumpId1=data[i].pump[0].sdmRunningRecordId;
 					pumpId2=data[i].pump[1].sdmRunningRecordId;
 					if(data[i].pump[0].openStatus=="1"){
 	 					deviceOpen1="${ctx}/static/img/supply-drain/dopen.svg";
 	 					isOpen1="开启";
 	 					labelStyle1="background:#00BFA5;";
 	 				}else if(data[i].pump[0].openStatus=="2"){
 	 					deviceOpen1="${ctx}/static/img/supply-drain/dclose.svg";
 	 					isOpen1="关闭";
 	 					labelStyle1="background:#A9A9A9;";
 	 				}
 					if(data[i].pump[1].openStatus=="1"){
 	 					deviceOpen2="${ctx}/static/img/supply-drain/dopen.svg";
 	 					isOpen2="开启";
 	 					labelStyle2 = "background:#00BFA5;";
 	 				}else if(data[i].pump[1].openStatus=="2"){
 	 					deviceOpen2="${ctx}/static/img/supply-drain/dclose.svg";
 	 					isOpen2="关闭";
 	 					labelStyle2 = "background:#A9A9A9;";
 	 				}
 	 				if(data[i].pump[0].faultStatus=="2"){
 	 					deviceOpen1="${ctx}/static/img/supply-drain/fault.svg";
 	 				}
 	 				if(data[i].pump[1].faultStatus=="2"){
 	 					deviceOpen2="${ctx}/static/img/supply-drain/fault.svg";
 	 				}
 					
 				}
 				drainDiv='<div id=div_'+deviceId+' style="width:480px;float:left;cursor: pointer;"' + '" onclick="drainDeviceDetailModal(\''+deviceId+'\')"><div style="width: 100%; height: 2.5rem; float: left;"><div style="font-size: 24px; line-height: 2.75rem;letter-spacing: 0;">'
		 			+deviceNo+'</div></div><div style="width: 120px; float: left;"><img id=skinStatus_'+deviceId+' style="width:120px;height:94px;margin-top: 25px;" src="'
		 			+skinStatus+'"/><span id=span_'+deviceId+' style="font-size: 16px; color: #4A4A4A; letter-spacing: 0; display: block; height: 2rem;width:120px;text-align: center;">'
		 			+isOpen+'</span></div>'
		 			+'<div style="width: 120px;float: left;">'
					+'<img style="width:120px;height:94px;margin-top: 25px;" src="'
					+devieLine+'"/></div>'
					+'<div style=" text-align: left;float: left; width: 13rem; padding-left: 1rem;">'
					+'<div  style="margin-top:0rem;"><img id=bump_1_'+deviceId+' style="width:40px;height:40px;margin-top: 0rem;" src="'
					+deviceOpen1+'"/>'
					+'<label id=label_1_'+deviceId+' style="'+labelStyle1+'margin-left:20px;border-radius: 8px;width:48px;height:20px;text-align:center;font-size: 16px;color: #FFFFFF;letter-spacing: 0;">'
					+isOpen1+'</label></div><div style="margin-top: 4.2rem;">'
					+'<img id=bump_2_'+deviceId+' style="width:40px;height:40px;" src="'
					+deviceOpen2+'"/>'
					+'<label  id=label_2_'+deviceId+' style="'+labelStyle2+'margin-left:20px;border-radius: 8px;width:48px;height:20px;text-align:center;font-size: 16px;color: #FFFFFF;letter-spacing: 0;">'
					+isOpen2+'</label></div></div></div>';
 			}else{
	 			devieLine="${ctx}/static/img/supply-drain/single.png";
 				if(pump!=null && pump.length==1){
	 				if(data[i].pump[0].openStatus=="1"){
	 					deviceOpen1="${ctx}/static/img/supply-drain/dopen.svg";
	 					isOpen1="开启";
	 					labelStyle1="background:#00BFA5;";
	 				}else if(data[i].pump[0].openStatus=="2"){
	 					deviceOpen1="${ctx}/static/img/supply-drain/dclose.svg";
	 					isOpen1="关闭";
	 					labelStyle1="background:#A9A9A9;";
	 				}//id=label_1_'+deviceId+'
	 				if(data[i].pump[0].faultStatus=="2"){
	 					deviceOpen1="${ctx}/static/img/supply-drain/fault.svg";
	 				}
 				}
 				drainDiv='<div style="width:480px;float:left;cursor: pointer;"' + '" onclick="drainDeviceDetailModal(\''+deviceId+'\')"><div style="width: 100%; height: 2.5rem; float: left;"><div style="font-size: 24px; line-height: 2.75rem;letter-spacing: 0;">'
 		 			+deviceNo+'</div></div><div style="width: 120px; float: left;"><img id=skinStatus_'+deviceId+' style="width:120px;height:94px;margin-top: 25px;" src="'
 		 			+skinStatus+'"/><span id=span_'+deviceId+' style="font-size: 16px; color: #4A4A4A; letter-spacing: 0; display: block; height: 2rem;width:120px;text-align: center;">'
 		 			+isOpen+'</span></div>'
 		 			+'<div style="width: 120px;float: left;">'
 					+'<img style="width:120px;height:1px;margin-top: 68px;" src="'
 					+devieLine+'"/></div>'
 					+'<div style=" text-align: left;float: left; width: 13rem; padding-left: 1rem;">'
 					+'<div style="margin-top:3.5rem;"><img id=bump_1_'+deviceId+' style="width:40px;height:40px;margin-top: 0rem;" src="'
 					+deviceOpen1+'"/>'
 					+'<label id=label_1_'+deviceId+' style="'+labelStyle1+'margin-left:20px;border-radius: 8px;width:48px;height:20px;text-align:center;font-size: 16px;color: #FFFFFF;letter-spacing: 0;">'
 					+isOpen1+'</label></div></div></div>';
 			}
 			//drainDiv.data(deviceId + '', data[i]);
			$("#drianMonitoringDiv").append(drainDiv);
	}
 }
	
	
		function drainDeviceDetailModal(id) {
			currentDrainDeviceId=id;//以后再考虑
			var detailData;
			if(currentDisplayPage==0){
				detailData = firstReturnData;
			}else{
				detailData=returnData;
			}
 			for (var i = 0; i < detailData.length; i++) {
 				if(detailData[i].deviceId==id){
 					drainDeviceDetail=detailData[i];
 					var deviceName ='<label style="font-size: 14px;color: #4A4A4A;" >'+drainDeviceDetail.deviceName + '</label>';
 				}
 			}
			createModalWithLoad("drainDeviceDetail-img", 600, 300, deviceName,
					"supplyDrain/drainDeviceDetail", "", "", "");
			openModal("#drainDeviceDetail-img-modal", true, false);
			isOpenDetail=id;
 		}
		
		
		function toSubscribe(){
			if (isConnectedGateWay) {
				//排水页面识别结果
				stompClient.subscribe('/topic/drainMonitoringStatus/'+ projectCode, function(result) {
					var json = JSON.parse(result.body);
					console.log(json);
					updateDrainPageInfo(json);
				});
			}
		}


		function unloadAndRelease() {
			if(stompClient != null) {
				stompClient.unsubscribe('/topic/drainMonitoringStatus/'+ projectCode);
			}
		}

		function updateDrainPageInfo(json){
			updateDeviceInfo(json);
		}
		
		//更换页面数据
		function updateDeviceInfo(data){
 			var result  = data;
 			var deviceId =result.deviceId;
			var detailData;
			var drainDeviceParam;
			if(currentDisplayPage==0){
				detailData = firstReturnData;
			}else{
				detailData=returnData;
			}
 			for (var i = 0; i < detailData.length; i++) {
 				if(detailData[i].deviceId==deviceId){
 					drainDeviceParam =detailData[i].drainDeviceParam;
 				}
 			}
 			if(drainDeviceParam==null){
 				return;
 			}
 			//拿到对应排水设备信息
 			var skinImg = document.getElementById("skinStatus_"+deviceId);
 			if(skinImg==null){
 				return;
 			}
 			if(result.alarmStatus=="1"){
				$("#span_"+deviceId).html("正常");
				skinImg.src="${ctx}/static/img/supply-drain/dnormal.svg";
 			}else if(result.alarmStatus=="2"){
				$("#span_"+deviceId).html("告警");
				skinImg.src="${ctx}/static/img/supply-drain/dalarm.svg";
 			}
			//取出集合的第一条数据（默认只会有一条运行数据）
			var bumpImg1 = document.getElementById("bump_1_"+deviceId);
			//单泵，直接跟新
 	 		if(result.bumpStatuss[0].openStatus=="1"){
 	 			bumpImg1.src="${ctx}/static/img/supply-drain/dopen.svg";
 				$("#label_1_"+deviceId).css("background","#00BFA5");
 				$("#label_1_"+deviceId).html("开启");
 			}else if(result.bumpStatuss[0].openStatus=="2"){
 				bumpImg1.src="${ctx}/static/img/supply-drain/dclose.svg";
 				$("#label_1_"+deviceId).css("background","#A9A9A9");
 				$("#label_1_"+deviceId).html("关闭");
 			}
			if(result.bumpStatuss[0].faultStatus=="2"){
				bumpImg1.src="${ctx}/static/img/supply-drain/fault.svg";
			}
			
			//双泵机 
			if(drainDeviceParam=="2"&& result.bumpStatuss.length>=2){
	 			var bumpImg2 = document.getElementById("bump_2_"+deviceId);
	 			//两个泵机数据全部跟新
 	 	 		if(result.bumpStatuss[1].openStatus=="1"){
 	 	 			bumpImg2.src="${ctx}/static/img/supply-drain/dopen.svg";
 	 				$("#label_2_"+deviceId).css("background","#00BFA5");
 	 				$("#label_2_"+deviceId).html("开启");
 	 			}else if(result.bumpStatuss[1].openStatus=="2"){
 	 				bumpImg2.src="${ctx}/static/img/supply-drain/dclose.svg";
 	 				$("#label_2_"+deviceId).css("background","#A9A9A9");
 	 				$("#label_2_"+deviceId).html("关闭");
 	 			}
 				if(result.bumpStatuss[1].faultStatus=="2"){
 					bumpImg2.src="${ctx}/static/img/supply-drain/fault.svg";
 				}
	 				
	 			}
			//跟新页面集合数据 
				if(currentDisplayPage==0){
 					var dataLength = firstReturnData.length;
 					for (var i = 0; i < dataLength; i++) {
 						//判断推送到页面的数据的设备当前页面是否存在
 						if(deviceId==firstReturnData[i].deviceId){
 							firstReturnData[i].alarmStatus=result.alarmStatus;
 							firstReturnData[i].pump=result.bumpStatuss;
 							if(deviceId==isOpenDetail){
 								drainDeviceDetail=firstReturnData[i];
 								initHtmlPage();
		 	 			}
 						}
 					}
 				}else{
 					var dataLength = returnData.length;
 					for (var i = 0; i < dataLength; i++) {
 						//判断推送到页面的数据的设备当前页面是否存在
 						if(deviceId==returnData[i].deviceId){
 							returnData[i].alarmStatus=result.alarmStatus;
 							returnData[i].pump=result.bumpStatuss;
 							if(deviceId==isOpenDetail){
 								drainDeviceDetail=returnData[i];
 								initHtmlPage();
		 	 			}
 							
 						}
 					}
 				}
			
 			}
 			
 	</script> 
</body>
</html>