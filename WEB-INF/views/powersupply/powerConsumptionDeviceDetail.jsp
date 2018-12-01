<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd HH:mm:ss" />
<fmt:formatDate value="${now}" var="currentYear" pattern="yyyy" />
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
	.content{
		height:100%;
		width:100%;
		overflow:scroll; /*任何时候都强制显示滚动条*/
overflow:auto; /*需要的时候会出现滚动条*/
overflow-x:auto; /*控制X方向的滚动条*/
overflow-y:auto; /*控制Y方向的滚动条*/
	}
</style>
</head>
<body>

		<div class="content">
			<div  id="div_monthDetail" style="height:99%;width:95%;margin-left:5%;">
						
			</div>
		</div>
		<div id="error-div"></div>
		<script type="text/javascript">
		var orgId = projectId;
		$(document).ready(function() {
			getMonthDeviceDetail();
		});
		
		//设备详情
		function getMonthDeviceDetail(){
			$.ajax({
				type : "post",
				url : "${ctx}/power-supply/supplyPowerMain/getMontDeviceDetailData?projectCode=" + projectCode+"&month="+chooseMonth,
				data : "",
				success : function(data) {
					if ( data.code == 0 && data.data!=null && data.data!="") {
						var result = data.data.deviceDlpDetail;
						var bgColor="#00A8E2";
						for(var i in result){
							var trContent = "<div style='font-size:14px;height:25px;margin-top:15px'><div style='display:block;width:100px;float:left'>"
							+result[i].deviceName+"</div><div style='visibility:hidden;margin-left:120px;float:left'>----------------</div><div  style='float:left;width:120px'>"
							+result[i].deviceDlp+"kwh&nbsp;&nbsp;</div><div id='id_rateDlp' style='float:left;'>"
							+result[i].dlpRate+"</div></div>"
							+"<div style='height:15px;'><div style='background-color:"+bgColor+";height:15px;width:"+result[i].dlpRate+"'></div><div>";
							$("#div_monthDetail").append(trContent);
						}
					} else {
						return false;
					}
				},
				error : function(req, error, errObj) {
					return false;
				}
			});
			
		}
		
	</script>
</body>
</html>