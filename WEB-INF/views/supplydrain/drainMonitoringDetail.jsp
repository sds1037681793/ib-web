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
	<link href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
	<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js" type="text/javascript" ></script>
	<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
	<style type="text/css">
</style>
</head>
<body>
	<div class="">
		<div>
			<table style="width:100%;">
				<tr>
					<td>
					<div style="position:relative; width:580px;height:200px;cursor: pointer;float:left;">
					<div style="position:relative; width:179.8px;height:179.8px;float:left;margin-left: 10px;margin-top: 10px;margin-bottom: 10.2px;">
					<img id="sinkImg" style="width:179.8px;height:179.8px;cursor: pointer;" src="${ctx}/static/img/m2.png"/>
					</div>
					<div style="position:absolute;float:left;margin-left: 221px;margin-top: 10px;background-color: #FFF;color: #000;height:179.8px;">
					<table style="margin-top: 20px;margin-left: 40px;">
					<td align="right" style="height:20px;font-size: 14px;">设备编号：</td>
					<td id="deviceNo" align="left" style="height:20px;font-size: 14px;padding-left:20px;">正常</td>
					</tr>
					<tr>
					<td align="right" style="height:20px;font-size: 14px;">位置：</td>
					<td id="location" align="left" style="height:20px;font-size: 14px;padding-left:20px;">排水楼栋</td>
					</tr>
					<tr id ="bump1OpenTr">
					<td id ="bump1IsOpen" align="right" style="height:20px;font-size: 14px;">一号泵机是否开启：</td>
					<td id="bump1Open" align="left" style="height:20px;font-size: 14px;padding-left:20px;padding-left:20px;">开启</td>
					</tr>
					<tr id ="bump2OpenTr">
					<td align="right" style="height:20px;font-size: 14px;">二号泵机是否开启：</td>
					<td id="bump2Open" align="left" style="height:20px;font-size: 14px;padding-left:20px;">开启</td>
					</tr>
					<tr id ="bump1faultTr">
					<td id ="bump1Isfault" align="right" style="height:20px;font-size: 14px;">一号泵机是否故障：</td>
					<td id="bump1fault" align="left" style="height:20px;font-size: 14px;padding-left:20px;">正常</td>
					</tr>
					<tr id ="bump2faultTr">
					<td align="right" style="height:20px;font-size: 14px;">二号泵机是否故障：</td>
					<td id="bump2fault" align="left" style="height:20px;font-size: 14px;padding-left:20px;">正常</td>
					</tr>
					<tr>
					<td align="right" style="height:20px;font-size: 14px;">高水位报警：</td>
					<td id="highWaterlarm" align="left" style="height:20px;font-size: 14px;padding-left:20px;">正常</td>
					</tr>
 					</table></div>
					</div>
					</td>
				</tr>	
			</table>
		</div>
	</div>

 	<script type="text/javascript"> 
 	var bumpTotal;
 	var image1;
 	$(document).ready(function(){
 		initHtmlPage();
 	});
 	$(".close").click(function(){
			isOpenDetail=0;
	});
 	function initHtmlPage(){
 		$("#deviceNo").html(drainDeviceDetail.deviceNumber);
 		$("#location").html("--");
 		if(drainDeviceDetail.floorName){
 			if(drainDeviceDetail.buildingName){
 				$("#location").html(drainDeviceDetail.buildingName+'<span style="visibility:hidden;">==</span>'+drainDeviceDetail.floorName);
 			}else{
 			$("#location").html(drainDeviceDetail.floorName);
 			}
 		}
		image1 = document.getElementById("sinkImg");
		image1.src="${ctx}/static/img/supply-drain/dnormal.svg";
		$("#highWaterlarm").html("--");
		$("#bump1Open").html("--");	
		$("#bump2Open").html("--");
		$("#bump1fault").html("--");
		$("#bump2fault").html("--");
		if(drainDeviceDetail.drainDeviceParam=="2"){//双泵
			if(drainDeviceDetail.alarmStatus!=null && drainDeviceDetail.alarmStatus=="1"){
				$("#highWaterlarm").html("正常");
				image1.src="${ctx}/static/img/supply-drain/dnormal.svg";
			}else if(drainDeviceDetail.alarmStatus!=null && drainDeviceDetail.alarmStatus=="2"){
				$("#highWaterlarm").html("告警");
				image1.src="${ctx}/static/img/supply-drain/dalarm.svg";
			}
			if(drainDeviceDetail.pump!=null && drainDeviceDetail.pump.length==1){
				if(drainDeviceDetail.pump[0].openStatus=="1"){
					$("#bump1Open").html("开启");	
				}else if(drainDeviceDetail.pump[0].openStatus=="2"){
					$("#bump1Open").html("关闭");
				}
				if(drainDeviceDetail.pump[0].faultStatus=="2"){
					$("#bump1fault").html("故障");
				}else if(drainDeviceDetail.pump[0].faultStatus=="1"){
					$("#bump1fault").html("正常");
				}
			}else if(drainDeviceDetail.pump!=null && drainDeviceDetail.pump.length==2){
				if(drainDeviceDetail.pump[0].openStatus=="1"){
					$("#bump1Open").html("开启");	
				}else{
					$("#bump1Open").html("关闭");
				}
				if(drainDeviceDetail.pump[1].openStatus=="1"){
					$("#bump2Open").html("开启");	
				}else{
					$("#bump2Open").html("关闭");
				}
				if(drainDeviceDetail.pump[0].faultStatus=="2"){
					$("#bump1fault").html("故障");
				}else if(drainDeviceDetail.pump[0].faultStatus=="1"){
					$("#bump1fault").html("正常");
				}
				if(drainDeviceDetail.pump[1].faultStatus=="2"){
					$("#bump2fault").html("故障");
				}else if(drainDeviceDetail.pump[1].faultStatus=="1"){
					$("#bump2fault").html("正常");
				}
			}
				
		}else if(drainDeviceDetail.drainDeviceParam=="1"){
			$("#bump1IsOpen").html("是否开启：");
			$("#bump1Isfault").html("是否故障：");
			if(drainDeviceDetail.alarmStatus!=null && drainDeviceDetail.alarmStatus=="1"){
				$("#highWaterlarm").html("正常");
				image1.src="${ctx}/static/img/supply-drain/dnormal.svg";
			}else if(drainDeviceDetail.alarmStatus!=null && drainDeviceDetail.alarmStatus=="2"){
				$("#highWaterlarm").html("告警");
				image1.src="${ctx}/static/img/supply-drain/dalarm.svg";
			}
			if(drainDeviceDetail.pump!=null && drainDeviceDetail.pump.length==1){
				if(drainDeviceDetail.pump[0].openStatus=="1"){
					$("#bump1Open").html("开启");	
				}else if(drainDeviceDetail.pump[0].openStatus=="2"){
					$("#bump1Open").html("关闭");
				}
				if(drainDeviceDetail.pump[0].faultStatus=="2"){
					$("#bump1fault").html("故障");
				}else if(drainDeviceDetail.pump[0].faultStatus=="1"){
					$("#bump1fault").html("正常");
				}
			}
			$("#bump2OpenTr").remove();
			$("#bump2faultTr").remove();
		}
			
 	}
		
 	</script> 
</body>
</html>