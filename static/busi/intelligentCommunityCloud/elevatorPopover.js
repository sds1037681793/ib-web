	//首次进入页面，先查询告警电梯信息
	function getelevatorAlarmData() {
		$.ajax({
			type : "post",
			url : ctx + "/elevator/elevatorAlarmVideo/queryElevatorAlarmInfo?projectCode=" + huojuProjectCode,
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			async:false,
			success : function(data) {
				if (data != null && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						elevatorAlarmDevice.unshift({
							"deviceId" : data[i].deviceId,
							"deviceName" : data[i].deviceName,
							"alarmName" : data[i].alarmName,
							"runningState" : data[i].runningState,
							"floorDisplaying" : data[i].floorDisplaying,
							"cameraDeviceId" : data[i].cameraDeviceId,
							"cameraStatus" : data[i].cameraStatus
						});
					}
				}
				//视频弹窗，防止首次查询数据过慢，导致页面无数据
				showElevatorAlarmVideo(elevatorAlarmDevice);
				elevatorVideoIsOpen = 1;
			},
			error : function(req, error, errObj) {
				return;
			}
		});

	}

	function closeAlarmVideoPopover(){
		elevatorVideoIsOpen = 0;
		elevator = null;
		elevatorName = null;
		elevatorAlarmName = null;
		elevatorFloorDisplaying = null;
		elevatorRunningState = null;
	}

	function showElevatorAlarmVideo(elevatorAlarmDevice) {
        createSimpleModalWithIframe("show-elevator-alarm-video", 704, 544, ctx + "/elevatorAlarmVideoPopover/elevatorVideoForCloud?videoType=elevator",null,closeAlarmVideoPopover,100,"right","blue");
		$(".modal-dialog").css("transform", "none");
		openModal("#show-elevator-alarm-video-modal", false, false);
	}
    $("#elevatorRunningMonitorPage-dialog").css("transform","none");

	function closeFuncs(){
		$(".modal-open").removeClass('modal-open');
	}