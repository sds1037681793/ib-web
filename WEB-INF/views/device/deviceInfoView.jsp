<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">
.h4, h4 {
    font-size: 14px;
    font-weight:bold;
}
</style>
<div>
 <form id="alarm-form">
 <div style="margin-left: 2px;">
	<table id ="alarm_id">
	    <tr>
			<td align="right" style="width=90;height: 25px;font-size: 14px;">一级分类： </td>
			<td><span id="systemCodes"> </span>
			</td>
		</tr>
		
		<tr>
			<td align="right" style="width=90;height: 30px;font-size: 14px;">二级分类：</td>
			<td><span style="font-size: 14px;" id="subSystemCodes"> </span>
			</td>
		</tr>
		
		<tr>
			<td align="right" style="width=90;height: 30px;font-size: 14px;">设备类型： </td>
			<td><span style="font-size: 14px;" id=deviceTypeNames> </span>
			</td>
		</tr>
		
		<tr>
			<td align="right" style="width=90;height: 30px;font-size: 14px;">设备编号： </td>
			<td><span style="font-size: 14px;" id="deviceNum"> </span>
			</td>
		</tr>
		
		<tr>
			<td align="right" style="width=90;height: 30px;font-size: 14px;">设备名称： </td>
			<td><span style="font-size: 14px;" id="deviceNames"></span>
			</td>
		</tr>
		
		<tr>
			<td align="right" style="width=90;height: 30px;font-size: 14px;">位置： </td>
			<td><span style="font-size: 14px;" id="locationNames"></span>
			</td>
		</tr>
		
	</table>
</div>
</form>

</div>

<script type="text/javascript">
var levelTypes;
//一级分类
var levelTypeLists = new Array();
var levelTypeMapss = new HashMap();
var levelTypeObjs;

// 二级分类
var levelTwoTypeLists = new Array();
var levelTwoTypeMapss = new HashMap();
var levelTwoTypeObjs;

// 设备类型
var levelThreeTypeLists = new Array();
var levelThreeTypeMapss = new HashMap();
var levelThreeTypeObjs;
$(document).ready(function(){
	if('' != "${param.rowIndex}"){
		var row = tbAlarmEven.row("${param.rowIndex}");
		$("#systemCodes").text(row.systemCode);
		$("#subSystemCodes").text(row.subSystemCode);
		$("#deviceTypeNames").text(row.deviceTypeName);
		$("#deviceNum").text(row.deviceNumber);
		$("#deviceNames").text(row.deviceName);
		if(row.locationName == "" || row.locationName == undefined){
			$("#locationNames").text("无");
		}else{
			$("#locationNames").text(row.locationName);
		}
		var deviceCode = row.deviceSysCode;
		var deviceTypeId = row.deviceTypeId;
		// 请求后台查询数据
		handleShow(deviceCode,row.id,deviceTypeId);
	} 
});

function handleShow(deviceCode,deviceId,deviceTypeId){
	$.ajax({
		type: "post",
		url: "${ctx}/device/deviceInfo/getDeviceParam?deviceCode="+deviceCode+"&deviceId="+deviceId+"&deviceTypeId="+deviceTypeId,
		dataType : "json",
		contentType : "application/json;charset=utf-8",
		success: function(data) {
			if (data != null) {
				for (var i = 0; i < data.length; i++) { //循环LIST
					var list = data[i];//获取LIST里面的对象
					var name = list.name;
					var value = list.value;
					// 动态生成表单
					var trContent = "<tr ><td align='right' style='width=90;height: 30px;font-size: 14px;'>"
						+ name
						+ "：</td><td><span style='font-size: 14px;'>"
						+ value
						+"</span></td></tr>"
				$("#alarm_id").append(trContent);
				}
			}
		},
		error: function(req, error, errObj) {
		}
	});
}
</script>