<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/static/css/btnicon.css" rel="stylesheet" type="text/css" />
<title>缓存管理</title>
</head>
<body>
<div>
<table>
<tr>
    <td align="right" width="80">子系统：</td>
	<td>
	    <div id="all-subsystem"></div>
	</td>
	<td align="right" width="20"></td>
	<td align="right" style="width: 10rem;">缓存类型:</td>
	<td  align="right" width="150">
	<div id="cacheType-dropdownlist"></div>
	</td>
	<td align="right" width="150" style="display: none;">查询值:</td>
	<td width="12"></td>
	<td><input id="value" type="text" style="width:150px;display: none;" class="form-control required" /></td>
	<td align="right" colspan = "2">
     <td>
     <button id="query" type="button" class="btn btn-default btn-common btn-common-green btnicons"
       style="margin-left: 5rem;">
      <p class="btniconimg"><span>查询</span></p>
     </button>
     </td>
      <td>
      <button id="reload" type="button" class="btn btn-default btn-common btn-common-green btnicons" 
       style="margin-left: 2rem;">
       <p class="btniconimgheavyload"><span>重载</span>
      </button>
      </td>
</tr>
</table>
</div>
<div style="width:100%;">
	<textarea id="result" style="margin-top: 20px; resize:none; width: 100%;"></textarea>
</div>
<div id="error-div"></div>
<script type="text/javascript">
    var cacheData;
    var subsystemList = new Array();
    subsystemList[subsystemList.length] = {itemText: "门禁系统", itemData: "1"};
    subsystemList[subsystemList.length] = {itemText: "告警系统 ", itemData: "2"};
    subsystemList[subsystemList.length] = {itemText: "设备系统 ", itemData: "3"};
    subsystemList[subsystemList.length] = {itemText: "电梯系统", itemData: "4"};
    subsystemList[subsystemList.length] = {itemText: "消防系统", itemData: "5"};
    subsystemList[subsystemList.length] = {itemText: "暖通系统", itemData: "6"};
    subsystemList[subsystemList.length] = {itemText: "照明系统 ", itemData: "7"};
    subsystemList[subsystemList.length] = {itemText: "停车系统", itemData: "8"};
    subsystemList[subsystemList.length] = {itemText: "供配电系统", itemData: "9"};
    subsystemList[subsystemList.length] = {itemText: "给排水系统", itemData: "10"};
    subsystemList[subsystemList.length] = {itemText: "system系统 ", itemData: "11"};
    subsystemList[subsystemList.length] = {itemText: "视频监控系统", itemData: "12"};
	var accessControlList = new Array();
	var alarmCenterList = new Array();
	var deviceList = new Array();
	var elevatorList = new Array();
	var fireFightingList = new Array();
	var hvacList = new Array();
	var lightingList = new Array();
	var parkingList = new Array();
	var powerSupplyList = new Array();
	var supplyDrainList = new Array();
	var systemList = new Array();
	var videoMonitoringList = new Array();
	accessControlList[accessControlList.length] = {itemText: "动态SQL", itemData: "1"};
	alarmCenterList[alarmCenterList.length] = {itemText: "动态SQL", itemData: "1"};
	deviceList[deviceList.length] = {itemText: "动态SQL", itemData: "1"};
	elevatorList[elevatorList.length] = {itemText: "动态SQL", itemData: "1"};
	elevatorList[elevatorList.length] = {itemText: "电梯告警事件编码", itemData: "2"};
	elevatorList[elevatorList.length] = {itemText: "电梯状态编码", itemData: "3"};
	elevatorList[elevatorList.length] = {itemText: "电梯困人告警信息", itemData: "4"};
	fireFightingList[fireFightingList.length] = {itemText: "动态SQL", itemData: "1"};
	fireFightingList[fireFightingList.length] = {itemText: "报警设备列表", itemData: "2"};
	fireFightingList[fireFightingList.length] = {itemText: "内外部项目编码互换", itemData: "3"};
	hvacList[hvacList.length] = {itemText: "动态SQL", itemData: "1"};
	lightingList[lightingList.length] = {itemText: "动态SQL", itemData: "1"};
	parkingList[parkingList.length] = {itemText: "动态SQL", itemData: "1"};
	powerSupplyList[powerSupplyList.length] = {itemText: "动态SQL", itemData: "1"};
	supplyDrainList[supplyDrainList.length] = {itemText: "动态SQL", itemData: "1"};
	supplyDrainList[supplyDrainList.length] = {itemText: "设备状态", itemData: "2"};
	systemList[systemList.length] = {itemText: "动态SQL", itemData: "1"};
	videoMonitoringList[videoMonitoringList.length] = {itemText: "动态SQL", itemData: "1"};
	var ddlValueType;
	$(document).ready(function() {
		 var displayHeight = window.screen.height;
		$("#result").css("height",(displayHeight-340)); 
		ddlSystemType = $("#all-subsystem").dropDownList({
	        inputName: "subsystemName",
	        inputValName: "subsystemType",
	        buttonText: "",
	        width: "135px",
	        readOnly: false,
	        required: true,
	        maxHeight: 510,
	        onSelect: function(i, data, icon) {
	        	cacheData = data;
	        	selectType(data);
	        },
	        items: subsystemList
	    });
		
		ddlCacheType = $("#cacheType-dropdownlist").dropDownList({
	        inputName: "cacheTypeName",
	        inputValName: "cacheType",
	        buttonText: "",
	        width: "135px",
	        readOnly: true,
	        required: true,
	        maxHeight: 510,
	        onSelect: function(i, data, icon) {},
	        items: accessControlList
	    }); 
		
		$('#query').on('click',function(){
			$('#result').val('');
			var cacheType = $('#cacheType').val();
			var subsystemType = $('#subsystemType').val();
			if(subsystemType == 0){
				showDialogModal("error-div", "操作错误", "请先选择系统类型", 1, null, true);
				return;
			}
			if(cacheType == 0){
				showDialogModal("error-div", "操作错误", "请先选择缓存类型", 1, null, true);
				return;
			}
			var subsystemType = $('#subsystemType').val();
			var value = $('#value').val();
			$.ajax({
				 type:"post",
		         url:"${ctx}/cacheManage/query?subsystemType="+subsystemType+"&busiType="+cacheType,
		         dataType:"json",
		         success: function(data){
		             if (data && data.CODE && data.CODE == "FAILED"){
		            	 showDialogModal("error-div", "操作失败", data.MESSAGE, 1, null, true);
		             }else{
		            	 $('#result').val(data);
		             }
		         },
		         error: function(req,error,errorObj){
		             showDialogModal("error-div", "操作错误", errorObj, 1, null, true);
		             return;
		         }
			});
		});
		
		
		
		$('#reload').on('click',function(){
			var subsystemType = $('#subsystemType').val();
			var cacheType = $('#cacheType').val();
			if(subsystemType == 0){
				showDialogModal("error-div", "操作错误", "请先选择系统类型", 1, null, true);
				return;
			}
			if(cacheType == 0){
				showDialogModal("error-div", "操作错误", "请先选择缓存类型", 1, null, true);
				return;
			}
			$.ajax({
				type:"post",
		         url:"${ctx}/cacheManage/reload?subsystemType="+subsystemType+"&busiType="+cacheType,
		         dataType:"json",
		         success: function(data){
		             if (data && data.CODE && data.CODE == "SUCCESS") 
		             {
		            	 showDialogModal("error-div", "操作成功", "缓存已重载", 1, null, true);
		             }
		             else
		             {
		                 showDialogModal("error-div", "操作失败", data.MESSAGE, 1, null, true);
		             }
		             return;
		         },
		         error: function(req,error,errorObj){
		             showDialogModal("error-div", "操作错误", errorObj, 1, null, true);
		             return;
		         }
			});
		});
	});
	
	
	
	function selectType(data){
			var checkSystem =  new Array();
			if(data == 1){
				checkSystem.push(accessControlList[0]);
			}else if(data == 2){
				checkSystem.push(alarmCenterList[0]);
			}else if(data == 3){
				checkSystem.push(deviceList[0]);
			}else if(data == 4){
				checkSystem.push(elevatorList[0]);
				checkSystem.push(elevatorList[1]);
				checkSystem.push(elevatorList[2]);
				checkSystem.push(elevatorList[3]);
			}else if(data == 5){
				checkSystem.push(fireFightingList[0]);
				checkSystem.push(fireFightingList[1]);
				checkSystem.push(fireFightingList[2]);
			}else if(data == 6){
				checkSystem.push(hvacList[0]);
			}else if(data == 7){
				checkSystem.push(lightingList[0]);
			}else if(data == 8){
				checkSystem.push(parkingList[0]);
			}else if(data == 9){
				checkSystem.push(powerSupplyList[0]);
			}else if(data == 10){
				checkSystem.push(supplyDrainList[0]);
				checkSystem.push(supplyDrainList[1]);
			}else if(data == 11){
				checkSystem.push(systemList[0]);
			}else if(data == 12){
				checkSystem.push(videoMonitoringList[0]);
			}
			
			ddlCacheType = $("#cacheType-dropdownlist").dropDownList({
		        inputName: "cacheTypeName",
		        inputValName: "cacheType",
		        buttonText: "",
		        width: "135px",
		        readOnly: false,
		        required: true,
		        maxHeight: 510,
		        onSelect: function(i, data, icon) {},
		        items: checkSystem
		    }); 
		
		
	}
</script>
</body>
</html>