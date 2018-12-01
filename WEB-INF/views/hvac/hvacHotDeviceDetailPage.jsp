<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<style>


</style>
<body>
<div Style="width: 100%;height:100%;">
	<div id = "hotBackImg" Style ="width: 28%;height:200px;float: left;background-color: red;margin-left:1%">
	</div>
	<div Style ="width: 70%;height:200px;float: left; margin-top:10px;">
		<table id="tb_deviceStatus" class="tb_deviceStatus" style="margin-left:41px">
<!-- 		<tr Style = "height:27px;line-height: 27px;"><td id ="deviceName_id" align="left" style="font-size: 12px;"colspan="4">冷源设备#</td></tr> -->
			<tr>
				<td align="right" style="width:80px;height:24px;font-size: 14px;padding: ">设备编号：</td>
				<td id = "code_id" style="width:120px;height:17px;font-size: 14px;"></td>
			</tr>
			<tr>
				<td align="right" style="width:80px;height:24px;font-size: 14px;">运行状态：</td>
				<td id = "workStatus_id" style="width:120px;height:17px;font-size: 14px;">关闭</td>
			</tr>
			<tr Style = "height:27px;line-height: 27px;">
				<td align="right"style="width:80px;height:24px;font-size: 14px;">压力：</td>
				<td  id = "pressure_id"style="width:120px;height:17px;font-size: 14px;">- -Mpa</td>
			</tr>
			<tr>
				<td align="right"style="width:80px;height:24px;font-size: 14px;">入水温度：</td>
				<td id = "temperature_id" style="width:80px;height:17px;font-size: 14px;">- -</td>
			</tr>
			<tr>
				<td align="right"style="width:80px;height:24px;font-size: 14px;">出水温度：</td>
				<td id = "out_temperature_id" style="width:80px;height:17px;font-size: 14px;">- -</td>
			</tr>
			
			<tr Style = "height:27px;line-height: 27px;">
				<td align="right"style="width:80px;height:24px;font-size: 14px;">故障状态：</td>
				<td id ="faultStatus_id" style="width:120px;height:17px;font-size: 14px;">正常</td>
			</tr>
		</table>
	</div>
</div>	
	
	<script type="text/javascript">
	var paramDeviceId = "${param.deviceId}";
	if($("#ref"+paramDeviceId).data("catagory")==='BOILER'){
		$("#hotBackImg").css("background-image",'url(${ctx}/static/images/hvac/boiler.png)');
	}else if($("#water"+paramDeviceId).data("catagory")==='WARM_MANIFOLD'||$("#water"+paramDeviceId).data("catagory")==='WARM_WATER_SEPARATOR'){
		$("#hotBackImg").css("background-image",'url(${ctx}/static/images/hvac/manifold.png)');
	}else if($("#pump"+paramDeviceId).data("catagory")==='HOT_WATER_LOOP_PUMP'){
		$("#hotBackImg").css("background-image",'url(${ctx}/static/images/hvac/loopPump.png)');
	}
	if($("#ref"+paramDeviceId).data("catagory")==='BOILER'){
		$("#device-detail-modal-label").html( $("#ref"+paramDeviceId).data("deviceName"));
		$("#code_id").html( $("#ref"+paramDeviceId).data("deviceNumber"));
		if($("#ref"+paramDeviceId).data("workStatus") != null){
		$("#workStatus_id").html( $("#ref"+paramDeviceId).data("workStatus")==0?"关闭":"开启");
		}
		$("#temperature_id").html("- -");
		$("#pressure_id").html("- -");
		$("#faultStatus_id").html( $("#ref"+paramDeviceId).data("faultStatus")==0?"异常":"正常");
	}
	if($("#pump"+paramDeviceId).data("catagory")==='HOT_WATER_LOOP_PUMP'){
		$("#device-detail-modal-label").html( $("#pump"+paramDeviceId).data("deviceName"));
		$("#code_id").html( $("#pump"+paramDeviceId).data("deviceNumber"));
		$("#workStatus_id").html( $("#pump"+paramDeviceId).data("workStatus")==0?"开启":"关闭");
		$("#temperature_id").html("- -");
		$("#out_temperature_id").html($("#water"+waterSepDeviceId).data("pumpOutTemperature")==null?'- -'+'°C':$("#water"+waterSepDeviceId).data("pumpOutTemperature")+'°C');
		$("#pressure_id").html("- -");
		$("#faultStatus_id").html( $("#pump"+paramDeviceId).data("faultStatus")==0?"异常":"正常");
	}
	if($("#water"+paramDeviceId).data("catagory")==='WARM_MANIFOLD'||$("#water"+paramDeviceId).data("catagory")==='WARM_WATER_SEPARATOR') {
		$("#device-detail-modal-label").html($("#water"+paramDeviceId).data("deviceName"));
		$("#code_id").html( $("#water"+paramDeviceId).data("deviceNumber"));
		$("#workStatus_id").html( $("#water"+paramDeviceId).data("workStatus")==0?"关闭":"开启");
		if($("#water"+paramDeviceId).data("catagory")==='WARM_MANIFOLD'){
			$("#temperature_id").html( $("#water"+paramDeviceId).data("temperature")==null?'- -'+'°C':$("#water"+paramDeviceId).data("temperature")+'°C');
			$("#out_temperature_id").html("- -");
		}else{
			$("#temperature_id").html("- -");
			$("#out_temperature_id").html($("#water"+paramDeviceId).data("pumpOutTemperature")==null?'- -'+'°C':$("#water"+paramDeviceId).data("pumpOutTemperature")+'°C');
		}
		$("#pressure_id").html( $("#water"+paramDeviceId).data("pressure")==null?'- -'+'Mpa':$("#water"+paramDeviceId).data("pressure")+'Mpa');
		$("#faultStatus_id").html( $("#water"+paramDeviceId).data("faultStatus")==0?"异常":"正常");
	}
	</script>
</body>
</html>