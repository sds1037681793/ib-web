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
<title>消防系统图</title>
<style type="text/css">
.ffm_bg { 
/* 	background: url('${ctx}/static/img/ffm/ffm_system_bg.png'); */
 	width: 1644px; 
 	height: 900px; 
 } 
</style>
</head>
<body>
	<div class="ffm_bg"></div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		getDeviceCountInfo();
		getPicture();
	})

	function getDeviceCountInfo() {
		$.ajax({
			type : "post",
			url : "${ctx}/device/manage/getDeviceCountBySystemCodeAndProjectCode?projectCode=" + projectCode + "&systemCode=FIRE_FIGHTING",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data && data.code == 0 && data.data) {
					$.each(data.data, function(i, v) {
						var deviceTypeCode = v.catagory;
						$("#"+deviceTypeCode).html(v.count);
					})
				}
			},
			error : function(req, error, errObj) {
			}
		})
	}
	function getPicture() {
		$.ajax({
			type : "post",
			url : "${ctx}/device/manage/getFfmPicture?projectId=" + projectId+ "&fileName=FFMSYSTEMPICTURE",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if(data && data.code == 0 && data.data){
					$(".ffm_bg").css("background-image",'url('+data.data.filePath+')');
				}else{
					$("#content-page").load("/ib-web/projectPage/noDataPage");
				}
			},
			error : function(req, error, errObj) {
			}
		})
	}
	function dd(){
		switch(deviceTypeCode){
			case 'TEMPERATURE_SENSING_DETECTOR' :        break;//感温
			case "SMOKE_DETECTOR":break;//感烟
			case "MANUAL_BUTTON":break;//手动报警按钮
			case "FIRE_HYDRANT_BUTTON":break;//消火栓按钮
			case "DEGREE_FIREPROOF_VALVE_280":break;//280°防火阀
			case "DEGREE_FIREPROOF_VALVE_70" :break;//70°防火阀
			case "FILL_THE_FAN":break;//补风机
			case "POWER_SUPPLY":break;//电源
			case "SHUTTER_DOORS":break;//卷帘门
			case "ACCESS_CONTROL":break;//门禁
			case "SMOKE_EXHAUST_VALVE":break;//排烟阀
			case "SMOKE_EXHAUST_FAN":break;//排烟风机
			case "HYDRANT_PUMP":break;//消防泵
			case "SOUND_AND_LIGHT_ALARM":break;//声光报警
			case "FLOW_INDICATOR":break;//水流指示器
			case "AIR_SUPPLY_VALVE":break;//送风阀
			case "FIRE_BROADCAST":break;//消防广播
			case "SIGNAL_BUTTERFLY_VALVE":break;//信号蝶阀
			case "PRESSURE_SWITCH":break;//压力开关
			case "POSITIVE_PRESSURE_BLOWER":break;//正压风机
			case "FIRE_DISPLAY_PANEL":break;//楼层显示器
			case "GAS_FIRE_EXTINGUISHING":break;//气体灭火
			case "COMBUSTIBLE_GAS_DETECTOR":break;//可燃气探测器
			case "ELEVATOR_LANDING_DEVICE":break;//电梯
			case "SMOKE_CONTROL":break;//防排烟
		}
	}
</script>
</html>
