/**
 * 获取所有的消防摄像头
 * 
 * @param deviceId
 * @returns
 */
function getAllFireFightingCameras() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingManage/getFiresAlarmVideoCache",
		dataType : "json",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.code == 0 && data.data != null) {
				var lists = data.data;
				$.each(lists, function(index, value) {
					if (value.fireAlarm == 1) {
						var dto = {
							"firesDeviceId" : value.firesDeviceId,
							"cameraName" : value.cameraName,
							"fireAlarm" : value.fireAlarm,
							"cameraDeviceId" : value.cameraDeviceId,
							"cameraStatus" : value.cameraStatus,
							"recordId" : value.recordId,
							"eventConfirm" : value.eventConfirm,
							"confirmType" : value.confirmType,
							"mark" : value.mark,
							"msgId" : value.msgId
						};
						firesVideoDeviceMap.put(value.cameraDeviceId, dto);
					}
				});
			}
		},
		error : function(req, error, errObj) {
			// showDialogModal("error-div", "操作错误", errObj);
			return;
		}
	})
}

function openVideoPage(busiType) {
	if (typeof ($("#fires-alarm-video-modal").val()) == "undefined") {
		// var titleName = '<label style=" margin-left: 22px;font-size:
		// 14px;color: #4A4A4A;" >消防火警报警视频</label>';
		//消防火警视频弹窗for西子国际首页
//		createModalWithLoad("fires-alarm-video", 654, 835, "", "fireFightingManage/firesVideoMonitor?videoType=fire-fighting", "", "", "");
		//消防火警视频弹窗for政府首页
		if(busiType=="DOOR_BLOCK"){
			createSimpleModalWithIframe("fires-alarm-video", 704, 540, ctx + "/fireFightingManage/firesVideoMonitor?videoType=fire-fighting&busiType="+busiType, "", "", "100px","","blue");
		}else{
			createSimpleModalWithIframe("fires-alarm-video", 704, 878, ctx + "/fireFightingManage/firesVideoMonitor?videoType=fire-fighting", "", "", "100px","","blue");
		}
		openModal("#fires-alarm-video-modal", false, false);
		$(".modal-dialog").css("transform", "none");
	} else {
		document.getElementById('fires-alarm-video-iframe').contentWindow.initFiresVideoDropDownList();
		document.getElementById('fires-alarm-video-iframe').contentWindow.showTip();
//		$("#firesAlarmTip").show();
//		firesVideoObj.setData($("#cameraListName").val(), "", "");
	}
}
