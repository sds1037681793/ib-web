<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<style>
    .confirm-type {
    	text-align:center;
    	vertical-align:middle;
    	font-size: 14px;
		color: #9B9B9B;
		letter-spacing: 0;
    	width:80px;
    	height:30px;
    	line-height:28px;   
    	margin: 10px 20px 0 0;
    	border: 1px solid #9B9B9B;
		border-radius: 4px;
		display: inline-block;
		cursor: pointer;
    }
    .confirm-select {
    	background: rgba(0,191,165,0.10);
		border: 1px solid #00BFA5;
		color: #00BFA5;
    }
    .ffm-alarm-reason{
    	margin-top:0;
    	margin-right: 20px;
    	font-weight:normal;
    }
    .ffm-alarm-reason::before{
    	margin:0 5px 0 0;
    	content: "\a0"; /*不换行空格*/
	    display: inline-block;
	    vertical-align: middle;
	    width: 14px;
	    height: 14px;
	    border-radius: 50%;
	    border: 1px solid #01cd78;
	    text-indent: .15em;
	    line-height: 1; 
    }
    .ffm-alarm-reason.checked::before {
	    background-color: #01cd78;
	    background-clip: content-box;
	    padding: 3px;
	}
	.confirm-type-reason-radio {
	    position: absolute;
	    clip: rect(0, 0, 0, 0);
	}
    .Max_msg{
    	width:87px;
    	height:17px;
    	font-size: 12px;
		color: #666666;
		float: right;
		position:absolute;
		top: 55px;
		right: 3px;
    }
</style>
</head>
<body>
<span id="operator-id" style="display:none"><shiro:principal property="id"/></span>
<span id="login-name" style="display:none"><shiro:principal property="loginName"/></span>
<div id = "fireAlarmType" style="height:60px;">
</div>

<div id="fireAlarm-confirm-reason" style="display: hidden;">
	<div id="confirm-reason-checkbox-title" >请选择原因类型（多选）</div>
	<div id="confirm-reason-checkbox" style="margin: 15px 10px 15px 0;">
	</div>
</div>
<div style="margin-top: 20px;position:relative;">
	<textarea maxlength="20" id="confirm-reason-mark" style="background: #FFFFFF;border: 1px solid #CCCCCC;padding:6px 12px;width:560px;height:80px;resize:none;" placeholder="请描述发生原因" onkeydown="checkMaxInput(this,20)"  
           onkeyup="checkMaxInput(this,20)" onfocus="checkMaxInput(this,20)" onblur="checkMaxInput(this,20);"></textarea>
</div>
</body>
<script type="text/javascript">
    var operatorId = $("#operator-id").text();
    var operatorName = $("#login-name").text();
	var alarmEventConfirmType = "${param.confirmType}";
	var alarmEventRecordId = "${param.recordId}";
	var eventType = "${param.eventType}";
	var msgId = "${param.msgId}";
	var confirmTypeTextList = 
	{
		"1" : [
				{
					itemData : "1",
					itemText : "真实火警"
				}, {
					itemData : "2",
					itemText : "误报"
				}, {
					itemData : "3",
					itemText : "测试"
				}
		],
		"2" : [
				{
					itemData : "4",
					itemText : "真实故障"
				}, {
					itemData : "5",
					itemText : "设备丢失"
				}, {
					itemData : "6",
					itemText : "测试"
				}
		],
		"3" : [
				{
					itemData : "7",
					itemText : "真实报警"
				}, {
					itemData : "3",
					itemText : "测试"
				}
		]
	};
	var alarmHtml = '';
	$.each(confirmTypeTextList[eventType],function(i,val){
		alarmHtml += '<div class="confirm-type"  value="'+val.itemData+'">'+val.itemText+'</div>';
	});
	$(document).ready(function() {
		
		$("#fireAlarmType").append(alarmHtml);
		if (alarmEventConfirmType <= 0) {
				alarmEventConfirmType = confirmTypeTextList[eventType][0].itemData;
				$(".confirm-type").each(function() {
					if (alarmEventConfirmType == $(this).attr("value")) {
						$(this).addClass("confirm-select");
					}
				});
				$(".confirm-type").on('click', function() {
					$(".confirm-type").each(function() {
						$(this).removeClass("confirm-select");
					});
					$(this).addClass("confirm-select");
					if (typeof ($(this).attr("value")) != 'undefined') {
						alarmEventConfirmType = $(this).attr("value");
						/* if (alarmEventConfirmType == 3 || alarmEventConfirmType == 6 || alarmEventConfirmType == 5) {
							$("#fireAlarm-confirm-reason").hide();
						} else {
							$("#fireAlarm-confirm-reason").show();
						} */
						listConfirmType($(this).attr("value"));
					}
				});
		}

		checkMaxInput("confirm-reason-mark", 20);
		if (confirmItem.confirmType) {
			confirmTypeList = confirmItem.confirmType.split(",");
		} else {
			confirmTypeList = [];
		}
		listConfirmType(alarmEventConfirmType);
		$("#confirm-reason-mark").val(confirmItem.mark);
	});

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
							innerHtml = innerHtml + '<label class="ffm-alarm-reason"><input type="radio" class="confirm-type-reason-radio" value="'+ item.confirmCode +'"/>' + item.confirmReason + '</label>'
						});
						$("#confirm-reason-checkbox").append(innerHtml);
						$("#fireAlarm-confirm-reason").show();

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
						$("#fireAlarm-confirm-reason").hide();
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
	function updateConfirm() {
		var mark = $("#confirm-reason-mark").val();
		var alarmConfirmTypeReason = "";
		$(".confirm-type-reason-radio").each(function() {
			if ($(this).data("checkState") == true) {
				alarmConfirmTypeReason = alarmConfirmTypeReason + $(this).val() + ",";
			}
		});
		if ((alarmEventConfirmType == 1 || alarmEventConfirmType == 2) && alarmConfirmTypeReason.length == 0) {
			showDialogModal("error-div", "操作错误", "请选择原因类型！");
			return;
		}
		if ((alarmEventConfirmType == 4) && alarmConfirmTypeReason.length == 0) {
			showDialogModal("error-div", "操作错误", "请选择原因类型！");
			return;
		}
		if (alarmEventConfirmType == 4 && mark.length == 0) {
			showDialogModal("error-div", "操作错误", "请填写原因！");
			return;
		}
		if (alarmEventConfirmType == 1 && mark.length == 0) {
			showDialogModal("error-div", "操作错误", "请填写原因！");
			return;
		}
		if (alarmConfirmTypeReason.length > 0) {
			alarmConfirmTypeReason = alarmConfirmTypeReason.substring(0, alarmConfirmTypeReason.length - 1);
		}
		var data = {
			id : alarmEventRecordId,
			eventConfirm : alarmEventConfirmType,
			confirmType : alarmConfirmTypeReason,
			mark : mark,
			msgId : msgId,
			operatorId : operatorId,
			operatorName : operatorName
		};
		$.ajax({
			type : "post",
			url : "${ctx}/fire-fighting/fireAlarmSystem/confirmAlarmEventHis",
			data : JSON.stringify(data),
			dataType : "json",
			async : false,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				//如果已经被确认过弹窗提醒
				if (data.confirmResult == 1 || data.confirmResult == 2) {
					showDialogModal("error-div", "提示", "该火警已被确认");
				} else if (data.confirmResult == 4) {
					showDialogModal("error-div", "提示", "历史事件已更新");
				}
				reloadEventGrid();
				$("#alarm-record-confirm-div-modal").modal('hide');
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
</script>
</html>