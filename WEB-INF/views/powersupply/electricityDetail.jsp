<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

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
	<div class="" style="font-size: 14px;">
		<div>
			<table >
				<tr>
					<td>
					<div style="position:relative; width:780px;cursor: pointer;float:left;">
					<div style="position:relative; width:200px;float:left;margin-left: 10px;margin-top: 100px;margin-bottom: 150px;">
					<img style="width:200px;height:200px;cursor: pointer;" src="${ctx}/static/images/powerSupply/meter.png"/>
					</div>
					<div style="position:relative;float:left;margin-top: 12px;background-color: #FFF;color: #000;">
					<table style="width:540px;color: #666666;margin-left: 30px;">
					<tr>
					<td colspan="3" id="deviceNo" style="width:139.5px;height: 40px;"><div style="display:inline-block; display:inline; zoom:1;float:left;">设备编号： </div><div id="deviceNumber" style="width:400px;float:left;word-break:break-all;">
					</div></td>
					</tr>
					<tr>
					<td colspan="3" id="deviceLocation" style="width:139.5px;height: 40px;"><div style="display:inline-block; display:inline; zoom:1;float:left;">设备位置： </div><div id="locationInfo" style="width:400px;float:left;word-break:break-all;">
					</div></td>
					</tr>
					<tr>
					<td colspan="3" id="level" style="width:139.5px;height: 40px;">电表级别：</td>
					</tr>
					<tr>
					<td colspan="3" id="meterStructure" style="width:139.5px;height: 40px;"><div style="display:inline-block; display:inline; zoom:1;float:left;">电表结构： </div><div id="parentMeter" style="width:400px;float:left;word-break:break-all;">
					</div></td>
					</tr>
					<tr>
					<td id="reactivePower" style="width:139.5px;height: 40px;">无功功率： </td>
					</tr>
					<tr>
					<td id="powerFactor" style="width:139.5px;height: 40px;">功率因数：</td>
					</tr>
					<tr>
					<td id="alarm" style="width:139.5px;height: 40px;">告警：</td>
					</tr>
					<tr>
					<td  colspan="3" id="activeElectricity" style="width:139.5px;height: 40px;">有功电量：</td>
					</tr>
					<tr>
					<td  colspan="3" id="positiveReactivePower" style="width:139.5px;height: 40px;">无功电量：</td>
					</tr>
					<tr>
					<td id="Uab" style="width:139.5px;height: 40px;">Uab：</td>
					<td id="Ubc" style="width:139.5px;height: 40px;">Ubc：</td>
					<td id="Uca" style="width:139.5px;height: 40px;">Uca：</td>
					</tr>
					<tr>
					<td id="Ua" style="width:139.5px;height: 40px;">Ua：</td>
					<td id="Ub" style="width:139.5px;height: 40px;">Ub：</td>
					<td id="Uc" style="width:139.5px;height: 40px;">Uc：</td>
					</tr>
					<tr>
					<td id="Ia" style="width:139.5px;height: 40px;">Ia：</td>
					<td id="Ib" style="width:139.5px;height: 40px;">Ib：</td>
					<td id="Ic" style="width:139.5px;height: 40px;">Ic：</td>
					</tr>
 					</table></div>
					</div>
					</td>
				</tr>	
			</table>
		</div>
	</div>

 	<script type="text/javascript"> 
	 	var  isAlarm;
	 	$(document).ready(function(){

	 		initPage();
	 	});//overflow:scroll;overflow:-moz-scrollbars-vertical;
	 		$(".close").click(function(){
	 			isOpenDetail=0;
	 			});
	 	function initPage(){
	 		if(electricityDetail.deviceNo){
	 			$("#deviceNumber").html("&nbsp;"+electricityDetail.deviceNo);
	 		}
	 		//这里是跳转页面之前查询出来的该电表位置和机构信息
	 		//===================================电表位置信息和结构信息===========================
			if(meterLocationAndStructure.meterBoxName){
			var meterBoxName =meterLocationAndStructure.meterBoxName;
			if(meterLocationAndStructure.meterRoomName){
				var meterRoomName =meterLocationAndStructure.meterRoomName;
				var str = meterRoomName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+meterBoxName;
				$("#locationInfo").html("&nbsp;"+str);
				}else{
					$("#locationInfo").html("&nbsp;"+meterBoxName);
				}
			}else{
				$("#locationInfo").html("&nbsp;--");
			}
	 		if(meterLocationAndStructure.parentMeterName){
				$("#parentMeter").html("&nbsp;"+meterLocationAndStructure.parentMeterName);
	 		}else {
	 			if(electricityDetail.level=="1"){
	 	 			$("#parentMeter").html("");
	 	 		}else{
	 	 			$("#parentMeter").html("&nbsp;--");
	 	 		}
	 		}
	 		//===================================电表位置信息和结构信息===========================
 		if(electricityDetail.level=="1"){
 			$("#level").html("电表级别： 一级电表");
 		}else if(electricityDetail.level=="2"){
 			$("#level").html("电表级别： 二级电表");
 		}else if(electricityDetail.level=="3"){
 			$("#level").html("电表级别： 三级电表");
 		}else if(electricityDetail.level=="4"){
 			$("#level").html("电表级别： 四级电表");
 		}
 		
 		if(electricityDetail.ua){
 			$("#Ua").html("Ua：&nbsp;"+electricityDetail.ua);
 		}else{
 			$("#Ua").html("Ua：&nbsp; --");
 		}
 		if(electricityDetail.ub){
 			$("#Ub").html("Ub：&nbsp;"+electricityDetail.ub);
 		}else{
 			$("#Ub").html("Ub： --");
 		}
 		if(electricityDetail.uc){
 			$("#Uc").html("Uc： &nbsp;"+electricityDetail.uc);
 		}else{
 			$("#Uc").html("Uc： --");
 		}
 		if(electricityDetail.uab){
 			$("#Uab").html("Uab：&nbsp;"+electricityDetail.uab);
 		}else{
 			$("#Uab").html("Uab：--");
 		}
 		if(electricityDetail.ubc){
 			$("#Ubc").html("Ubc： &nbsp;"+electricityDetail.ubc);
 		}else{
 			$("#Ubc").html("Ubc：--");
 		}
 		if(electricityDetail.uca){
 			$("#Uca").html("Uca： &nbsp;"+electricityDetail.uca);
 		}else{
 			$("#Uca").html("Uca：  --");
 		}
 		if(electricityDetail.ia){
 			$("#Ia").html("Ia： &nbsp;"+electricityDetail.ia);
 		}else{
 			$("#Ia").html("Ia：--");//'<span style="visibility:hidden;">11</span>'+
 		}
 		if(electricityDetail.ib){
 			$("#Ib").html("Ib： &nbsp;"+electricityDetail.ib);
 		}else{
 			$("#Ib").html("Ib： --");
 		}
 		if(electricityDetail.ic){
 			$("#Ic").html("Ic： &nbsp;"+electricityDetail.ic);
 		}else{
 			$("#Ic").html("Ic： --");
 		}
 		if(electricityDetail.activeElectricity){
 			$("#activeElectricity").html("有功电量： "+electricityDetail.activeElectricity+"kWh");
 		}else{
 			$("#activeElectricity").html("有功电量： --");
 		}
 		if(electricityDetail.positiveReactivePower){
 			$("#positiveReactivePower").html("无功电量： "+electricityDetail.positiveReactivePower+"kWh");
 		}else{
 			$("#positiveReactivePower").html("无功电量： --");
 		}
 		if(electricityDetail.reactivePower){
 			$("#reactivePower").html("无功功率： "+electricityDetail.reactivePower);
 		}else{
 			$("#reactivePower").html("无功功率： --");
 		}
 		if(electricityDetail.powerFactor){
 			$("#powerFactor").html("功率因数： "+electricityDetail.powerFactor);
 		}else{
 			$("#powerFactor").html("功率因数： --");
 		}
 		if(typeof (electricityDetail.alarmStatus) == "undefined" || electricityDetail.alarmStatus==null){
 			$("#alarm").html("告"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"警： --");
 		}else if(electricityDetail.alarmStatus=="1"){
 			isAlarm='<label style="color: #F37B7B;margin-top: 0px;" >异常 </label>';
 			$("#alarm").html("告"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"警：  "+isAlarm);
 		}else if(electricityDetail.alarmStatus=="2"){
 			isAlarm='<label style="color: #00BFA5;margin-top: 0px;" >正常 </label>';
 			$("#alarm").html("告"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"警： "+isAlarm);
 		}
 		
 	}
 	</script> 
</body>
</html>