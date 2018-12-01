 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd HH:mm:ss" />
<!DOCTYPE html>
<html>
<head>
<link
	href="${ctx}/static/autocomplete/1.1.2/css/jquery.autocomplete.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/autocomplete/1.1.2/js/jquery.autocomplete.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/util.js"></script>
<style type="text/css">
</style>
</head>
<body>
	<div style="width: 100%; height: 100%">
		<div style="width: 30%; height: 100%; float: left;padding-left:30px;padding-top:40px;">
		<div 
			style="width:80%;height:60%;background-size:115px 150px;background-image: url('${ctx}/static/img/supply-drain/supplyDevice.png');"></div>
		</div>
		<div style="width: 70%; height: 100%; float: left;">
			<form id="cardEdit-form"
				style="padding: 10px 0px 10px 40px;height:90%;">
				<table>
						<tr style="margin-top:10px;height:40px;margin-left:50px;">
							<td align="left" width="100px">设备编号：</td>
							<td id="d_deviceName">--</td>
						</tr>
						<tr style="margin-top:10px;height:40px;margin-left:50px;">
							<td align="left" width="100px">设备位置：</td>
							<td id="d_deviceLocation">--</td>
						</tr>
						<tr style="margin-top:10px;height:40px;;margin-left:50px;display:none">
							<td align="left" width="120px" >1号泵是否开启：</td>
							<td id="a_openStatus">--</td>
						</tr>
						<tr style="margin-top:10px;height:40px;;margin-left:50px;display:none">
							<td align="left" width="120px">1号泵故障状态：</td>
							<td id="a_falutStatus">--</td>
						</tr>
						<tr style="margin-top:10px;height:40px;;margin-left:50px;display:none">
						<td align="left" width="120px">2号泵是否开启：</td>
						<td id="b_openStatus">--</td>
						</tr>
						<tr style="margin-top:10px;height:40px;;margin-left:50px;display:none">
						<td align="left" width="120px">2号泵故障状态：</td>
						<td id="b_falutStatus">--</td>
						</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
		 
		  if(deviceObjData!=null){
			  initDeviceDetailInfo(deviceObjData);
			  openDetailDeviceId = deviceObjData.deviceCode;
			
		  }
		
		});
		
		//初始话设备信息
		function initDeviceDetailInfo(deviceObjData){
				$("#d_deviceName").html(deviceObjData.deviceCode);
				$("#d_deviceLocation").html(deviceObjData.deviceLocation);
				
				if(deviceObjData.oaStatus!="undefined"){
					$("#a_openStatus").parent("tr").show();

						if(deviceObjData.oaStatus==1){
							$("#a_openStatus").html("开启");
						}else if(deviceObjData.oaStatus==2){
							$("#a_openStatus").html("关闭");
						}else{
							$("#a_openStatus").html("--");
						}
					
				}
				
				if(deviceObjData.faStatus!="undefined"){
					$("#a_falutStatus").parent("tr").show();
					if(deviceObjData.faStatus==1){
						$("#a_falutStatus").html("正常");
					}else if(deviceObjData.faStatus==2){
						$("#a_falutStatus").html("异常");
					}else{
						$("#a_falutStatus").html("--");
					}
				}
				
				if(deviceObjData.obStatus!="undefined"){
					$("#b_openStatus").parent("tr").show();
					if(deviceObjData.obStatus==1){
						$("#b_openStatus").html("开启");
					}else if(deviceObjData.obStatus==2){
						$("#b_openStatus").html("关闭");
					}else{
						$("#b_openStatus").html("--");
					}
				}
				if(deviceObjData.fbStatus!="undefined"){
					$("#b_falutStatus").parent("tr").show();
					if(deviceObjData.fbStatus==1){
						$("#b_falutStatus").html("正常");
					}else if(deviceObjData.fbStatus==2){
						$("#b_falutStatus").html("异常");
					}else{
						$("#b_falutStatus").html("--");
					}
				}
		}
		//触发关闭
		$(".close").click(function(){
			isOpenDetail=0;
		});
	</script>
</body>
</html>