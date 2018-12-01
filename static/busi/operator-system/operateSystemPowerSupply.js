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
		stompClient.subscribe('/topic/fireAreaAlarmData/' + projectCode + "/G",
				function(result) {
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
		url : ctx + "/report/" + id + "?projectCode=" + projectCode
				+ "&areaCode=G",
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

function showPowerDetail() {
	createSimpleModalWithIframe("powerSupply-detail-div", 700, 520, ctx
			+ "/psdMain/powerAccountDetail?width=700", "", "",100);
	openModal("#powerSupply-detail-div-modal", false, false);
}

