<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/component/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/iconic.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-datetimepicker/2.1.9/css/jquery.datetimepicker.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/component/jquery-icheck/1.0.2/css/all.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/rib.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/frame.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/firesVideoForCloud.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/cloudModleIframeBlue.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/css/dropdownlistStyleForCloud.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctx}/static/component/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/frame.js" type="text/javascript"></script>
<script src="${ctx}/static/js/HashMap.js" type="text/javascript"></script>
<script src="${ctx}/static/js/StringBuffer.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/commons.js" type="text/javascript"></script>
<script src="${ctx}/static/component/wadda/wadda.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-dropdownlist/jquery.dropdownlist.js" type="text/javascript"></script>
<script src="${ctx}/static/component/jquery-datetimepicker/2.1.9/js/jquery.datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/static/js/dropdownlistBule.js" type="text/javascript"></script>

<title>消防火警视频监控</title>
<style type="text/css">
</style>
</head>
<body>
	<label class="fires-title" id="alarmTitleName">消防火警报警视频</label>
	<span id="operator-id" style="display:none"><shiro:principal property="id"/></span>
    <span id="login-name" style="display:none"><shiro:principal property="loginName"/></span>
	<div style="padding-top: 20px;">
		<table class="fires-title">
			<td class="alarm-describe">报警点</td>
			<td>
				<img src="${ctx}/static/img/alarm/huojing.svg" id="firesAlarmTip" style="display: block;">
			</td>
			<td>
				<div id="alarm-num" class="alarm-num" ></div>
			</td>
			<td>
				<div id="cameraName-dropdownlist"></div>
			</td>
			<input type="text" hidden="true" value="" id="cameraListName">
		</table>
		<div id="video-show" class="right_box">
			<iframe src="${ctx}/videomonitoring/showVideo?height=340&width=610" id="video-iframe" name="video-iframe" frameborder="0"  scrolling="no"></iframe>
		</div>
		<div id="video-imgae"></div>

		<!-- 消防确认开始 -->
		<div class="result-describe" id="result-describe-div">
			<div id="ffm-title">结果确认</div>
			<div id="ffm-fires">
				<div class="fires-type">
					<div class="confirm-type" value="1">真实火警</div>
					<div class="confirm-type" value="2">误报</div>
					<div class="confirm-type" value="3">测试</div>
				</div>
				<div id="confirm-reason">
					<div id="confirm-reason-checkbox-title">请选择火灾原因类型（多选）</div>
					<div id="confirm-reason-checkbox" style="margin: 12px 10px 15px 37px;"></div>
				</div>
				<div id = "mark-div">
					<textarea maxlength="20" id="confirm-reason-mark"  placeholder="请描述火灾发生原因" onkeydown="checkMaxInput(this,20)" onkeyup="checkMaxInput(this,20)" onfocus="checkMaxInput(this,20)" onblur="checkMaxInput(this,20);"></textarea>
				</div>

				<!-- 消防确认 -->
				<div id="submitValue">
					<div id="alarm-record-confirm-div-button-confirm" class="btn-confirm-select" onclick="updateConfirm();">确定</div>
					<div class="btn-confirm-cancal" data-dismiss="modal" onclick ="canal()">取消</div>
				</div>
			</div>
			<!-- 动态加载页面 -->
			<div id="ffm-affirm-view"></div>
		</div>
	</div>
	<div id="ffm_event_error_div"></div>
	<script type="text/javascript">
		var busiType = "${param.busiType}";
        var operatorId = $("#operator-id").text();
        var operatorName = $("#login-name").text();
		var firesVideoObj;
		var firesVideoDeviceList;
		var firesVideoDeviceMap = parent.firesVideoDeviceMap;
		//第一次进来页面，默认事件确认类型:真实火警
		var alarmEventConfirmType = 1;
		//设备id值
		var firesDeviceId;
		//与摄像机相关联的设备信息
		var deviceMap;
		//消防历史事件记录表id
		var recordId;
		//消息id
		var msgId;
		var projectCode = parent.projectCode;

		$(document).ready(function() {
			if (busiType == 'DOOR_BLOCK') {
				$("#result-describe-div").hide();
				$("#alarmTitleName").html("消防通道阻塞报警视频");
				$("#firesAlarmTip").attr("src","${ctx}/static/img/alarm/doorBlock.svg")
				firesVideoDeviceList = parent.doorBlockDeviceList;
			} else {
				firesVideoDeviceList = parent.firesVideoDeviceList;
			}
		    parent.cameraDeviceId = firesVideoDeviceList[0].itemData;
		    deviceMap = firesVideoDeviceMap.get(parent.cameraDeviceId);
			if(typeof(deviceMap.eventConfirm) == "undefined" || deviceMap.eventConfirm == null || deviceMap.eventConfirm == 0){
				$("#ffm-fires").css("display","block");
				affirmFires();
			}else{
				ffmView();
			}
		});

		//确认火警信息(火警未确认)
		function affirmFires(){
			//确认火警类型点击样式
			$(".confirm-type").each(function() {
				if (alarmEventConfirmType == $(this).attr("value")) {
					$(this).addClass("confirm-select");
				}
			});
			checkMaxInput("confirm-reason-mark", 20);
			listConfirmType(alarmEventConfirmType);
			$(".confirm-type").on('click', function() {
				$(".confirm-type").each(function() {
					$(this).removeClass("confirm-select");
				});
				$(this).addClass("confirm-select");
				if (typeof ($(this).attr("value")) != 'undefined') {
					alarmEventConfirmType = $(this).attr("value");
					listConfirmType($(this).attr("value"));
				}
			})
		}
		//查看火警信息
		function ffmView(){
			$("#ffm-fires").css("display","none");
			alarmEventConfirmType = deviceMap.eventConfirm;
			if(alarmEventConfirmType == 1){
				eventConfirm = "真实火警";
			}else if (alarmEventConfirmType == 2){
				eventConfirm = "误报";
			}else if (alarmEventConfirmType == 3){
				eventConfirm = "测试";
			}
			var confirmType = deviceMap.confirmType;
			if(typeof (confirmType) == "undefined" || confirmType == null){
				confirmType = "";
			}
			var mark = deviceMap.mark;
			if(typeof (mark) == "undefined" || mark == null){
				mark = "";
			}
			var ffmTable = '<div id="ffm-view" class="ffm-view">' + '<div id ="event-confirm" class="event-confirm" >'+ eventConfirm  +' </div>'
			+ '<div id ="event-confirm-type" class="event-confirm-type">火灾原因：'+ confirmType  +'</div>'
			+ '<div id ="event-mark" class="event-mark">原因描述：'+ mark  +'</div>' + '</div>';
			$("#ffm-affirm-view").html(ffmTable);
		}
		function callbackLoadVideo() {
			if ("${param.videoType}" == "fire-fighting") {
				$(".modal-dialog").css("transform", "none");
				initFiresVideoDropDownList();
				firesVideoObj.setData(firesVideoDeviceList[0].itemText,
						firesVideoDeviceList[0].itemData, "");
				$("#cameraListName").val(firesVideoDeviceList[0].itemText);
				showFiresVideoMonitor(firesVideoDeviceList[0].itemData);
			}
		}

		function listConfirmType(confirmType) {
			$.ajax({
				type : "get",
				url : "${ctx}/fire-fighting/fireAlarmSystem/listConfirmType?confirmType=" + confirmType,
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data) {
						$("#confirm-reason-checkbox").html("");
						if (data.length > 0) {
							var innerHtml = "";
							$.each(data, function(i, item) {
								innerHtml = innerHtml + '<label class="ffm-alarm-reason"><input type="checkbox" class="confirm-type-reason-radio" id = "confirm-type'+ item.confirmCode +'"  value="'+ item.confirmCode +'"/>' + item.confirmReason + '</label>'
							});
							$("#confirm-reason-checkbox").append(innerHtml);
// 							$("#confirm-reason").show();
							$("#confirm-reason").css("display", "block");
							$(".confirm-type-reason-radio").click(function(event) {
								if ($(this).data("checkState") == true) {
									$(this).prop("checked", false);
									$(this).data("checkState", false);
									$(this).parent().removeClass('checked')
								} else {
									$(this).parent().addClass('checked')
									$(this).data("checkState", true);
								}
							});
						} else {
// 							$("#confirm-reason").hide();
							$("#confirm-reason").css("display", "none");
						}
					} else {
						showDialogModal("ffm_event_error_div", "操作错误", item.MESSAGE);
						return;
					}
				},
				error : function(data) {
				}
			});
		}

		function showFiresVideoMonitor(deviceId) {
			parent.cameraDeviceId = deviceId;
		    deviceMap = firesVideoDeviceMap.get(deviceId);
			firesDeviceId = deviceMap.firesDeviceId;
			recordId = deviceMap.recordId;
			msgId = deviceMap.msgId;
			if (deviceMap.cameraStatus == 1) {
				$("#video-imgae").hide();
				$("#video-show").show();
				$("#video-iframe")[0].contentWindow.closeVideo();
				$("#video-iframe")[0].contentWindow.startPlay(deviceId);
			} else {
				$("#video-iframe")[0].contentWindow.closeVideo();
				$("#video-show").hide();
				$("#video-imgae").show();
			}
		}

		function initFiresVideoDropDownList() {
			if (busiType == 'DOOR_BLOCK') {
				firesVideoDeviceList = parent.doorBlockDeviceList;
			}else{
				firesVideoDeviceList = parent.firesVideoDeviceList;
			}
			firesVideoDeviceMap = parent.firesVideoDeviceMap;
			firesVideoObj = $("#cameraName-dropdownlist").dropDownListBule({
				inputName : "cameraName",
				inputValName : "cameraDeviceId",
				buttonText : "",
				width : "120px",
				readOnly : false,
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {
					if (typeof (data) != "undefined") {
						eventConfirmResult(data);
						}
// 					$("#firesAlarmTip").hide();
				},
				items : firesVideoDeviceList
			});
			$("#alarm-num").html(firesVideoDeviceList.length);
			if (firesVideoDeviceList.length == 0) {
				firesVideoObj.setData($("#cameraListName").val(), "", "");
			}
			if(parent.cameraDeviceId == parent.tempCameraId && parent.tempCameraId != null){				
			eventConfirmResult(parent.cameraDeviceId);
			parent.tempCameraId = null;
			}
			
		}
		
		function eventConfirmResult(data){
			showFiresVideoMonitor(data);
			$("#cameraListName").val(firesVideoDeviceMap.get(data).cameraName);
			if( typeof(deviceMap.eventConfirm) == "undefined" || deviceMap.eventConfirm == null ||deviceMap.eventConfirm <= 0){
				$("#ffm-view").css("display","none");
				$("#ffm-fires").css("display","block");
				$(".confirm-type").removeClass("confirm-select");
				alarmEventConfirmType = 1;
				$("#confirm-reason-mark").val('');
				affirmFires();
			}else{
				ffmView();
			}
		}
		function showTip() {
			firesVideoObj.setData($("#cameraListName").val(), "", "");
// 			$("#firesAlarmTip").show();
		}

		//消防火警确认信息
		function updateConfirm() {
			var mark = $("#confirm-reason-mark").val();
			//确认事件原因类型
			var alarmConfirmTypeReason = "";
			$(".confirm-type-reason-radio").each(function() {
				if ($(this).data("checkState") == true) {
					alarmConfirmTypeReason = alarmConfirmTypeReason + $(this).val() + ",";
				}
			});
			if ((alarmEventConfirmType == 1 || alarmEventConfirmType == 2) && alarmConfirmTypeReason.length == 0) {
				showAlert('warning','请选择原因类型！',"confirm-type1",'top');
				return;
			}
			if (alarmEventConfirmType == 1 && mark.length == 0) {
				showAlert('warning','请填写火灾原因！',"mark-div",'top');
				return;
			}
			if (alarmConfirmTypeReason.length > 0) {
				alarmConfirmTypeReason = alarmConfirmTypeReason.substring(0, alarmConfirmTypeReason.length - 1);
			}
			var data = {
				deviceId : firesDeviceId,
				eventConfirm : alarmEventConfirmType,
				confirmType : alarmConfirmTypeReason,
				mark : mark,
				msgId:msgId,
				id:recordId,
				projectCode:projectCode,
				operatorId:operatorId,
				operatorName:operatorName
			};
			$.ajax({
				type : "post",
				url : "${ctx}/fire-fighting/fireAlarmSystem/confirmAlarmEventHis",
				data : JSON.stringify(data),
				dataType : "json",
				async : false,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					//关闭摄像机播放
					$("#video-imgae").hide();
					$("#video-iframe")[0].contentWindow.closeVideo();
					parent.firesVideoDeviceMap.remove(parent.cameraDeviceId);
					//确认后，删除词条设备缓存，不在重复弹出此设备
					for (var i = 0; i < parent.firesVideoDeviceList.length; i++) {
						if (parent.firesVideoDeviceList[i].itemData == parent.cameraDeviceId) {
							parent.firesVideoDeviceList.splice(i, 1);
						}
					}
					if (parent.firesVideoDeviceList.length == 0) {
						if(data.confirmResult == 1 || data.confirmResult == 2){						
							parent.showDialogModal("ffm_error_div", "提示", "该火警已被确认");
						}else if(data.confirmResult == 4){		
							showDialogModal("error-div", "提示", "历史事件已更新");
						}
						//关闭弹窗
						parent.$("#fires-alarm-video-modal").modal('hide');
					} else {
						if(data.confirmResult == 1 || data.confirmResult == 2){						
							showDialogModal("ffm_event_error_div", "提示", "该火警已被确认");
						}else if(data.confirmResult == 4){		
							showDialogModal("error-div", "提示", "历史事件已更新");
						}
						parent.tempCameraId = null;
						//重新加载下拉框,重新新加载确认信息
						initFiresVideoDropDownList();
						firesVideoObj.setData(firesVideoDeviceList[0].itemText, firesVideoDeviceList[0].itemData, "");
						$("#cameraListName").val(firesVideoDeviceList[0].itemText);
						showFiresVideoMonitor(firesVideoDeviceList[0].itemData);
						if(typeof(deviceMap.eventConfirm) == "undefined" || deviceMap.eventConfirm == null || deviceMap.eventConfirm == 0){
							$("#ffm-fires").css("display","block");
							$(".confirm-type").removeClass("confirm-select");
							alarmEventConfirmType = 1;
							$("#confirm-reason-mark").val('');
							affirmFires();
						}else{
							ffmView();
						}
					}
				},
				error : function(req, error, errObj) {
				}
			});
		}

		//多行文本输入框剩余字数计算
		function checkMaxInput(obj, maxLen) {
			if (obj == null || obj == undefined || obj == "") {
				return;
			}
			if (maxLen == null || maxLen == undefined || maxLen == "") {
				maxLen = 100;
			}

			var strResult;
			if (typeof (obj) == 'string') {
				obj = document.getElementById(obj);
			}
			var $obj = $(obj);
			var newid = $obj.attr("id") + 'msg';

			strResult = '<span id="' + newid + '" class=\'Max_msg\' ></span>'; //计算并显示剩余字数
			var $msg = $("#" + newid);
			if ($msg.length == 0) {
				$obj.after(strResult);
				$msg = $("#" + newid);
			}
			if (obj.value.length > maxLen) { //如果输入的字数超过了限制
				obj.value = obj.value.substring(0, maxLen); //就去掉多余的字
				strResult = '最多输入' + (maxLen - obj.value.length) + '字';
			} else {
				strResult = '最多输入' + (maxLen - obj.value.length) + '字';
			}
			$msg.html(strResult);
		}

		//清空剩除字数提醒信息
		function resetMaxmsg() {
			$("span.Max_msg").remove();
		}
		//取消按钮，关闭弹窗
		function canal(){
			parent.$("#fires-alarm-video-modal").modal('hide');
		}
	</script>
</body>
</html>