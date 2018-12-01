function startConn(gatewayAddr) {
	connect(gatewayAddr);
	setInterval("connect('" + gatewayAddr + "')", 40000);
}

function connect(gatewayAddr) {
	if (isConnectedGateWay) {
		return;
	}
	var url = gatewayAddr + '/websocket';
	g_gatewayAddr = gatewayAddr;
	var socket = new SockJS(url);
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		isConnectedGateWay = true;
		console.info("网关连接成功！");
		// 告警中心告警
		stompClient.subscribe('/topic/fireAreaAlarmData/' + projectCode + "/G", function(result) {
			console.info("接收到数据:" + result);
			var json = JSON.parse(result.body);
			updatePage(json, null);
		});
	}, onerror);
}

function onerror(frame) {
	if (frame.indexOf("Lost connection") > -1) {
		console.info("未连接上网关地址：" + g_gatewayAddr);
		isConnectedGateWay = false;
		disconnect();
	}
}

function disconnect() {
	if (stompClient != null) {
		stompClient.disconnect();
	}
}

function unloadAndRelease() {
	disconnect();
}

function getData(id, divId) {
	$.ajax({
		type : "post",
		url : ctx + "/report/" + id + "?projectCode=" + projectCode + "&areaCode=G",
		async : false,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			var obj = echarts.init(document.getElementById(divId));
			obj.setOption($.parseJSON(data));
		},
		error : function(req, error, errObj) {
		}
	});
}

function getFiresAreaInfo() {
	$.ajax({
		type : "post",
		url : ctx + "/fire-fighting/fireFightingManage/getFiresAreaMonitorInfo?projectCode=" + projectCode + "&areaCode=G",
		async : true,
		contentType : "application/json;charset=utf-8",
		success : function(data) {
			if (data.data != null && data.code == 0) {
				var info = data.data;
				updatePage(info, 0);
			}
		},
		error : function(req, error, errObj) {
		}
	});
}

function updatePage(info, type) {
	$("#fires").html(info.fires);
	$("#faults").html(info.faults);
	$("#feedbacks").html(info.feedbacks);
	getData(129, "maintenance_chart");
	if (typeof (flushFiresTime) != "undefined") {
		// 防止多次加载产生多个定时任务
		clearTimeout(flushFiresTime);
	}
	var pointList = info.firesVideoMonitorDTOs;
	$.each(pointList, function(i, v) {
		if (type == 0) {
			$("#camera_" + v.firesDeviceNumber).attr("class", v.cameraUuid);
		}
		if (v.faultStatus == 1) {
			$('#' + v.firesDeviceNumber).attr("src", abnormalUrl);
		} else {
			if (v.fireAlarm == 1) {
				$('#' + v.firesDeviceNumber).attr("src", alarmUrl);
			} else {
				$('#' + v.firesDeviceNumber).attr("src", normalUrl);
			}
		}
		if (v.cameraStatus == 0) {
			$("." + v.cameraUuid).attr("src", cameraOffline);
		} else {
			$("." + v.cameraUuid).attr("src", cameraOnline);
		}
		firesVideoDeviceMap.put(v.firesDeviceNumber, v.cameraDeviceId);
		cameraStatusMap.put(v.cameraDeviceId, v.cameraStatus);
	});
	firesMaxTime = info.firesNoDealTime;
	if (firesMaxTime > 0) {
		flushFiresTime = setTimeout("timeChange()", 1000);
	} else {
		$("#fires_day").html("--天");
		$("#fires_time").html("--小时" + "--分钟" + "--秒");
	}

}

// 消防最长时间变化
function timeChange() {
	if (typeof (flushFiresTime) != "undefined" && 'undefined' != typeof ($("#fires_day").val())) {
		firesMaxTime = firesMaxTime + 1000;
		var days = parseInt(firesMaxTime / (1000 * 60 * 60 * 24));
		var hours = parseInt((firesMaxTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		var minutes = parseInt((firesMaxTime % (1000 * 60 * 60)) / (1000 * 60));
		var seconds = (firesMaxTime % (1000 * 60)) / 1000;
		$("#fires_day").html(days + "天");
		$("#fires_time").html(hours + "小时" + minutes + "分钟" + parseInt(seconds) + "秒");
		flushFiresTime = setTimeout("timeChange()", 1000);
	}
}

function showVideo() {
	createSimpleModalWithIframe("fires-alarm-video", 830, 547, ctx + "/videomonitoring/iframeShowVideo?height=432&width=768&cameraDeviceId="+cameraId, "", "", "", "right","blue");
	openModal("#fires-alarm-video-modal", false, false);
    $('.modal-body').prepend('<div style="font-size: 24px;color: #FFFFFF;letter-spacing: 2.86px;margin-left:360px;margin-top: -20px;">查看视频</div>')
    $("#fires-alarm-video-modal").modal('show');
	//$(".modal-content").css("background", "rgba(9,162,221,0.40) none repeat scroll 0% 0%");
	//$("#fires-alarm-video-iframe").css("margin-top", "50px");
	//$("#fires-alarm-video-iframe body").css("background", "rgba(9, 162, 221, 0.4) none repeat scroll 0% 0%");
}
function showSnapshotPic() {
    createSimpleModalWithIframe("fires-image", 830, 740,ctx + "/fireFightingManage/firesImageForArea?isExternal=true&CHECK_AUTHENTICATION=false&projectCode="+projectCode+"&deviceNumber=" + encodeURI(deviceNumber),"","", "", "right","blue");
    //createModalWithLoad("fires-image", 800, 650, "火警抓拍历史记录", "/fireFightingManage/firesImageForArea?isExternal=true&CHECK_AUTHENTICATION=false&deviceNumber=" + encodeURI(deviceNumber), "", "");
    openModal("#fires-image-modal", false, false);
    $('.modal-body').prepend('<div style="font-size: 24px;color: #FFFFFF;letter-spacing: 2.86px;margin-left:308px;margin-top: -20px;">火警抓拍历史记录</div>')
}
function hiddenScroller() {
	var height = $(window).height();
	if (height > 1070) {
		document.documentElement.style.overflowY = 'hidden';
	} else {
		document.documentElement.style.overflowY = 'auto';
	}
}

$(window).resize(function() {
	hiddenScroller();
});
