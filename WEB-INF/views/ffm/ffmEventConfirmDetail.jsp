<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<style>
.reason{
font-size: 14px;
color: #999999;
letter-spacing: 0;
}
#reason{
font-size: 14px;
color: #999999;
line-height:35px;
}
#mark{
font-size: 14px;
color: #999999;
line-height:35px;
}
.eventTypeConfirm{
font-size: 14px;
color: #4A4A4A;
letter-spacing: 0;
line-height:35px;
}
</style>
</head>
<body>
	<div class = "eventTypeConfirm" ></div>
	<div class = "eventConfirm-reason" ><span id = "reason">原因：</span><span id ="reason-detail"></span></div>
	<div class = "eventConfirm-mark" ><span id = "mark">原因描述：</span><span id ="mark-detail"></span></div>
</body>
<script type="text/javascript">
	var alarmEventConfirmType = "${param.confirmType}";
	var alarmEventRecordId = "${param.recordId}";
	var confirmDetail = "${param.confirmDetail}";
	var eventType = "${param.eventType}";
	if(eventType==1){
		$("#reason").html("火警原因：");
	}else{
		$("#reason").html("故障原因：");
	}
	var mark =confirmItem.mark;
	$(".eventTypeConfirm").html(FaultEventConfirmText.get(alarmEventConfirmType));	
	
	$("#mark-detail").html(mark);
	
	var FaultEventConfirmText = new HashMap();
	FaultEventConfirmText.put(0,"未确认");
	FaultEventConfirmText.put(1,"真实火警");
	FaultEventConfirmText.put(2,"误报");
	FaultEventConfirmText.put(3,"测试");
	FaultEventConfirmText.put(4,"真实故障");
	FaultEventConfirmText.put(5,"设备丢失");
	FaultEventConfirmText.put(6,"测试");
	FaultEventConfirmText.put(7,"真实报警");
	$(document).ready(function(){
		listConfirmType(alarmEventConfirmType);
	});
	function listConfirmType(confirmType){
		$.ajax({
			type : "get",
			url : "${ctx}/fire-fighting/fireAlarmSystem/listConfirmType?confirmType=" + confirmType,
			dataType : "json",
			async:false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				if (data) {
					if(data.length > 0){
						var innerHtml = "";
						$.each(data,function(i,item){
							if(confirmDetail.indexOf(item.confirmCode)>-1){
								innerHtml = innerHtml + item.confirmReason+";";
							}
						});
						if(innerHtml.length>0){
							innerHtml = innerHtml.substring (-1,innerHtml.length-1)+"。";
						}
						$("#reason-detail").html(innerHtml);	
					}
				} else {
					showDialogModal("error-div", "操作错误", item.MESSAGE);
					return;
				}
			},
			error : function(req, error, errObj) {
			}
		});
	}
</script>
</html>