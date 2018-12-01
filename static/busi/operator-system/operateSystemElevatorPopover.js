	//首次进入页面，先查询告警电梯信息
	function getelevatorAlarmData() {
		$.ajax({
			type : "post",
			url : ctx + "/elevator/elevatorAlarmVideo/queryElevatorAlarmInfo?projectCode=" + projectCode,
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
// 		var titleName = '<label style=" margin-left: 22px;font-size: 14px;color: #4A4A4A;" >电梯困人报警视频</label>';
        createSimpleModalWithIframe("show-elevator-alarm-video", 704, 544, ctx + "/elevatorAlarmVideoPopover/showElevatorAlarmVideo?videoType=elevator",null,closeAlarmVideoPopover,100,"right","blue");
		$(".modal-dialog").css("transform", "none");
		openModal("#show-elevator-alarm-video-modal", false, false);
		hiddenScroller();
	}
    $("#elevatorRunningMonitorPage-dialog").css("transform","none");

	function showElevatorRunningMonitorPage() {
        createSimpleModalWithIframefade("elevatorRunningMonitorPage", 1920, 1080, ctx + "/projectPage/elevatorMonitorPage",null,closeFuncs,0,"left");
		$("#elevatorRunningMonitorPage-dialog").css("transform","none");
		openModal("#elevatorRunningMonitorPage-modal", false, false);
		hiddenScroller();
	}
	function closeFuncs(){
		$(".modal-open").removeClass('modal-open');
	}
	//关闭订阅
	function unloadAndReleasePopover() {
		if(stompClient != null) {
			stompClient.unsubscribe('/topic/elevatorAlarmVideoPopoverRunningData');
			stompClient.unsubscribe('/topic/elevatorAlarmVideoPopover');
		}
	}
    function changeScroller() {
        var height = $(window).height();
        if (height > 1070) {
            document.documentElement.style.overflowY = 'hidden';
            $(".modal-open").css("overflow-y", "hidden");
        } else {
            document.documentElement.style.overflowY = 'auto';
            $(".modal-open").css("overflow-y", "auto");
        }
    }